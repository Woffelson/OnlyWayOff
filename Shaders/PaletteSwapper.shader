shader_type canvas_item;

uniform vec3 soossi_1;
uniform vec3 soossi_2;
uniform vec3 soossi_3;
uniform vec3 soossi_4;
uniform vec3 soossi_5;
uniform vec3 soossi_6;
uniform vec3 soossi_7;
uniform vec3 soossi_0;
uniform vec3 uloste_1;
uniform vec3 uloste_2;
uniform vec3 uloste_3;
uniform vec3 uloste_4;
uniform vec3 uloste_5;
uniform vec3 uloste_6;
uniform vec3 uloste_7;
uniform vec3 uloste_0;
void fragment(){
	vec4 curr_color = texture(TEXTURE, UV); //read from texture
	if (curr_color.rgb == soossi_0){
        COLOR.rgb = uloste_0;
    }else if (curr_color.rgb == soossi_1){
        COLOR.rgb = uloste_1;
    }else if (curr_color.rgb == soossi_2){
        COLOR.rgb = uloste_2;
	}else if (curr_color.rgb == soossi_3){
        COLOR.rgb = uloste_3;
    }else if (curr_color.rgb == soossi_4){
        COLOR.rgb = uloste_4;
	}else if (curr_color.rgb == soossi_5){
        COLOR.rgb = uloste_5;
    }else if (curr_color.rgb == soossi_6){
        COLOR.rgb = uloste_6;
	}else if (curr_color.rgb == soossi_7){
        COLOR.rgb = uloste_7;
    }else{
        COLOR = curr_color;
    }
}