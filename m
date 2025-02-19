Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9B124F59B;
	Wed, 19 Feb 2025 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000752; cv=none; b=a9C6luXqX3mgYyYPb2xVqPNRmaZjC9ayLsOvYMeubQFDFmgg6YqMDKhpF5LMUze9bOJuKaJGFAa1/KV5wYVfmv90bR/eRsN7n0yophJnlLn2Ef3lWDyjA0FxREyIFZkyDRuiwpR7+ZDFy4eN/pSPh8z6fTChb7bA/s/ohHK/3Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000752; c=relaxed/simple;
	bh=R1DT0LKXETP1mkKDAQ5SuvxP4ZXu8sX1cMCFdFI4olM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ilx7+Pw8BPa//qFePBEdTaHQ5Q2aVkZRslTZ0eWFroFnG728E9qxsFnJu+VEt2zsbOrU59QJNZp7dy6O8lG2UyZKUW6CmGCjZCOK0FVk0qUhI0teRfnAAChw8cStZKaJz5R2+YdI/7BVyaKSC8SoiP6IDhP+si+enF8EwMe0Ewo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=oTfIrG0K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oINcBM6r; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="oTfIrG0K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oINcBM6r"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9E09D2540196;
	Wed, 19 Feb 2025 16:32:28 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 19 Feb 2025 16:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1740000748; x=1740087148; bh=iYgnEhnSiY
	4SDl7PRJM6FrAN6/BSW0DulOFqA3NUQeQ=; b=oTfIrG0KnniWyQgZjlq1G9ZTiG
	zALJbtnnyh3NKgbdBJc49skNhpXnAQekoKJvyv1v6oqTs7JbPyBxbxt9mSNRAnFg
	R46EwMkZ/KpbaUAIiFMpipqQllHyc0IymnG0nGP1XHF1cjDUrrXOz7aodFdD+c1/
	Uutbraxb70sH/V2osQzJrpcICqkWHXYqUFpArd/dAwhm+9ttX/AUGUuhI1Cz7vFT
	5mvfxfguS0VKMJdNjjZc+Bdli9ra3vDLPhykEQ/KYjg/DmRDOIoQdz+DkX0RpJeW
	m3qaRwoek//5OQLpxf/iaAW7eEughLyHppPvOj4wLSgr4/uJayNGxA2wnSbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740000748; x=1740087148; bh=iYgnEhnSiY4SDl7PRJM6FrAN6/BSW0DulOF
	qA3NUQeQ=; b=oINcBM6rrDfuJhePVu8wYiVR5Syw4P6kExWVV8gZCQI4tQt81Zc
	mkpFj0kQDF1G3KURTKI5tYOfUJf6dL5Yvr7oN1AwxEdikgYWe2wTa6hHLhtbulPB
	WG9YLk4M92y9jQDASvTMGxxmYSx28xcxiPEJjROJoeIP0X0f6jfFCwcbF0M2qEmI
	C2LdpuEMkkDyCDg4F7RuaDhkMg0YaVu9fW7HlZcWzPdFh6uS5CjJiiLMcwh5DcDn
	0d4bjuIxSwIywBADSdRT3B73P4ZfmhiJdxYnkOTEuECFF+ZUghNKIy2VX1ZzOdBC
	A911j5XTrUWs7twMEcMkzunElBkcfNeg8Eg==
X-ME-Sender: <xms:6022Z6A3cQm9sv8YH8SABmfrtY05vRO5FrxfVCnrnVablxBDJfI9jQ>
    <xme:6022Z0iLpAxCBjjWTdgluLgLLIUbTQNfqJeWfXsaBmqm16ba0TYP3WtOXcCLzEaXK
    AcS-nq1fEjdYnE74jI>
X-ME-Received: <xmr:6022Z9lV8gTKwcYOWguv7LlfeMZY37X-ThUEW9iVWF6RpJbQRWDEJ2hhZbCV_h37xkCNf5wpmjT1CmjP72nkiV57q9sgzggsd8o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiheefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttdej
    necuhfhrohhmpeflrghnnhgvucfirhhunhgruhcuoehjsehjrghnnhgruhdrnhgvtheqne
    cuggftrfgrthhtvghrnhepgfdvffevleegudejfeefheehkeehleehfefgjefffeetudeg
    tefhuedufeehfeetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhesjhgrnhhnrghurdhnvghtpdhnsggprhgtphhtthhopedugedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepvhhitghtohhrshhhihhhghhlihesghhmrghilh
    drtghomhdprhgtphhtthhopehulhhfrdhhrghnshhsohhnsehlihhnrghrohdrohhrghdp
    rhgtphhtthhopegrughrihgrnhdrhhhunhhtvghrsehinhhtvghlrdgtohhmpdhrtghpth
    htoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegsvghntghhuhgrnhhgghhlihesghhmrghilhdrtghomhdprhgtphhtthhopehluhgt
    rghsrdhlrghisehgvghnvghshihslhhoghhitgdrtghomhdrthifpdhrtghpthhtohephh
    hlrdhlihhusehgvghnvghshihslhhoghhitgdrtghomhdrthifpdhrtghpthhtohepghhr
    vghgrdhtuhesghgvnhgvshihshhlohhgihgtrdgtohhmrdhtfi
