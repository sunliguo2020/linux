#!/bin/bash
#Date : 
#Purpose :
#Created : 
#Modified :

function showdate(){
	date +%F	
	
	}
function showtime(){
	
	date +%r
	}
function mailadmin(){
    echo 	mail -s "Successfull Execution of script " root
	}
function getuserinfo()
{
	echo Please enter your firstname an lastname 
	read firstname lastname
	echo Hello $firstname $lastname
	
	}
showdate
showtime
mailadmin
getuserinfo
