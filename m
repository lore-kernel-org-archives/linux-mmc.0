Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA2D1B3927
	for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 15:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732547660; cv=none; b=cAxrYiM5ccQGyWJYP7IwCAgYn/B6+FCmNBRKkriqz2TwFGwhGQMQIqUxK9YLhLTxMAsqUzLenzBf4k7EJVN+6xyxqGKT+s5Do5wyjhMZ4gAjX3XYKImk//xoaT9HYGPZ5Z4VG0GhL8nfWFdtTjYvTKf7VjjTRVHh9QfSHhTKeRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732547660; c=relaxed/simple;
	bh=udSDtNajs+H8p4UAH8xPYuj/vRuWAdZQen1z7/nDarI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBdSXV9KPyimRyyYzIS6NUAfO8bBKALNFRQkmE5P3ZpuQMz9IL4tDvkQE7q8VrG7MYJ3+UgK5FgoivWXe7SaPbFO36LaOw0bxAUzTO95H/OWIAXwurMvDj61pE6IeraC3lzHtobohr41qCORB6AnT1VlYdi33/6Iv62Iku82e9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4ZDFps3; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4ZDFps3"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ed91d2a245so2026067a91.3
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 07:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732547658; x=1733152458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wa0N1SU22Wu+tyL3YIkI5FjfbL56goRe3EIZS5NsUlI=;
        b=G4ZDFps3IMk1HeX92fFmP+Ng5w5b6tFc8ztgIPGhoFzYnKV5YycRac3JZWB1BnF6RO
         g9nRO7Eh26of4sLrM5C/0smCmGlneQtI4CKPUOQpzG7iwEL4NpjzWDkye0ULER63R95+
         /4LHLcHKngnylX4Sn+ZC4f79qFdl95gydL4AcCP4GN4adrXEPMze43HM/teTdqpX9DhY
         2AS3AIblKvpQPPPsGXe4si4aKzAmH05AVVDpQu4mi/jSgBx5BVdCFEl40CHhwK7ZqXMq
         zQIP1EaHJrt6CY1SKRiUXv418wDziXmtr1tYv3p3NLzYtHBrr1Ts7yvFx6YhTE/EPbQ3
         9ASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732547658; x=1733152458;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wa0N1SU22Wu+tyL3YIkI5FjfbL56goRe3EIZS5NsUlI=;
        b=wA8MX43ptGkl+Ias5Ig6X5zL2eFwIjGAzkFvnoDaTdmcH+IuRpZPJr5FKbxp6pFKiM
         TNJXcuVXEmj3TSFREQHd6tDa96e1b3n267cTBlrAIdAyAxRhWrRvKG+oWmtXKSbYQcw8
         5IDSyT6AipFESkCFpz/vOCw91HRhXLDikBdn3uuNilQ0b764kSOiLd7aamju88RoBokQ
         T1HC+lLqbWCEqLKkxCLzAPUVj4Ra4R2yPQLm9FCuRg1d8Tuk77Ottfz+0OkggFCjAtgY
         1UcVuhxBoTy2LU1CYXq21Bv0G+TQs4D2p82atPjZEvKbP5517FJcMra03paqZmpvP09I
         uYug==
X-Gm-Message-State: AOJu0YzyPychTZSqSSRH0fBvhn2Nn8x3w7FP5tUF86O/e3R8Iu23LcSv
	qEn6tkUCFViJIxoFJ/vdZXophc7RypbKZ3k0lQoU3/v/RfbpibYwY+svsBUB8T39hQb4/cqPq6X
	NK4ivu6iFK6OA7jLtgNK6Aexy4to=
X-Gm-Gg: ASbGncsMVT5p5cbUiNzYe8PWaejgZSuzVPV+XMnQdUgVAAuqS4lYW/SadmSVXts0H+I
	yg6yRPx7Bx7WaOMn2P36fIy8Vs8aCCQ==
