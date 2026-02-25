Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F4129BD95
	for <linux-mmc@vger.kernel.org>; Wed, 25 Feb 2026 22:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772056853; cv=none; b=D/9vwzMTiKdenRMm3WLG1Crl08mXFSAtHRTX/ibscpZ49tiG9Qw1XsaJTl7xEs4I5Yck3Cq4CN2EoWsDMZmYWL0SgDf7riWZqQpaPa2BOBuBg2zDaXDCqfRDb7JMQe10Sah1ma029P9LgbPsDRhaUGh3uNIYG8FIkLQOXDVX3Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772056853; c=relaxed/simple;
	bh=H8glJtgK6H1ccI0L5w0MYMLvNcGCZg1BIEoCtxKXUQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=de97T8bKNwyv/24HeEzJxT1jhd1rdnG3Ibq0KreeSJOcJYnjYS04k71tHbsyoiUTtaE1+Do/XI+0Umtg43C7LIBGSx15xJofFGPizpX4knzqK8YC+c9/Iok/Q1SaI33Q9kwqMk6JfwRWhYIApUHqin/LMLoWV46NsiZMFKv6M40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i4gEMQZW; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i4gEMQZW"
Message-ID: <655ee663-b331-4dcb-bf85-0e40c1b5191b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772056839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z07+CPftTuzEkc+7pjVzDmag2A41/nXFQsCmS1EB2oE=;
	b=i4gEMQZWifdVvILX8PeYJSj5D8NzqH0r6oDVhZg1s2PQyToo7f740AIwj0sx5EuWAb6ZnA
	EwqRWJyVrz91N2AU3+Z/2ujbEdC2KRJ3oaQ3vjS+VFzzr3j2sNgTCdMUBcNgCCLzE6wuN9
	Ql724UQivKyMljowgb6uXyAdUPjeKv4=
Date: Wed, 25 Feb 2026 14:00:29 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
To: =?UTF-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?=
 <Ben.Chuang@genesyslogic.com.tw>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "benchuanggli@gmail.com" <benchuanggli@gmail.com>
