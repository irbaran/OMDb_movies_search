/**
OMDb Movies Search

Copyright (c) 2019, irbaran. 
All rights reserved.

Permission to use, copy, modify, and distribute this software for any purpose
with or without fee is hereby granted, provided that the above copyright
notice and this permission notice appear in all copies.

The software is provided "as is", without warranty of any kind, express or
implied, including but not limited to the warranties of merchantability,
fitness for a particular purpose and noninfringement of third party rights. 
In no event shall the authors or copyright holders be liable for any claim,
damages or other liability, whether in an action of contract, tort or
otherwise, arising from, out of or in connection with the software or the use
or other dealings in the software.

Except as contained in this notice, the name of a copyright holder shall not
be used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization of the copyright holder.
 */
#include <stdio.h> 
#include <iostream>
#include <string>
#include <curl/curl.h>
#include "rapidjson/document.h"
#include "rapidjson/writer.h"
#include "rapidjson/stringbuffer.h"
using namespace std;
using namespace rapidjson;

//User menu difines
#define NONE_SEL            0    // No selection
#define HELP_SEL            1    // Parameter selected help
#define TITLE_MOVIE_SEL     2    // Parameter selected search movies by title
#define MEDIA_TYPE_SEL      3    // Selected by media type

//Status errors
#define RUNSTS_ERROR        0    // Run main status error
#define RUNSTS_OK           1    // Run main status ok

//URL and JSON parser errors
#define ERROR_BUFFER_SHORT  1    // Buffer to short from OMDb
#define ERROR_JSON_PARSE    2    // JSON parse error


//////////////////////////
//Help funtion
/////////////////////////
void help(void)
{
	const int help_num_lines = 4;     // define a quantidade de nomes no array
	const int help_line_size = 80;    // define o tamanho maximo do nome
	int i;		//for iterator
	char help_str[help_num_lines][help_line_size] = 
		{	"  -h             -- Show this help list.",
			"  -s <title>     -- Search movies by title.",
			"  -t <type>      -- Returns only media type selected (movie, series, episode).",
			"  Example: movies -s Guardians of the Galaxy -t movie"};
	
	for(i = 0; i < help_num_lines; i++)
	cout << help_str[i] << endl;
}

//////////////////////////
//User menu funtion to generate URL 
/////////////////////////
string user_menu(int argc, char** argv)
{
	int arg;                                // argument iterator
	int user_menu_error_sts = RUNSTS_OK;    // Menu function status error
	int menu_select	= NONE_SEL;             // menu selected function
	int help_request = 0;                   // Indicates help user cli request
	string title;                           // Title from user parameter line when option -s
	string media_type;                      // Media type from user parameter line when option -t
	string url;                             // URL string mounter
	int count_menu_param_s = 0;             // Count user menu parameter s
	int count_menu_param_t = 0;             // Count user menu parameter t
	string curr_argv;                       // Current argument string

	//User parameter menu extraction
	for( arg = 1; arg < argc; arg++ )
	{
		if( argv[1][0] != '-' )
		{
			cout << "Incorrect sintax argument, see help function below.\n\n";
			help();
			user_menu_error_sts = RUNSTS_ERROR;
			break;
		}

		if (help_request == 0)
		{
			if( argv[arg][0] == '-' )
			{ 
				//Capture user comand line parameter 
				switch( argv[arg][1] )
				{
					case 'h':   // help ask
						help();
						url = "Invalid";
						help_request = 1;
						break;
					case 's':   // Search movies by title
						if (title[0] == '\0')
							menu_select = TITLE_MOVIE_SEL;
						else
							menu_select	= NONE_SEL;
						count_menu_param_s++;
						if (count_menu_param_s == 2) 
							cout << "Only first option -s is considered\n";
						break;
					case 't':   // Qualifies search media type (movie, series, episode)
						if (media_type[0] == '\0')
							menu_select = MEDIA_TYPE_SEL;
						else
							menu_select	= NONE_SEL;
						count_menu_param_t++;
						if (count_menu_param_t == 2) 
							cout << "Only first option -t is considered\n";
						break;
					default:    // Invalid argument
						cout << "Invalid argument, see help function below.\n\n";
						user_menu_error_sts = RUNSTS_ERROR;
						help();
						break;
				}
			}
			else
			{
				//Capture string qualifier of user comand line parameter 
				if (menu_select == TITLE_MOVIE_SEL)
				{
					if (title[0] == '\0')
						title = title + argv[arg];
					else
						title = title + "%2f" + argv[arg];
				}
				if (menu_select == MEDIA_TYPE_SEL)
				{
					if (media_type[0] == '\0')
					{
						curr_argv = argv[arg]; 
						if ((curr_argv == "movie") || (curr_argv == "series") || (curr_argv == "episode"))
							media_type = argv[arg];
						else
						{
							cout << "Invalid media type. The type must be movie, series or episode\n";
							user_menu_error_sts = RUNSTS_ERROR;
						}
					}
					else
					{
						cout << "Invalid media type. The type must be only one word, ex: movie, series, episode\n";
						media_type = '\0';
						user_menu_error_sts = RUNSTS_ERROR;
						break;
					}
				}
			}	
		}
		else
		{
			user_menu_error_sts = RUNSTS_ERROR;
			break;
		}
		
	}

	if (((argc > 1) && (help_request == 1)) || (count_menu_param_s > 1) || (count_menu_param_t > 1)) 
		cout << "Incorrect number of arguments\n";


	//Build API URL with user commands
	if ((user_menu_error_sts == RUNSTS_OK) && (help_request == 0))
	{
		if ((title[0] != '\0') && (media_type[0] != '\0'))
			if (media_type != "episode")
				url = "http://www.omdbapi.com/?t="+title+"&type="+media_type+"&apikey=155c1dad";
			else
				url = "http://www.omdbapi.com/?t="+title+"&Season=1&"+media_type+"=1&apikey=155c1dad";
		else if (title[0] != '\0')
			url = "http://www.omdbapi.com/?t="+title+"&apikey=155c1dad"; 
		else
			cout << "Missing movie title\n";
	}

	return url;
}