X-Google-Smtp-Source: AGHT+IEgXbFU53468R6fHk6tl/Y/6IjGWAbq7BHTCPBOwcgmL2ToYd/RLELZHGI2v/uLAyaKDgNMmbqScE/Ii4YWR8E=
X-Received: by 2002:a17:90b:4b0c:b0:2ea:4e9e:df87 with SMTP id
 98e67ed59e1d1-2eb0e3331d0mr16082377a91.19.1732547657040; Mon, 25 Nov 2024
 07:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdCjQuiLHkX+ZJT6RbG01gxMo-Q9Y80P=FpNnS35rYWWV3eLw@mail.gmail.com>
 <CAPDyKFrqxO6gSNTx7suYv+2_KZRaBrwnwwXzrAeSERYs3nRDXg@mail.gmail.com>
 <CAOdCjQsGG5wdsvkkSw9DtcnYGG-4q1Mzpfb=m5EvEtMccX3QLg@mail.gmail.com> <CAPDyKFo9waTUhFWgZMtgmGzmho7BzxvGCpQp7ikdEF6=LmipVg@mail.gmail.com>
In-Reply-To: <CAPDyKFo9waTUhFWgZMtgmGzmho7BzxvGCpQp7ikdEF6=LmipVg@mail.gmail.com>
From: Pankaj Pandey <pankaj.embedded@gmail.com>
Date: Mon, 25 Nov 2024 20:44:05 +0530
Message-ID: <CAOdCjQsQkRnhpgXtJL_+GfwX4s8K5QyBH=G7pt+_QSe=P1+cOQ@mail.gmail.com>
Subject: Re: SDHCI: linux-6.11: mmc0: Reset 0x2 never completed
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, isheng Zhang <jszhang@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Liming Sun <limings@nvidia.com>, 
	Yifeng Zhao <yifeng.zhao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf/Isheng/Shawn/Liming,

For reference please find my dts changes for  sdhci:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
sdmmc: sdhci@48102000 {
                        compatible =3D "snps,dwcmshc-sdhci";
                        reg =3D <0x48102000 0x1000>;
                        interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
                                     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
                        clocks =3D <&syst_hclk>, <&syst_hclk>;
                        clock-names =3D "core", "bus";
                        bus-width =3D <4>;
                        max-frequency =3D <25000000>;
                        pinctrl-names =3D "default";
                        pinctrl-0 =3D <&pinctrl_sdhci>;
                        status =3D "okay";
                };
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

My Soc is based on Cortex-A32 processor.  Clock feeding to SD clk is
200MHz and max-frequency supported is 25Mhz.
For reference please find mmc debug messages from sys fs during card
detect stage:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
root@devkit-e7:~# cat /sys/kernel/debug/mmc0/ios
clock:          400000 Hz
actual clock:   400000 Hz
vdd:            21 (3.3 ~ 3.4 V)
bus mode:       2 (push-pull)
chip select:    1 (active high)
power mode:     2 (on)
bus width:      0 (1 bits)
timing spec:    0 (legacy)
signal voltage: 0 (3.30 V)
driver type:    0 (driver type B)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

If you have any pointers please suggest,  your  inputs are  highly apprecia=
ted..

Regards,
Pankaj Pandey

