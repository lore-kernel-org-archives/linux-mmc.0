From: Diogo Sousa <diogogsousa@gmail.com>
Subject: rtsx_pci issue: Realtek 5289 SDHC/SDXC
Date: Mon, 22 Jul 2013 02:55:22 +0100
Message-ID: <51EC910A.7090507@gmail.com>
References: <51D77CDF.4070106@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GKXWMOLJRKFKTAKBWPVJ"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53059 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab3GVBze (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 21 Jul 2013 21:55:34 -0400
Received: by mail-wi0-f174.google.com with SMTP id k10so1340664wiv.7
        for <linux-mmc@vger.kernel.org>; Sun, 21 Jul 2013 18:55:32 -0700 (PDT)
Received: from [192.168.1.100] (a79-169-47-110.cpe.netcabo.pt. [79.169.47.110])
        by mx.google.com with ESMTPSA id s19sm62913619wik.11.2013.07.21.18.55.31
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1 cipher=AES128-SHA bits=128/128);
        Sun, 21 Jul 2013 18:55:31 -0700 (PDT)
In-Reply-To: <51D77CDF.4070106@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GKXWMOLJRKFKTAKBWPVJ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have sent this mail before to this mailing list but got no response so
I'm resending it:

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
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin B routed to IRQ 41
        Region 0: Memory at f7800000 (32-bit, non-prefetchable) [size=3D6=
4K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA
PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst- PME-Enable- DSel=3D0 DScale=3D0 PME=
-
        Capabilities: [50] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
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
        Capabilities: [b0] MSI-X: Enable- Count=3D1 Masked-
                Vector table: BAR=3D0 offset=3D00000000
                PBA: BAR=3D0 offset=3D00000000
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
                Caps:   LPEVC=3D0 RefClk=3D100ns PATEntryBits=3D1
                Arb:    Fixed- WRR32- WRR64- WRR128-
                Ctrl:   ArbSelect=3DFixed
                Status: InProgress-
                VC0:    Caps:   PATOffset=3D00 MaxTimeSlots=3D1 RejSnoopT=
rans-
                        Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128-
WRR256-
                        Ctrl:   Enable+ ID=3D0 ArbSelect=3DFixed TC/VC=3D=
ff
                        Status: NegoPending- InProgress-
        Capabilities: [160 v1] Device Serial Number 33-32-09-09-68-4c-e0-=
00
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
I ran dd if=3D/dev/mmcblk0 of=3D/dev/null bs=3D4K count=3D100 and it is v=
ery slow:

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

Thank you,
Diogo Sousa


------enig2GKXWMOLJRKFKTAKBWPVJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR7JESAAoJEN6T8FNssaHVIycP/AlI4yefqTbHkaF5NGzXUOji
4QRr+NbQKjOVZoRGI+KcZXh4FIaaGzY5xknehOo7Tq+KjmBYU8WhKL3Fl+CHMvyP
CwqpwXxjHOS9BfzH8e3CPkHgNXsNMH1dkgWX2+iGnC/MVQ0BUEvrzyv2VaE3RlZp
j1pKDOVtiLhcyTnajivJA8oMKOc5+w+MLjVBq75PBcWWNSJwwhupozjXMRu+ZBIz
6yBDbY29+TzJrzMXKCYoaD3q7/KwERYxohgno9VKu39+HE6lF/3/NDKs/slJEN4Y
5AWB3UUEVh7T9sJyavZI1WP3MqV+vkmTXvnEN/NaGxJuli37dtDjzHvDpO1eRl3u
yQXVkSenw2MvLQ2FUu7pxUSKlTkLwqkzsqvN2fDCpQho2j76iGwZ3H7YPgrKYSrq
0fDakUAdTlyeWqQeG/x1KBYW8LvgTqkJXPFQnpYQswOgZGZWRQnTDLIAFb2fzr+C
7mUQ5Qcergp0R/DoD/XXaVGLtteLnb09BSe4LN5vLHjkHZMAeyoU1XU5amAES2oZ
EIwsFm2FBD8MdaPDa9waIz0RQUV3edYYY6OvRLyz761QiYQn+ahVzSgwCHShWfmY
LlKiSscfLZgU3KqutX1kizhI1Eyfk1wyM5Cpk3kACbpdUYye2c24CwGdPuNKrp00
4vo93GQJJmHrEzQwlMT6
=tZY1
-----END PGP SIGNATURE-----

------enig2GKXWMOLJRKFKTAKBWPVJ--
