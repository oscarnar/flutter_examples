cmake_minimum_required(VERSION 3.4.1) 

add_library( native_plugin # Name

             # Sets the library as a shared library.
             SHARED

             # Provides a relative path to your source file(s).
             ../ios/Classes/native_plugin.cpp )