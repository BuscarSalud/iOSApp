//
//  StatesDictionary.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 4/21/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "StatesDictionary.h"
#import "State.h"

@implementation StatesDictionary

@synthesize tid, displayName;


+(NSArray*)allStates
{
    NSArray *statesArray;
    State *s1 = [State new];
    s1.displayName = @"Aguascalientes";
    s1.tid = @"1";
    
    State *s2 = [State new];
    s2.displayName = @"Baja California";
    s2.tid = @"2";
    
    State *s3 = [State new];
    s3.displayName = @"Baja California Sur";
    s3.tid = @"3";
    
    State *s4 = [State new];
    s4.displayName = @"Campeche";
    s4.tid = @"4";
    
    State *s5 = [State new];
    s5.displayName = @"Chiapas";
    s5.tid = @"5";
    
    State *s6 = [State new];
    s6.displayName = @"Chihuahua";
    s6.tid = @"6";
    
    State *s7 = [State new];
    s7.displayName = @"Coahuila de Zaragoza";
    s7.tid = @"7";
    
    State *s8 = [State new];
    s8.displayName = @"Colima";
    s8.tid = @"8";
    
    State *s32 = [State new];
    s32.displayName = @"Distrito Federal";
    s32.tid = @"32";
    
    State *s9 = [State new];
    s9.displayName = @"Durango";
    s9.tid = @"9";
    
    State *s33 = [State new];
    s33.displayName = @"Extranjero";
    s33.tid = @"33";
    
    State *s10 = [State new];
    s10.displayName = @"Guanajuato";
    s10.tid = @"10";
    
    State *s11 = [State new];
    s11.displayName = @"Guerrero";
    s11.tid  = @"11";
    
    State *s12 = [State new];
    s12.displayName = @"Hidalgo";
    s12.tid = @"12";
    
    State *s13 = [State new];
    s13.displayName = @"Jalisco";
    s13.tid = @"13";
    
    State *s14 = [State new];
    s14.displayName = @"México";
    s14.tid = @"14";
    
    State *s15 = [State new];
    s15.displayName = @"Michoacán de Ocampo";
    s15.tid = @"15";
    
    State *s16 = [State new];
    s16.displayName = @"Morelos";
    s16.tid = @"16";
    
    State *s17 = [State new];
    s17.displayName = @"Nayarit";
    s17.tid = @"17";
    
    State *s18 = [State new];
    s18.displayName = @"Nuevo León";
    s18.tid = @"18";
    
    State *s19 = [State new];
    s19.displayName = @"Oaxaca";
    s19.tid = @"19";
    
    State *s20 = [State new];
    s20.displayName = @"Puebla";
    s20.tid = @"20";
    
    State *s21 = [State new];
    s21.displayName = @"Querétaro";
    s21.tid = @"21";
    
    State *s22 = [State new];
    s22.displayName = @"Quintana Roo";
    s22.tid = @"22";
    
    State *s23 = [State new];
    s23.displayName = @"San Luis Potosí";
    s23.tid = @"23";
    
    State *s24 = [State new];
    s24.displayName = @"Sinaloa";
    s24.tid = @"24";
    
    State *s25 = [State new];
    s25.displayName = @"Sonora";
    s25.tid = @"25";
    
    State *s26 = [State new];
    s26.displayName = @"Tabasco";
    s26.tid = @"26";
    
    State *s27 = [State new];
    s27.displayName = @"Tamaulipas";
    s27.tid = @"27";
    
    State *s28 = [State new];
    s28.displayName = @"Tlaxcala";
    s28.tid = @"28";
    
    State *s29 = [State new];
    s29.displayName = @"Veracruz";
    s29.tid = @"29";
    
    State *s30 = [State new];
    s30.displayName = @"Yucatán";
    s30.tid = @"30";
    
    State *s31 = [State new];
    s31.displayName = @"Zacatecas";
    s31.tid = @"31";
    
    State *s34 = [State new];
    s34.displayName = @"Staff";
    s34.tid = @"104";
    
    statesArray = [NSArray arrayWithObjects:s1, s2, s3, s4, s5, s6, s7, s8, s32, s9, s33, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s34, nil];
    
    return statesArray;
}

+(State *)returnState: (NSString *)termId
{
    State *state;
    NSString *stateDisplayName;
    NSArray *arrayStates = [self allStates];
    
    for(state in arrayStates){
        if ([state.tid isEqualToString:termId]) {
            stateDisplayName = state.displayName;
            break;
        }
    }
    
    return state;
}
@end
