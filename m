Received: from mail-m19731117.qiye.163.com (mail-m19731117.qiye.163.com [220.197.31.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5E052F88;
	Sat, 17 Jan 2026 04:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768622776; cv=none; b=ktkX2IJc1E6pQyuH8rJ7o9N47zpeSFVbaYO85YuU2yVgguklRUU7Tn2GThfM8tHcCMLXrUVeRZ/g9vDcZBHks1DvXvz55R/YRM3ESttSRm2ev8wMRy3QwC8KVD6/kKBbmKaOc+FqbLkNph6LqKdkJXsWrlajY1yPY3jRdcRULfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768622776; c=relaxed/simple;
	bh=YYGwi7vKL1nwe+K0TzJIiL92IoHqGt/AdYAoqhv12wU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PtEy+YxqTldmJvhMZErcF8dqZDjDY+ifmdJ8QlYEQLvdpZVNV+YbTBCXYXbcPNWtk6F/Lho1xKcX1II6ntRc1Xj/22T3NBuxCXj4j6KWpdaLD2MU4y+4pis8jBGIfzxdEt5A6cMQdm93yhHWWSlrUGoXvOcdJ/cvXGwrBJyMfY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=C1Nt+d3N; arc=none smtp.client-ip=220.197.31.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="C1Nt+d3N"
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 30f969b32;
	Sat, 17 Jan 2026 10:50:20 +0800 (GMT+08:00)
Message-ID: <e7275490-da64-45ce-980c-7d932b60f638@rock-chips.com>
Date: Sat, 17 Jan 2026 10:50:19 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] consistent write corruption on Genesys Logic GL9750 microSD
 card reader
To: Matthew Schwartz <matthew.schwartz@linux.dev>,
 Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
References: <33d12807-5c72-41ce-8679-57aa11831fad@linux.dev>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <33d12807-5c72-41ce-8679-57aa11831fad@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9bc9dc59ae09cckunm3e92b68277c18e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkNOTlYaGh1OGUxDSE4YGhlWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=C1Nt+d3N+YaqshOetDaXMbebzT2m5C/XnCANclx+Nf/hCSRSU4S/ajhRN8DSEJMzpPQACQKOh88wJKvLkzgFd1ONNj1XilpgNvXvBHOKedu403pvryssvYkx89F8+4+ht0OJZDd8nlOJaVCueTY9D/bixxcQQ4ufXzLEVFFo7kE=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=rv5V7kcKp03CswPWArW3/AMO8zZMGdfz0Qs/3ynUTRc=;
	h=date:mime-version:subject:message-id:from;

在 2026/01/17 星期六 2:54, Matthew Schwartz 写道:
> Hello,
> 
> On a system with a Genesys Logic, Inc GL9750 SD Host Controller [17a0:9750], I am experiencing a consistent amount of corruption on a small number of sectors when running f3write and f3read [1].
> 
> This appears on two separate SanDisk Extreme Pro microSD cards (1TB and 2TB) and a Samsung Evo 128GB card.
> 
> The corruption is not present if I write the data using these other card readers:
> 
> SD Host controller: Genesys Logic, Inc GL9755 SD Host Controller (rev 01)
> SD Host controller: Genesys Logic, Inc GL9767 SD Host Controller (rev 04)
> 
> and then run f3read on the affected device, so it appears to be specific writing with the GL9750 model. There is nothing related to the card reader or SD card in dmesg when the write corruption occurs, and this issue occurs on every kernel I have tried so far up to 6.19-rc5. I have also tested the same device and SD cards on Windows and no corruption is present when running tests with H2hwtest, which is what f3write/f3read are based on.
> 
> The only way around the issue that I have found so far is `sdhci.debug_quirks=0x60` to use PIO instead, as disabling DMA or ADMA individually is not enough to prevent the issue. However, this severely impacts performance [2].
> 
> I'm including a full lspci readout for the card reader below at [3] for reference. Is there any more information I can provide to debug this further?
> 
> Thanks,
> Matt
> 
> [1]:
> deck@legion-go-s ~ sudo f3write /run/media/deck/SR01T/ -e 3 && sudo f3read /run/media/deck/SR01T/
> F3 write 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
> Removing old file 1.h2w ...
> Free space: 935.72 GB
> Creating file 1.h2w ... OK!
> Creating file 2.h2w ... OK!
> Creating file 3.h2w ... OK!
> Free space: 932.72 GB
> Average writing speed: 54.10 MB/s
> F3 read 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
>                    SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2097099/       53/      0/      0
> Validating file 2.h2w ... 2097077/       75/      0/      0
> Validating file 3.h2w ... 2097087/       65/      0/      0
> 
>    Data OK: 3.00 GB (6291263 sectors)
> Data LOST: 96.50 KB (193 sectors)
>                 Corrupted: 96.50 KB (193 sectors)
>          Slightly changed: 0.00 Byte (0 sectors)
>               Overwritten: 0.00 Byte (0 sectors)
> Average reading speed: 85.62 MB/s
> 
> [2]:
> deck@legion-go-s ~> sudo f3write /run/media/deck/SR01T/ -e 1 && sudo f3read /run/media/deck/SR01T/
> F3 write 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
> Removing old file 1.h2w ...
> Free space: 935.09 GB
> Creating file 1.h2w ... OK!
> Free space: 934.72 GB
> Average writing speed: 24.22 MB/s
> F3 read 9.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
> 
>                    SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2097152/        0/      0/      0
> 
>    Data OK: 1.00 GB (2097152 sectors)
> Data LOST: 0.00 Byte (0 sectors)
>                 Corrupted: 0.00 Byte (0 sectors)
>          Slightly changed: 0.00 Byte (0 sectors)
>               Overwritten: 0.00 Byte (0 sectors)
> Average reading speed: 3.07 MB/s
> 
> [3]:
> 02:00.0 SD Host controller: Genesys Logic, Inc GL9750 SD Host Controller (rev 01) (prog-if 01)
>          Subsystem: Genesys Logic, Inc GL9750 SD Host Controller
>          Physical Slot: 0
>          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>          Latency: 0, Cache Line Size: 64 bytes
>          Interrupt: pin A routed to IRQ 55
>          Region 0: Memory at b0a00000 (32-bit, non-prefetchable) [size=4K]
>          Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
>                  DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
>                          ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 75W TEE-IO-
>                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                          RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                          MaxPayload 128 bytes, MaxReadReq 512 bytes
>                  DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
>                  LnkCap: Port #80, Speed 2.5GT/s, Width x1, ASPM L1, Exit Latency L1 <64us
>                          ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                  LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
>                          ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- FltModeDis-
>                  LnkSta: Speed 2.5GT/s, Width x1
>                          TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                  DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
>                           10BitTagComp- 10BitTagReq- OBFF Via message/WAKE#, ExtFmt- EETLPPrefix-
>                           EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
>                           FRS- TPHComp- ExtTPHComp-
>                           AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                           AtomicOpsCtl: ReqEn-
>                           IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
>                           10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                  LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retimer- 2Retimers- DRS-
>                  LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                           Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                           Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
>                  LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
>                           EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
>                           Retimer- 2Retimers- CrosslinkRes: unsupported, FltMode-
>          Capabilities: [e0] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                  Address: 00000000fee04000  Data: 0022
>          Capabilities: [f8] Power Management version 3
>                  Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
>                  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>          Capabilities: [100 v1] Vendor Specific Information: ID=17a0 Rev=1 Len=008 <?>
>          Capabilities: [108 v1] Latency Tolerance Reporting
>                  Max snoop latency: 1048576ns
>                  Max no snoop latency: 1048576ns
>          Capabilities: [110 v1] L1 PM Substates
>                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
>                            PortCommonModeRestoreTime=20us PortTPowerOnTime=4us
>                  L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>                             T_CommonMode=0us LTR1.2_Threshold=176128ns

Just chiming in, I vaguely remember there was a reported regarding to
GL9750's ASPM, more precisely L1 substate support. Not sure if it's
related to your problem, but worth a try by disabling the ASPM support.

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2526,6 +2526,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 
0x1080, quirk_disable_aspm_l0s_l
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, 0x0451, 
quirk_disable_aspm_l0s_l1);
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_PASEMI, 0xa002, 
quirk_disable_aspm_l0s_l1);
  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_HUAWEI, 0x1105, 
quirk_disable_aspm_l0s_l1);
+DECLARE_PCI_FIXUP_HEADER(0x17a0, 0x9750, quirk_disable_aspm_l0s_l1);



>                  L1SubCtl2: T_PwrOn=150us
>          Capabilities: [200 v1] Advanced Error Reporting
>                  UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                          ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                  UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP-
>                          ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                  UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+
>                          ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
>                          PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
>                  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr- CorrIntErr- HeaderOF-
>                  CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvNonFatalErr+ CorrIntErr- HeaderOF-
>                  AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- ECRCChkCap- ECRCChkEn-
>                          MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
>                  HeaderLog: 4a000040 00130200 02000900 01000000
>          Kernel driver in use: sdhci-pci
>          Kernel modules: sdhci_pci
> 
> 

