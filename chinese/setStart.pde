// ************************
// startPosition FUNCTIONS
// ************************

void startPosition()
{
  // GREEN pieces    
  pos[0][0]=349; pos[0][1]=66;    pos[0][2]=0;
  
  pos[1][0]=325; pos[1][1]=108;   pos[1][2]=0;
  pos[2][0]=373; pos[2][1]=108;   pos[2][2]=0;
  
  pos[3][0]=301; pos[3][1]=149;   pos[3][2]=0;
  pos[4][0]=349; pos[4][1]=149;   pos[4][2]=0;
  pos[5][0]=398; pos[5][1]=149;   pos[5][2]=0;
  
  pos[6][0]=277; pos[6][1]=191;   pos[6][2]=0;
  pos[7][0]=325; pos[7][1]=191;   pos[7][2]=0;
  pos[8][0]=374; pos[8][1]=191;   pos[8][2]=0;
  pos[9][0]=422; pos[9][1]=191;   pos[9][2]=0;

  // RED pieces    
  pos[10][0]=494; pos[10][1]=232;   pos[10][2]=1;
  pos[11][0]=543; pos[11][1]=232;   pos[11][2]=1;
  pos[12][0]=591; pos[12][1]=232;   pos[12][2]=1;
  pos[13][0]=639; pos[13][1]=232;   pos[13][2]=1;
                        
  pos[14][0]=518; pos[14][1]=274;   pos[14][2]=1;
  pos[15][0]=567; pos[15][1]=274;   pos[15][2]=1;
  pos[16][0]=615; pos[16][1]=274;   pos[16][2]=1;
                        
  pos[17][0]=543; pos[17][1]=316;   pos[17][2]=1;
  pos[18][0]=591; pos[18][1]=316;   pos[18][2]=1;
                        
  pos[19][0]=567; pos[19][1]=357;   pos[19][2]=1;
  
  // VIOLET pieces
  pos[20][0]=567; pos[20][1]=440;   pos[20][2]=2;
                        
  pos[21][0]=543; pos[21][1]=482;   pos[21][2]=2;
  pos[22][0]=591; pos[22][1]=482;   pos[22][2]=2;
                        
  pos[23][0]=519; pos[23][1]=524;   pos[23][2]=2;
  pos[24][0]=567; pos[24][1]=524;   pos[24][2]=2;
  pos[25][0]=615; pos[25][1]=524;   pos[25][2]=2;
                        
  pos[26][0]=494; pos[26][1]=565;   pos[26][2]=2;
  pos[27][0]=543; pos[27][1]=565;   pos[27][2]=2;
  pos[28][0]=591; pos[28][1]=565;   pos[28][2]=2;
  pos[29][0]=640; pos[29][1]=565;   pos[29][2]=2;
  
  // ORANGE pieces
  pos[30][0]=277; pos[30][1]=607;   pos[30][2]=3;
  pos[31][0]=325; pos[31][1]=607;   pos[31][2]=3;
  pos[32][0]=374; pos[32][1]=607;   pos[32][2]=3;
  pos[33][0]=422; pos[33][1]=607;   pos[33][2]=3;
                        
  pos[34][0]=301; pos[34][1]=648;   pos[34][2]=3;
  pos[35][0]=349; pos[35][1]=648;   pos[35][2]=3;
  pos[36][0]=398; pos[36][1]=648;   pos[36][2]=3;
                        
  pos[37][0]=325; pos[37][1]=690;   pos[37][2]=3;
  pos[38][0]=374; pos[38][1]=690;   pos[38][2]=3;
                        
  pos[39][0]=349; pos[39][1]=732;   pos[39][2]=3;
  
  // YELLOW pieces
  pos[40][0]=131; pos[40][1]=440;   pos[40][2]=4;
  
  pos[41][0]=107; pos[41][1]=482;   pos[41][2]=4;
  pos[42][0]=155; pos[42][1]=482;   pos[42][2]=4;
  
  pos[43][0]=83;  pos[43][1]=524;   pos[43][2]=4;
  pos[44][0]=131; pos[44][1]=524;   pos[44][2]=4;
  pos[45][0]=180; pos[45][1]=524;   pos[45][2]=4;
  
  pos[46][0]=59;  pos[46][1]=565;   pos[46][2]=4;
  pos[47][0]=107; pos[47][1]=565;   pos[47][2]=4;
  pos[48][0]=155; pos[48][1]=565;   pos[48][2]=4;
  pos[49][0]=204; pos[49][1]=565;   pos[49][2]=4;
  
  // BLU pieces
  pos[50][0]=59;  pos[50][1]=232;   pos[50][2]=5;
  pos[51][0]=107; pos[51][1]=232;   pos[51][2]=5;
  pos[52][0]=155; pos[52][1]=232;   pos[52][2]=5;
  pos[53][0]=204; pos[53][1]=232;   pos[53][2]=5;
  
  pos[54][0]=83;  pos[54][1]=274;   pos[54][2]=5;
  pos[55][0]=131; pos[55][1]=274;   pos[55][2]=5;
  pos[56][0]=180; pos[56][1]=274;   pos[56][2]=5;

  pos[57][0]=107; pos[57][1]=316;   pos[57][2]=5;
  pos[58][0]=155; pos[58][1]=316;   pos[58][2]=5;
  
  pos[59][0]=131; pos[59][1]=357;   pos[59][2]=5;
 
}


