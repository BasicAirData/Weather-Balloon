%Balloon 
%JLJ 2016
%%https://www.grc.nasa.gov/www/k-12/Numbers/Math/Mathematical_Thinking/designing_a_high_altitude.htm#8
%Constants
R=8.31432; %J/mol/K Us.Standard atmosphere
g=9.81;
sf=1; %Safety factor
MwHe=0.004002602; %kg/mol
RHe=R/MwHe;
MwAir=0.028964; %kg/mol
RAir=R/MwAir
%Altitude 90 km;
T=187;%°K
p=0.18398487; %Pa
ms=10; %kg

inkey1=99;
while inkey1~=0
    fprintf('Basic Air Data Preliminary Ballon Sizer\n')
    fprintf('JLJ@basicairdata.eu 2016\n')
    fprintf('Maximum Altitude 32000 m. Refer to main site for assumptions and documentation\n')
    fprintf('1- Given geometric desired altitude and mass calculates balloon equivalent radii and Helium mass at lower burts point, input \n')
    fprintf('2- Given burst radii, mass calculates burst altitude\n')
    fprintf('3- Probe mass, air and helium density calculates minimum balloon burst radii \n')
    fprintf('------------------------------------------------------------\n')
    fprintf('4- Calculates descent rate for given altitude, mass, diameter, cdd and \n')
    inkey1=input('Select calculation mode, 0 to exit : ');
switch inkey1
    case 1
        h=input('Desired Burst Altitude [m]: ');
        [T p RhoAir]=ISAatm(h);
        fprintf('Calculated Temperautre %.1f [°K], Pressure %.1f [Pa] and Air Density %.6f [kg/m^3]\n',T,p,RhoAir);
        RhoHe=p/(RHe*T); %%Calculates the density of Helium
        ms=input('Weight of probe, Helium excluded [kg]: ');
        VB=ms/(RhoAir-RhoHe);
        RB=(3/4*VB/pi())^(1/3);
        me=VB*RhoHe;
        fprintf('If burst happens at %.1f meters, the balloon volume is %.2f m^3, the balloon radius is %.2f meters, mass of Helium is %.3f kg\n',h,VB,RB,me);
        %Coefficient of Drag at ground
        cD=0.45;
        %moles of Helium
        ne=me/MwHe;
        %Volume of the balloon at ground
        VG=ne*R*288.15/101325;
        RG=(3/4*VG/pi())^(1/3);
        mto=ms/sf;
        FFL=(1.225*VG-mto-me)*g;
        vz=(8*RG*g/3/cD*(1-3*(mto+me)/(4*pi()*1.225*RG^3)))^0.5;
        fprintf('Volume of the Balloon at ground %.2f [m^3], Radius of the balloon at ground %.2f [m], Free lift at ground [N] %.3f \n',VG,RG,FFL);  
        fprintf('Ascent speed %.2f [m/s] \n\n',vz);  
    case 2 
        RB=input('Burts radius [m]: ');
        ms=input('Weight of probe, Helium excluded [kg]: ');
   %     RhoAir=input('Air density [kg/m^3]: ');
   %     RhoHe=input('Helium density [kg/m^3]: ');
        %VB=ms/(RhoAir-RhoHe);
        VB=4/3*pi()*RB^3;
        RhoHe=RhoAir-ms/VB;
        me=VB*RhoHe;
        fprintf('Balloon radius is %.2f meters, mass of Helium is %.3f kg \n\n',RB,me);
        
    case 3 
        % Test case https://www.grc.nasa.gov/www/k-12/Numbers/Math/Mathematical_Thinking/designing_a_high_altitude.htm#8
        % h=90 km h ms=10 kg RhoAir=3.42e-6 kg/m^3  RhoHe=4.66e-7 kg/m^3
        ms=input('Weight of probe, Helium excluded [kg]: ');
        RhoAir=input('Air density [kg/m^3]: ');
        RhoHe=input('Helium density [kg/m^3]: ');
        VB=ms/(RhoAir-RhoHe);
        RB=(3/4*VB/pi())^(1/3);
        me=VB*RhoHe;
        fprintf('Balloon radius is %.2f meters, mass of Helium is %.3f kg \n\n',RB,me);
         %Coefficient of Drag at ground
        cD=0.45;
        %moles of Helium
        ne=me/MwHe;
        %Volume of the balloon at ground
        VG=ne*R*288.15/101325;
        RG=(3/4*VG/pi())^(1/3);
        mto=ms/sf;
        FFL=(1.225*VG-mto-me)*g;
        vz=(8*RG*g/3/cD*(1-3*(mto+me)/(4*pi()*1.225*RG^3)))^0.5;
        fprintf('Volume of the Balloon at ground %.2f [m^3], Radius of the balloon at ground %.2f [m], Free lift at ground [N] %.3f \n',VG,RG,FFL);  
        fprintf('Ascent speed %.2f [m/s] \n\n',vz);  
    case 4
         %% Calculates descent rate at given altitude
         mt=input('Total weight of probe [kg]: ');
         ddp=input('Diameter of parachute [m]: ');
         cddu=input('Parachute coefficient of drag :');
         h=input('Altitude [m]: ');
         [T p RhoAir]=ISAatm(h);
         areaparachute=(ddp/2)^2*pi();
         vf=(2*mt*g/(cddu*RhoAir*areaparachute))^0.5;
         fprintf('Still Air Descent Rate %.2f [m/s] \n\n',vf);  
end
end


%RhoAir=p/(RAir*T);

%[1] A. Gallice et al.: Modeling the ascent of sounding balloon
%Buoyancy force [1] Equation 1
%FFL=(rhoa*V-mtot)*g;
%Drag Force [1] Equation 2
%FD=0.5*cD*rhoa*S*Vz^2

%%Coefficient of drag
%%cD=4.808×10?2(lnRe)2?1.406lnRe+10.490
