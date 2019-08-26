cmake_minimum_required (VERSION 3.1)
project (radialpose)

if(NOT CMAKE_BUILD_TYPE OR CMAKE_BUILD_TYPE STREQUAL "")
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "" FORCE)
endif()




set (CMAKE_CXX_STANDARD 14)

add_compile_options(-Wall -Werror -Wno-maybe-uninitialized -Wno-sign-compare -Wno-unused-variable -Wno-unused-but-set-variable)

find_package (Eigen3 REQUIRED NO_MODULE)
include_directories("RansacLib")

add_library(radialpose STATIC solvers/bujnak_accv10.cc solvers/kukelova_iccv13.cc solvers/larsson_iccv17.cc solvers/larsson_iccv19.cc solvers/larsson_iccv19_impl.cc solvers/oskarsson_arxiv18.cc misc/distortion.cc misc/univariate.cc misc/refinement.cc)
target_link_libraries (radialpose Eigen3::Eigen)

add_executable (radialpose_test radialpose_test.cc)
target_link_libraries (radialpose_test LINK_PUBLIC radialpose Eigen3::Eigen)

add_executable (ransac_test ransac_test.cc)
target_link_libraries (ransac_test LINK_PUBLIC radialpose Eigen3::Eigen)


