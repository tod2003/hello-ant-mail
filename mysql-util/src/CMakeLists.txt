#---------------------------------base----------------------------------------#
#set cmake minimum required version
cmake_minimum_required(VERSION 3.3)

#set variable of project name
set(PROJECT_NAME mysql-util)

#set variable of folder name
set(FOLDER_NAME mysql-util)

#set project name
project(${PROJECT_NAME})

add_definitions(-DUNICODE -D_UNICODE)
if(WIN32)
	add_definitions(-D_WINDOWS -DLIBCACHE_EXPORTS)
elseif(UNIX)
    add_definitions(-D_UNIX)
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=gnu++11 -Wall " CACHE STRING "" FORCE)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -Wall -Wextra -fPIC" CACHE STRING "" FORCE)
endif()

#---------------------------link--------------------------------------#

message("---------------- trying to find Jsoncpp ------------------")
find_package(Jsoncpp)
if(Jsoncpp_FOUND)
	message("INFO: we found LibJsoncpp on your pc.")
	message(Jsoncpp_FOUND = ${Jsoncpp_FOUND})
	message(Jsoncpp_INCLUDE_DIR = ${Jsoncpp_INCLUDE_DIR})
	message(Jsoncpp_LIBRARY = ${Jsoncpp_LIBRARY})
else(Jsoncpp_FOUND)
	message("WARNING: we couldn't find LibJsoncpp on your pc. DLC is
disabled.")
endif(Jsoncpp_FOUND)
message("----------------------------------------------------------")

#include directories
foreach(include_dirs
    ${CMAKE_CURRENT_SOURCE_DIR}/
    ../dist/include
    /home/3rdparty/boost_1_63_0
    )
  include_directories(${include_dirs})
endforeach()

#link directories
foreach(link_dirs
    #${PROJECT_BINARY_DIR}/lib
    ../dist/lib/
    /home/3rdparty/boost_1_63_0/lib
    /usr/lib64/mysql
     )
  link_directories(${link_dirs})
endforeach()

#------------------------------------------------------------------#

#find target header files & source files
#GLOB_RECURSE-traverse directory recursively
#GLOB-traverse current directory only
file(GLOB_RECURSE TARGET_H "*.h")
file(GLOB_RECURSE TARGET_SRC "*.cpp")

set(SRC_LIST ${TARGET_H} ${TARGET_SRC})
aux_source_directory(./ SRC_LIST)

set(src_util
  MySql.cpp
  MySqlException.cpp
  MySqlPreparedStatement.cpp
  OutputBinder.cpp
)

set(src_examples
  ${src_util}
  examples.cpp
)
set(src_test
   tests/*
)

#generate lib file
add_library(${PROJECT_NAME} SHARED ${src_util})
add_executable(examples ${src_examples})

#set target properties
set_target_properties(${PROJECT_NAME} PROPERTIES FOLDER ${FOLDER_NAME})

#link additional libs
foreach(libs_dep
	pthread
        mysqlclient_r
#	boost_util_test_framework 
#	json-cpp
#	http-parser
    )
  target_link_libraries(${PROJECT_NAME} ${libs_dep})
  target_link_libraries(examples ${libs_dep})
endforeach()


#-----------------------istall-------------------------------------#
install(TARGETS ${PROJECT_NAME} 
    RUNTIME DESTINATION $ENV{PATH_DIST}/bin
    LIBRARY DESTINATION $ENV{PATH_DIST}/lib
    ARCHIVE DESTINATION $ENV{PATH_DIST}/lib)

install(TARGETS examples 
    RUNTIME DESTINATION $ENV{PATH_DIST}/bin
    LIBRARY DESTINATION $ENV{PATH_DIST}/lib
    ARCHIVE DESTINATION $ENV{PATH_DIST}/lib)
	
#HEADER-FILES
install(DIRECTORY . DESTINATION $ENV{PATH_DIST}/include/${PROJECT_NAME} FILES_MATCHING PATTERN
"*.h")

#add_subdirectory(test)