//////////////////////////
//Curl write funtion
/////////////////////////
string curl_buffer;
size_t curl_write( void *ptr, size_t size, size_t nmemb, void *stream)
{
curl_buffer.append((char*)ptr, size*nmemb);
return size*nmemb;
}

//////////////////////////
//JSON parse and print funtion
/////////////////////////
int	json_print(string curl_buffer)
{
	int json_error_sts = RUNSTS_OK;     // JSON function status error
	
	// JSON parse
	const char* json = curl_buffer.c_str();
	Document omdb_data;
	omdb_data.Parse(json);
	
	// JSON Print 
	for(rapidjson::Value::ConstMemberIterator iter = omdb_data.MemberBegin(); iter != omdb_data.MemberEnd(); ++iter)
	{
		if(iter->name.IsString() && iter->value.IsString())
		{	
			string iter_aKey = iter->name.GetString();
			string Key_Respose = "Response";
			if (iter_aKey != Key_Respose)
				cout << iter_aKey << " - " << iter->value.GetString() << endl;
		}	
		if(iter->name.IsString() && iter->value.IsArray())
		{
			string aKey = iter->name.GetString();
			cout << aKey << " - "<< endl;
			const rapidjson::Value& aJsonData = omdb_data[aKey.c_str()];
			if(aJsonData.IsArray())
			{
				for (rapidjson::SizeType i = 0; i < aJsonData.Size(); i++)
				{
					for(rapidjson::Value::ConstMemberIterator iter1 = aJsonData[i].MemberBegin(); iter1 != aJsonData[i].MemberEnd(); ++iter1)
					{
						if(iter1->name.IsString() && iter1->value.IsString())
							cout << iter1->name.GetString() << " : " << iter1->value.GetString() << endl;
					}
				}
			}
		}
	}
	
	return json_error_sts;
}

//////////////////////////
//API RESTful OMDb JSON request funtion
/////////////////////////
int omdb_request(string url)
{
	int omdb_error_sts = RUNSTS_OK;     // OMDb function status error
	int omdb_error_sts_tmp;             // OMDb function status error temporary
	
	if (url != "Invalid")
	{
		//Initiate curl
		CURL *curl;
		CURLcode res;	
		curl = curl_easy_init();   

		if(curl) {
			//set url to visit
			curl_easy_setopt(curl, CURLOPT_URL, url.c_str());
			/* if URL is redirected, we tell libcurl to follow redirection */
			curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
			curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, curl_write);
			/* Perform the request, res will get the return code */ 
			res = curl_easy_perform(curl);
			/* Check for errors */ 
			if(res != CURLE_OK){
				fprintf(stderr, "curl_easy_perform() failed: %s\n",curl_easy_strerror(res));
				omdb_error_sts = RUNSTS_ERROR;
			}
			try{
				//if response is too short, it's an error!
				if(curl_buffer.length()<100){ 
					throw ERROR_BUFFER_SHORT;
				}
				else{
					omdb_error_sts_tmp = json_print(curl_buffer);
					if (omdb_error_sts_tmp == RUNSTS_ERROR)
					{
						omdb_error_sts = RUNSTS_ERROR;
						throw ERROR_JSON_PARSE;
					}
				}
			}
			catch(int list_error){ // catch exceptions
				if (list_error == ERROR_BUFFER_SHORT)
					cout<<"ERROR: Curl buffer too short! Please check the spelling or try another title\n";
				if (list_error == ERROR_JSON_PARSE)
					cout<<"ERROR: on JSON parse or print!\n";
				omdb_error_sts = RUNSTS_ERROR;
			}

			// cleanup data storage*/
			curl_buffer.clear();
			curl_easy_cleanup(curl);
		}
	}
	return omdb_error_sts;
}

//////////////////////////
//Main function
/////////////////////////
int main(int argc, char** argv) 
{
	string url;                             // URL string mounter
	int main_error_sts;                     // Main function status error
	
	//Capture user command line and generates URL
	url = user_menu(argc, argv);
	
	if (url != "") 
		//Request OMDb API
		main_error_sts = omdb_request(url);
	else
		main_error_sts = RUNSTS_ERROR;
	
	return main_error_sts;
}