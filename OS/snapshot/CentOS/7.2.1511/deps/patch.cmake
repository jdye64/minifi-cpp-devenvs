diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9d80e57..cd73cce 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -53,6 +53,7 @@ find_package(Threads REQUIRED)
 list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
 
 add_subdirectory(thirdparty/yaml-cpp-yaml-cpp-0.5.3)
+add_subdirectory(thirdparty/leveldb-1.18)
 add_subdirectory(libminifi)
 add_subdirectory(main)
 
diff --git a/libminifi/CMakeLists.txt b/libminifi/CMakeLists.txt
index ff1634a..726d6d5 100644
--- a/libminifi/CMakeLists.txt
+++ b/libminifi/CMakeLists.txt
@@ -38,6 +38,7 @@ set(CMAKE_CXX_STANDARD_REQUIRED ON)
 
 include_directories(../include)
 include_directories(../thirdparty/yaml-cpp-yaml-cpp-0.5.3/include)
+include_directories(../thirdparty/leveldb-1.18/include)
 include_directories(include)
 
 file(GLOB SOURCES "src/*.cpp")
@@ -57,12 +58,3 @@ else ()
     # Build from our local version
 endif (LIBXML2_FOUND)
 
-# Include LevelDB
-find_package (Leveldb REQUIRED)
-if (LEVELDB_FOUND)
-	include_directories(${LEVELDB_INCLUDE_DIRS})
-	target_link_libraries (minifi ${LEVELDB_LIBRARIES})
-else ()
-    message( FATAL_ERROR "LevelDB was not found. Please install LevelDB" )
-endif (LEVELDB_FOUND)
-
diff --git a/main/CMakeLists.txt b/main/CMakeLists.txt
index 3e0bbc4..b713df1 100644
--- a/main/CMakeLists.txt
+++ b/main/CMakeLists.txt
@@ -48,7 +48,7 @@ endif()
 find_package(UUID REQUIRED)
 
 # Link against minifi, yaml-cpp, uuid, and leveldb
-target_link_libraries(minifiexe minifi yaml-cpp ${UUID_LIBRARIES} ${LEVELDB_LIBRARIES})
+target_link_libraries(minifiexe minifi yaml-cpp leveldb ${UUID_LIBRARIES} ${LEVELDB_LIBRARIES})
 set_target_properties(minifiexe
         PROPERTIES OUTPUT_NAME minifi)
 
diff --git a/thirdparty/leveldb-1.18/CMakeLists.txt b/thirdparty/leveldb-1.18/CMakeLists.txt
index 09e72e9..27bdadf 100755
--- a/thirdparty/leveldb-1.18/CMakeLists.txt
+++ b/thirdparty/leveldb-1.18/CMakeLists.txt
@@ -1,4 +1,4 @@
-cmake_minimum_required(VERSION 3.0.2 FATAL_ERROR)
+cmake_minimum_required(VERSION 2.8.0 FATAL_ERROR)
 
 project(leveldb CXX)    
 set(CMAKE_DEBUG_POSTFIX "d")
