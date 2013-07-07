From: Diogo Sousa <diogogsousa@gmail.com>
Subject: Fwd: rtsx_pci issue: Realtek 5289 SDHC/SDXC
Date: Sun, 07 Jul 2013 18:40:23 +0100
Message-ID: <51D9A807.6060807@gmail.com>
References: <51D77CDF.4070106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:56252 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847Ab3GGRk1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Jul 2013 13:40:27 -0400
Received: by mail-we0-f176.google.com with SMTP id t56so3019010wes.7
        for <linux-mmc@vger.kernel.org>; Sun, 07 Jul 2013 10:40:26 -0700 (PDT)
Received: from [192.168.1.100] (a79-169-47-110.cpe.netcabo.pt. [79.169.47.110])
        by mx.google.com with ESMTPSA id x2sm6823485wif.3.2013.07.07.10.40.24
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Sun, 07 Jul 2013 10:40:25 -0700 (PDT)
In-Reply-To: <51D77CDF.4070106@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I sent the following mail a few days ago, but somehow it didn't reach
the linux-mmc, so I'm re-sending it.

(I removed the attachments since that might be the reason for the mail
to get filtered.)

Thank you,
Diogo Sousa

-------- Original Message --------
Subject: rtsx_pci issue: Realtek 5289 SDHC/SDXC
Date: Sat, 06 Jul 2013 03:11:43 +0100
From: Diogo Sousa <diogogsousa@gmail.com>
To: cjb@laptop.org
CC: wei_wang@realsil.com.cn, linux-mmc@vger.kernel.org

Hi,

I'm not sure if this is the proper way to report bugs, I will gladly
report it bugzilla if that is preferred.

I have been experiencing an issue with the rtsx_pci driver.
I cannot read SDHC or SDXC cards. I'm running linux 3.9.9 on a x86_64.
Normal SD cards seems to work fine.

This is the output from lspci -vvv:

04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. Device
5289 (rev 01)
        Subsystem: ASUSTeK Computer Inc. Device 1447
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 41
        Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000feeff00c  Data: 4191
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr+
TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1,
Latency L0 unlimited, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot-
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain-
CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR-, OBFF Not Supported
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-,
LTR-, OBFF Disabled
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance-
SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=1 Masked-
                Vector table: BAR=0 offset=00000000
                PBA: BAR=0 offset=00000000
        Capabilities: [d0] Vital Product Data
                Not readable
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+
ChkEn-
        Capabilities: [140 v1] Virtual Channel
                Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=Fixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 33-32-09-09-68-4c-e0-00
        Kernel driver in use: rtsx_pci

When I insert a SDHC card I get the following messages in dmesg:

[ 2078.383348] mmc0: cannot verify signal voltage switch
[ 2078.526771] mmc0: cannot verify signal voltage switch
[ 2078.669982] mmc0: cannot verify signal voltage switch
[ 2078.813750] mmc0: cannot verify signal voltage switch
[ 2078.957172] mmc0: cannot verify signal voltage switch
[ 2079.103832] mmc0: cannot verify signal voltage switch
[ 2079.247207] mmc0: cannot verify signal voltage switch
[ 2079.390900] mmc0: cannot verify signal voltage switch
[ 2079.537701] mmc0: cannot verify signal voltage switch
[ 2079.681181] mmc0: cannot verify signal voltage switch
[ 2079.713251] mmc0: Skipping voltage switch
[ 2079.836792] mmc0: new high speed SDHC card at address e624
[ 2079.837103] mmcblk0: mmc0:e624 SD16G 14.8 GiB

the device is created but I have trouble reading from it,
I ran dd if=/dev/mmcblk0 of=/dev/null bs=4K count=100 and it is very slow:

100+0 records in
100+0 records out
409600 bytes (410 kB) copied, 70.098 s, 5.8 kB/s

and dmesg outputs:

[ 1916.101005] mmcblk0: timed out sending r/w cmd command, card status
0x400b00

If I run mkfs.vfat /dev/mmcblk0 it outputs:

mkfs.fat 3.0.20 (12 Jun 2013)
mkfs.vfat: failed whilst writing FAT

and the dmesg gives:

