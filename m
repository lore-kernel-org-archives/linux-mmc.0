Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E9962819
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 22:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707864988; cv=none; b=s3mspyimUlQl4i1NpN6vX5mYeaZGd+P1VqI35kNzZ63l9K/2SRglI+ul7Ra6+wv40C73Ll6lHdIO5EZnTEQEAh4kvh/pn4phip0/1rvDDjxidolMIaN5ID/fCHl+izBlHaDMJ3D2u9ESdekzMgUFKynAxiLlajZkV5rF1y+AJ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707864988; c=relaxed/simple;
	bh=6FXI32dJedbXagOZyEKv50SBHdSnC2u/rPjZ9zisrgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSyhxS/UVSY7ZzDfFadK50IvdAzWtrQapN8IKsKpBVwZh7tw4euZ0h0PWc0KIFjvJw/raEGK3GmnJNViXGkm+lAvsoZW5Y4SbJIujU72T8/Oi8ZCGDAYrvxiANQtL0cDksygRScjNeQSNQVWhONK3b7soV9ccfo4UT7PRCjEa5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nre4/uPz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nre4/uPz"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607836d3c5bso13387337b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 14:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707864985; x=1708469785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOpYO9bMJzLX1aLXsmcXUv6iXDncV6zz1EvNUklvTCA=;
        b=Nre4/uPzbMqMXh1fbkcnGFpFiGj3dl/26OmibelaZW1lOnlOOoP+x4JwXfkjd7iDem
         Jmh/rshEtcbLPKVv0tvRqc5j8a69VbmT1TNWipMZheJAIVKkYhDwVOhSa/j/vO+HesqE
         UHCLflcBrgMeDnf8j9CEWpFTBeNPKHNwlR3fzpPtRKEgdm841eg3lybHBMKljtBJPUWK
         Wi5o8R56+2lsIiE7t+F2rpRkF7dQdeyIbv3sdLAFGEYxF+PP1jYPVgvVROlWDX0hCnST
         8q1Ldlii5atXSLUewuOTFLwEqEGfKLRiM2GbfuRXCh5jHDeEYO8CaUbVAQLykPgzgrau
         fOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707864985; x=1708469785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uOpYO9bMJzLX1aLXsmcXUv6iXDncV6zz1EvNUklvTCA=;
        b=X2XdP649SlXhSqi6Dw0ihsiCfaaA/Cji82sZnxYOt48Emp0S5xtDjQR/41NlLchUOs
         1VDcI8WMUKZBaQEEAgpCwIj+UmUL0j6VYud4mfOmdODnZca+PLnTCOFnjrZDCIyZc/vA
         8fiSlc031kIbu8FOvNkj42VMus3Walz6ljm/obPrILS9u0AyRQbhoQiSFWg4CsyTIu+z
         TWdWpbwdXcQqG0ZZbYVKiZMUI6qCMUi1cNwVGYFRvp+5ajCedyZpoj8v09TeRHPeSRQi
         uGz7+v0AvwC5nUEQvWzofZEzUaGDND2jNyjY64UbhTdgbZCpFXD/UlY0Vbx0U+mM2aO3
         VoaA==
X-Gm-Message-State: AOJu0YyoLOgID+4uLbKmH4WCkilUyDewjbbwXYlz2+RruNP67DNi74kn
	8x0EZHilD+vfgtepx5cL/ToVWG8rRljUVwkDT4kjZMisdc8M9n8V3/XGhv58aQl0gPGoL2odtfl
	oNxYFa378O/lAyetpKZn4ZdQwZ+7bKtAHLSEFWz7msJJMj2w2
X-Google-Smtp-Source: AGHT+IG9MgvrJJkbI9RhT+U17ddxhrZGtBWmovV4Mw8M+YBwLLYNe6n29aT7U4ZaQcKEQxW3lHbQrxxwkYXJj5HmekY=
X-Received: by 2002:a81:838b:0:b0:604:69ee:5b4c with SMTP id
 t133-20020a81838b000000b0060469ee5b4cmr952596ywf.18.1707864985347; Tue, 13
 Feb 2024 14:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206172845.34316-1-ivan@semenov.dev> <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
 <CAEgyhrn3PqXdj=-dSGXc_5GkwjipmvjO=3VPTFtaGZ2S6VsMhw@mail.gmail.com>
