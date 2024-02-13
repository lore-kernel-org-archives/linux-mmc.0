Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F665DF18
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843722; cv=none; b=QzK5RmY62+nNiNvvKGgNgt4Fwy1bv3jZioAAfN+f5vOnFE5RfyR+2Ac67RbNU1bcmH9Jf+EkXL6peHKzlu9U6OGAyXbaVbGjXyt14TOi0CKB7LT9IXrGAgwrsXPY7IfFDPKxYxSnyvGajqyUbPlKmcnLsH9+eA+0zfc2FP6k6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843722; c=relaxed/simple;
	bh=WVVl2KoiKQ0TP22I5ljOzaFqCKXwmgOUdfOqcDXhvkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XufoWJAPuEap837zrS6Xbju5xb15dY8F6hHVbrZi9SkCcvKKiWeekm4Tf/AOwMjdjXIPZDhEeqQG3HADAVPoZQKXcBwy5LhNwUebhuRxzic0fKhT5yUiJkh6IgQhqf3IDsxTaxSj/hizq9Z85M+t5s/SxOj8jD2YD0bmAbNTZlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semenov.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=semenov.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-686a92a8661so22284556d6.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 09:02:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707843719; x=1708448519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NlbpSPa8hKxjfZssjxPJsQBmWT0eezm2hqEiQDcUB9g=;
        b=M8FjgiVZdQMyYrTtGnwAUnmV14LJreFddLbLLqks0t7HzhJZovLnjlclJRm+Qhawn6
         NeK7M+AIdwaTS3t5WEvirVyEjbEpRSihuqJHJTvf4prX3XhFn7gRWzJhGQdlZ2qxVdFY
         CwXN+3+cK/h8l0vBp30uZ2rRdOxScOQ7olhtwV1vResaisADjTv36JPaxQ3MMMTcxvki
         r5fESe0TwETDXa+bwtx7gWxI3YlkvpDL05K6fiYPQRwsmVuxwDnXV0kKP30bgcv8bM7C
         jG03O4O54Gov+SecdInKsBMeeCLo3MaWA3fH7CO3peaLHPf/9zu/7DnEwd8zdktykEwe
         TVcg==
X-Gm-Message-State: AOJu0YwGWkbQPxx00/f80CzVVWAyTvvj/mymHhAu8hM6Nxi6mtzVWjDP
	PMMEbSHhhgOp1AVjywMTukAOxPELEiSSOr6hNeZ/udgc6pgkjmOE9n/HVxERy9E5oQ==
X-Google-Smtp-Source: AGHT+IE3mFf7FlD/bqFqY/iXsl1l+yEzwQL7WdHFERSyfazlxeOg1kfsFfnNkTBoTrhunTyjNVfPow==
X-Received: by 2002:a05:6214:519a:b0:68c:e946:90e4 with SMTP id kl26-20020a056214519a00b0068ce94690e4mr21724qvb.27.1707843719227;
        Tue, 13 Feb 2024 09:01:59 -0800 (PST)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com. [209.85.222.173])
        by smtp.gmail.com with ESMTPSA id lz9-20020a0562145c4900b0068d05b81fb2sm1423205qvb.15.2024.02.13.09.01.54
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 09:01:59 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-785388b3281so165326585a.2
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 09:01:54 -0800 (PST)
X-Received: by 2002:a05:6214:c43:b0:68c:8037:90f5 with SMTP id
 r3-20020a0562140c4300b0068c803790f5mr9305qvj.44.1707843714039; Tue, 13 Feb
 2024 09:01:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206172845.34316-1-ivan@semenov.dev> <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
In-Reply-To: <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
From: Ivan Semenov <ivan@semenov.dev>
Date: Tue, 13 Feb 2024 19:01:42 +0200
X-Gmail-Original-Message-ID: <CAEgyhrn3PqXdj=-dSGXc_5GkwjipmvjO=3VPTFtaGZ2S6VsMhw@mail.gmail.com>
Message-ID: <CAEgyhrn3PqXdj=-dSGXc_5GkwjipmvjO=3VPTFtaGZ2S6VsMhw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Fix eMMC initialization with 1-bit bus connection
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 6:41=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> On Tue, 6 Feb 2024 at 18:28, Ivan Semenov <ivan@semenov.dev> wrote:
> >
> > The Linux mmc driver currently encounters a problem with eMMC chips con=
nected via a 1-bit bus, when the chip supports a 4-bit bus. This regression=
 was introduced in commit 577fb13 after functioning correctly in kernel ver=
