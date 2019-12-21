#set cmake minimum required version
cmake_minimum_required(VERSION 3.3)

#set variable of project name
set(ProjectName http-parser)

#set variable of folder name
set(FolderName http-parser)

#set project name
project(${ProjectName})

add_definitions(-DUNICODE -D_UNICODE)
if(WIN32)
	add_definitions(-D_WINDOWS -DLIBCACHE_EXPORTS)
elseif(UNIX)
    add_definitions(-D_UNIX)
    SET(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c++0x  -Wall " CACHE STRING "" FORCE)
    SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x -Wall -Wextra -Werror -fPIC  " CACHE STRING "" FORCE)
endif()

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


#include directories
foreach(include_dirs
    ${CMAKE_CURRENT_SOURCE_DIR}/
    )
  include_directories(${include_dirs})
endforeach()

#link directories
foreach(link_dirs
    #${PROJECT_BINARY_DIR}/lib
     )
  link_directories(${link_dirs})
endforeach()


#find target header files & source files
#GLOB_RECURSE-traverse directory recursively
#GLOB-traverse current directory only
file(GLOB_RECURSE TARGET_H "*.h")
file(GLOB_RECURSE TARGET_SRC "*.cpp")

set(SRC_LIST ${TARGET_H} bench.c http_parser.c)#${TARGET_SRC})
#aux_source_directory(./ SRC_LIST)
#----------------------link-----------------------------------------
#generate lib file
add_library(${ProjectName} SHARED ${SRC_LIST})

#set target properties
set_target_properties(${ProjectName} PROPERTIES FOLDER ${FolderName})

#link additional libs
foreach(myLibs
    )
  target_link_libraries(${ProjectName} ${myLibs})
endforeach()

#aux_source_directory(${CMAKE_CURRENT_SOURCE_DIR} SRC_LIST)

#-----------------------istall--------------------------------------
install(TARGETS ${ProjectName} 
    RUNTIME DESTINATION $ENV{PATH_DIST}/bin
    LIBRARY DESTINATION $ENV{PATH_DIST}/bin
    ARCHIVE DESTINATION $ENV{PATH_DIST}/lib)
	
#HEADER-FILES
install(DIRECTORY . DESTINATION $ENV{PATH_DIST}/include/${ProjectName} FILES_MATCHING PATTERN
"*.h")