X-ME-Proxy: <xmx:6022Z4zvPmvADj302GeodEWXhpqWjzRXsBF3U1mMuY6mhdWwJu4eyg>
    <xmx:6022Z_SKV65Pqy3K6QtCT6-o0SIHvHZPgK7ydIru8o4JXBXMfrzNUQ>
    <xmx:6022Zzb-8xMMjULWnILGJNc1TbjuTIkWHa4J5bvQ8KfByRKs05DGMQ>
    <xmx:6022Z4RSrVV3DJ0_8Kl_Oxyjzq41lnGVhJfsq5ITmcbfcxn2f-5_EA>
    <xmx:7E22Z7oHVMxT5Dh0GWOrqx7wSJg3ku7OuDx3xEhnWM7elPdiUtaCZrVb>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 16:32:26 -0500 (EST)
Date: Wed, 19 Feb 2025 22:32:24 +0100
From: Janne Grunau <j@jannau.net>
To: Victor Shih <victorshihgli@gmail.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com, Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>,
	asahi@lists.linux.dev
Subject: Re: [PATCH V23 15/16] mmc: sdhci-pci-gli: enable UHS-II mode for
 GL9755
Message-ID: <20250219213224.GA57799@robin.jannau.net>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
 <20241018105333.4569-16-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241018105333.4569-16-victorshihgli@gmail.com>

Hej,

On Fri, Oct 18, 2024 at 06:53:32PM +0800, Victor Shih wrote:
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
> 
> Changes are:
>  * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
>  * Enable the internal clock when do reset on UHS-II mode.
>  * Increase timeout value before detecting UHS-II interface.
>  * Add vendor settings fro UHS-II mode.
>  * Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl variable.
>  * Make a function sdhci_gli_wait_software_reset_done() for gl9755 reset.
>  * Remove unnecessary code from sdhci_gl9755_reset().
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
> ---
> 
>  drivers/mmc/host/sdhci-pci-gli.c | 235 ++++++++++++++++++++++++++++++-
>  1 file changed, 234 insertions(+), 1 deletion(-)

This change results in error messages / timeout about UHS2 followed by
register dumps with the GL9755 integrated in Apple silicon Macbook Pros
and Mac Studio systems. Non UHS-II function of controller does not seem
to be affected. Apple advertises the the SDXC slot as UHS-II capable.

