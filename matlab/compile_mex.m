clear all
clear mex
clc
EIGEN_DIR = 'c:\work\thirdparty\eigen3\';
RANSACLIB_DIR = '../RansacLib/';
sources = {'../solvers/bujnak_accv10.cc', ...
    '../solvers/kukelova_iccv13.cc','../solvers/larsson_iccv17.cc', ...
    '../solvers/larsson_iccv19.cc','../solvers/larsson_iccv19_impl.cc', ...
    '../solvers/oskarsson_arxiv18.cc','../misc/distortion.cc', ...
    '../misc/univariate.cc','../misc/refinement.cc'};



comp_flags = "COMPFLAGS=$COMPFLAGS /bigobj";
%%
tic
mex(comp_flags,'-v','-DEIGEN_NO_DEBUG',['-I' EIGEN_DIR],'radialpose_mex.cc',sources{:})
toc
%%
tic
mex(comp_flags,'-v','-D_USE_MATH_DEFINES','-DEIGEN_NO_DEBUG',['-I' RANSACLIB_DIR],['-I' EIGEN_DIR],'ransac_radialpose_mex.cc',sources{:})
toc
%%


x = randn(2,10);
X = randn(3,10);

[R,t,f,dist] = radialpose_mex(x,X,8);
