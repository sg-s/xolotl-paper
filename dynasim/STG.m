% simulate DynaSim STG like model

% set up DynaSim equation block
equations = {...
  'gNa=0,'...
  'gCaT=0,'...
  'gCaS=0,'...
  'gA=0,'...
  'gKCa=0,'...
  'gKd=0,'...
  'gH=0,'...
  'gLeak=0,'...
  'Cm=10,'...
  'eNa=50,'...
  'eA=-80,'...
  'eKCa=-80,'...
  'eKd=-80,'...
  'eH=-20,'...
  'eLeak=-50,'...
  'iNa(v,mNa,hNa)=gNa.*mNa.^3.*hNa.*(v+eNa),'...
  'iCaT(v,mCaT,hCaT,Ca)=gCaT.*mCaT.^3.*hCaT.*(v+eCa(Ca)),'...
  'iCaS(v,mCaS,hCaS,Ca)=gCaS.*mCaS.^3.*hCaS.*(v+eCa(Ca)),'...
  'iA(v,mA,hA)=gA.*mA.^3.*hA.*(v+eA),'...
  'iKCa(v,mKCa)=gKCa.*mKCa.^4.*(v+eKCa),'...
  'iKd(v,mKd)=gKd.*mKd.^4.*(v+eKd),'...
  'iH(v,mH)=gH.*mH.*(v+eH),'...
  'iLeak(v)=gLeak.*(v+eLeak),'...
  'eCa(Ca)=1000*8.314*(11+273.15)/(96485*2)*log(3000/Ca)',...
  'v(0)=-65',...
  'Ca(0)=0.05',...
  'eCa=30',...
  'mNa(0)=0',...
  'mCaT(0)=0',...
  'mCaS(0)=0',...
  'mA(0)=0',...
  'mKCa(0)=0',...
  'mKd(0)=0',...
  'mH(0)=0',...
  'hNa(0)=1',...
  'hCaT(0)=1',...
  'hCaS(0)=1',...
  'hA(0)=1',...
  'dv/dt=-(iNa(v,mNa,hNa)+iCaT(v,mCaT,hCaT,Ca)+iCaS(v,mCaS,hCaS,Ca)+iA(v,mA,hA)+iKCa(v,mKCa)+iKd(v,mKd)+iH(v,mH)+iLeak(v))/Cm', ...
  'dmNa/dt=(minfNa(v)-mNa)./taumNa(v)',...
  'dmCaT/dt=(minfCaT(v)-mCaT)./taumCaT(v)',...
  'dmCaS/dt=(minfCaS(v)-mCaS)./taumCaS(v)',...
  'dmA/dt=(minfA(v)-mA)./taumA(v)',...
  'dmKCa/dt=(minfKCa(v)-mKCa)./taumKCa(v)',...
  'dmKd/dt=(minfKd(v)-mKd)./taumKd(v)',...
  'dmH/dt=(minfH(v)-mH)./taumH(v)',...
  'dCa/dt=(0.05-(200*90*(iCaT+iCaS)*0.0628*.5)/(96485*0.0628)-Ca)./200',...
  'dhNa/dt=(hinfNa(v)-hNa)./tauhNa(v)',...
  'dhCaT/dt=(hinfCaT(v)-hCaT)./tauhCaT(v)',...
  'dhCaS/dt=(hinfCaS(v)-hCaS)./tauhCaS(v)',...
  'dhA/dt=(hinfA(v)-hA)./tauhA(v)',...
  'minfNa(v)=1.0/(1.0+exp((v+25.5)/-5.29))',...
  'minfCaT(v)=1.0/(1.0+exp((v+27.1)/-7.2))',...
  'minfCaS(v)=1.0/(1.0+exp((v+33.0)/-8.1))',...
  'minfA(v)=1.0/(1.0+exp((v+27.2)/-8.7))',...
  'minfKCa(v,Ca)=(Ca/(Ca+3.0))/(1.0+exp((v+28.3)/-12.6))',...
  'minfKd(v)=1.0/(1.0+exp((v+12.3)/-11.8))',...
  'minfH(v)=1.0/(1.0+exp((v+70.0)/6.0))',...
  'taumNa(v)=1.32-1.26/(1+exp((v+120.0)/-25.0))',...
  'taumCaT(v)=21.7-21.3/(1.0+exp((v+68.1)/-20.5))',...
  'taumCaS(v)=1.4+7.0/(exp((v+27.0)/10.0)+exp((v+70.0)/-13.0))',...
  'taumA(v)=11.6-10.4/(1.0+exp((v+32.9)/-15.2))',...
  'taumKCa(v)=90.3-75.1/(1.0+exp((v+46.0)/-22.7))',...
  'taumKd(v)=7.2-6.4/(1.0+exp((v+28.3)/-19.2))',...
  'taumH(v)=(272.0+1499.0/(1.0+exp((v+42.2)/-8.73)))',...
  'hinfNa(v)=1.0/(1.0+exp((v+48.9)/5.18))',...
  'hinfCaT(v)=1.0/(1.0+exp((v+32.1)/5.5))',...
  'hinfCaS(v)=1.0/(1.0+exp((v+60.0)/6.2))',...
  'hinfA(v)=1.0/(1.0+exp((v+56.9)/4.9))',...
  'tauhNa(v)=(0.67/(1.0+exp((v+62.9)/-10.0)))*(1.5+1.0/(1.0+exp((v+34.9)/3.6)))',...
  'tauhCaT(v)=105.0-89.8/(1.0+exp((v+55.0)/-16.9))',...
  'tauhCaS(v)=60.0+150.0/(exp((v+55.0)/9.0)+exp((v+65.0)/-16.0))',...
  'tauhA(v)=38.6-29.2/(1.0+exp((v+38.9)/-26.5))'};


