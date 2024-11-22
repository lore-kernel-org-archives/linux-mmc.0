Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E181DE89D
	for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292108; cv=none; b=LP71gZu01tcr9zQvM1B6PHef4wDLVn8ygMxNLPRl1GqJc6D8Uj93YF5eEWVW8TNg9LVF0bVUMBHl2eSkUgtGiY5l5Gy8DqjFNfsVqnUa0wsts3mWFTQJ01YkeTS60Vd0/0qGbKuQkKw4NReZp89plQIqQaHpqNWgRpfcXA1fXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292108; c=relaxed/simple;
	bh=UXHKH+tn2k1sf2pymXA3k1t9baA/88reB+OQUj4zdHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qA6JVlp07LqeIKQphREgqSPeLyHD7f0BYbJLAXoqwrKgaBkcZTK02u+gQZNSzPBlXhcp07+XYOpeZobwy1VwSGQTi9PurysT7GKBBknrRge8LW6eix7x2UVIxvcL0gIZHOdfbV/4MR3kvvpd4NiD5Lcz0/ntSroQmkLbdv8oals=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p55FwqHi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p55FwqHi"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5cf9ef18ae9so6487315a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 08:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732292104; x=1732896904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKuaoF5WY6am7cO+jXx2uCjMC60YxcYyklIAVCPFPTE=;
        b=p55FwqHiYY+5gvWK5BamjrMWtyk48nL/dLiyERGgGD1dt93eljXDwGyR+OEaQnv9ov
         Cs1XEarMh7iyIDCUoSr5eeVG5DRbzB6/wVCF+P5RKUgROO2C94JgugTxbEjNdvFLD3vM
         sW5rOxyJDXKxuLSNnpmlxlD8bAMVOKRnNVVfh8P9k7mRnne2F7fzIyPbW3jO0Ck5sewu
         EnsQxHs4ekiGDwaiobY4Kfunn0AkeJwkxehkRAyn7VOzDP/59rYvhAWR1gI/a6SeFT6W
         +H5OCeaDIavtjM3D/bknRlPbGpyM1OEOKdzFykUAhZ9sIL72ygKAyESzB5WTNITBv5cR
         ABpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732292104; x=1732896904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKuaoF5WY6am7cO+jXx2uCjMC60YxcYyklIAVCPFPTE=;
        b=sXPse34wtjTQ4Bc6Tet3GGK190bV04TYzq2Olb2JHpgTpz6xNQOPnm3Ivi1qj1TqZd
         r2qiT0I+dQEwiWI910d1P68p18tgok4XjCJYzlPFEUS+zX7jB0NfodKiQGq/Zwr8Oa+q
         DkJ+zD4kbDdZn06V1XdZHywBmsnm8rx35kJNpioSOTCNuLodaByYBTuKgbHMhMxl6BVz
         xRgqmc9RXZq2eKto3Ts6Se8emsuAQSCFZeXeB17q7tH60yn0hP6rTM+ou310xLCchshZ
         IpTCNY19JTnqt28k6R1JYtIiLxdX743dg16IYUdk2hJs/pjeG5x4MsZAXcNaq+4GeoJg
         nVXA==
X-Gm-Message-State: AOJu0YxQgr5rVXYUoE3CPmtnxuhAnngipiVfMcyvIwkgjrhC2WfU44KM
	Ks3o9kjC6cTsdTbl7PJuPhqe96FoRrGkT3ppVIr6T6CsV0IwrH07pPXEOS+X7tUUyUdnpZMNn0a
	sTQRmlAu35lbkTYDYwKamanUQTVwpZ7OgEC5XTA==
X-Gm-Gg: ASbGncsw7NytM6aA4dyRHMYH9QOsV50IhcOZ3pWG9egcX6MMB2Utbz/n9wwX87qtguY
	+ExLqJQJJkJxbcLJVn3/4s+6LoCgm5c8A
X-Google-Smtp-Source: AGHT+IFSakD+edGOb7cjWBeASvcWCarbhk3/bGqqxTgW8QTN6VnCuOros7gn3tl8Zs99mMCeBEl7vdhAv7EJRVPLTCY=
X-Received: by 2002:a17:907:770a:b0:a99:f777:c6ef with SMTP id
 a640c23a62f3a-aa509985435mr429626166b.3.1732292104288; Fri, 22 Nov 2024
 08:15:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdCjQuiLHkX+ZJT6RbG01gxMo-Q9Y80P=FpNnS35rYWWV3eLw@mail.gmail.com>
 <CAPDyKFrqxO6gSNTx7suYv+2_KZRaBrwnwwXzrAeSERYs3nRDXg@mail.gmail.com> <CAOdCjQsGG5wdsvkkSw9DtcnYGG-4q1Mzpfb=m5EvEtMccX3QLg@mail.gmail.com>
