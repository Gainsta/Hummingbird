// Функция Ek, выполняющая шифрование блока данных длинной 16 бит,
// с использование части ключа шифрования величиной 64 бит

module encryption_function(
input	wire	[15:0]	data_in,
input	wire	[63:0]	key_in,
output		[15:0]	data_out);

wire [15:0] key1_in, key2_in, key3_in, key4_in;
wire [15:0] xor1, xor2, xor3, xor4, xor5;
wire [15:0] S_box1, S_box2, S_box3, S_box4, S_box5;
wire [15:0] L_transf1, L_transf2, L_transf3, L_transf4;

assign key1_in = key_in[15:0];
assign key2_in = key_in[31:16];
assign key3_in = key_in[47:32];
assign key4_in = key_in[63:48];

// Наложение ключа шифрования
assign xor1 = data_in ^ key1_in;

// Табличная замена
S1_box_enc s11 (xor1[15:12],S_box1[15:12]);
S2_box_enc s12 (xor1[11:8], S_box1[11:8]);
S3_box_enc s13 (xor1[ 7:4], S_box1[ 7:4]);
S4_box_enc s14 (xor1[ 3:0], S_box1[ 3:0]);

// Линейное преобразование
linear_transform_enc lt1 (S_box1, L_transf1);

// Наложение ключа шифрования
assign xor2 = L_transf1 ^ key2_in;

// Табличная замена
S1_box_enc s21 (xor2[15:12],S_box2[15:12]);
S2_box_enc s22 (xor2[11:8], S_box2[11:8]);
S3_box_enc s23 (xor2[ 7:4], S_box2[ 7:4]);
S4_box_enc s24 (xor2[ 3:0], S_box2[ 3:0]);

// Линейное преобразование
linear_transform_enc lt2 (S_box2, L_transf2);

// Наложение ключа шифрования
assign xor3 = L_transf2 ^ key3_in;

// Табличная замена
S1_box_enc s31 (xor3[15:12],S_box3[15:12]);
S2_box_enc s32 (xor3[11:8], S_box3[11:8]);
S3_box_enc s33 (xor3[ 7:4], S_box3[ 7:4]);
S4_box_enc s34 (xor3[ 3:0], S_box3[ 3:0]);

// Линейное преобразование
linear_transform_enc lt3 (S_box3, L_transf3);

// Наложение ключа шифрования
assign xor4 = L_transf3 ^ key4_in;

// Табличная замена
S1_box_enc s41 (xor4[15:12],S_box4[15:12]);
S2_box_enc s42 (xor4[11:8], S_box4[11:8]);
S3_box_enc s43 (xor4[ 7:4], S_box4[ 7:4]);
S4_box_enc s44 (xor4[ 3:0], S_box4[ 3:0]);

// Линейное преобразование
linear_transform_enc lt4 (S_box4, L_transf4);

// Наложение ключа шифрования
assign xor5 = L_transf4 ^ (key1_in ^ key3_in);

// Табличная замена
S1_box_enc s51 (xor5[15:12],S_box5[15:12]);
S2_box_enc s52 (xor5[11:8], S_box5[11:8]);
S3_box_enc s53 (xor5[ 7:4], S_box5[ 7:4]);
S4_box_enc s54 (xor5[ 3:0], S_box5[ 3:0]);

// Наложение ключа шифрования
assign data_out = S_box5 ^ (key2_in ^ key4_in);

endmodule
