Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF53909A1
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 10:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773052380; cv=pass; b=VlXzoMNHx0a4pY/WJ3E6GCb5I2LFaShFUCHIh4Ubvz2DFVa6bbaTA0fBMt+zzutZqkyvENpsJ5+uMyhTfqE/pQ5CySqGCfimyYsoxctzIFAHzQE8iKhOKD2s+Sb4A8kddzSn+Gs93+WuBb+1ORH4fU+T4pDqZK1Ak3Nmb9Cnot8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773052380; c=relaxed/simple;
	bh=y7wuThGYnUtDKgV28nKsh5wsvpPKdidycqd61+dpPdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU6JQ9+iC+3MVNymQyZw/onmMa2B7xlAEEzks+aW0KDYH0WigdDxfdk0QeUCjpdXsh1WK9wqp+f5DptZ2bmcP7zwKh8pEpAf2PgwYFwHgkGmX39MzfaJ7lPZ5LOQOUYTpkHQdEn/ci1CaBS7XEMhhTwd5YVG8B3kBJaFpDKiNBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V0wrvRZA; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0wrvRZA"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64c9fcc24b3so8709530d50.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 03:32:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773052375; cv=none;
        d=google.com; s=arc-20240605;
        b=BtVB+6luKywYEfFDoXiekoc9AvLS441RQh2x/HgN8MQXbb6QQrPWHp5mxgNAvtnf5m
         YFKBR29ZCgYBCzJKfeeuS6lqVtIK83w1deAYBbql3/jRPZ/CFy/eYG6BdYkCDjoU4W0t
         uKqnZgGZdQMOTuUqW+LPN9eOpE7bxtHGFOr/dOd2QbhQPYXOegKt5HaoIHVbv+Y3C7uF
         LTE8G2eIqmcKwQji/13jbHzmaim4Ct3TEkdf/a+ZlOZkWGhhaz+QUHyrOk64DsTXlZzU
         jAaFnG8+k5ntS9m2OyW+IcybKl8t1+mf0PTLm+uwNvH1nxRr4dYxf+qpsBcxmY0nMP+v
         0xmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7R00jT9f/wF6nP47m5GBLd6PhCW+dAuP70evV4AQ3/g=;
        fh=hDUqf0+X88Wytgdx3Pv0Ep5zYFZaELhNYQBTQCVqKgk=;
        b=doPdLRhsVK5OPNctVRf7/1vCChqzseNL74ObO6BMz0dB9D+2m50oZv+/uuoNIEORh1
         3ifbsekONHZbf5kheXZN14/WuuhgHWtS9Qg/Ajb8ZYiHmLHp+AH1eREN2LpReuwFA47v
         RhwkPilJG3bCzQ2LYv//VgT1azrg/jqtweHEDorgYDpi14AUcTyCp67PtgbE8b8A00zD
         krIyj5Z10qZW1DD9y692fGDqx+aZ9rTaER8Im18EFI39/O4gOQYVBAXxqsoslMsz5Rnc
         wsmVfKOJMAjv/GJEOiLKUZjJUPh8puJ5VVBwB5GhurE2G6YM4pPToUu9ZRG0ILIKoxo9
         2VBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773052375; x=1773657175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7R00jT9f/wF6nP47m5GBLd6PhCW+dAuP70evV4AQ3/g=;
        b=V0wrvRZA1ST3DqLxg/FAqEj7xgTojb6S9saKCBIABqjc4yBVcei9nestk/UzBehyPQ
         mgeWyw/wfe/4ikXoPToEcyQRY3bJVQkEiYTWb9aQm5QcuL+jtwjRvCVvK2XlIXFApg7l
         ItdhIxA0wUlMZ/KfCy3TZqrdR/QMQ7zQ6nwWIzCgJEfIp44XOP1Y/nekCDFwmbfS8qzz
         v/38Z9dhSTb3cKrlV/mWm98e9kOGmMyH2ESPldiyTqLPNz/jx+ID71aZ8rpBvmtt207i
         zpo4AA/i7VvHJaeIL79/+9Yscq6Zbqq1PW3IrMnuhlRz/Y2w9qXeGiJJXRsqJct/IwTR
         YgqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773052375; x=1773657175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7R00jT9f/wF6nP47m5GBLd6PhCW+dAuP70evV4AQ3/g=;
        b=v8gmjvekoNmZALtMELZQc2QLWpeeo81isny/qqjsnoWJyH51bTiGzYOffMZ1HUrpBk
         uy3rJvmnL8Jz5mYqFhmK+d4/1FRuYxrn0Rvy7/D8Xdx0Hru32efPiV20uCiJ5ybv025g
         vWm6DXaSgeRFiJ1r7JmgZFkaivBH4A+JreNsKIbwEXMVDJd/EAO/pDmxvy5VJhKjFate
         3LzabakTEf7h9+/kfna2Ti5mMUJV1ykwBrRpA5DiKPEz0aJIqcy5u5i5WgnkPbVjdMON
         Ljogtly7muMsWS4pmmg2IAYrI2eQp1NcWpZ7w3KGB3gWJTcB2qOgaO6VrM7+mhrr/vp0
         UYgA==
