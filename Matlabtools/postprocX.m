function postprocX(folder)

% postprocX(folder)
% Outputs diagnostics as a function of \nu_c for the files included in
% the file "titles" in the folder "folder"


    out=strcat(folder,'/titles')

    fid=fopen(out,'r');

    TS=textscan(fid,'%s%s%s');
    ts=TS{2};

    dim=size(ts);
    dim=dim(1);

    clear V L K V v Fc Fo Ffield Felec Fion Ftot Felec2 Fion2 Ffield2 Ftot2 Fcoll2 fluxtot;
        figure;
        hold all
               
    
    for kk=1:dim
        f=ts{kk};
        filename=strcat(folder,'/',f);
        readoutput
        vt=sqrt(2*Ti);vm=sqrt(8*Ti/pi);
        Vp;
        V(kk)=Vp;
        B(kk)=Bz;
        flux0=sqrt(2*Ti)/(2*sqrt(pi));
        fluxofangle=double(ninth)*double(nthused-1)/(4*pi*rhoinf*dt*double(nastep))/flux0;
        fluxtot(kk)=trapz(fluxofangle)/double(nthused-1);

        %R=fluxofangle(nthused)/(max(fluxofangle)*1e-5+fluxofangle(1));
        %K(kk)=log(R)/vd;
        K(kk)=1;
        
        L(kk)=dbl;
        C(kk)=coll;
        
        Ffield(kk)=dbl^2*ffield(1);
        Felec(kk)=felec1;
        Fion(kk)=fion1;
        Ftot(kk)=ftot1;
        Fcoll1(kk)=fcol1;
        
        Ffield2(kk)=dbl^2*ffield(2);
        Felec2(kk)=felec2;
        Fion2(kk)=fion2;
        Fcoll2(kk)=fcol2;
        Ftot2(kk)=ftot2;
        %Fcoll2(kk)=-coll*(sum(sum(vzsum))-vd*sum(sum(psum)))/rhoinf;
     end
    
    % sort
    % sort
    C=max(C,10^-6);
    XF=[C',fluxtot',K',V',Ffield',Felec',Fion',Ftot',Ffield2',Felec2',Fion2',Fcoll2',Ftot2'];
    XF=sortrows(XF,1);
    figure(1)
    semilogx(XF(:,1),XF(:,2),'-s')
    title('Ion Current','FontSize',18)
    xlabel('\nu_c','FontSize',18)
    ylabel('I_i/ (4 \pi r_p^2 v_{ti}/ 2\pi^{1/2})','FontSize',18)

    figure(2)
    semilogx(XF(:,1),XF(:,5),'b^-',XF(:,1),XF(:,6),'k-',XF(:,1),XF(:,7),'og-',XF(:,1),XF(:,9),'rs-')
    legend('Ffield','Felec','Fion','Ftot')
    title('Force Inner','FontSize',18)
    xlabel('\nu_c','FontSize',18)
    ylabel('Forces /(n_{\infty} r_p^2 T_e)','FontSize',18)
    
    figure(3)
    semilogx(XF(:,1),XF(:,9),'b^-',XF(:,1),XF(:,10),'k-',XF(:,1),XF(:,11),'og-',XF(:,1),XF(:,12),'+m-',XF(:,1),XF(:,13),'rs-')
    legend('Ffield','Felec','Fion','Fcoll','Ftot')
    title('Force Outer','FontSize',18)
    xlabel('\nu_c','FontSize',18)
    ylabel('Forces /(n_{\infty} r_p^2 T_e)','FontSize',18)
    
    
    figure(4)
    semilogx(XF(:,1),XF(:,4),'-s')
    title('Floating potential','FontSize',18);
    xlabel('\nu_c','FontSize',18)
    ylabel('\phi_f / (T_e/e)','FontSize',18)

end