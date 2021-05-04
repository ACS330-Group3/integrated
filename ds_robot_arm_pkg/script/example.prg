%%%
  VERSION:1
  LANGUAGE:ENGLISH
%%%

MODULE example

! UPDATE reference point
CONST robtarget P1:=[[639.4,-119.9,378.9],[0.13334, -0.23621, 0.96143, -0.04554],[0,-1,0,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]];
! UPDATE tool point
PERS tooldata Bic:=[TRUE,[[0.500839,-0.574904,226.276],[1,0,0,0]],[0.25,[85,0,65],[1,0,0,0],0.01,0.01,0.01]];
VAR num array_draw_x{2094}:= [9.0, 8.5, 8.5, 9.0, 9.0, 9.0, 9.0, 9.5, 9.5, 9.5, 9.5, 10.0, 10.0, 10.0, 10.0, 10.5, 10.5, 10.5, 10.5, 10.5, 10.5, 11.0, 11.0, 11.0, 11.0, 11.5, 11.5, 11.5, 11.5, 12.0, 12.0, 12.0, 12.0, 12.5, 12.5, 12.5, 12.5, 13.0, 13.0, 13.0, 13.0, 13.5, 13.5, 13.5, 13.5, 14.0, 14.0, 14.0, 14.0, 14.5, 14.5, 15.0, 15.0, 15.5, 15.5, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.0, 17.0, 17.5, 17.5, 17.5, 17.5, 18.0, 18.0, 18.0, 18.0, 17.5, 17.5, 17.5, 17.5, 17.0, 17.0, 17.0, 17.0, 16.5, 16.5, 16.5, 16.5, 16.0, 16.0, 16.0, 16.0, 15.5, 15.5, 15.5, 15.5, 15.5, 15.5, 15.0, 15.0, 14.5, 14.5, 14.0, 14.0, 13.5, 13.5, 13.0, 13.0, 12.5, 12.5, 12.0, 12.0, 11.5, 11.5, 11.0, 11.0, 10.5, 10.5, 10.0, 10.0, 9.5, 9.5, 9.0, 9.0, 8.5, 8.5, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 7.5, 8.0, 8.0, 8.5, 8.5, 9.0, 9.0, 9.5, 9.5, 10.0, 10.0, 9.5, 9.5, 9.0, 9.0, 8.5, 8.5, 8.0, 8.0, 8.0, 8.0, 7.5, 7.5, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.5, 8.5, 8.5, 8.5, 8.5, 8.5, 9.0, 9.0, 9.5, 9.5, 10.0, 10.0, 10.5, 10.5, 11.0, 11.0, 11.5, 11.5, 12.0, 12.0, 12.5, 12.5, 13.0, 13.0, 13.5, 13.5, 14.0, 14.0, 14.5, 14.5, 13.5, 13.5, 13.0, 13.0, 12.5, 12.5, 12.0, 12.0, 11.5, 11.5, 11.0, 11.0, 10.5, 10.5, 11.0, 11.0, 11.5, 11.5, 12.0, 12.0, 13.0, 13.0, 13.5, 13.5, 14.0, 14.0, 14.5, 14.5, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 14.5, 14.5, 14.0, 14.0, 14.5, 14.5, 15.0, 15.0, 15.5, 15.5, 16.0, 16.0, 16.0, 16.0, 16.0, 16.0, 15.5, 15.5, 15.0, 15.0, 16.5, 16.5, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 17.5, 17.5, 17.5, 17.5, 17.5, 17.5, 18.5, 18.5, 18.5, 18.5, 18.0, 18.0, 18.0, 18.0, 17.5, 17.5, 17.0, 17.0, 17.0, 17.0, 17.0, 17.0, 16.0, 16.0, 16.0, 16.0, 16.5, 16.5, 16.5, 16.5, 17.0, 17.0, 17.0, 17.0, 16.0, 16.0, 15.5, 15.5, 15.0, 15.0, 14.5, 14.5, 14.0, 14.0, 13.5, 13.5, 13.0, 13.0, 12.5, 12.5, 12.0, 12.0, 11.5, 11.5, 11.0, 11.0, 10.5, 10.5, 10.0, 10.0, 10.0, 10.0, 10.0, 10.0, 10.5, 10.5, 11.0, 11.0, 11.5, 11.5, 12.0, 12.0, 12.5, 12.5, 13.0, 13.0, 13.5, 13.5, 14.0, 14.0, 14.0, 14.0, 14.0, 14.0, 14.5, 14.5, 14.5, 14.5, 15.0, 15.0, 15.0, 15.0, 15.5, 15.5, 15.5, 15.5, 16.5, 16.5, 16.0, 16.0, 16.0, 16.0, 16.0, 16.0, 15.5, 15.5, 15.5, 15.5, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.5, 15.5, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 18.0, 18.0, 18.5, 18.5, 19.0, 19.0, 19.5, 19.5, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 19.0, 19.0, 19.5, 19.5, 20.0, 20.0, 20.0, 20.0, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 22.5, 22.5, 23.0, 23.0, 23.0, 23.0, 23.0, 23.0, 23.5, 23.5, 23.5, 23.5, 24.0, 24.0, 24.0, 24.0, 24.5, 24.5, 24.5, 24.5, 25.0, 25.0, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 22.5, 22.5, 23.0, 23.0, 23.5, 23.5, 24.0, 24.0, 24.5, 24.5, 25.0, 25.0, 25.5, 25.5, 26.0, 26.0, 26.5, 26.5, 27.0, 27.0, 27.0, 27.0, 27.0, 27.0, 26.5, 26.5, 26.5, 26.5, 26.0, 26.0, 26.0, 26.0, 27.0, 27.0, 27.0, 27.0, 27.5, 27.5, 27.5, 27.5, 27.5, 27.5, 28.0, 28.0, 28.0, 28.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 31.5, 31.5, 32.0, 32.0, 32.5, 32.5, 33.0, 33.0, 33.0, 33.0, 33.5, 33.5, 33.5, 33.5, 33.0, 33.0, 32.5, 32.5, 32.0, 32.0, 31.5, 31.5, 26.5, 26.5, 26.5, 26.5, 26.0, 26.0, 26.0, 26.0, 25.5, 25.5, 25.0, 25.0, 25.0, 25.0, 25.0, 25.0, 24.5, 24.5, 24.0, 24.0, 24.0, 24.0, 23.5, 23.5, 23.5, 23.5, 23.5, 23.5, 24.0, 24.0, 24.5, 24.5, 25.0, 25.0, 25.5, 25.5, 26.0, 26.0, 26.5, 26.5, 27.0, 27.0, 27.5, 27.5, 28.0, 28.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 32.0, 32.0, 32.0, 32.0, 32.5, 32.5, 32.5, 32.5, 33.0, 33.0, 33.0, 33.0, 33.5, 33.5, 33.5, 33.5, 34.0, 34.0, 34.0, 34.0, 34.5, 34.5, 35.0, 35.0, 35.0, 35.0, 35.5, 35.5, 35.5, 35.5, 36.0, 36.0, 36.0, 36.0, 36.0, 36.0, 36.5, 36.5, 36.5, 36.5, 37.0, 37.0, 37.0, 37.0, 37.0, 37.0, 36.5, 36.5, 36.5, 36.5, 36.0, 36.0, 37.5, 37.5, 38.0, 38.0, 38.5, 38.5, 39.0, 39.0, 39.5, 39.5, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 40.0, 39.5, 39.5, 39.0, 39.0, 38.5, 38.5, 38.0, 38.0, 37.5, 37.5, 36.0, 36.0, 36.0, 36.0, 35.5, 35.5, 35.0, 35.0, 34.5, 34.5, 31.5, 31.5, 31.0, 31.0, 31.0, 31.0, 30.5, 30.5, 30.5, 30.5, 30.0, 30.0, 30.0, 30.0, 29.5, 29.5, 29.5, 29.5, 29.0, 29.0, 29.0, 29.0, 28.5, 28.5, 28.5, 28.5, 28.0, 28.0, 28.0, 28.0, 27.5, 27.5, 27.5, 27.5, 27.0, 27.0, 27.0, 27.0, 26.5, 26.5, 26.5, 26.5, 26.0, 26.0, 26.0, 26.0, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 26.0, 26.0, 26.5, 26.5, 27.0, 27.0, 27.5, 27.5, 27.0, 27.0, 26.5, 26.5, 26.0, 26.0, 26.5, 26.5, 27.0, 27.0, 27.5, 27.5, 28.0, 28.0, 28.5, 28.5, 28.5, 28.5, 28.0, 28.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 31.0, 31.0, 32.5, 32.5, 33.0, 33.0, 33.5, 33.5, 32.0, 32.0, 31.5, 31.5, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 32.0, 32.0, 33.0, 33.0, 34.0, 34.0, 34.5, 34.5, 35.0, 35.0, 35.5, 35.5, 36.0, 36.0, 36.5, 36.5, 37.0, 37.0, 37.5, 37.5, 38.0, 38.0, 38.5, 38.5, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 38.5, 38.5, 38.0, 38.0, 37.5, 37.5, 37.0, 37.0, 36.5, 36.5, 36.0, 36.0, 35.5, 35.5, 35.0, 35.0, 34.5, 34.5, 34.0, 34.0, 33.5, 33.5, 33.0, 33.0, 32.5, 32.5, 32.0, 32.0, 31.5, 31.5, 31.0, 31.0, 30.5, 30.5, 30.0, 30.0, 29.5, 29.5, 29.0, 29.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 32.0, 32.0, 32.5, 32.5, 33.0, 33.0, 33.5, 33.5, 34.0, 34.0, 34.5, 34.5, 35.0, 35.0, 35.5, 35.5, 36.0, 36.0, 36.5, 36.5, 37.0, 37.0, 37.5, 37.5, 38.0, 38.0, 38.5, 38.5, 38.5, 38.5, 38.5, 38.5, 38.0, 38.0, 38.0, 38.0, 38.0, 38.0, 37.5, 37.5, 37.5, 37.5, 37.5, 37.5, 37.0, 37.0, 37.0, 37.0, 36.5, 36.5, 36.0, 36.0, 35.0, 35.0, 34.5, 34.5, 34.0, 34.0, 33.5, 33.5, 33.0, 33.0, 32.5, 32.5, 32.0, 32.0, 32.5, 32.5, 33.0, 33.0, 33.5, 33.5, 34.5, 34.5, 35.5, 35.5, 36.0, 36.0, 36.0, 36.0, 36.0, 36.0, 36.0, 36.0, 35.5, 35.5, 35.5, 35.5, 35.0, 35.0, 35.0, 35.0, 34.5, 34.5, 34.0, 34.0, 33.5, 33.5, 33.0, 33.0, 32.5, 32.5, 32.0, 32.0, 31.0, 31.0, 30.5, 30.5, 30.5, 30.5, 30.0, 30.0, 30.0, 30.0, 31.5, 31.5, 31.0, 31.0, 30.5, 30.5, 30.0, 30.0, 29.5, 29.5, 29.0, 29.0, 28.5, 28.5, 28.0, 28.0, 27.5, 27.5, 27.0, 27.0, 26.5, 26.5, 26.0, 26.0, 27.0, 27.0, 27.5, 27.5, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 31.0, 31.0, 30.5, 30.5, 30.0, 30.0, 29.0, 29.0, 28.5, 28.5, 28.0, 28.0, 27.5, 27.5, 27.0, 27.0, 27.0, 27.0, 26.5, 26.5, 26.0, 26.0, 26.5, 26.5, 26.5, 26.5, 26.0, 26.0, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.0, 25.0, 24.5, 24.5, 24.0, 24.0, 23.5, 23.5, 23.0, 23.0, 22.5, 22.5, 22.0, 22.0, 21.5, 21.5, 25.0, 25.0, 25.5, 25.5, 25.5, 25.5, 26.0, 26.0, 26.0, 26.0, 26.5, 26.5, 26.5, 26.5, 27.0, 27.0, 27.0, 27.0, 27.5, 27.5, 27.5, 27.5, 28.0, 28.0, 28.0, 28.0, 28.5, 28.5, 28.5, 28.5, 29.0, 29.0, 29.0, 29.0, 29.5, 29.5, 29.5, 29.5, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 19.5, 19.5, 19.0, 19.0, 18.5, 18.5, 18.5, 18.5, 18.5, 18.5, 18.0, 18.0, 18.0, 18.0, 18.0, 18.0, 17.5, 17.5, 17.5, 17.5, 17.0, 17.0, 17.0, 17.0, 16.5, 16.5, 16.0, 16.0, 15.5, 15.5, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.0, 15.5, 15.5, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 17.5, 17.5, 17.5, 17.5, 18.5, 18.5, 18.5, 18.5, 20.0, 20.0, 20.0, 20.0, 19.0, 19.0, 19.5, 19.5, 20.0, 20.0, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 22.5, 22.5, 23.0, 23.0, 23.5, 23.5, 24.0, 24.0, 24.5, 24.5, 25.0, 25.0, 25.5, 25.5, 26.0, 26.0, 26.5, 26.5, 27.0, 27.0, 27.5, 27.5, 28.0, 28.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 31.5, 31.5, 31.0, 31.0, 31.5, 31.5, 31.5, 31.5, 32.0, 32.0, 33.5, 33.5, 33.0, 33.0, 33.0, 33.0, 32.5, 32.5, 33.0, 33.0, 33.0, 33.0, 33.5, 33.5, 33.5, 33.5, 34.0, 34.0, 34.5, 34.5, 34.5, 34.5, 35.0, 35.0, 35.5, 35.5, 35.5, 35.5, 35.5, 35.5, 35.5, 35.5, 35.0, 35.0, 39.0, 39.0, 39.5, 39.5, 40.0, 40.0, 40.5, 40.5, 41.0, 41.0, 41.5, 41.5, 42.0, 42.0, 42.5, 42.5, 43.0, 43.0, 43.5, 43.5, 44.0, 44.0, 44.5, 44.5, 45.0, 45.0, 45.5, 45.5, 46.0, 46.0, 46.5, 46.5, 47.0, 47.0, 47.5, 47.5, 48.0, 48.0, 48.5, 48.5, 49.0, 49.0, 49.5, 49.5, 49.5, 49.5, 49.0, 49.0, 48.5, 48.5, 48.0, 48.0, 47.5, 47.5, 47.0, 47.0, 46.5, 46.5, 46.0, 46.0, 45.5, 45.5, 45.0, 45.0, 44.5, 44.5, 44.0, 44.0, 43.5, 43.5, 43.0, 43.0, 42.5, 42.5, 42.0, 42.0, 41.5, 41.5, 41.0, 41.0, 40.5, 40.5, 40.0, 40.0, 39.5, 39.5, 39.0, 39.0, 38.5, 38.5, 38.5, 38.5, 38.0, 38.0, 38.0, 38.0, 37.5, 37.5, 37.5, 37.5, 37.0, 37.0, 37.0, 37.0, 36.5, 36.5, 36.5, 36.5, 36.0, 36.0, 35.5, 35.5, 35.0, 35.0, 34.5, 34.5, 34.5, 34.5, 34.0, 34.0, 34.0, 34.0, 33.5, 33.5, 33.5, 33.5, 33.0, 33.0, 33.0, 33.0, 32.5, 32.5, 32.5, 32.5, 32.0, 32.0, 32.0, 32.0, 31.5, 31.5, 31.5, 31.5, 31.0, 31.0, 31.0, 31.0, 30.5, 30.5, 30.5, 30.5, 30.0, 30.0, 30.0, 30.0, 29.5, 29.5, 29.5, 29.5, 29.0, 29.0, 29.0, 29.0, 28.5, 28.5, 28.5, 28.5, 28.0, 28.0, 28.0, 28.0, 27.5, 27.5, 27.5, 27.5, 27.0, 27.0, 26.0, 26.0, 26.0, 26.0, 25.5, 25.5, 25.5, 25.5, 25.0, 25.0, 25.0, 25.0, 24.5, 24.5, 24.5, 24.5, 24.0, 24.0, 24.0, 24.0, 23.5, 23.5, 23.5, 23.5, 23.0, 23.0, 23.0, 23.0, 22.5, 22.5, 22.5, 22.5, 22.0, 22.0, 22.0, 22.0, 21.5, 21.5, 21.5, 21.5, 21.0, 21.0, 21.0, 21.0, 20.5, 20.5, 20.5, 20.5, 20.0, 20.0, 20.0, 20.0, 19.5, 19.5, 19.5, 19.5, 19.0, 19.0, 19.0, 19.0, 18.5, 18.5, 18.5, 18.5, 18.0, 18.0, 18.0, 18.0, 17.5, 17.5, 17.5, 17.5, 17.0, 17.0, 17.0, 17.0, 16.5, 16.5, 16.5, 16.5, 16.0, 16.0, 16.0, 16.0, 15.5, 15.5, 15.5, 15.5, 15.0, 15.0, 14.5, 14.5, 14.0, 14.0, 14.0, 14.0, 13.5, 13.5, 13.5, 13.5, 13.0, 13.0, 13.0, 13.0, 12.5, 12.5, 12.5, 12.5, 12.0, 12.0, 12.0, 12.0, 11.5, 11.5, 11.5, 11.5, 11.0, 11.0, 11.0, 11.0, 10.5, 10.5, 10.5, 10.5, 10.0, 10.0, 10.0, 10.0, 9.5, 9.5, 9.5, 9.5, 9.0, 9.0, 9.0, 9.0, 8.5, 8.5, 8.5, 8.5, 8.0, 8.0, 8.0, 8.0, 7.5, 7.5, 7.5, 7.5, 7.0, 7.0, 7.0, 7.0, 6.5, 6.5, 6.5, 6.5, 6.0, 6.0, 6.0, 6.0, 5.5, 5.5, 5.5, 5.5, 5.0, 5.0, 5.0, 5.0, 4.5, 4.5, 4.5, 4.5, 4.0, 4.0, 4.0, 4.0, 3.5, 3.5, 3.5, 3.5, 3.0, 3.0, 3.0, 3.0, 2.5, 2.5, 2.5, 2.5, 2.0, 2.0, 2.0, 2.0, 1.5, 1.5, 1.5, 1.5, 1.0, 1.0, 1.0, 1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 1.5, 1.5, 1.5, 1.5, 2.0, 2.0, 2.0, 2.0, 2.5, 2.5, 2.5, 2.5, 3.0, 3.0, 3.0, 3.0, 3.5, 3.5, 3.5, 3.5, 4.0, 4.0, 4.0, 4.0, 4.5, 4.5, 4.5, 4.5, 5.0, 5.0, 5.0, 5.0, 5.5, 5.5, 5.5, 5.5, 6.0, 6.0, 6.0, 6.0, 6.5, 6.5, 6.5, 6.5, 7.0, 7.0, 7.0, 7.0, 7.5, 7.5, 7.5, 7.5, 8.0, 8.0, 8.0, 8.0, 8.5, 8.5, 8.5, 8.5, 9.0, 9.0, 9.0, 9.0, 9.5, 9.5, 10.0, 10.0, 10.5, 10.5, 11.0, 11.0, 11.5, 11.5, 12.0, 12.0, 12.5, 12.5, 13.0, 13.0, 13.0, 13.0, 13.5, 13.5, 13.5, 13.5, 14.0, 14.0, 14.0, 14.0, 14.5, 14.5, 14.5, 14.5, 15.0, 15.0, 15.0, 15.0, 15.5, 15.5, 15.5, 15.5, 16.0, 16.0, 16.0, 16.0, 16.5, 16.5, 16.5, 16.5, 17.0, 17.0, 17.0, 17.0, 17.5, 17.5, 17.5, 17.5, 18.0, 18.0, 18.0, 18.0, 18.5, 18.5, 18.5, 18.5, 19.0, 19.0, 19.0, 19.0, 19.5, 19.5, 19.5, 19.5, 20.0, 20.0, 20.0, 20.0, 20.5, 20.5, 20.5, 20.5, 21.0, 21.0, 21.0, 21.0, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 22.0, 22.0, 22.5, 22.5, 23.5, 23.5, 24.0, 24.0, 24.0, 24.0, 24.5, 24.5, 24.5, 24.5, 25.0, 25.0, 25.0, 25.0, 25.5, 25.5, 25.5, 25.5, 26.0, 26.0, 26.0, 26.0, 26.5, 26.5, 26.5, 26.5, 27.0, 27.0, 27.0, 27.0, 27.5, 27.5, 27.5, 27.5, 28.0, 28.0, 28.0, 28.0, 28.5, 28.5, 28.5, 28.5, 29.0, 29.0, 29.0, 29.0, 29.5, 29.5, 29.5, 29.5, 30.0, 30.0, 30.0, 30.0, 30.5, 30.5, 30.5, 30.5, 31.0, 31.0, 31.0, 31.0, 31.5, 31.5, 31.5, 31.5, 32.0, 32.0, 32.0, 32.0, 32.5, 32.5, 32.5, 32.5, 33.0, 33.0, 33.0, 33.0, 33.5, 33.5, 33.5, 33.5, 34.0, 34.0, 34.0, 34.0, 34.5, 34.5, 34.5, 34.5, 35.0, 35.0, 35.0, 35.0, 35.5, 35.5, 35.5, 35.5, 36.0, 36.0, 36.0, 36.0, 36.5, 36.5, 36.5, 36.5, 37.0, 37.0, 37.0, 37.0, 37.5, 37.5, 37.5, 37.5, 38.0, 38.0, 38.0, 38.0, 38.5, 38.5, 38.5, 38.5, 39.0, 39.0, 39.0, 39.0, 39.5, 39.5, 39.5, 39.5, 40.0, 40.0, 40.0, 40.0, 40.5, 40.5, 41.0, 41.0, 41.0, 41.0, 41.5, 41.5, 41.5, 41.5, 42.0, 42.0, 42.0, 42.0, 42.5, 42.5, 42.5, 42.5, 43.0, 43.0, 43.0, 43.0, 43.5, 43.5, 43.5, 43.5, 44.0, 44.0, 44.0, 44.0, 44.5, 44.5, 44.5, 44.5, 45.0, 45.0, 45.0, 45.0, 45.5, 45.5, 45.5, 45.5, 46.0, 46.0, 46.0, 46.0, 46.5, 46.5, 46.5, 46.5, 47.0, 47.0, 47.0, 47.0, 47.5, 47.5, 47.5, 47.5, 48.0, 48.0, 48.0, 48.0, 48.5, 48.5, 48.5, 48.5, 49.0, 49.0, 49.0, 49.0, 49.5];
VAR num array_draw_y{2094}:= [27.0, 27.5, 27.5, 28.0, 28.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 31.5, 31.5, 32.0, 32.0, 32.0, 32.0, 32.5, 32.5, 32.5, 32.5, 33.0, 33.0, 33.0, 33.0, 33.5, 33.5, 33.5, 33.5, 34.0, 34.0, 34.0, 34.0, 34.5, 34.5, 34.5, 34.5, 35.0, 35.0, 35.0, 35.0, 34.5, 34.5, 34.5, 34.5, 34.0, 34.0, 34.0, 34.0, 34.0, 34.0, 33.5, 33.5, 32.5, 32.5, 32.0, 32.0, 31.5, 31.5, 31.0, 31.0, 31.0, 31.0, 30.5, 30.5, 30.5, 30.5, 30.0, 30.0, 30.0, 30.0, 29.5, 29.5, 29.5, 29.5, 29.0, 29.0, 28.5, 28.5, 28.0, 28.0, 27.5, 27.5, 27.0, 27.0, 26.5, 26.5, 26.5, 26.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.0, 25.0, 24.5, 24.5, 24.0, 24.0, 23.5, 23.5, 23.0, 23.0, 22.5, 22.5, 22.0, 22.0, 21.5, 21.5, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 21.0, 21.0, 21.0, 21.0, 20.5, 20.5, 20.5, 20.5, 20.5, 20.5, 20.0, 20.0, 19.5, 19.5, 19.0, 19.0, 18.5, 18.5, 18.0, 18.0, 17.5, 17.5, 17.0, 17.0, 16.5, 16.5, 16.0, 16.0, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 18.0, 18.0, 18.5, 18.5, 19.0, 19.0, 19.5, 19.5, 20.0, 20.0, 20.5, 20.5, 21.0, 21.0, 22.5, 22.5, 22.5, 22.5, 22.0, 22.0, 22.0, 22.0, 22.0, 22.0, 21.5, 21.5, 22.5, 22.5, 22.5, 22.5, 23.0, 23.0, 23.0, 23.0, 23.5, 23.5, 23.5, 23.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.0, 25.0, 24.5, 24.5, 24.0, 24.0, 24.0, 24.0, 24.0, 24.0, 23.0, 23.0, 23.0, 23.0, 23.5, 23.5, 23.5, 23.5, 23.0, 23.0, 22.5, 22.5, 22.0, 22.0, 21.5, 21.5, 21.0, 21.0, 21.5, 21.5, 21.5, 21.5, 21.5, 21.5, 21.5, 21.5, 21.0, 21.0, 20.5, 20.5, 20.0, 20.0, 19.5, 19.5, 19.0, 19.0, 19.5, 19.5, 19.0, 19.0, 18.5, 18.5, 18.0, 18.0, 17.0, 17.0, 16.5, 16.5, 16.0, 16.0, 15.5, 15.5, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 18.0, 18.0, 18.5, 18.5, 20.5, 20.5, 20.0, 20.0, 19.5, 19.5, 19.0, 19.0, 18.5, 18.5, 18.0, 18.0, 17.5, 17.5, 17.0, 17.0, 16.5, 16.5, 16.0, 16.0, 15.5, 15.5, 15.0, 15.0, 15.0, 15.0, 14.5, 14.5, 14.0, 14.0, 13.5, 13.5, 13.0, 13.0, 12.5, 12.5, 12.0, 12.0, 11.5, 11.5, 11.0, 11.0, 10.5, 10.5, 10.5, 10.5, 11.0, 11.0, 11.5, 11.5, 12.0, 12.0, 12.5, 12.5, 13.5, 13.5, 14.0, 14.0, 14.5, 14.5, 15.0, 15.0, 14.5, 14.5, 14.0, 14.0, 13.5, 13.5, 13.0, 13.0, 12.5, 12.5, 12.0, 12.0, 11.5, 11.5, 11.0, 11.0, 10.5, 10.5, 10.0, 10.0, 9.5, 9.5, 9.5, 9.5, 9.0, 9.0, 9.0, 9.0, 8.5, 8.5, 8.5, 8.5, 8.5, 8.5, 8.5, 8.5, 8.0, 8.0, 8.0, 8.0, 8.5, 8.5, 9.0, 9.0, 9.5, 9.5, 10.0, 10.0, 10.5, 10.5, 11.0, 11.0, 11.5, 11.5, 12.0, 12.0, 12.5, 12.5, 13.0, 13.0, 13.5, 13.5, 14.0, 14.0, 14.5, 14.5, 15.0, 15.0, 15.5, 15.5, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 18.0, 18.0, 18.5, 18.5, 19.0, 19.0, 19.5, 19.5, 20.5, 20.5, 20.5, 20.5, 20.5, 20.5, 20.0, 20.0, 20.0, 20.0, 20.5, 20.5, 20.5, 20.5, 20.5, 20.5, 20.0, 20.0, 19.5, 19.5, 19.0, 19.0, 18.5, 18.5, 18.0, 18.0, 17.0, 17.0, 16.5, 16.5, 16.0, 16.0, 15.5, 15.5, 14.5, 14.5, 14.0, 14.0, 13.5, 13.5, 13.0, 13.0, 8.5, 8.5, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.0, 8.5, 8.5, 8.5, 8.5, 8.5, 8.5, 9.0, 9.0, 9.5, 9.5, 10.0, 10.0, 10.5, 10.5, 11.0, 11.0, 12.0, 12.0, 12.5, 12.5, 12.5, 12.5, 12.0, 12.0, 11.5, 11.5, 11.0, 11.0, 10.5, 10.5, 10.0, 10.0, 9.5, 9.5, 9.5, 9.5, 9.5, 9.5, 9.5, 9.5, 10.0, 10.0, 10.0, 10.0, 10.5, 10.5, 10.5, 10.5, 11.0, 11.0, 11.0, 11.0, 11.5, 11.5, 11.5, 11.5, 12.0, 12.0, 12.0, 12.0, 12.5, 12.5, 13.0, 13.0, 13.5, 13.5, 14.0, 14.0, 14.5, 14.5, 13.5, 13.5, 14.0, 14.0, 14.5, 14.5, 15.0, 15.0, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 18.5, 18.5, 19.5, 19.5, 20.0, 20.0, 20.5, 20.5, 21.0, 21.0, 21.5, 21.5, 21.5, 21.5, 21.5, 21.5, 21.0, 21.0, 20.5, 20.5, 20.0, 20.0, 19.5, 19.5, 19.0, 19.0, 18.5, 18.5, 18.0, 18.0, 17.5, 17.5, 17.0, 17.0, 16.5, 16.5, 16.0, 16.0, 15.5, 15.5, 15.0, 15.0, 16.0, 16.0, 16.0, 16.0, 15.5, 15.5, 15.5, 15.5, 15.0, 15.0, 15.0, 15.0, 14.5, 14.5, 14.5, 14.5, 14.0, 14.0, 14.0, 14.0, 13.5, 13.5, 13.5, 13.5, 13.5, 13.5, 14.0, 14.0, 14.0, 14.0, 14.5, 14.5, 14.5, 14.5, 15.0, 15.0, 15.5, 15.5, 15.5, 15.5, 16.0, 16.0, 16.0, 16.0, 16.5, 16.5, 17.0, 17.0, 17.5, 17.5, 18.0, 18.0, 18.5, 18.5, 18.5, 18.5, 18.0, 18.0, 17.5, 17.5, 17.5, 17.5, 18.0, 18.0, 18.5, 18.5, 19.0, 19.0, 19.5, 19.5, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 20.0, 19.5, 19.5, 19.0, 19.0, 19.5, 19.5, 19.5, 19.5, 20.0, 20.0, 20.0, 20.0, 16.5, 16.5, 16.5, 16.5, 17.0, 17.0, 17.0, 17.0, 17.5, 17.5, 17.5, 17.5, 18.0, 18.0, 18.0, 18.0, 18.5, 18.5, 18.5, 18.5, 19.0, 19.0, 19.0, 19.0, 19.5, 19.5, 19.5, 19.5, 20.0, 20.0, 20.0, 20.0, 20.5, 20.5, 20.5, 20.5, 21.0, 21.0, 21.0, 21.0, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 22.0, 22.0, 22.5, 22.5, 23.0, 23.0, 23.5, 23.5, 23.5, 23.5, 23.5, 23.5, 23.0, 23.0, 24.0, 24.0, 24.0, 24.0, 24.5, 24.5, 25.0, 25.0, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 23.5, 23.5, 22.5, 22.5, 22.5, 22.5, 22.0, 22.0, 22.0, 22.0, 23.0, 23.0, 23.0, 23.0, 23.0, 23.0, 22.5, 22.5, 22.0, 22.0, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 22.0, 22.0, 21.5, 21.5, 21.5, 21.5, 21.0, 21.0, 21.0, 21.0, 20.5, 20.5, 20.0, 20.0, 21.0, 21.0, 21.0, 21.0, 20.5, 20.5, 20.5, 20.5, 20.5, 20.5, 20.5, 20.5, 21.0, 21.0, 21.0, 21.0, 21.5, 21.5, 22.0, 22.0, 22.5, 22.5, 23.0, 23.0, 23.5, 23.5, 24.0, 24.0, 24.5, 24.5, 25.0, 25.0, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 25.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 26.5, 27.0, 27.0, 27.5, 27.5, 28.0, 28.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 32.0, 32.0, 32.0, 32.0, 32.0, 32.0, 31.5, 31.5, 31.5, 31.5, 31.0, 31.0, 31.0, 31.0, 31.0, 31.0, 30.5, 30.5, 31.5, 31.5, 31.5, 31.5, 32.0, 32.0, 32.0, 32.0, 32.5, 32.5, 33.0, 33.0, 33.0, 33.0, 33.5, 33.5, 34.0, 34.0, 34.5, 34.5, 35.0, 35.0, 35.5, 35.5, 36.0, 36.0, 36.5, 36.5, 37.0, 37.0, 37.0, 37.0, 37.5, 37.5, 37.5, 37.5, 37.0, 37.0, 36.5, 36.5, 37.0, 37.0, 37.0, 37.0, 36.5, 36.5, 36.5, 36.5, 36.0, 36.0, 36.0, 36.0, 35.5, 35.5, 35.0, 35.0, 34.5, 34.5, 34.0, 34.0, 33.5, 33.5, 33.0, 33.0, 32.5, 32.5, 32.0, 32.0, 31.5, 31.5, 31.0, 31.0, 30.5, 30.5, 29.5, 29.5, 29.5, 29.5, 30.0, 30.0, 30.0, 30.0, 30.5, 30.5, 30.5, 30.5, 30.5, 30.5, 31.0, 31.0, 30.0, 30.0, 30.0, 30.0, 29.5, 29.5, 29.5, 29.5, 29.0, 29.0, 29.0, 29.0, 28.5, 28.5, 28.5, 28.5, 28.5, 28.5, 26.5, 26.5, 27.0, 27.0, 27.5, 27.5, 28.0, 28.0, 29.0, 29.0, 29.0, 29.0, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 31.0, 31.0, 31.0, 31.0, 31.0, 31.0, 31.0, 31.0, 31.0, 31.0, 31.5, 31.5, 31.5, 31.5, 32.0, 32.0, 31.5, 31.5, 31.5, 31.5, 32.0, 32.0, 32.0, 32.0, 32.5, 32.5, 32.5, 32.5, 33.0, 33.0, 33.0, 33.0, 33.5, 33.5, 33.5, 33.5, 34.0, 34.0, 34.0, 34.0, 34.5, 34.5, 34.5, 34.5, 35.0, 35.0, 35.0, 35.0, 35.5, 35.5, 35.5, 35.5, 36.0, 36.0, 35.5, 35.5, 35.0, 35.0, 34.5, 34.5, 34.0, 34.0, 33.5, 33.5, 33.0, 33.0, 32.5, 32.5, 32.0, 32.0, 31.5, 31.5, 32.0, 32.0, 32.0, 32.0, 32.5, 32.5, 33.0, 33.0, 33.5, 33.5, 34.0, 34.0, 34.5, 34.5, 36.0, 36.0, 35.5, 35.5, 35.5, 35.5, 35.0, 35.0, 35.0, 35.0, 35.0, 35.0, 35.5, 35.5, 35.5, 35.5, 36.0, 36.0, 36.5, 36.5, 37.0, 37.0, 37.5, 37.5, 37.5, 37.5, 38.0, 38.0, 37.5, 37.5, 37.5, 37.5, 37.0, 37.0, 36.5, 36.5, 36.0, 36.0, 35.5, 35.5, 36.0, 36.0, 36.5, 36.5, 37.0, 37.0, 37.5, 37.5, 37.0, 37.0, 37.5, 37.5, 38.0, 38.0, 38.0, 38.0, 38.0, 38.0, 38.5, 38.5, 38.5, 38.5, 38.5, 38.5, 38.5, 38.5, 38.5, 38.5, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.0, 39.5, 39.5, 39.5, 39.5, 39.5, 39.5, 39.5, 39.5, 39.5, 39.5, 39.0, 39.0, 37.5, 37.5, 37.5, 37.5, 38.0, 38.0, 38.5, 38.5, 38.5, 38.5, 38.5, 38.5, 39.0, 39.0, 39.5, 39.5, 40.0, 40.0, 40.5, 40.5, 40.5, 40.5, 41.0, 41.0, 41.0, 41.0, 41.0, 41.0, 40.5, 40.5, 40.5, 40.5, 40.0, 40.0, 39.5, 39.5, 39.0, 39.0, 38.5, 38.5, 38.5, 38.5, 37.5, 37.5, 37.0, 37.0, 36.5, 36.5, 36.0, 36.0, 35.5, 35.5, 35.0, 35.0, 34.5, 34.5, 34.0, 34.0, 33.5, 33.5, 33.0, 33.0, 32.5, 32.5, 32.0, 32.0, 31.5, 31.5, 31.0, 31.0, 30.5, 30.5, 30.0, 30.0, 29.5, 29.5, 29.0, 29.0, 28.5, 28.5, 28.0, 28.0, 27.5, 27.5, 27.5, 27.5, 27.0, 27.0, 28.0, 28.0, 28.5, 28.5, 29.0, 29.0, 29.5, 29.5, 30.0, 30.0, 30.5, 30.5, 31.0, 31.0, 31.5, 31.5, 32.0, 32.0, 32.5, 32.5, 33.0, 33.0, 33.5, 33.5, 34.0, 34.0, 34.5, 34.5, 35.0, 35.0, 35.5, 35.5, 36.0, 36.0, 36.5, 36.5, 37.0, 37.0, 37.5, 37.5, 38.0, 38.0, 38.0, 38.0, 38.5, 38.5, 38.5, 38.5, 39.0, 39.0, 39.0, 39.0, 39.5, 39.5, 39.5, 39.5, 40.0, 40.0, 40.0, 40.0, 40.5, 40.5, 41.0, 41.0, 41.5, 41.5, 42.0, 42.0, 42.0, 42.0, 42.5, 42.5, 42.5, 42.5, 43.0, 43.0, 43.0, 43.0, 43.5, 43.5, 43.5, 43.5, 44.0, 44.0, 44.0, 44.0, 44.5, 44.5, 44.5, 44.5, 45.0, 45.0, 45.0, 45.0, 45.5, 45.5, 45.5, 45.5, 46.0, 46.0, 46.0, 46.0, 46.5, 46.5, 46.5, 46.5, 47.0, 47.0, 47.0, 47.0, 47.5, 47.5, 47.5, 47.5, 48.0, 48.0, 48.0, 48.0, 48.5, 48.5, 48.5, 48.5, 49.0, 49.0, 49.0, 49.0, 49.5, 49.5, 49.5, 49.5, 49.5, 49.5, 49.0, 49.0, 49.0, 49.0, 48.5, 48.5, 48.5, 48.5, 48.0, 48.0, 48.0, 48.0, 47.5, 47.5, 47.5, 47.5, 47.0, 47.0, 47.0, 47.0, 46.5, 46.5, 46.5, 46.5, 46.0, 46.0, 46.0, 46.0, 45.5, 45.5, 45.5, 45.5, 45.0, 45.0, 45.0, 45.0, 44.5, 44.5, 44.5, 44.5, 44.0, 44.0, 44.0, 44.0, 43.5, 43.5, 43.5, 43.5, 43.0, 43.0, 43.0, 43.0, 42.5, 42.5, 42.5, 42.5, 42.0, 42.0, 42.0, 42.0, 41.5, 41.5, 41.5, 41.5, 41.0, 41.0, 41.0, 41.0, 40.5, 40.5, 40.5, 40.5, 40.0, 40.0, 40.0, 40.0, 39.5, 39.5, 39.5, 39.5, 39.0, 39.0, 39.0, 39.0, 38.5, 38.5, 38.5, 38.5, 38.0, 38.0, 37.5, 37.5, 37.0, 37.0, 37.0, 37.0, 36.5, 36.5, 36.5, 36.5, 36.0, 36.0, 36.0, 36.0, 35.5, 35.5, 35.5, 35.5, 35.0, 35.0, 35.0, 35.0, 34.5, 34.5, 34.5, 34.5, 34.0, 34.0, 34.0, 34.0, 33.5, 33.5, 33.5, 33.5, 33.0, 33.0, 33.0, 33.0, 32.5, 32.5, 32.5, 32.5, 32.0, 32.0, 32.0, 32.0, 31.5, 31.5, 31.5, 31.5, 31.0, 31.0, 31.0, 31.0, 30.5, 30.5, 30.5, 30.5, 30.0, 30.0, 30.0, 30.0, 29.5, 29.5, 29.5, 29.5, 29.0, 29.0, 29.0, 29.0, 28.5, 28.5, 28.5, 28.5, 28.0, 28.0, 28.0, 28.0, 27.5, 27.5, 27.5, 27.5, 27.0, 27.0, 27.0, 27.0, 26.5, 26.5, 26.5, 26.5, 26.0, 26.0, 26.0, 26.0, 25.5, 25.5, 25.5, 25.5, 25.0, 25.0, 25.0, 25.0, 24.5, 24.5, 24.5, 24.5, 24.0, 24.0, 24.0, 24.0, 23.5, 23.5, 22.0, 22.0, 22.5, 22.5, 22.0, 22.0, 21.5, 21.5, 21.5, 21.5, 21.0, 21.0, 21.0, 21.0, 20.5, 20.5, 20.5, 20.5, 20.0, 20.0, 20.0, 20.0, 19.5, 19.5, 19.5, 19.5, 19.0, 19.0, 19.0, 19.0, 18.5, 18.5, 18.5, 18.5, 18.0, 18.0, 18.0, 18.0, 17.5, 17.5, 17.5, 17.5, 17.0, 17.0, 17.0, 17.0, 16.5, 16.5, 16.5, 16.5, 16.0, 16.0, 16.0, 16.0, 15.5, 15.5, 15.5, 15.5, 15.0, 15.0, 15.0, 15.0, 14.5, 14.5, 14.5, 14.5, 14.0, 14.0, 14.0, 14.0, 13.5, 13.5, 13.0, 13.0, 12.5, 12.5, 12.0, 12.0, 11.5, 11.5, 11.0, 11.0, 10.5, 10.5, 10.0, 10.0, 10.0, 10.0, 9.5, 9.5, 9.5, 9.5, 9.0, 9.0, 9.0, 9.0, 8.5, 8.5, 8.5, 8.5, 8.0, 8.0, 8.0, 8.0, 7.5, 7.5, 7.5, 7.5, 7.0, 7.0, 7.0, 7.0, 6.5, 6.5, 6.5, 6.5, 6.0, 6.0, 6.0, 6.0, 5.5, 5.5, 5.5, 5.5, 5.0, 5.0, 5.0, 5.0, 4.5, 4.5, 4.5, 4.5, 4.0, 4.0, 4.0, 4.0, 3.5, 3.5, 3.5, 3.5, 3.0, 3.0, 3.0, 3.0, 2.5, 2.5, 2.5, 2.5, 2.0, 2.0, 2.0, 2.0, 1.5, 1.5, 1.5, 1.5, 1.0, 1.0, 1.0, 1.0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 1.0, 1.0, 1.0, 1.0, 1.5, 1.5, 1.5, 1.5, 2.0, 2.0, 2.0, 2.0, 2.5, 2.5, 2.5, 2.5, 3.0, 3.0, 3.0, 3.0, 3.5, 3.5, 3.5, 3.5, 4.0, 4.0, 4.0, 4.0, 4.5, 4.5, 4.5, 4.5, 5.0, 5.0, 5.0, 5.0, 5.5, 5.5, 5.5, 5.5, 6.0, 6.0, 6.0, 6.0, 6.5, 6.5, 6.5, 6.5, 7.0, 7.0, 7.0, 7.0, 7.5, 7.5, 7.5, 7.5, 8.0, 8.0, 8.0, 8.0, 8.5, 8.5, 8.5, 8.5, 9.0, 9.0, 9.0, 9.0, 9.5, 9.5, 9.5, 9.5, 10.0, 10.0, 10.0, 10.0, 10.5, 10.5, 10.5, 10.5, 11.0, 11.0, 11.0, 11.0, 11.5, 11.5, 11.5, 11.5, 12.0, 12.0, 12.0, 12.0, 12.5, 12.5, 12.5, 12.5, 13.0, 13.0, 13.0, 13.0, 13.5, 13.5, 13.5, 13.5, 14.0, 14.0, 14.0, 14.0, 14.5, 14.5, 14.5, 14.5, 15.0, 15.0, 15.0, 15.0, 15.5, 15.5, 15.5, 15.5, 16.0, 16.0, 16.0, 16.0, 16.5, 16.5, 16.5, 16.5, 17.0, 17.0, 17.0, 17.0, 17.5, 17.5, 18.0, 18.0, 18.0, 18.0, 18.5, 18.5, 18.5, 18.5, 19.0, 19.0, 19.0, 19.0, 19.5, 19.5, 19.5, 19.5, 20.0, 20.0, 20.0, 20.0, 20.5, 20.5, 20.5, 20.5, 21.0, 21.0, 21.0, 21.0, 21.5, 21.5, 21.5, 21.5, 22.0, 22.0, 22.0, 22.0, 22.5, 22.5, 22.5, 22.5, 23.0, 23.0, 23.0, 23.0, 23.5, 23.5, 23.5, 23.5, 24.0, 24.0, 24.0, 24.0, 24.5, 24.5, 24.5, 24.5, 25.0, 25.0, 25.0, 25.0, 25.5, 25.5, 25.5, 25.5, 26.0, 26.0, 26.0];
VAR num array_draw_z{2094}:= [-15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, 10, 10, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, 10, 10, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, 10, 10, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, 10, 10, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, 10, 10, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, 10, 10, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15, -15];
	PROC main()
		MoveAbsJ [[45,0,0,0,90,0],[9E+09,9E+09,9E+09,9E+09,9E+09,9E+09]]\NoEOffs,v100,z50,Bic;
		MoveJ Offs(P1,0,0,100),v100,fine,Bic;
		FOR i FROM 1 TO Dim(array_draw_x, 1) DO
			MoveL Offs (P1,array_draw_x{i},array_draw_y{i},array_draw_z{i}), v100,z1,Bic;
		ENDFOR
		MoveL Offs (P1,0,0,100),v100,z10,Bic;
		WaitTime 2;
	ENDPROC
ENDMODULE