In-Reply-To: <CAEgyhrn3PqXdj=-dSGXc_5GkwjipmvjO=3VPTFtaGZ2S6VsMhw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 23:55:48 +0100
Message-ID: <CAPDyKFpiwQ=JuMZdQxOCCqvPsKEFZSPWQNmTgi-T8_USNf0T_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: Fix eMMC initialization with 1-bit bus connection
To: Ivan Semenov <ivan@semenov.dev>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Feb 2024 at 18:01, Ivan Semenov <ivan@semenov.dev> wrote:
>
> On Tue, Feb 13, 2024 at 6:41=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> >
> > On Tue, 6 Feb 2024 at 18:28, Ivan Semenov <ivan@semenov.dev> wrote:
> > >
> > > The Linux mmc driver currently encounters a problem with eMMC chips c=
onnected via a 1-bit bus, when the chip supports a 4-bit bus. This regressi=
on was introduced in commit 577fb13 after functioning correctly in kernel v=
ersion 3.15.
> > >
> > > In the function mmc_select_bus_width, the driver attempts to switch t=
o 8-bit and 4-bit modes, but if the 4-bit bus test fails, it does not fall =
back to 1-bit mode and leaves eMMC in broken 4-bit mode. This results in I/=
O errors and failure to read the partition table.
> > >
> > > This patch addresses the issue by ensuring that the driver fallback t=
o 1-bit bus mode if the attempt to switch to 4-bit mode fails.
> > >
> > > dmesg log for Samsung eMMC 5.1 chip connected  via 1bit bus (only D0 =
pin) before patch:
> >
> > Wow, that was an old bug you found there.
> >
> > Just to make sure I understand correctly, the platform only supports
> > 1-bit bus, but the DTS doesn't reflect that correctly as it instead
> > indicates that 4 and 8-bit modes are supported?
>
> Yes, you are correct, and the second case - with no DTS, when emmc is
> connected to PC via cardreader, but via 1bit connection only
>
> > Don't get me wrong, I think the initialization-error-path should be
> > able to cope with that, so we should certainly fix it!
> >
> > >
> > > [134509.044225] mmc0: switch to bus width 4 failed
> > > [134509.044509] mmc0: new high speed MMC card at address 0001
> > > [134509.054594] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
> > > [134509.281602] mmc0: switch to bus width 4 failed
> > > [134509.282638] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> > > [134509.282657] Buffer I/O error on dev mmcblk0, logical block 0, asy=
nc page read
> > > [134509.284598] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> > > [134509.284602] Buffer I/O error on dev mmcblk0, logical block 0, asy=
nc page read
> > > [134509.284609] ldm_validate_partition_table(): Disk read failed.
> > > [134509.286495] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> > > [134509.286500] Buffer I/O error on dev mmcblk0, logical block 0, asy=
nc page read
> > > [134509.288303] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> > > [134509.288308] Buffer I/O error on dev mmcblk0, logical block 0, asy=
nc page read
> > > [134509.289540] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> > > [134509.289544] Buffer I/O error on dev mmcblk0, logical block 0, asy=
nc page read
> > > [134509.289553]  mmcblk0: unable to read partition table
> > > [134509.289728] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
> > > [134509.290283] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
> > > [134509.294577] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x80700 phys_seg 1 prio class 2
> > > [134509.295835] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags =
0x0 phys_seg 1 prio class 2
> > > [134509.295841] Buffer I/O error on dev mmcblk0, logical block 0, asy=
nc page read
> > >
> > > After patch:
> > >
> > > [134551.089613] mmc0: switch to bus width 4 failed
> > > [134551.090377] mmc0: new high speed MMC card at address 0001
> > > [134551.102271] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
> > > [134551.113365]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 =
p14 p15 p16 p17 p18 p19 p20 p21
> > > [134551.114262] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
> > > [134551.114925] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
> >
> > To allow me to apply the patch, you need to provide your
> > Signed-off-by-tag. According to the below:
> >
> > Signed-off-by: Ivan Semenov <ivan@semenov.dev>
> >
> > Please tell me if you are okay with that, then I can amend the patch
> > when applying. No need for you to post a new version.
>
> I=E2=80=99m ok with that, is it ok to put it here or I need to send a pat=
ch again?
> Signed-off-by: Ivan Semenov <ivan@semenov.dev>

You don't need to re-send. Instead, I have amended the patch to add
your sob-tag and while doing that I took the liberty of making some
clarification to the commit message a bit too. Please have a look at
my fixes/next branch and let me know if it doesn't look okay to you.

So, applied for fixes, thanks!

Kind regards
Uffe


>
> >
> > > ---
> > >  drivers/mmc/core/mmc.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > > index f410bee50132..58ed7193a3ca 100644
> > > --- a/drivers/mmc/core/mmc.c
> > > +++ b/drivers/mmc/core/mmc.c
> > > @@ -1015,10 +1015,12 @@ static int mmc_select_bus_width(struct mmc_ca=
rd *card)
> > >         static unsigned ext_csd_bits[] =3D {
> > >                 EXT_CSD_BUS_WIDTH_8,
> > >                 EXT_CSD_BUS_WIDTH_4,
> > > +               EXT_CSD_BUS_WIDTH_1,
> > >         };
> > >         static unsigned bus_widths[] =3D {
> > >                 MMC_BUS_WIDTH_8,
> > >                 MMC_BUS_WIDTH_4,
> > > +               MMC_BUS_WIDTH_1,
> > >         };
> > >         struct mmc_host *host =3D card->host;
> > >         unsigned idx, bus_width =3D 0;
> >
> > For my understanding, does your platform support HS200 mode too? Or
> > only high-speed mode?
> >
> > The reason for my question is that it would be interesting to
> > understand whether we end up running the error path in
> > mmc_select_hs200() or not.
>
> In my case, platform supports only High-Speed mode, so I can=E2=80=99t te=
st in
> with HS200 mode.
>
> >
> > [...]
> >
> > Kind regards
> > Uffe
> >
