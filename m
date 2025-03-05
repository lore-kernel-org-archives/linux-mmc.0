Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEF814012;
	Wed,  5 Mar 2025 00:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741136164; cv=none; b=nlDWCcoN43/A2YMbVL/IiL5aTFT0G49tvHOXyOYWn+ervnmCXJbQNJTLTnw8j7VuNbSDGy0jlnGNcRvviNTmlhPKUJ9Z3p8fkcxFmqaI/ndylVLeXpmAaSMi5TecNyeeH9icDFlkpanmMikjLbeZH5CY9zZupCSd5TG465vJCCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741136164; c=relaxed/simple;
	bh=JTn6GzPNPqqm9bsg0T92D8cwuGo3C+SZjKiKXwoacIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QroqxgDjscmlgVEEOyIjETAX8FlCvBuXx1nFfk9nJVfftwWi6L4WBv9YZMG0sJTth0s5amv7HJOkWr5HK+PdAeRnOM/U5l9953TKO0W9Eo9jTtpXcmvYTaBWpHa1vaaALCLtd422wnF1juCG1QS6ea4Kqg4yV30YCACXvIH6uXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKYN5io0; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKYN5io0"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abbd96bef64so978055966b.3;
        Tue, 04 Mar 2025 16:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741136161; x=1741740961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OY2x4gnjLqoTDFi3EfoqcVKZo6xoBR0yZoxan8KFIxg=;
        b=CKYN5io0cU3o5PlySXrjYMsTEEdpyuHK+Cr7vWRtR0OyS+t9mClosEaAtGaXzUnkdY
         +EvN6+Cj4Ew2Dlr/170sMtE/yKRkxBNqDhhknWtzH0NKaYt+BvsvjTu+OOWNzKIp1m9q
         LCHYbSPcqlt1ol5JqS1k0erPGWihPIIQSvPvc3hGxlkvdekEF4eBM9jUiyXmDQ6iQmxo
         QyEPCDhDB1Mw7qHv6IGs6tFeSMyvQAO0aYA/4SkPe7h901gawQFs1TmmrkOzft20+j1B
         vQDylHm/Z5Y42VLTtBI1bD0WFRR4OSya0C4oY4JH3VkImsvNwijWwPaXSqI6P6yzjZ2B
         CuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741136161; x=1741740961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OY2x4gnjLqoTDFi3EfoqcVKZo6xoBR0yZoxan8KFIxg=;
        b=qpLXlG3tTyW0J0hUnsO1G8t5U/Vb+u5mZ3haSAcXhwCXhFqyzzCsBMTvHdPZhrVClG
         qG/e+/EN3w6tpNJ+Swyya6ViD9YScZ/I2a3o447Z0Brx2MCC8kCRPF3Z4yLOx1aQmXmM
         KrcetHnXoYv07eekQJAzXv/MLITa5r/jqHi6Lg0znDknycNWlkx+gM8ioYZnJU4ylI2G
         ygb+GSiIdAhuBVHZlzgeKZMcx7LVJbpQ3wyD0nLXktbrSKi6l9e+yvQl4x+iiQW+fsQZ
         Pb2z/auolh20359jI5UI8z+qCALt4gM6vpKEuOd5KXvvjBtBYBg044BjTphiiaSdT4JB
         NrYA==
X-Forwarded-Encrypted: i=1; AJvYcCUVRgUvqq1evxcN78fNhimamStWhp2YMkOJv6oLq948MjC/EPNQIvPptqE9CIQ/k/z0HoFBFhTOiQLu@vger.kernel.org, AJvYcCWmdoEVgwCPSWJ8lOSQhQ65rmDNXiLC+izWpUb9BZoGgMJ9liBWlI/3v7mRADkJmQ2RUyb//+eEHAHo8rk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/WXrlNWr54uYsi7M9scc1ckLQVQSl5uRfjIH5vmm419uiwZn
	D+Mcv39aer1N9jaYjBw1YpXHeLqd2ncpzCjlkWa2ol0v/oae+j+9VruNDxcIm11HvsEoPa2T/nu
	H3LnzoQaruKuFv9coNtvi6l4NNV4=