void loadCenter()
{
// row 1
// green
center[0][0]=349; center[0][1]=66;

// row 2
//green
center[1][0]=325; center[1][1]=108;
center[2][0]=373; center[2][1]=108;

// row 3
//green
center[3][0]=301; center[3][1]=149;
center[4][0]=349; center[4][1]=149;
center[5][0]=398; center[5][1]=149;

// row 4
//green
center[6][0]=277; center[6][1]=191;
center[7][0]=325; center[7][1]=191;
center[8][0]=374; center[8][1]=191;
center[9][0]=422; center[9][1]=191;

// row 5
//blu
center[10][0]=59; center[10][1]=232;
center[11][0]=107; center[11][1]=232;
center[12][0]=155; center[12][1]=232;
center[13][0]=204; center[13][1]=232;
//empty
center[14][0]=252; center[14][1]=232;
center[15][0]=301; center[15][1]=232;
center[16][0]=349; center[16][1]=232;
center[17][0]=398; center[17][1]=232;
center[18][0]=445; center[18][1]=232;
//red
center[19][0]=494; center[19][1]=232;
center[20][0]=543; center[20][1]=232;
center[21][0]=591; center[21][1]=232;
center[22][0]=639; center[22][1]=232;

// row 6
//blu
center[23][0]=83; center[23][1]=274;
center[24][0]=131; center[24][1]=274;
center[25][0]=180; center[25][1]=274;
//empty
center[26][0]=228; center[26][1]=274;
center[27][0]=277; center[27][1]=274;
center[28][0]=325; center[28][1]=274;
center[29][0]=374; center[29][1]=274;
center[30][0]=422; center[30][1]=274;
center[31][0]=470; center[31][1]=274;
//red
center[32][0]=518; center[32][1]=274;
center[33][0]=567; center[33][1]=274;
center[34][0]=615; center[34][1]=274;

// row 7
//blu
center[35][0]=107; center[35][1]=316;
center[36][0]=155; center[36][1]=316;
//empty
center[37][0]=204; center[37][1]=316;
center[38][0]=252; center[38][1]=316;
center[39][0]=301; center[39][1]=316;
center[40][0]=349; center[40][1]=316;
center[41][0]=398; center[41][1]=316;
center[42][0]=445; center[42][1]=316;
center[43][0]=494; center[43][1]=316;
//red
center[44][0]=543; center[44][1]=316;
center[45][0]=591; center[45][1]=316;

// row 8
//blu
center[46][0]=131; center[46][1]=357;
//empty
center[47][0]=180; center[47][1]=357;
center[48][0]=228; center[48][1]=357;
center[49][0]=277; center[49][1]=357;
center[50][0]=325; center[50][1]=357;
center[51][0]=374; center[51][1]=357;
center[52][0]=422; center[52][1]=357;
center[53][0]=470; center[53][1]=357;
center[54][0]=518; center[54][1]=357;
//red
center[55][0]=567; center[55][1]=357;

// row 9
//empty
center[56][0]=155; center[56][1]=399;
center[57][0]=204; center[57][1]=399;
center[58][0]=252; center[58][1]=399;
center[59][0]=301; center[59][1]=399;
center[60][0]=349; center[60][1]=399;
center[61][0]=398; center[61][1]=399;
center[62][0]=445; center[62][1]=399;
center[63][0]=494; center[63][1]=399;
center[64][0]=543; center[64][1]=399;

// row 10
//yellow
center[65][0]=131; center[65][1]=440;
//empty
center[66][0]=180; center[66][1]=440;
center[67][0]=228; center[67][1]=440;
center[68][0]=277; center[68][1]=440;
center[69][0]=325; center[69][1]=440;
center[70][0]=374; center[70][1]=440;
center[71][0]=422; center[71][1]=440;
center[72][0]=470; center[72][1]=440;
center[73][0]=518; center[73][1]=440;
//violet
center[74][0]=567; center[74][1]=440;

// row 11
// yellow
center[75][0]=107; center[75][1]=482;
center[76][0]=155; center[76][1]=482;
//empty
center[77][0]=204; center[77][1]=482;
center[78][0]=252; center[78][1]=482;
center[79][0]=301; center[79][1]=482;
center[80][0]=349; center[80][1]=482;
center[81][0]=398; center[81][1]=482;
center[82][0]=445; center[82][1]=482;
center[83][0]=494; center[83][1]=482;
//violet
center[84][0]=543; center[84][1]=482;
center[85][0]=591; center[85][1]=482;

// row 12
//yellow
center[86][0]=83; center[86][1]=524;
center[87][0]=131; center[87][1]=524;
center[88][0]=180; center[88][1]=524;
//empty
center[89][0]=228; center[89][1]=524;
center[90][0]=277; center[90][1]=524;
center[91][0]=325; center[91][1]=524;
center[92][0]=374; center[92][1]=524;
center[93][0]=422; center[93][1]=524;
center[94][0]=470; center[94][1]=524;
//violet
center[95][0]=519; center[95][1]=524;
center[96][0]=567; center[96][1]=524;
center[97][0]=615; center[97][1]=524;

// row 13
//yellow
center[98][0]=59; center[98][1]=565;
center[99][0]=107; center[99][1]=565;
center[100][0]=155; center[100][1]=565;
center[101][0]=204; center[101][1]=565;
//empty
center[102][0]=252; center[102][1]=565;
center[103][0]=301; center[103][1]=565;
center[104][0]=349; center[104][1]=565;
center[105][0]=398; center[105][1]=565;
center[106][0]=445; center[106][1]=565;
//violet
center[107][0]=494; center[107][1]=565;
center[108][0]=543; center[108][1]=565;
center[109][0]=591; center[109][1]=565;
center[110][0]=640; center[110][1]=565;

// row 14
//orange
center[111][0]=277; center[111][1]=607;
center[112][0]=325; center[112][1]=607;
center[113][0]=374; center[113][1]=607;
center[114][0]=422; center[114][1]=607;

// row 15
//orange
center[115][0]=301; center[115][1]=648;
center[116][0]=349; center[116][1]=648;
center[117][0]=398; center[117][1]=648;
// row 16
//orange
center[118][0]=325; center[118][1]=690;
center[119][0]=374; center[119][1]=690;

// row 17
//orange
center[120][0]=349; center[120][1]=732;
}

