Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706FE230999
	for <linux-mmc@vger.kernel.org>; Fri, 22 Nov 2024 07:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732259369; cv=none; b=qe3cmbU/Fp78jJ9V2uaAuq/AYu5IAjK7LcD3zMxMolokEVH4IzRBrqJ5Nk3AKA95xqIOGBkYARj/QmaK70omXacYoo0HMp/WoNk95JUTK3fzNLNK5h/amo85Hoh8wxWLmJ0RwYIfIKxIjuZf7ybfgXfPE7cCiqNBusqyIrznGtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732259369; c=relaxed/simple;
	bh=LVOn1uf2aZgtaTuaL/RjZFmIIiWTOuoVUC/RGwkw56c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZGWNf9pXS0SCsDoaaRUvK1taj64bCSunMU+Pv1xh4gVVIoUgUne5cXuUsn5R30OMb7wFf25vBC3p9AXg44dVMbXPq53FAGnYrMGFDrr+cr9rejKylq0RDIhe0E78m29xfp1tYftsgx15w6Ym6UMQUus1TgXO6g6WnTX5g4v+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K47Aee/4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K47Aee/4"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so1478133a12.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2024 23:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732259368; x=1732864168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mG2ESGmi0RzTWybrDzghyGMSZ/bd7PjLj9w4lt7n7uk=;
        b=K47Aee/4u8oeqbD6KO+RPrDURQBuZaD1NHCsprm3cPMnAkp57e0EvUA6j9SV+6Ayup
         ujyzIaUcNx5yiZQml0zU1bSAU9Ir0aYIUOZDAD0x8vF6eSJ1hbfuCuIYBp4JFlHcQMfb
         RyW3Hic9COlNUG10XhO7nEJu6a5+G6Y0QNs+p8KYUaDNZMzOJz/qFTEaCPwejNwO9xbb
         6mECZG6+nBQHaGxAPzR2L/g4zb4RASNphWuGlv6PrHVq15C7U1cMfGMtPbEAp/0d17UT
         rWKB2rTKKsfP1ITzMPjdSvdf+xC46x3EvVpD58CmqCV75dBuptxhA1s3AUkihCiv0iZL
         Wv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732259368; x=1732864168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mG2ESGmi0RzTWybrDzghyGMSZ/bd7PjLj9w4lt7n7uk=;
        b=qxmz1nFcYvXe07Ny1TCNL74NpxDGOzh30SXy6jpUDGuLAhM8rDUvOaYIerfuTXuzsv
         sFcUktzrKrA7PysqTdsNRfHBlzSm4XfMEjiRw3EfD0jajFlYmP1h0R54dK3527mZsr5N
         1UXIc3zvhRZkRnUt4bSd9+krRGL3D+9jlcBc1n5ElSdQ9G8Hs8RMVxxLUphfuYJcbd3n
         nYdWjkM1KdBrofXpsC9hNvT40em9gBs6Kc3O219ecNS97MOTw6Ymr1hBIVOODNeelXc0
         SXpUFD/DejTRStS/zbWHyZjRLuw7oNccynu85lO80O/Uvm47e6SQ8bmt+t+B5YziHm61
         Kcxg==
X-Gm-Message-State: AOJu0Yz2iLmofYrpOzZcwWN1wCinN5OiUcjtZlFXuNs26vMjv4lgtdGK
	2wT3MbzYsmD/6ebVzBfUm63sd+VOkYr2VCkSTMi+m+Ccu48eevfcC7xT0WhAu8AnQ4h2C87dXpX
	/4qtV3hfuhQvSo5LayUnrhCSWLjo=
X-Gm-Gg: ASbGncuVqqbSSrmWeb3IraTBi/KiWwMjEPyV1PsNCwmNZ772USd5Inv5Qyjd5lkfWz7
	wtaHCF3svRXipsFVIyJbHu58D1X7aEw==
X-Google-Smtp-Source: AGHT+IH+U8H1NI2OaV0fSkxaJ/gAksQc9HfYnwxFyE0t6wnlQ8j31I+0O628coVGrh7c4SKkGgLh9KguJSuQFyPUdZY=
X-Received: by 2002:a05:6a20:734f:b0:1db:e922:9eaf with SMTP id
 adf61e73a8af0-1e09e49fa49mr2413637637.27.1732259367415; Thu, 21 Nov 2024
 23:09:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOdCjQuiLHkX+ZJT6RbG01gxMo-Q9Y80P=FpNnS35rYWWV3eLw@mail.gmail.com>
 <CAPDyKFrqxO6gSNTx7suYv+2_KZRaBrwnwwXzrAeSERYs3nRDXg@mail.gmail.com>