X-Gm-Gg: ASbGnctOOKfra5Y9mjmyDyWpYMToffwQrGonrDFP6Qs6cv+/G2dywa3WLtNcUT7l9zU
	qE8rAB9aGbCgfc4LHPeetL2fgE0jCpO48gobeAN7DErLjSRiUAvLqbEfEk7SL1IdVDgNDDLpG2U
	isF/REvhBV8sS7jrR2qkHuFlKKxw==
X-Google-Smtp-Source: AGHT+IGQzRduDfZFmBJyaj4Z7SOysnLQsRrUO5HDaJ018JPlEHCqsqp7XujrtSitg9FNgWCQt4ly41NTZdNISfR/iPo=
X-Received: by 2002:a17:907:1c1e:b0:abf:215b:4ac6 with SMTP id
 a640c23a62f3a-ac20db689e7mr123775866b.53.1741136160531; Tue, 04 Mar 2025
 16:56:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018105333.4569-1-victorshihgli@gmail.com>
 <20241018105333.4569-16-victorshihgli@gmail.com> <20250219213224.GA57799@robin.jannau.net>
In-Reply-To: <20250219213224.GA57799@robin.jannau.net>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Wed, 5 Mar 2025 08:56:09 +0800
X-Gm-Features: AQ5f1JoWYl7jq37wqR0tO3MuppCzy7Hw8hyzC8DbxRyc-DB-AjUUnpPyAGyQrAY
Message-ID: <CACT4zj9Xgah3Gp-=Ujp-z7hRCmHt_aGnLEchurN00M1LtbjSzQ@mail.gmail.com>
Subject: Re: [PATCH V23 15/16] mmc: sdhci-pci-gli: enable UHS-II mode for GL9755
To: Janne Grunau <j@jannau.net>
Cc: Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org, 
	adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lucas.Lai@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw, dlunev@chromium.org, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, 
	AKASHI Takahiro <takahiro.akashi@linaro.org>, Victor Shih <victor.shih@genesyslogic.com.tw>, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Janne,

On Thu, Feb 20, 2025 at 5:32=E2=80=AFAM Janne Grunau <j@jannau.net> wrote:
>
> Hej,
>
> On Fri, Oct 18, 2024 at 06:53:32PM +0800, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Changes are:
> >  * Disable GL9755 overcurrent interrupt when power on/off on UHS-II.
> >  * Enable the internal clock when do reset on UHS-II mode.
> >  * Increase timeout value before detecting UHS-II interface.
> >  * Add vendor settings fro UHS-II mode.
> >  * Remove sdhci_gli_enable_internal_clock functon unused clk_ctrl varia=
ble.
> >  * Make a function sdhci_gli_wait_software_reset_done() for gl9755 rese=
t.
> >  * Remove unnecessary code from sdhci_gl9755_reset().
> >
> > Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > Signed-off-by: Lucas Lai <lucas.lai@genesyslogic.com.tw>
> > ---
> >
> >  drivers/mmc/host/sdhci-pci-gli.c | 235 ++++++++++++++++++++++++++++++-
> >  1 file changed, 234 insertions(+), 1 deletion(-)
>
> This change results in error messages / timeout about UHS2 followed by
> register dumps with the GL9755 integrated in Apple silicon Macbook Pros
> and Mac Studio systems. Non UHS-II function of controller does not seem
> to be affected. Apple advertises the the SDXC slot as UHS-II capable.
>
> The only quirk we've experienced with gl9755 on this platform is that 8
> and 16 bit MMIO reads do not work. Workaround added in commit
> c064bb5c78c1b ("mmc: sdhci-pci-gli: GL975[50]: Issue 8/16-bit MMIO reads
> as 32-bit reads.").
>
> If you have ideas or patches to try I'm happy to do that. If not we can
> look into what MacOS does.
>
> See kernel log and lspci output below
>
> Thanks,
> Janne
>
> [   38.130033] kernel: sdhci: Secure Digital Host Controller Interface dr=
iver
> [   38.130141] kernel: sdhci: Copyright(c) Pierre Ossman
> [   38.133352] kernel: sdhci-pci 0000:02:00.0: Adding to iommu group 13
> [   38.160551] kernel: sdhci-pci 0000:02:00.0: SDHCI controller found [17=
a0:9755] (rev 1)
> [   38.160655] kernel: sdhci-pci 0000:02:00.0: enabling device (0000 -> 0=
002)
> [   38.160750] kernel: mmc0: SDHCI controller on PCI [0000:02:00.0] using=
 ADMA 64-bit
> [   38.274617] kernel: mmc0: not detect UHS2 interface in 100ms.
> [   38.274717] kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
SDHCI REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   38.274782] kernel: mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x0=
0000005
> [   38.277391] kernel: mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x0=
0000000
> [   38.277475] kernel: mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0=
0000000
> [   38.280125] kernel: mmc0: sdhci: Present:   0x20070000 | Host ctl: 0x0=
0000000
> [   38.280206] kernel: mmc0: sdhci: Power:     0x000000bf | Blk gap:  0x0=
0000000
> [   38.284511] kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0=
000032f
> [   38.284592] kernel: mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x0=
0000000
> [   38.284636] kernel: mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x0=
0ff0083
> [   38.287200] kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x0=
0000000
> [   38.287281] kernel: mmc0: sdhci: Caps:      0x396a3281 | Caps_1:   0x1=
803057f
> [   38.291212] kernel: mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x0=
00000c8
> [   38.291292] kernel: mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x0=
0000000
> [   38.291335] kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x0=
0000000
> [   38.293513] kernel: mmc0: sdhci: Host ctl2: 0x00009107
> [   38.293604] kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0=
000000000000000
> [   38.297842] kernel: mmc0: sdhci_uhs2: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D UHS2 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [   38.297923] kernel: mmc0: sdhci_uhs2: Blk Size:  0x00000000 | Blk Cnt:=
  0x00000000