X-Forwarded-Encrypted: i=1; AJvYcCWT4GuU10Sl7LQbG9i8pMiBb64NwZT05MGy3eMCehDMe0QbVISRtgNVhpNLzDuz24UxOKYUBOFMkIY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXQ9LV+xFPt8tQrzZe0thmMshKQP8PfJlKD/F+2k6OMDER1CD
	X1fr5X7OsWnswAWEb5g+WUUGg7+xYX3eS1dQXq1FHesq9/nKCnv8/+MaiM79EFPzD8jsv6cP8WU
	XTFpPoQZd2qCF4/ZTEkJz7U1Jc1NgG0rPXTA92qA=
X-Gm-Gg: ATEYQzxM2rlzyGTYMkop5DhgGJwT+BbpVcFkxznfOHFZtM90nSId/HQAIuHemsoVIs9
	8gDb+GuE5eKthAu1QEvUmnFv5HtaN9KNZ2rYbgCximyy2S9sm0t/xcNFuhcKCn2bvIam7LgV3tW
	pA4qDs5klIKb1XVXADugrzTPjbMk93LG92E3gDjQhuJJMX9HtBnW4nnDOz2nD0zjMLepp5rvcrr
	1gTMgQWisadMIcn6FdJB1bJ//aVHJEoj/5wrGl28f+6zj/oz+a5h7KwI17TxV6r0cI/3GFJ8tmv
	BOC8GaA=
X-Received: by 2002:a53:ecd7:0:b0:640:dd02:a777 with SMTP id
 956f58d0204a3-64d142fedf4mr8471850d50.69.1773052375353; Mon, 09 Mar 2026
 03:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
 <20260302-orangepi-sd-card-uhs-v1-2-89c219973c0c@gmail.com> <20260307022951-GKC302167@kernel.org>
In-Reply-To: <20260307022951-GKC302167@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 9 Mar 2026 11:32:44 +0100
X-Gm-Features: AaiRm50q4cIc_96jC1UTLpzV5oO0Bj-ABAK0PLIBWIjJCOYDycAu5o9P3q_6JjE
Message-ID: <CABdCQ=PWJKv9x-vXt1_jGgZK+XJzrY71PPECp2FttHrDjA_MYw@mail.gmail.com>
Subject: Re: [PATCH 02/10] mmc: sdhci-of-k1: enable essential clock
 infrastructure for SD operation
