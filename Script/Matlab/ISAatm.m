function [ T p rhoa] = ISAatm(hm)
%ISAatm return air density, temperature and altitude at given altitude [m]
%ISA standard day and atmosphere
%Valid up to 32000 m, 104990 feet
hf=hm/0.3048; 
%Troposphere
if hf <= 36089 
    T=518.69-3.5662e-3*hf;
    p=1.1376e-11*T^(5.2560);
    rhoa=6.6277e-15*T^(4.256);
end
%Tropopause
if (hf <= 65617) & (hf>36089) 
    T=389.99;
    p=2678.4*exp(-4.8063e-5*hf);
    rhoa=1.4939e-6*p;
end
%Low Stratosphere 
if (hf <= 104990) & (hf>65617) 
    T=389.99+5.4864e-4*(hf-65617);
    p=3.793e90*T^(-34.164);
    rhoa=2.2099e87*T^(-35.164);
end
%High Stratosphere, exponential model
if (hf <= 154200) & (hf>104990) 

end

%Convert from US customary units to SI
T=T*5/9;
p=p*47.880268685;
rhoa=rhoa*14.593903/(0.3048*0.3048*0.3048);