sion 3.15.
> >
> > In the function mmc_select_bus_width, the driver attempts to switch to =
8-bit and 4-bit modes, but if the 4-bit bus test fails, it does not fall ba=
ck to 1-bit mode and leaves eMMC in broken 4-bit mode. This results in I/O =
errors and failure to read the partition table.
> >
> > This patch addresses the issue by ensuring that the driver fallback to =
1-bit bus mode if the attempt to switch to 4-bit mode fails.
> >
> > dmesg log for Samsung eMMC 5.1 chip connected  via 1bit bus (only D0 pi=
n) before patch:
>
> Wow, that was an old bug you found there.
>
> Just to make sure I understand correctly, the platform only supports
> 1-bit bus, but the DTS doesn't reflect that correctly as it instead
> indicates that 4 and 8-bit modes are supported?

Yes, you are correct, and the second case - with no DTS, when emmc is
connected to PC via cardreader, but via 1bit connection only

> Don't get me wrong, I think the initialization-error-path should be
> able to cope with that, so we should certainly fix it!
>
> >
> > [134509.044225] mmc0: switch to bus width 4 failed
> > [134509.044509] mmc0: new high speed MMC card at address 0001
> > [134509.054594] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
> > [134509.281602] mmc0: switch to bus width 4 failed
> > [134509.282638] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x=
0 phys_seg 1 prio class 2
> > [134509.282657] Buffer I/O error on dev mmcblk0, logical block 0, async=
 page read
> > [134509.284598] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x=
0 phys_seg 1 prio class 2
> > [134509.284602] Buffer I/O error on dev mmcblk0, logical block 0, async=
 page read
> > [134509.284609] ldm_validate_partition_table(): Disk read failed.
> > [134509.286495] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x=
0 phys_seg 1 prio class 2
> > [134509.286500] Buffer I/O error on dev mmcblk0, logical block 0, async=
 page read
> > [134509.288303] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x=
0 phys_seg 1 prio class 2
> > [134509.288308] Buffer I/O error on dev mmcblk0, logical block 0, async=
 page read
> > [134509.289540] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x=
0 phys_seg 1 prio class 2
> > [134509.289544] Buffer I/O error on dev mmcblk0, logical block 0, async=
 page read
> > [134509.289553]  mmcblk0: unable to read partition table
> > [134509.289728] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
> > [134509.290283] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
> > [134509.294577] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x=
80700 phys_seg 1 prio class 2
> > [134509.295835] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x=
0 phys_seg 1 prio class 2
> > [134509.295841] Buffer I/O error on dev mmcblk0, logical block 0, async=
 page read
> >
> > After patch:
> >
> > [134551.089613] mmc0: switch to bus width 4 failed
> > [134551.090377] mmc0: new high speed MMC card at address 0001
> > [134551.102271] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
> > [134551.113365]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p1=
4 p15 p16 p17 p18 p19 p20 p21
> > [134551.114262] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
> > [134551.114925] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
>
> To allow me to apply the patch, you need to provide your
> Signed-off-by-tag. According to the below:
>
> Signed-off-by: Ivan Semenov <ivan@semenov.dev>
>
> Please tell me if you are okay with that, then I can amend the patch
> when applying. No need for you to post a new version.

I=E2=80=99m ok with that, is it ok to put it here or I need to send a patch=
 again?
Signed-off-by: Ivan Semenov <ivan@semenov.dev>

>
> > ---
> >  drivers/mmc/core/mmc.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> > index f410bee50132..58ed7193a3ca 100644
> > --- a/drivers/mmc/core/mmc.c
> > +++ b/drivers/mmc/core/mmc.c
> > @@ -1015,10 +1015,12 @@ static int mmc_select_bus_width(struct mmc_card=
 *card)
> >         static unsigned ext_csd_bits[] =3D {
> >                 EXT_CSD_BUS_WIDTH_8,
> >                 EXT_CSD_BUS_WIDTH_4,
> > +               EXT_CSD_BUS_WIDTH_1,
> >         };
> >         static unsigned bus_widths[] =3D {
> >                 MMC_BUS_WIDTH_8,
> >                 MMC_BUS_WIDTH_4,
> > +               MMC_BUS_WIDTH_1,
> >         };
> >         struct mmc_host *host =3D card->host;
> >         unsigned idx, bus_width =3D 0;
>
> For my understanding, does your platform support HS200 mode too? Or
> only high-speed mode?
>
> The reason for my question is that it would be interesting to
> understand whether we end up running the error path in
> mmc_select_hs200() or not.

In my case, platform supports only High-Speed mode, so I can=E2=80=99t test=
 in
with HS200 mode.

>
> [...]
>
> Kind regards
> Uffe
>