To: Yixun Lan <dlan@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 7 mar 2026 a las 3:29, Yixun Lan (<dlan@kernel.org>) escribi=
=C3=B3:
>
> Hi Iker,
>
> On 16:13 Mon 02 Mar     , Iker Pedrosa wrote:
> > Ensure SD card pins receive clock signals by enabling pad clock
> > generation and overriding automatic clock gating. Required for all SD
> > operation modes.
> >
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-of-k1.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of=
-k1.c
> > index 0cc97e23a2f9c7b2f9376318a8a7ebb860571504..b703b78282ed8d89183c816=
477c149c0a565618a 100644
> > --- a/drivers/mmc/host/sdhci-of-k1.c
> > +++ b/drivers/mmc/host/sdhci-of-k1.c
> > @@ -20,6 +20,13 @@
> >  #include "sdhci.h"
> >  #include "sdhci-pltfm.h"
> >
> [snip]
>
> > +     spacemit_sdhci_setbits(host, SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_=
ON,
> > +                            SPACEMIT_SDHC_OP_EXT_REG);
> As I'm testing on Bananapi F3 board with emmc chip, this line will cause =
timeout problem
>
> [   27.613806] mmc2: Timeout waiting for hardware interrupt.
> [   27.616592] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D SDHCI RE=
GISTER DUMP =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   27.623007] mmc2: sdhci: Sys addr:  0x00000400 | Version:  0x00000002
> [   27.629429] mmc2: sdhci: Blk size:  0x00007200 | Blk cnt:  0x000003a6
> [   27.635853] mmc2: sdhci: Argument:  0x001ca0a0 | Trn mode: 0x0000002b
> [   27.642277] mmc2: sdhci: Present:   0x01f70106 | Host ctl: 0x00000035
> [   27.648700] mmc2: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> [   27.655124] mmc2: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> [   27.661547] mmc2: sdhci: Timeout:   0x0000000e | Int stat: 0x00000000
> [   27.667971] mmc2: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
> [   27.674394] mmc2: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> [   27.680818] mmc2: sdhci: Caps:      0x35fc0080 | Caps_1:   0x00002f77
> [   27.687241] mmc2: sdhci: Cmd:       0x0000193a | Max curr: 0x00000000
> [   27.693666] mmc2: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xfff6dbff
> [   27.700088] mmc2: sdhci: Resp[2]:   0x320f5903 | Resp[3]:  0x00000900
> [   27.706513] mmc2: sdhci: Host ctl2: 0x0000400d
> [   27.710940] mmc2: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0x02080208
> [   27.717363] mmc2: sdhci: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
>
> Drop it will make emmc work again.. but I'm still unable to make SD card =
driver work,
> that's probably another problem
>
> I've took a look at current K3's sdhci driver, all operations on SPACEMIT=
_SDHC_OP_EXT_REG
> register are used only when doing voltage switch with SD card, snip of th=
e code from vendor
>
>         if (host->mmc->caps2 & MMC_CAP2_NO_MMC) {
>                 /* sd/sdio has no phy */
>                 spacemit_sdhci_setbits(host, SDHC_TX_INT_CLK_SEL, SPACEMI=
T_SDHC_TX_CFG_REG);
>
>         } else {
>                 /* use phy func mode */
>                 spacemit_sdhci_setbits(host, SDHC_PHY_FUNC_EN | SDHC_PHY_=
PLL_LOCK,
>                                        SPACEMIT_SDHC_PHY_CTRL_REG);
>                 spacemit_sdhci_clrsetbits(host, SDHC_PHY_DRIVE_SEL,
>                                           SDHC_RX_BIAS_CTRL |
>                                           FIELD_PREP(SDHC_PHY_DRIVE_SEL, =
4),
>                                           SPACEMIT_SDHC_PHY_PADCFG_REG);
>                 /* mmc card mode */
>                 spacemit_sdhci_setbits(host, SDHC_MMC_CARD_MODE, SPACEMIT=
_SDHC_MMC_CTRL_REG);
>         }

You are right, SPACEMIT_SDHC_OP_EXT_REG should only be called for SD cards

>
> --
> Yixun Lan (dlan)