In-Reply-To: <CAOdCjQsGG5wdsvkkSw9DtcnYGG-4q1Mzpfb=m5EvEtMccX3QLg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Nov 2024 17:14:26 +0100
Message-ID: <CAPDyKFo9waTUhFWgZMtgmGzmho7BzxvGCpQp7ikdEF6=LmipVg@mail.gmail.com>
Subject: Re: SDHCI: linux-6.11: mmc0: Reset 0x2 never completed
To: Pankaj Pandey <pankaj.embedded@gmail.com>
Cc: linux-mmc@vger.kernel.org, isheng Zhang <jszhang@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Liming Sun <limings@nvidia.com>, 
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Shawn, Liming, Yifeng,

On Fri, 22 Nov 2024 at 08:09, Pankaj Pandey <pankaj.embedded@gmail.com> wro=
te:
>
> Hi Ulf,
>
> Tried in linux-6.12 but observed same issue there also:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> devkit-e7 login: mmc0: Timeout waiting for hardware cmd interrupt.
> mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
> mmc0: sdhci: Present:   0x03ff0000 | Host ctl: 0x00000001
> mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> mmc0: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
> mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00000000
> mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> mmc0: sdhci: Host ctl2: 0x00000000
> mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> mmc0: Reset 0x2 never completed.
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Regards,
> Pankaj Pandey

Thanks Pankaj,

It's not entirely easy to tell what goes wrong - and a lot of changes
have happened since v5.4.

I guess a git bisect would help us to narrow down when things got
screwed up. If you have the time to do that, that would greatly help I
think.

I have looped in some more of the driver authors to see if someone has
an idea where to start looking.

In the meantime, it would be useful to get some more information about
your platform and a pointer to some DTS files.

Kind regards
Uffe

>
> On Wed, Nov 20, 2024 at 6:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Wed, 20 Nov 2024 at 09:28, Pankaj Pandey <pankaj.embedded@gmail.com>=
 wrote:
> > >
> > > Hi All,
> > >
> > > My target board(ARMv8-A AArch32 processor), supports the "Synopsys DW=
C
> > > MSHC controller." I am using the Linux 5.4 kernel and have enabled th=
e
> > > following configurations to support the "SDHCI platform driver for
> > > Synopsys DWC MSHC":
> > >
> > > CONFIG_MMC_SDHCI=3Dy
> > > CONFIG_MMC_SDHCI_PLTFM=3Dy
> > > CONFIG_MMC_SDHCI_OF_DWCMSHC=3Dy
> > >
> > > This setup works perfectly on Linux 5.4, successfully detecting all
> > > microSD cards. However, when I use the same driver configuration with
> > > Linux 6.11.0, I encounter the below mentioned error:
> > >
> > > sdhci: Secure Digital Host Controller Interface driver
> > > sdhci: Copyright(c) Pierre Ossman
> > > sdhci-pltfm: SDHCI platform and OF driver helper
> > > mmc0: sdhci: Version:   0x00000005 | Present:  0x020f0000
> > > mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> > > SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > > mmc0: sdhci: Auto-CMD23 available
> > > mmc0: SDHCI controller on 48102000.sdhci [48102000.sdhci] using ADMA
> > > mmc0: Timeout waiting for hardware cmd interrupt.
> > > mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP=
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> > > mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> > > mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
> > > mmc0: sdhci: Present:   0x020f0000 | Host ctl: 0x00000001
> > > mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> > > mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> > > mmc0: sdhci: Int enab:  0x00ff1083 | Sig enab: 0x00ff1083
> > > mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > > mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> > > mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00000000
> > > mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> > > mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > > mmc0: sdhci: Host ctl2: 0x00000000
> > > mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> > > mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > mmc0: Reset 0x2 never completed.
> > >
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > >
> > > Please find mmc debug info and dts file changes for references:-
> > >
> > > root@devkit-e7:~# cat /sys/kernel/debug/mmc0/ios
> > > clock:          400000 Hz
> > > actual clock:   400000 Hz
> > > vdd:            21 (3.3 ~ 3.4 V)
> > > bus mode:       2 (push-pull)
> > > chip select:    1 (active high)
> > > power mode:     2 (on)
> > > bus width:      0 (1 bits)
> > > timing spec:    0 (legacy)
> > > signal voltage: 0 (3.30 V)
> > > driver type:    0 (driver type B)
> > >
> > > sdmmc: sdhci@48102000 {
> > >                         compatible =3D "snps,dwcmshc-sdhci";
> > >                         reg =3D <0x48102000 0x1000>;
> > >                         interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIG=
H>,
> > >                                      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>=
;
> > >                         clocks =3D <&syst_hclk>, <&syst_hclk>;
> > >                         clock-names =3D "core", "bus";
> > >                         bus-width =3D <4>;
> > > max-frequency =3D <25000000>;
> > >                         status =3D "okay";
> > >                 };
> > >
> > > Kindly request you to please let me know if I am missing anything.
> >
> > Would it be possible for you to do a "git bisect" to see if we can
> > find if there is a particular commit causing the problem?
> >
> > Moreover, we have v6.12 now, so it seems reasonable to give that a try =
too.
> >
> > Kind regards
> > Uffe