%% Increasing Time Step

% simulation time
t_end       = 30e3;

% dt vector
max_dt      = 1e3;
K           = 1:max_dt;
all_dt      = K(rem(max_dt,K) == 0);
all_dt      = all_dt/1e3;

% set up output vectors
all_sim_time= NaN*all_dt;
all_f       = NaN*all_dt;

% downsampling time
time        = all_dt(end) * (1:(t_end / max(all_dt)));

for ii = length(all_dt):-1:1
  disp(ii)

  % perform simulation
  tic;
  data = dsSimulate(equations, 'solver', 'rk2', 'tspan', [all_dt(ii) t_end], 'dt', all_dt(ii), 'compile_flag', 1);
  all_sim_time(ii) = toc;
  V = interp1(all_dt(ii)*(1:length(data.(data.labels{1}))), data.(data.labels{1}), time);

  % find spikes, scale by time in seconds
  all_f(ii) = xolotl.findNSpikes(V, -20);
  all_f(ii) = all_f(ii) / (t_end * 1e-3);
end

% delete the last one because the first sim is slow
all_f(end) = [];
all_sim_time(end) = [];
all_dt(end) = [];

% measure error
f0          = all_f(1);
Q           = abs(all_f - f0)/f0;
% measure speed
S           = t_end ./ all_sim_time;
S           = S * 1e-3;

% save the data
save('data_STG_dt.mat', 'S', 'Q')
disp('saved DynaSim STG time-step data')

%% Increasing Simulation Time

dt          = 0.1;
all_t_end   = unique(round(logspace(0,6,50)));
all_sim_time = NaN*all_t_end;

for ii = 1:length(all_t_end)
  disp(ii)

  tic
  dsSimulate(equations, 'solver', 'rk2', 'tspan', [dt all_t_end(ii)], 'dt', dt, 'compile_flag', 1);
  all_sim_time(ii) = toc;
end

S           = all_t_end ./ all_sim_time;
S           = S * 1e-3;

% save the data
save('data_STG_time.mat', 'S', 'Q')
disp('saved DynaSim STG simulation time data')

%% Increasing Number of Compartments

t_end       = 30e3;
dt          = 0.1;
nComps      = [1, 2, 4, 8, 16, 32, 64, 128, 250, 500, 1000];
all_sim_time= NaN * nComps;

for ii = 1:length(nComps)
  disp(ii)

  % set up DynaSim specification
  clear DynaSim
  DynaSim = struct;
  DynaSim.populations.name      = 'test';
  DynaSim.populations.size      = nComps(ii);
  DynaSim.populations.equations = equations;

  % trial run
  dsSimulate(DynaSim, 'solver', 'rk2', 'tspan', [dt t_end], 'dt', dt, 'compile_flag', 1);

  % begin timing
  tic
  dsSimulate(DynaSim, 'solver', 'rk2', 'tspan', [dt t_end], 'dt', dt, 'compile_flag', 1);
  all_sim_time(ii) = toc;
end

S           = t_end ./ all_sim_time;
S           = S * 1e-3;

% save the data
save('data_STG_nComps.mat', 'S', 'Q')
disp('saved DynaSim STG compartments data')