In-Reply-To: <CAPDyKFrqxO6gSNTx7suYv+2_KZRaBrwnwwXzrAeSERYs3nRDXg@mail.gmail.com>
From: Pankaj Pandey <pankaj.embedded@gmail.com>
Date: Fri, 22 Nov 2024 12:39:15 +0530
Message-ID: <CAOdCjQsGG5wdsvkkSw9DtcnYGG-4q1Mzpfb=m5EvEtMccX3QLg@mail.gmail.com>
Subject: Re: SDHCI: linux-6.11: mmc0: Reset 0x2 never completed
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, "pierre@ossman.eu" <pierre@ossman.eu>, 
	isheng Zhang <jszhang@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

Tried in linux-6.12 but observed same issue there also:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
devkit-e7 login: mmc0: Timeout waiting for hardware cmd interrupt.
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
mmc0: sdhci: Present:   0x03ff0000 | Host ctl: 0x00000001
mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
mmc0: sdhci: Int enab:  0x00ff1003 | Sig enab: 0x00ff1003
mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
mmc0: sdhci: Cmd:       0x0000341a | Max curr: 0x00000000
mmc0: sdhci: Resp[0]:   0x00000000 | Resp[1]:  0x00000000
mmc0: sdhci: Resp[2]:   0x00000000 | Resp[3]:  0x00000000
mmc0: sdhci: Host ctl2: 0x00000000
mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x00000000
mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
mmc0: Reset 0x2 never completed.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Regards,
Pankaj Pandey

On Wed, Nov 20, 2024 at 6:34=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Wed, 20 Nov 2024 at 09:28, Pankaj Pandey <pankaj.embedded@gmail.com> w=
rote:
> >
> > Hi All,
> >
> > My target board(ARMv8-A AArch32 processor), supports the "Synopsys DWC
> > MSHC controller." I am using the Linux 5.4 kernel and have enabled the
> > following configurations to support the "SDHCI platform driver for
> > Synopsys DWC MSHC":
> >
> > CONFIG_MMC_SDHCI=3Dy
> > CONFIG_MMC_SDHCI_PLTFM=3Dy
> > CONFIG_MMC_SDHCI_OF_DWCMSHC=3Dy
> >
> > This setup works perfectly on Linux 5.4, successfully detecting all
> > microSD cards. However, when I use the same driver configuration with
> > Linux 6.11.0, I encounter the below mentioned error:
> >
> > sdhci: Secure Digital Host Controller Interface driver
> > sdhci: Copyright(c) Pierre Ossman
> > sdhci-pltfm: SDHCI platform and OF driver helper
> > mmc0: sdhci: Version:   0x00000005 | Present:  0x020f0000
> > mmc0: sdhci: Caps:      0x276e648a | Caps_1:   0x08008071
> > SMCCC: SOC_ID: ARCH_SOC_ID not implemented, skipping ....
> > mmc0: sdhci: Auto-CMD23 available
> > mmc0: SDHCI controller on 48102000.sdhci [48102000.sdhci] using ADMA
> > mmc0: Timeout waiting for hardware cmd interrupt.
> > mmc0: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI REGISTER DUMP =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00000005
> > mmc0: sdhci: Blk size:  0x00000000 | Blk cnt:  0x00000000
> > mmc0: sdhci: Argument:  0x00000c00 | Trn mode: 0x00000000
> > mmc0: sdhci: Present:   0x020f0000 | Host ctl: 0x00000001
> > mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
> > mmc0: sdhci: Timeout:   0x00000000 | Int stat: 0x00000000
> > mmc0: sdhci: Int enab:  0x00ff1083 | Sig enab: 0x00ff1083
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
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >
> > Please find mmc debug info and dts file changes for references:-
> >
> > root@devkit-e7:~# cat /sys/kernel/debug/mmc0/ios
> > clock:          400000 Hz
> > actual clock:   400000 Hz
> > vdd:            21 (3.3 ~ 3.4 V)
> > bus mode:       2 (push-pull)
> > chip select:    1 (active high)
> > power mode:     2 (on)
> > bus width:      0 (1 bits)
> > timing spec:    0 (legacy)
> > signal voltage: 0 (3.30 V)
> > driver type:    0 (driver type B)
> >
> > sdmmc: sdhci@48102000 {
> >                         compatible =3D "snps,dwcmshc-sdhci";
> >                         reg =3D <0x48102000 0x1000>;
> >                         interrupts =3D <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>=
,
> >                                      <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> >                         clocks =3D <&syst_hclk>, <&syst_hclk>;
> >                         clock-names =3D "core", "bus";
> >                         bus-width =3D <4>;
> > max-frequency =3D <25000000>;
> >                         status =3D "okay";
> >                 };
> >
> > Kindly request you to please let me know if I am missing anything.
>
> Would it be possible for you to do a "git bisect" to see if we can
> find if there is a particular commit causing the problem?
>
> Moreover, we have v6.12 now, so it seems reasonable to give that a try to=
o.
>
> Kind regards
> Uffe