On Fri, Nov 22, 2024 at 9:45=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> + Shawn, Liming, Yifeng,
>
> On Fri, 22 Nov 2024 at 08:09, Pankaj Pandey <pankaj.embedded@gmail.com> w=
rote:
> >
> > Hi Ulf,
> >
> > Tried in linux-6.12 but observed same issue there also:
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > devkit-e7 login: mmc0: Timeout waiting for hardware cmd interrupt.
> > mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> > mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> > mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
> > mmc0: sdhci: Present:   0x03ff0000 | Host ctl: 0x00000001
> > mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> > mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> > mmc0: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
> > mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> > mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00000000
> > mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> > mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > mmc0: sdhci: Host ctl2: 0x00000000
> > mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> > mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > mmc0: Reset 0x2 never completed.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >
> > Regards,
> > Pankaj Pandey
>
> Thanks Pankaj,
>
> It's not entirely easy to tell what goes wrong - and a lot of changes
> have happened since v5.4.
>
> I guess a git bisect would help us to narrow down when things got
> screwed up. If you have the time to do that, that would greatly help I
> think.
>
> I have looped in some more of the driver authors to see if someone has
> an idea where to start looking.
>
> In the meantime, it would be useful to get some more information about
> your platform and a pointer to some DTS files.
>
> Kind regards
> Uffe
>
> >
> > On Wed, Nov 20, 2024 at 6:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro=
.org> wrote:
> > >
> > > On Wed, 20 Nov 2024 at 09:28, Pankaj Pandey <pankaj.embedded@gmail.co=
m> wrote:
> > > >
> > > > Hi All,
> > > >
> > > > My target board(ARMv8-A AArch32 processor), supports the "Synopsys =
DWC
> > > > MSHC controller." I am using the Linux 5.4 kernel and have enabled =
the
> > > > following configurations to support the "SDHCI platform driver for
> > > > Synopsys DWC MSHC":
> > > >
> > > > CONFIG_MMC_SDHCI=3Dy
> > > > CONFIG_MMC_SDHCI_PLTFM=3Dy
> > > > CONFIG_MMC_SDHCI_OF_DWCMSHC=3Dy
> > > >
> > > > This setup works perfectly on Linux 5.4, successfully detecting all
> > > > microSD cards. However, when I use the same driver configuration wi=
th
> > > > Linux 6.11.0, I encounter the below mentioned error:
> > > >
> > > > sdhci: Secure Digital Host Controller Interface driver
> > > > sdhci: Copyright(c) Pierre Ossman
> > > > sdhci-pltfm: SDHCI platform and OF driver helper
> > > > mmc0: sdhci: Version:   0x00000005 | Present:  0x020f0000
> > > > mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> > > > SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > > > mmc0: sdhci: Auto-CMD23 available
> > > > mmc0: SDHCI controller on 48102000.sdhci [48102000.sdhci] using ADM=
A
> > > > mmc0: Timeout waiting for hardware cmd interrupt.
> > > > mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DU=
MP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> > > > mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> > > > mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
> > > > mmc0: sdhci: Present:   0x020f0000 | Host ctl: 0x00000001
> > > > mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > > > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> > > > mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> > > > mmc0: sdhci: Int enab:  0x00ff1083 | Sig enab: 0x00ff1083
> > > > mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > > > mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> > > > mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00000000
> > > > mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
> > > > mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
> > > > mmc0: sdhci: Host ctl2: 0x00000000
> > > > mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
> > > > mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > mmc0: Reset 0x2 never completed.
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> > > >
> > > > Please find mmc debug info and dts file changes for references:-
> > > >
> > > > root@devkit-e7:~# cat /sys/kernel/debug/mmc0/ios
> > > > clock:          400000 Hz
> > > > actual clock:   400000 Hz
> > > > vdd:            21 (3.3 ~ 3.4 V)
> > > > bus mode:       2 (push-pull)
> > > > chip select:    1 (active high)
> > > > power mode:     2 (on)
> > > > bus width:      0 (1 bits)
> > > > timing spec:    0 (legacy)
> > > > signal voltage: 0 (3.30 V)
> > > > driver type:    0 (driver type B)
> > > >
> > > > sdmmc: sdhci@48102000 {
> > > >                         compatible =3D "snps,dwcmshc-sdhci";
> > > >                         reg =3D <0x48102000 0x1000>;
> > > >                         interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_H=
IGH>,
> > > >                                      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIG=
H>;
> > > >                         clocks =3D <&syst_hclk>, <&syst_hclk>;
> > > >                         clock-names =3D "core", "bus";
> > > >                         bus-width =3D <4>;
> > > > max-frequency =3D <25000000>;
> > > >                         status =3D "okay";
> > > >                 };
> > > >
> > > > Kindly request you to please let me know if I am missing anything.
> > >
> > > Would it be possible for you to do a "git bisect" to see if we can
> > > find if there is a particular commit causing the problem?
> > >
> > > Moreover, we have v6.12 now, so it seems reasonable to give that a tr=
y too.
> > >
> > > Kind regards
> > > Uffe