> [   38.297968] kernel: mmc0: sdhci_uhs2: Cmd:       0x00000000 | Trn mode=
: 0x00000000
> [   38.300773] kernel: mmc0: sdhci_uhs2: Int Stat:  0x00000000 | Dev Sel =
: 0x00000000
> [   38.300853] kernel: mmc0: sdhci_uhs2: Dev Int Code:  0x00000000
> [   38.304739] kernel: mmc0: sdhci_uhs2: Reset:     0x00000000 | Timer:  =
  0x000000a7
> [   38.304811] kernel: mmc0: sdhci_uhs2: ErrInt:    0x00000000 | ErrIntEn=
: 0x00030000
> [   38.304856] kernel: mmc0: sdhci_uhs2: ErrSigEn:  0x00030000
> [   38.307110] kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> [   38.307201] kernel: mmc0: cannot detect UHS2 interface.
> [   38.310110] kernel: mmc0: failed to initial phy for UHS-II!
> [   38.424645] kernel: mmc0: not detect UHS2 interface in 100ms.
> [   38.424731] kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
SDHCI REGISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   38.424758] kernel: mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x0=
0000005
> [   38.424782] kernel: mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x0=
0000000
> [   38.424840] kernel: mmc0: sdhci: Argument:  0x00000000 | Trn mode: 0x0=
0000000
> [   38.427603] kernel: mmc0: sdhci: Present:   0x20070000 | Host ctl: 0x0=
0000000
> [   38.427659] kernel: mmc0: sdhci: Power:     0x000000bf | Blk gap:  0x0=
0000000
> [   38.430579] kernel: mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0=
000032f
> [   38.430626] kernel: mmc0: sdhci: Timeout:   0x00000007 | Int stat: 0x0=
0000000
> [   38.433504] kernel: mmc0: sdhci: Int enab:  0x00ff0083 | Sig enab: 0x0=
0ff0083
> [   38.433550] kernel: mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x0=
0000000
> [   38.437596] kernel: mmc0: sdhci: Caps:      0x396a3281 | Caps_1:   0x1=
803057f
> [   38.437641] kernel: mmc0: sdhci: Cmd:       0x00000000 | Max curr: 0x0=
00000c8
> [   38.437677] kernel: mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x0=
0000000
> [   38.440318] kernel: mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x0=
0000000
> [   38.440345] kernel: mmc0: sdhci: Host ctl2: 0x00009107
> [   38.444119] kernel: mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x0=
000000000000000
> [   38.444161] kernel: mmc0: sdhci_uhs2: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D UHS2 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> [   38.444184] kernel: mmc0: sdhci_uhs2: Blk Size:  0x00000000 | Blk Cnt:=
  0x00000000