[ 2089.845882]  mmcblk0: unknown partition table
[ 2173.021244] mmcblk0: error -110 sending status command, retrying
[ 2173.121268] mmcblk0: error -110 sending status command, retrying
[ 2173.221366] mmcblk0: error -110 sending status command, aborting
[ 2173.221377] blk_update_request: 445 callbacks suppressed
[ 2173.221380] end_request: I/O error, dev mmcblk0, sector 0
[ 2173.221385] quiet_error: 444 callbacks suppressed
[ 2173.221388] Buffer I/O error on device mmcblk0, logical block 0
[ 2173.221390] lost page write due to I/O error on mmcblk0
[ 2173.221402] end_request: I/O error, dev mmcblk0, sector 8
[ 2173.221404] Buffer I/O error on device mmcblk0, logical block 1
[ 2173.221406] lost page write due to I/O error on mmcblk0
[ 2173.221410] end_request: I/O error, dev mmcblk0, sector 16
[ 2173.221412] Buffer I/O error on device mmcblk0, logical block 2
[ 2173.221414] lost page write due to I/O error on mmcblk0
[ 2173.221417] end_request: I/O error, dev mmcblk0, sector 24
[ 2173.221420] Buffer I/O error on device mmcblk0, logical block 3
[ 2173.221422] lost page write due to I/O error on mmcblk0
[ 2173.421653] mmcblk0: error -110 sending status command, retrying
[ 2173.521640] mmcblk0: error -110 sending status command, retrying
[ 2173.621766] mmcblk0: error -110 sending status command, aborting
[ 2173.621778] end_request: I/O error, dev mmcblk0, sector 40
[ 2173.821934] mmcblk0: error -110 sending status command, retrying
[ 2173.922032] mmcblk0: error -110 sending status command, retrying
[ 2174.022133] mmcblk0: error -110 sending status command, aborting
[ 2174.022144] end_request: I/O error, dev mmcblk0, sector 32
[ 2174.022150] Buffer I/O error on device mmcblk0, logical block 4
[ 2174.022152] lost page write due to I/O error on mmcblk0

If insert a SDXC card dmesg gives me this:

[ 2306.176389] mmc0: cannot verify signal voltage switch
[ 2306.349892] mmc0: cannot verify signal voltage switch
[ 2306.593425] mmc0: cannot verify signal voltage switch
[ 2306.840316] mmc0: cannot verify signal voltage switch
[ 2307.010455] mmc0: cannot verify signal voltage switch
[ 2307.253969] mmc0: cannot verify signal voltage switch
[ 2307.500663] mmc0: cannot verify signal voltage switch
[ 2307.747808] mmc0: cannot verify signal voltage switch
[ 2307.994467] mmc0: cannot verify signal voltage switch
[ 2308.238251] mmc0: cannot verify signal voltage switch
[ 2308.343644] mmc0: Skipping voltage switch
[ 2308.488095] mmc0: SD Status: Invalid Allocation Unit size.
[ 2308.894204] mmc0: error -110 whilst initialising SD card
[ 2309.766266] mmc0: cannot verify signal voltage switch
[ 2310.012988] mmc0: cannot verify signal voltage switch
[ 2310.256729] mmc0: cannot verify signal voltage switch
[ 2310.503553] mmc0: cannot verify signal voltage switch
[ 2310.747171] mmc0: cannot verify signal voltage switch
[ 2310.920695] mmc0: cannot verify signal voltage switch
[ 2311.164169] mmc0: cannot verify signal voltage switch
[ 2311.411142] mmc0: cannot verify signal voltage switch
[ 2311.654696] mmc0: cannot verify signal voltage switch
[ 2311.824810] mmc0: cannot verify signal voltage switch
[ 2311.930227] mmc0: Skipping voltage switch
[ 2312.073672] mmc0: SD Status: Invalid Allocation Unit size.
[ 2312.477415] mmc0: error -110 whilst initialising SD card
[ 2313.349384] mmc0: cannot verify signal voltage switch
[ 2313.593097] mmc0: cannot verify signal voltage switch
[ 2313.766606] mmc0: cannot verify signal voltage switch
[ 2314.010221] mmc0: cannot verify signal voltage switch
[ 2314.253441] mmc0: cannot verify signal voltage switch
[ 2314.497259] mmc0: cannot verify signal voltage switch
[ 2314.670753] mmc0: cannot verify signal voltage switch
[ 2314.840909] mmc0: cannot verify signal voltage switch
[ 2315.084450] mmc0: cannot verify signal voltage switch
[ 2315.254359] mmc0: cannot verify signal voltage switch
[ 2315.359953] mmc0: Skipping voltage switch
[ 2315.503904] mmc0: SD Status: Invalid Allocation Unit size.
[ 2315.907207] mmc0: error -110 whilst initialising SD card

and no device is created.

I attach the .config and /proc/modules, in case that's relevant.

Thank you,
Diogo Sousa