References: <20260117234800.931664-1-matthew.schwartz@linux.dev>
 <8efb0406-b9ce-46ec-bd8d-4763c12298e1@intel.com>
 <TYZPR01MB426077A7AB8CE602ECA2CAF4D766A@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <TYZPR01MB426077A7AB8CE602ECA2CAF4D766A@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/6/26 12:05 AM, BenChuang[莊智量] wrote:
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Friday, January 30, 2026 6:53 PM
>> To: Matthew Schwartz <matthew.schwartz@linux.dev>; Ulf Hansson <ulf.hansson@linaro.org>; BenChuang[莊智量]
>> <Ben.Chuang@genesyslogic.com.tw>; Victor Shih <victor.shih@genesyslogic.com.tw>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [RFC PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
>>
>> Genesys folks : Any comment on this?
> 
> Hi Matthew,
> 
> Could you share the 510h register value on your computer under Windows,
> and the 510h register value under Linux when the f3 test is normal and abnormal?

Hi Ben,

Apologies for the late reply, I was taking some time off. For reference, the device in question is a Lenovo Legion Go S which is a handheld gaming PC, and it has an AMD Z2 Go APU.

Under Windows - I used RWEverything, unsure if there's a better tool as iotools only seems available on Linux:

Type:Memory   Address 00000000B0AFF510
Width:01
00=0F 01=00 02=00 03=00 04=00 05=00 06=00 07=00 
08=00 09=00 0A=00 0B=00 0C=00 0D=00 0E=00 0F=00 
10=00 11=00 12=80 13=0F 14=00 15=2A 16=00 17=00 
18=00 19=00 1A=00 1B=00 1C=0C 1D=00 1E=00 1F=00 
20=00 21=00 22=00 23=00 24=00 25=00 26=00 27=00 
28=00 29=00 2A=00 2B=00 2C=00 2D=00 2E=00 2F=00 
30=00 31=00 32=11 33=01 34=07 35=00 36=00 37=00 
38=00 39=00 3A=00 3B=00 3C=00 3D=00 3E=00 3F=00 
40=00 41=00 42=00 43=00 44=00 45=00 46=00 47=00 
48=00 49=00 4A=00 4B=00 4C=00 4D=00 4E=00 4F=00 
50=00 51=00 52=00 53=00 54=00 55=00 56=00 57=00 
58=00 59=00 5A=00 5B=00 5C=00 5D=00 5E=00 5F=00 
60=00 61=00 62=00 63=00 64=00 65=00 66=00 67=00 
68=00 69=00 6A=00 6B=00 6C=00 6D=00 6E=00 6F=00 
70=00 71=00 72=00 73=00 74=00 75=00 76=00 77=00 
78=00 79=00 7A=00 7B=00 7C=00 7D=00 7E=00 7F=00 
80=00 81=00 82=00 83=00 84=00 85=00 86=00 87=00 
88=00 89=00 8A=00 8B=00 8C=00 8D=00 8E=00 8F=00 
90=00 91=00 92=00 93=00 94=00 95=00 96=00 97=00 
98=00 99=00 9A=00 9B=00 9C=00 9D=00 9E=00 9F=00 
A0=00 A1=00 A2=00 A3=00 A4=00 A5=00 A6=00 A7=00 
A8=00 A9=00 AA=00 AB=00 AC=00 AD=00 AE=00 AF=00 
B0=00 B1=00 B2=00 B3=00 B4=00 B5=00 B6=00 B7=00 
B8=00 B9=00 BA=00 BB=00 BC=00 BD=00 BE=00 BF=00 
C0=00 C1=00 C2=00 C3=00 C4=00 C5=00 C6=00 C7=00 
C8=00 C9=00 CA=00 CB=00 CC=00 CD=00 CE=00 CF=00 
D0=00 D1=00 D2=00 D3=00 D4=00 D5=00 D6=00 D7=00 
D8=00 D9=00 DA=00 DB=00 DC=00 DD=00 DE=00 DF=00 
E0=00 E1=00 E2=00 E3=00 E4=00 E5=00 E6=00 E7=00 
E8=00 E9=00 EA=00 EB=00 EC=00 ED=00 EE=00 EF=00 
F0=00 F1=00 F2=00 F3=00 F4=00 F5=00 F6=00 F7=00 
F8=00 F9=00 FA=00 FB=00 FC=00 FD=00 FE=00 FF=00 

Under Linux with abnormal test:

deck@steamdeck ~> sudo iotools mmio_read32 0xb0a00510
0x0303000f

Under Linux with normal test (i.e. with kernel patch): 
deck@steamdeck ~> sudo iotools mmio_read32 0xb0a00510
0x0300000f

> 
> These two bits 510h[17:16] (R_OSRC_Lmt) on GL9750, are likely used to limit requests.
> Additionally, 510h[25:24] are similar but marked as W_OSRC_Lmt.
> 
> I tested the demo board I had on hand with an Intel PC, and I didn't reproduce the issue.
> The test information is as follows.
> 
> --
> $ sudo f3write -e 3 /run/media/gli/sdsamsung/ && sudo f3read /run/media/gli/sdsamsung/
> F3 write 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
> Free space: 29.00 GB
> Creating file 1.h2w ... OK!
> Creating file 2.h2w ... OK!
> Creating file 3.h2w ... OK!
> Free space: 26.00 GB
> Average writing speed: 21.17 MB/s
> F3 read 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2097152/        0/      0/      0
> Validating file 2.h2w ... 2097152/        0/      0/      0
> Validating file 3.h2w ... 2097152/        0/      0/      0
> 
>   Data OK: 3.00 GB (6291456 sectors)
> Data LOST: 0.00 Byte (0 sectors)
>                Corrupted: 0.00 Byte (0 sectors)
>         Slightly changed: 0.00 Byte (0 sectors)
>              Overwritten: 0.00 Byte (0 sectors)
> Average reading speed: 70.75 MB/s
> $ sudo f3write -e 3 /run/media/gli/sdsamsung/ && sudo f3read /run/media/gli/sdsamsung/
> F3 write 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
> Removing old file 1.h2w ...
> Removing old file 2.h2w ...
> Removing old file 3.h2w ...
> Free space: 29.00 GB
> Creating file 1.h2w ... OK!
> Creating file 2.h2w ... OK!
> Creating file 3.h2w ... OK!
> Free space: 26.00 GB
> Average writing speed: 20.90 MB/s
> F3 read 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2097152/        0/      0/      0
> Validating file 2.h2w ... 2097152/        0/      0/      0
> Validating file 3.h2w ... 2097152/        0/      0/      0
> 
>   Data OK: 3.00 GB (6291456 sectors)
> Data LOST: 0.00 Byte (0 sectors)
>                Corrupted: 0.00 Byte (0 sectors)
>         Slightly changed: 0.00 Byte (0 sectors)
>              Overwritten: 0.00 Byte (0 sectors)
> Average reading speed: 71.18 MB/s
> $ sudo f3write -e 3 /run/media/gli/sdsamsung/ && sudo f3read /run/media/gli/sdsamsung/
> F3 write 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
> Removing old file 1.h2w ...
> Removing old file 2.h2w ...
> Removing old file 3.h2w ...
> Free space: 29.00 GB
> Creating file 1.h2w ... OK!
> Creating file 2.h2w ... OK!
> Creating file 3.h2w ... OK!
> Free space: 26.00 GB
> Average writing speed: 20.48 MB/s
> F3 read 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2097152/        0/      0/      0
> Validating file 2.h2w ... 2097152/        0/      0/      0
> Validating file 3.h2w ... 2097152/        0/      0/      0
> 
>   Data OK: 3.00 GB (6291456 sectors)
> Data LOST: 0.00 Byte (0 sectors)
>                Corrupted: 0.00 Byte (0 sectors)
>         Slightly changed: 0.00 Byte (0 sectors)
>              Overwritten: 0.00 Byte (0 sectors)
> Average reading speed: 71.22 MB/s

deck@steamdeck ~> sudo f3write -e 5 /run/media/deck/SR02T/ && sudo f3read /run/media/deck/SR02T/
[sudo] password for deck: 
F3 write 8.0
Copyright (C) 2010 Digirati Internet LTDA.
This is free software; see the source for copying conditions.

Removing old file 1.h2w ...
Removing old file 2.h2w ...
Removing old file 3.h2w ...
Removing old file 4.h2w ...
Removing old file 5.h2w ...
Free space: 378.34 GB
Creating file 1.h2w ... OK!                         
Creating file 2.h2w ... OK!                         
Creating file 3.h2w ... OK!                        
Creating file 4.h2w ... OK!                        
Creating file 5.h2w ... OK!                        
Free space: 372.60 GB
Average writing speed: 62.56 MB/s
F3 read 8.0
Copyright (C) 2010 Digirati Internet LTDA.
This is free software; see the source for copying conditions.

                  SECTORS      ok/corrupted/changed/overwritten
Validating file 1.h2w ... 2097150/        2/      0/      0
Validating file 2.h2w ... 2097152/        0/      0/      0
Validating file 3.h2w ... 2097150/        2/      0/      0
Validating file 4.h2w ... 2097147/        5/      0/      0
Validating file 5.h2w ... 2097150/        2/      0/      0

  Data OK: 5.00 GB (10485749 sectors)
Data LOST: 5.50 KB (11 sectors)
               Corrupted: 5.50 KB (11 sectors)
        Slightly changed: 0.00 Byte (0 sectors)
             Overwritten: 0.00 Byte (0 sectors)
Average reading speed: 85.93 MB/s


> $
> $ uname -a
> Linux arch-pc 6.18.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 24 Jan 2026 00:47:39 +0000 x86_64 GNU/Linux

Linux steamdeck 7.0.0-rc1-1-git #1 SMP PREEMPT_DYNAMIC Wed, 25 Feb 2026 18:53:27 +0000 x86_64 GNU/Linux

> $ lsblk /dev/mmcblk1
> NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> mmcblk1     179:0    0 29.8G  0 disk
> └─mmcblk1p1 179:1    0 29.8G  0 part /run/media/gli/sdsamsung

deck@steamdeck ~ [32]> lsblk /dev/mmcblk0p1 
NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
mmcblk0p1 179:1    0  1.9T  0 part /run/media/deck/SR02T

> $ sudo dmesg | grep mmc1
> [    1.557901] mmc1: SDHCI controller on PCI [0000:06:00.0] using ADMA
> [  272.440507] mmc1: new UHS-I speed SDR104 SDHC card at address 0001
> [  272.468419] mmcblk1: mmc1:0001 EB1QT 29.8 GiB

deck@steamdeck ~ [0|1]> sudo dmesg | grep mmc
[    1.034894] mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA
[    1.557246] mmc0: new UHS-I speed SDR104 SDXC card at address d555
[    1.567765] mmcblk0: mmc0:d555 SR02T 1.86 TiB
[    1.580830]  mmcblk0: p1
[    6.507652] EXT4-fs (mmcblk0p1): Using encoding defined by superblock: utf8-12.1.0 with flags 0x0
[    6.765191] EXT4-fs (mmcblk0p1): mounted filesystem 4d6b24bb-833f-4859-a85a-13e1d1dbd3d8 r/w with ordered data mode. Quota mode: none.

> $ sudo lspci -d 17a0:9750 -vvv
> 06:00.0 SD Host controller: Genesys Logic, Inc GL9750 SD Host Controller (rev 01) (prog-if 01)
>         Subsystem: Genesys Logic, Inc GL9750 SD Host Controller
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 205
>         Region 0: Memory at 84000000 (32-bit, non-prefetchable) [size=4K]
>         Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W TEE-IO-
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                 LnkCap: Port #80, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 unlimited
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- FltModeDis-
>                 LnkSta: Speed 2.5GT/s, Width x1
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                          AtomicOpsCtl: ReqEn-
>                          IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
>         Capabilities: [e0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee00d58  Data: 0000
>         Capabilities: [f8] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME+
>         Capabilities: [100 v1] Vendor Specific Information: ID=17a0 Rev=1 Len=008 <?>
>         Capabilities: [108 v1] Latency Tolerance Reporting
>                 Max snoop latency: 3145728ns
>                 Max no snoop latency: 3145728ns
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>                           PortCommonModeRestoreTime=255us PortTPowerOnTime=3100us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                            T_CommonMode=0us LTR1.2_Threshold=3375104ns
>                 L1SubCtl2: T_PwrOn=3100us
>         Capabilities: [200 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvNonFatalErr- CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvNonFatalErr+ CorrIntErr- HeaderOF-
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Kernel driver in use: sdhci-pci
>         Kernel modules: sdhci_pci

deck@legion-go-s ~> sudo lspci -d 17a0:9750 -vvv
02:00.0 SD Host controller: Genesys Logic, Inc GL9750 SD Host Controller (rev 01) (prog-if 01)
        Subsystem: Genesys Logic, Inc GL9750 SD Host Controller
        Physical Slot: 0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 63
        Region 0: Memory at b0a00000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75W TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #80, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- FltModeDis-
                LnkSta: Speed 2.5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
                         EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
        Capabilities: [e0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee04000  Data: 0023
        Capabilities: [f8] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Vendor Specific Information: ID=17a0 Rev=1 Len=008 <?>
        Capabilities: [108 v1] Latency Tolerance Reporting
                Max snoop latency: 1048576ns
                Max no snoop latency: 1048576ns
        Capabilities: [110 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=20us PortTPowerOnTime=4us
                L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                           T_CommonMode=0us LTR1.2_Threshold=176128ns
                L1SubCtl2: T_PwrOn=150us
        Capabilities: [200 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
                        ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvNonFatalErr+ CorrIntErr- HeaderOF-
                AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: sdhci-pci
        Kernel modules: sdhci_pci


> $ sudo iotools mmio_read32 0x84000510
> 0x0303000f
> $
> --
> Best regards,
> Ben Chuang
> 
>>
>> On 18/01/2026 01:48, Matthew Schwartz wrote:
>>> The GL9750 SD host controller has intermittent data corruption during
>>> DMA write operations, which has been traced to an incorrect burst
>>> configuration. This was discovered by comparing initialization sequences
>>> between the working GL9767 controller and GL9750 and seeing that the
>>> GM_BURST register was handled differently.
>>>
>>> Clearing bits 16-17 eliminates the corruption with f3write/f3read tests
>>> while maintaining full DMA write/read performance.
>>>
>>> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x support")
>>> Closes:
>> https://lore.kernel.org/linux-mmc/33d12807-5c72-41c
>> e-8679-57aa11831fad%40linux.dev%2F&data=05%7C02%7Cben.chuang%40genesyslogic.com.tw%7C2361bfc18a574c93ddc
>> 308de5fedb708%7C4e753840bf6b40a19645185818deeb52%7C0%7C0%7C639053671790416204%7CUnknown%7CTWFpbG
>> Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7
>> C%7C%7C&sdata=AzJ5iXlS1yxTdGDFK64jJxRkOAty%2FzNAGMHM%2FItQDfA%3D&reserved=0
>>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
>>> ---
>>>
>>> Hi all,
>>>
>>> I arrived at this after a whole bunch of guesswork based on the other
>>> Genesys card readers in the kernel that do work, like GL9767. I landed on
>>> register 0x510 which appears to be "GM_BURST_SIZE" and ended up going
>>> through each bit and either setting it or masking it. Eventually, I
>>> arrived at masking bits 16-17 which seemed to stabilize writes completely.
>>>
>>> Could someone at Genesys confirm what this register is for on GL9750, and
>>> what those bits are? At least locally, I have been able to run 50GB of
>>> f3write/f3read without any corruption while before even 1GB would corrupt.
>>> This also maintains the same read/write speed as before this change. I
>>> tried searching online but was unable to find any relevant docs, and I'd
>>> like to confirm the purpose of those bits before sending this out as v1.
>>>
>>> Thanks,
>>> Matt
>>>
>>> ---
>>>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>>> index b0f91cc9e40e4..a06b0cf11f12d 100644
>>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>>> @@ -26,6 +26,9 @@
>>>  #define   GLI_9750_WT_EN_ON            0x1
>>>  #define   GLI_9750_WT_EN_OFF           0x0
>>>
>>> +#define SDHCI_GLI_9750_GM_BURST_SIZE                 0x510
>>> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_MASK            GENMASK(17, 16)
>>> +
>>>  #define SDHCI_GLI_9750_CFG2          0x848
>>>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>>>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
>>> @@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>>>
>>>     gl9750_wt_on(host);
>>>
>>> +   /* clear GM_BURST bits to avoid corruption with DMA writes */
>>> +   value = sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
>>> +   value &= ~SDHCI_GLI_9750_GM_BURST_SIZE_MASK;
>>> +   sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
>>> +
>>>     value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
>>>     value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
>>>     /* set ASPM L1 entry delay to 7.9us */
> 
> ________________________________
> 
> Genesys Logic Email Confidentiality Notice:
> This mail and any attachments may contain information that is confidential, proprietary, privileged or otherwise protected by law. The mail is intended solely for the named addressee (or a person responsible for delivering it to the addressee). If you are not the intended recipient of this mail, you are not authorized to read, print, copy or disseminate this mail.
> 
> If you have received this email in error, please notify us immediately by reply email and immediately delete this message and any attachments from your system. Please be noted that any unauthorized use, dissemination, distribution or copying of this email is strictly prohibited.
> ________________________________

