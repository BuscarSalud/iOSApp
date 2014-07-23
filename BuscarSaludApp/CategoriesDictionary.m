//
//  CategoriesDictionary.m
//  BuscarSaludApp
//
//  Created by FELIX OLIVARES on 4/21/14.
//  Copyright (c) 2014 FELIX OLIVARES. All rights reserved.
//

#import "CategoriesDictionary.h"
#import "Specialty.h"

@implementation CategoriesDictionary

@synthesize tid, displayName;


+(NSArray*)allCategories
{
    NSArray *categoriesArray;
    
    Specialty *s1 = [Specialty new];
    s1.displayName = @"Acupuntura";
    s1.tid = @"34";
    
    Specialty *s2 = [Specialty new];
    s2.displayName = @"Adicciones";
    s2.tid = @"77";
    
    Specialty *s3 = [Specialty new];
    s3.displayName = @"Administración";
    s3.tid = @"91";
    
    Specialty *s4 = [Specialty new];
    s4.displayName = @"Alergias";
    s4.tid = @"35";
    
    Specialty *s5 = [Specialty new];
    s5.displayName = @"Anestesiología";
    s5.tid = @"36";
    
    Specialty *s6 = [Specialty new];
    s6.displayName = @"Audiologia";
    s6.tid = @"37";
    
    Specialty *s7 = [Specialty new];
    s7.displayName = @"Biomedicina";
    s7.tid = @"73";
    
    Specialty *s8 = [Specialty new];
    s8.displayName = @"Cardiología";
    s8.tid = @"48";
    
    Specialty *s32 = [Specialty new];
    s32.displayName = @"Cirugía";
    s32.tid = @"41";
    
    Specialty *s9 = [Specialty new];
    s9.displayName = @"Cirugía Oral";
    s9.tid = @"38";
    
    Specialty *s33 = [Specialty new];
    s33.displayName = @"Cirugía Ortopédica";
    s33.tid = @"70";
    
    Specialty *s10 = [Specialty new];
    s10.displayName = @"Cirugía Plastica";
    s10.tid = @"69";
    
    Specialty *s11 = [Specialty new];
    s11.displayName = @"Coloproctología";
    s11.tid  = @"98";
    
    Specialty *s12 = [Specialty new];
    s12.displayName = @"Dentista";
    s12.tid = @"39";
    
    Specialty *s13 = [Specialty new];
    s13.displayName = @"Dentista Pediatrico";
    s13.tid = @"40";
    
    Specialty *s14 = [Specialty new];
    s14.displayName = @"Dermatología";
    s14.tid = @"58";
    
    Specialty *s15 = [Specialty new];
    s15.displayName = @"Endocrinología";
    s15.tid = @"101";
    
    Specialty *s16 = [Specialty new];
    s16.displayName = @"Endoscopia";
    s16.tid = @"99";
    
    Specialty *s17 = [Specialty new];
    s17.displayName = @"Enfermería";
    s17.tid = @"42";
    
    Specialty *s18 = [Specialty new];
    s18.displayName = @"Entomología";
    s18.tid = @"100";
    
    Specialty *s19 = [Specialty new];
    s19.displayName = @"Estomatología";
    s19.tid = @"81";
    
    Specialty *s20 = [Specialty new];
    s20.displayName = @"Farmacología";
    s20.tid = @"78";
    
    Specialty *s21 = [Specialty new];
    s21.displayName = @"Fisiología";
    s21.tid = @"83";
    
    Specialty *s22 = [Specialty new];
    s22.displayName = @"Fisioterapia";
    s22.tid = @"68";
    
    Specialty *s23 = [Specialty new];
    s23.displayName = @"Gastroenterología";
    s23.tid = @"66";
    
    Specialty *s24 = [Specialty new];
    s24.displayName = @"Genética";
    s24.tid = @"93";
    
    Specialty *s25 = [Specialty new];
    s25.displayName = @"Geriatría";
    s25.tid = @"92";
    
    Specialty *s26 = [Specialty new];
    s26.displayName = @"Ginecología";
    s26.tid = @"49";
    
    Specialty *s27 = [Specialty new];
    s27.displayName = @"Hematología";
    s27.tid = @"95";
    
    Specialty *s28 = [Specialty new];
    s28.displayName = @"Homeopatía";
    s28.tid = @"51";
    
    Specialty *s29 = [Specialty new];
    s29.displayName = @"Infectología";
    s29.tid = @"94";
    
    Specialty *s30 = [Specialty new];
    s30.displayName = @"Inmunología";
    s30.tid = @"96";
    
    Specialty *s31 = [Specialty new];
    s31.displayName = @"Laboratorista";
    s31.tid = @"71";
    
    Specialty *s34 = [Specialty new];
    s34.displayName = @"Legal y Forense";
    s34.tid = @"82";
    
    Specialty *s35 = [Specialty new];
    s35.displayName = @"Medicina Aeroespacial";
    s35.tid = @"102";
    
    Specialty *s36 = [Specialty new];
    s36.displayName = @"Medicina Familiar";
    s36.tid = @"74";
    
    Specialty *s37 = [Specialty new];
    s37.displayName = @"Medicina General";
    s37.tid = @"72";
    
    Specialty *s38 = [Specialty new];
    s38.displayName = @"Medicina Integrada";
    s38.tid = @"108";
    
    Specialty *s39 = [Specialty new];
    s39.displayName = @"Medicina Interna";
    s39.tid = @"107";
    
    Specialty *s40 = [Specialty new];
    s40.displayName = @"Microbiología";
    s40.tid = @"64";
    
    Specialty *s41 = [Specialty new];
    s41.displayName = @"Nefrología";
    s41.tid = @"106";
    
    Specialty *s42 = [Specialty new];
    s42.displayName = @"Neumología";
    s42.tid = @"86";
    
    Specialty *s43 = [Specialty new];
    s43.displayName = @"Neurocirugía";
    s43.tid = @"60";
    
    Specialty *s44 = [Specialty new];
    s44.displayName = @"Neurología";
    s44.tid = @"61";
    
    Specialty *s45 = [Specialty new];
    s45.displayName = @"Neuropsiquiatría";
    s45.tid = @"46";
    
    Specialty *s46 = [Specialty new];
    s46.displayName = @"Nutriología";
    s46.tid = @"57";
    
    Specialty *s47 = [Specialty new];
    s47.displayName = @"Oftalmología";
    s47.tid = @"53";
    
    Specialty *s48 = [Specialty new];
    s48.displayName = @"Oncología";
    s48.tid = @"50";
    
    Specialty *s49 = [Specialty new];
    s49.displayName = @"Optometría";
    s49.tid = @"52";
    
    Specialty *s50 = [Specialty new];
    s50.displayName = @"Ortopedia";
    s50.tid = @"75";
    
    Specialty *s51 = [Specialty new];
    s51.displayName = @"Otorrinolaringología";
    s51.tid = @"63";
    
    Specialty *s52 = [Specialty new];
    s52.displayName = @"Patología";
    s52.tid = @"87";
    
    Specialty *s53 = [Specialty new];
    s53.displayName = @"Pediatría";
    s53.tid = @"47";
    
    Specialty *s54 = [Specialty new];
    s54.displayName = @"Podología";
    s54.tid = @"88";
    
    Specialty *s55 = [Specialty new];
    s55.displayName = @"Protesis";
    s55.tid = @"90";
    
    Specialty *s56 = [Specialty new];
    s56.displayName = @"Psicología";
    s56.tid = @"43";
    
    Specialty *s57 = [Specialty new];
    s57.displayName = @"Psicoterapia";
    s57.tid = @"44";
    
    Specialty *s58 = [Specialty new];
    s58.displayName = @"Psiquiatría";
    s58.tid = @"45";
    
    Specialty *s59 = [Specialty new];
    s59.displayName = @"Puericultura";
    s59.tid = @"55";
    
    Specialty *s60 = [Specialty new];
    s60.displayName = @"Química";
    s60.tid = @"85";
    
    Specialty *s61 = [Specialty new];
    s61.displayName = @"Quiropráctica";
    s61.tid = @"67";
    
    Specialty *s62 = [Specialty new];
    s62.displayName = @"Radiología";
    s62.tid = @"54";
    
    Specialty *s63 = [Specialty new];
    s63.displayName = @"Reumatología";
    s63.tid = @"65";
    
    Specialty *s64 = [Specialty new];
    s64.displayName = @"Salud Pública";
    s64.tid = @"76";
    
    Specialty *s65 = [Specialty new];
    s65.displayName = @"Sexología";
    s65.tid = @"89";
    
    Specialty *s66 = [Specialty new];
    s66.displayName = @"Toxicología";
    s66.tid = @"103";
    
    Specialty *s67 = [Specialty new];
    s67.displayName = @"Trabajo";
    s67.tid = @"79";
    
    Specialty *s68 = [Specialty new];
    s68.displayName = @"Urgencias";
    s68.tid = @"80";
    
    Specialty *s69 = [Specialty new];
    s69.displayName = @"Urología";
    s69.tid = @"56";
    
    Specialty *s70 = [Specialty new];
    s70.displayName = @"Veterinaria";
    s70.tid = @"62";
    
    Specialty *s71 = [Specialty new];
    s71.displayName = @"Sistemas";
    s71.tid = @"105";
    
    Specialty *s72 = [Specialty new];
    s72.displayName = @"Citología";
    s72.tid = @"97";
    
    
    
    categoriesArray = [NSArray arrayWithObjects:s1, s2, s3, s4, s5, s6, s7, s8, s32, s9, s33, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20, s21, s22, s23, s24, s25, s26, s27, s28, s29, s30, s31, s34, s35, s36, s37, s38, s39, s40, s41, s42, s43, s44, s45, s46, s47, s48, s49, s50, s51, s52, s53, s54, s55, s56, s57, s58, s59, s60, s61, s62, s63, s64, s65, s66, s67, s68, s69, s70, s71, s72, nil];
    
    return categoriesArray;
}

+(Specialty *)returnSpecialty: (NSString *)termId
{
    Specialty *category;
    NSString *categoryDisplayName;
    NSArray *arrayCategory = [self allCategories];
    
    for(category in arrayCategory){
        if ([category.tid isEqualToString:termId]) {
            categoryDisplayName = category.displayName;
            break;
        }
    }
    
    return category;
}


@end