The only quirk we've experienced with gl9755 on this platform is that 8
and 16 bit MMIO reads do not work. Workaround added in commit
c064bb5c78c1b ("mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads
as 32-bit reads.").

If you have ideas or patches to try I'm happy to do that. If not we can
look into what MacOS does.

See kernel log and lspci output below

Thanks,
Janne

[   38.130033] kernel: sdhci: Secure Digital Host Controller Interface driver
[   38.130141] kernel: sdhci: Copyright(c) Pierre Ossman
[   38.133352] kernel: sdhci-pci 0000:02:00.0: Adding to iommu group 13
[   38.160551] kernel: sdhci-pci 0000:02:00.0: SDHCI controller found [17a0:9755] (rev 1)
[   38.160655] kernel: sdhci-pci 0000:02:00.0: enabling device (0000 -> 0002)
[   38.160750] kernel: mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA 64-bit
[   38.274617] kernel: mmc0: not detect UHS2 interface in 100ms.
[   38.274717] kernel: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   38.274782] kernel: mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
[   38.277391] kernel: mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[   38.277475] kernel: mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[   38.280125] kernel: mmc0: sdhci: Present:   0x20070000 | Host ctl: 0x00000000
[   38.280206] kernel: mmc0: sdhci: Power:     0x000000bf | Blk gap:  0x00000000
[   38.284511] kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000032f
[   38.284592] kernel: mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x00000000
[   38.284636] kernel: mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
[   38.287200] kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   38.287281] kernel: mmc0: sdhci: Caps:      0x396a3281 | Caps_1:   0x1803057f
[   38.291212] kernel: mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x000000c8
[   38.291292] kernel: mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[   38.291335] kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   38.293513] kernel: mmc0: sdhci: Host ctl2: 0x00009107
[   38.293604] kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000000000000
[   38.297842] kernel: mmc0: sdhci_uhs2: ==================== UHS2 ==================
[   38.297923] kernel: mmc0: sdhci_uhs2: Blk Size:  0x00000000 | Blk Cnt:  0x00000000
[   38.297968] kernel: mmc0: sdhci_uhs2: Cmd:       0x00000000 | Trn mode: 0x00000000
[   38.300773] kernel: mmc0: sdhci_uhs2: Int Stat:  0x00000000 | Dev Sel : 0x00000000
[   38.300853] kernel: mmc0: sdhci_uhs2: Dev Int Code:  0x00000000
[   38.304739] kernel: mmc0: sdhci_uhs2: Reset:     0x00000000 | Timer:    0x000000a7
[   38.304811] kernel: mmc0: sdhci_uhs2: ErrInt:    0x00000000 | ErrIntEn: 0x00030000
[   38.304856] kernel: mmc0: sdhci_uhs2: ErrSigEn:  0x00030000
[   38.307110] kernel: mmc0: sdhci: ============================================
[   38.307201] kernel: mmc0: cannot detect UHS2 interface.
[   38.310110] kernel: mmc0: failed to initial phy for UHS-II!
[   38.424645] kernel: mmc0: not detect UHS2 interface in 100ms.
[   38.424731] kernel: mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   38.424758] kernel: mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
[   38.424782] kernel: mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
[   38.424840] kernel: mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x00000000
[   38.427603] kernel: mmc0: sdhci: Present:   0x20070000 | Host ctl: 0x00000000
[   38.427659] kernel: mmc0: sdhci: Power:     0x000000bf | Blk gap:  0x00000000
[   38.430579] kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000032f
[   38.430626] kernel: mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x00000000
[   38.433504] kernel: mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x00ff0083
[   38.433550] kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   38.437596] kernel: mmc0: sdhci: Caps:      0x396a3281 | Caps_1:   0x1803057f
[   38.437641] kernel: mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x000000c8
[   38.437677] kernel: mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
[   38.440318] kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
[   38.440345] kernel: mmc0: sdhci: Host ctl2: 0x00009107
[   38.444119] kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0000000000000000
[   38.444161] kernel: mmc0: sdhci_uhs2: ==================== UHS2 ==================
[   38.444184] kernel: mmc0: sdhci_uhs2: Blk Size:  0x00000000 | Blk Cnt:  0x00000000
[   38.446918] kernel: mmc0: sdhci_uhs2: Cmd:       0x00000000 | Trn mode: 0x00000000
[   38.446958] kernel: mmc0: sdhci_uhs2: Int Stat:  0x00000000 | Dev Sel : 0x00000000
[   38.450833] kernel: mmc0: sdhci_uhs2: Dev Int Code:  0x00000000
[   38.450874] kernel: mmc0: sdhci_uhs2: Reset:     0x00000000 | Timer:    0x000000a7
[   38.450907] kernel: mmc0: sdhci_uhs2: ErrInt:    0x00000000 | ErrIntEn: 0x00030000
[   38.454625] kernel: mmc0: sdhci_uhs2: ErrSigEn:  0x00030000
[   38.454665] kernel: mmc0: sdhci: ============================================
[   38.454699] kernel: mmc0: cannot detect UHS2 interface.
[   38.456705] kernel: mmc0: failed to initial phy for UHS-II!


`lspci -vvvnn -d 17a0:9755` output:
02:00.0 SD Host controller [0805]: Genesys Logic, Inc GL9755 SD Host Controller [17a0:9755] (rev 01) (prog-if 01)
        Subsystem: Genesys Logic, Inc GL9755 SD Host Controller [17a0:9755]
        Device tree node: /sys/firmware/devicetree/base/soc@200000000/pcie@590000000/pci@1,0/mmc@0,0
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 168
        IOMMU group: 13
        Region 0: Memory at 5c1e00000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W TEE-IO-
                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
                        MaxPayload 128 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
                LnkCap: Port #85, Speed 5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <4us, L1 unlimited
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1
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
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [e0] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fffff000  Data: 0018
        Capabilities: [f8] Power Management version 3
                Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0-,D1+,D2+,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME+
        Capabilities: [100 v1] Vendor Specific Information: ID=17a0 Rev=1 Len=008 <?>
        Capabilities: [108 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [110 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=255us PortTPowerOnTime=3100us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=3375104ns
                L1SubCtl2: T_PwrOn=3100us
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
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: sdhci-pci
        Kernel modules: sdhci_pci