> [   38.446918] kernel: mmc0: sdhci_uhs2: Cmd:       0x00000000 | Trn mode=
: 0x00000000
> [   38.446958] kernel: mmc0: sdhci_uhs2: Int Stat:  0x00000000 | Dev Sel =
: 0x00000000
> [   38.450833] kernel: mmc0: sdhci_uhs2: Dev Int Code:  0x00000000
> [   38.450874] kernel: mmc0: sdhci_uhs2: Reset:     0x00000000 | Timer:  =
  0x000000a7
> [   38.450907] kernel: mmc0: sdhci_uhs2: ErrInt:    0x00000000 | ErrIntEn=
: 0x00030000
> [   38.454625] kernel: mmc0: sdhci_uhs2: ErrSigEn:  0x00030000
> [   38.454665] kernel: mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> [   38.454699] kernel: mmc0: cannot detect UHS2 interface.
> [   38.456705] kernel: mmc0: failed to initial phy for UHS-II!
>

On which UHS-II card does this message appear? Please share the card
information.
If it is a UHS-I card, this message is normal.

Best regards,
Ben Chuang

>
> `lspci -vvvnn -d 17a0:9755` output:
> 02:00.0 SD Host controller [0805]: Genesys Logic, Inc GL9755 SD Host Cont=
roller [17a0:9755] (rev 01) (prog-if 01)
>         Subsystem: Genesys Logic, Inc GL9755 SD Host Controller [17a0:975=
5]
>         Device tree node: /sys/firmware/devicetree/base/soc@200000000/pci=
e@590000000/pci@1,0/mmc@0,0
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0
>         Interrupt: pin A routed to IRQ 168
>         IOMMU group: 13
>         Region 0: Memory at 5c1e00000 (32-bit, non-prefetchable) [size=3D=
4K]
>         Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4=
us, L1 unlimited
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- S=
lotPowerLimit 0W TEE-IO-
>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+=
 TransPend-
>                 LnkCap: Port #85, Speed 5GT/s, Width x1, ASPM L0s L1, Exi=
t Latency L0s <4us, L1 unlimited
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 5GT/s, Width x1
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROP=
rPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Via message/WAKE=
#, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, Emergency=
PowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                          AtomicOpsCtl: ReqEn-
>                          IDOReq- IDOCompl- LTR+ EmergencyPowerReductionRe=
q-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Ret=
imer- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- Speed=
Dis-
>                          Transmit Margin: Normal Operating Range, EnterMo=
difiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB de-emphasis,=
 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationCom=
plete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3- LinkEqua=
lizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported
>         Capabilities: [e0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>                 Address: 00000000fffff000  Data: 0018
>         Capabilities: [f8] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1=
+,D2+,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME=
+
>         Capabilities: [100 v1] Vendor Specific Information: ID=3D17a0 Rev=
=3D1 Len=3D008 <?>
>         Capabilities: [108 v1] Latency Tolerance Reporting
>                 Max snoop latency: 0ns
>                 Max no snoop latency: 0ns
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+=
 L1_PM_Substates+
>                           PortCommonModeRestoreTime=3D255us PortTPowerOnT=
ime=3D3100us
>                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1=
-
>                            T_CommonMode=3D0us LTR1.2_Threshold=3D3375104n=
s
>                 L1SubCtl2: T_PwrOn=3D3100us
>         Capabilities: [200 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNon=
FatalErr- CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvNon=
FatalErr+ CorrIntErr- HeaderOF-
>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- E=
CRCChkCap+ ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCa=
p-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Kernel driver in use: sdhci-pci
>         Kernel modules: sdhci_pci
>
