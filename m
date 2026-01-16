Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB74526CE3F
	for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768589731; cv=none; b=puI0gTAgiE3ptUZXA+eKQyW2y+DwERRxOnF7iTjdqwXdZ/JeGhxax0eh3kxTQ00b3UuNBOMwjhcMyFUjeWzugLGsB/iwziqyICu7Zfj0GKg6nMDO1dMaql6VVKT6umhNpWtLnZcpbRNx1oHK2m97BnGy6GJ6Q0h4mAinvYOex50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768589731; c=relaxed/simple;
	bh=oalKEjIQR2VoTsAVB8Nai0/ipe6Ln9/FuK42anTlul0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=mkK5ZobOcaPsM8TwjVfLT4WfxjqizZZtw5dpazOmalClkb5lInLjG3gt/2zhJ7sZaju2RJY+4qqZ5T+9f7eRLh27IY6d0ETZ7Ip2JkUYwE7olDH6b4u531aeOkUyCrVJxdXdLBzogCI3znAj7SGgYJu23g79yDE8pXu6SAHK+dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=L2EJpASb; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="L2EJpASb"
Message-ID: <33d12807-5c72-41ce-8679-57aa11831fad@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768589693;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0y2QSF63mCJ+jW0dVK1VeVv6RBvcYtxAH73okddn4MM=;
	b=L2EJpASbXcEx7PCW7V7q1ubngkNUPxRsmQstJtVxuLrdTCqqId/kXs2rPMgb128IbOtGoT
	2SMJGbkV0rMnliJRARomUgOEdu7vUCCZ7FHx1W5jIJ5AbFAvyPK2PpBldqekzKSxnKggo2
	dBjljS093d7WFufsGQM2o2oxrWiNkZk=
Date: Fri, 16 Jan 2026 10:54:48 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Ben Chuang <ben.chuang@genesyslogic.com.tw>,
 Victor Shih <victor.shih@genesyslogic.com.tw>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Subject: [BUG] consistent write corruption on Genesys Logic GL9750 microSD
 card reader
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hello,

On a system with a Genesys Logic, Inc GL9750 SD Host Controller [17a0:9750], I am experiencing a consistent amount of corruption on a small number of sectors when running f3write and f3read [1].

This appears on two separate SanDisk Extreme Pro microSD cards (1TB and 2TB) and a Samsung Evo 128GB card.

The corruption is not present if I write the data using these other card readers:

SD Host controller: Genesys Logic, Inc GL9755 SD Host Controller (rev 01)
SD Host controller: Genesys Logic, Inc GL9767 SD Host Controller (rev 04)

and then run f3read on the affected device, so it appears to be specific writing with the GL9750 model. There is nothing related to the card reader or SD card in dmesg when the write corruption occurs, and this issue occurs on every kernel I have tried so far up to 6.19-rc5. I have also tested the same device and SD cards on Windows and no corruption is present when running tests with H2hwtest, which is what f3write/f3read are based on.

The only way around the issue that I have found so far is `sdhci.debug_quirks=0x60` to use PIO instead, as disabling DMA or ADMA individually is not enough to prevent the issue. However, this severely impacts performance [2].

I'm including a full lspci readout for the card reader below at [3] for reference. Is there any more information I can provide to debug this further?

Thanks,
Matt

[1]:
deck@legion-go-s ~ sudo f3write /run/media/deck/SR01T/ -e 3 && sudo f3read /run/media/deck/SR01T/
F3 write 9.0
Copyright (C) 2010 Digirati Internet LTDA.
This is free software; see the source for copying conditions.

Removing old file 1.h2w ...
Free space: 935.72 GB
Creating file 1.h2w ... OK!                        
Creating file 2.h2w ... OK!                        
Creating file 3.h2w ... OK!                        
Free space: 932.72 GB
Average writing speed: 54.10 MB/s
F3 read 9.0
Copyright (C) 2010 Digirati Internet LTDA.
This is free software; see the source for copying conditions.

                  SECTORS      ok/corrupted/changed/overwritten
Validating file 1.h2w ... 2097099/       53/      0/      0
Validating file 2.h2w ... 2097077/       75/      0/      0
Validating file 3.h2w ... 2097087/       65/      0/      0

  Data OK: 3.00 GB (6291263 sectors)
Data LOST: 96.50 KB (193 sectors)
               Corrupted: 96.50 KB (193 sectors)
        Slightly changed: 0.00 Byte (0 sectors)
             Overwritten: 0.00 Byte (0 sectors)
Average reading speed: 85.62 MB/s

[2]:
deck@legion-go-s ~> sudo f3write /run/media/deck/SR01T/ -e 1 && sudo f3read /run/media/deck/SR01T/
F3 write 9.0
Copyright (C) 2010 Digirati Internet LTDA.
This is free software; see the source for copying conditions.

Removing old file 1.h2w ...
Free space: 935.09 GB
Creating file 1.h2w ... OK!                        
Free space: 934.72 GB
Average writing speed: 24.22 MB/s
F3 read 9.0
Copyright (C) 2010 Digirati Internet LTDA.
This is free software; see the source for copying conditions.

                  SECTORS      ok/corrupted/changed/overwritten
Validating file 1.h2w ... 2097152/        0/      0/      0

  Data OK: 1.00 GB (2097152 sectors)
Data LOST: 0.00 Byte (0 sectors)
               Corrupted: 0.00 Byte (0 sectors)
        Slightly changed: 0.00 Byte (0 sectors)
             Overwritten: 0.00 Byte (0 sectors)
Average reading speed: 3.07 MB/s

[3]:
02:00.0 SD Host controller: Genesys Logic, Inc GL9750 SD Host Controller (rev 01) (prog-if 01)
        Subsystem: Genesys Logic, Inc GL9750 SD Host Controller
        Physical Slot: 0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 55
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
                Address: 00000000fee04000  Data: 0022
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
                HeaderLog: 4a000040 00130200 02000900 01000000
        Kernel driver in use: sdhci-pci
        Kernel modules: sdhci_pci
