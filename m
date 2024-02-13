Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60335F48C
	for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 16:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842481; cv=none; b=mnGnxiyngmdX8RjoaBmNeZat9o0VWOB4y7dz4rUOVixbLkjZ1bajxcoHgeqbA+u51iN7WW0e/JMB7mXU/4o5NOUm+Vb0cDaFwznAG6JsN9AexaiDLV8e5jluSCnUdxmxrprBXTMGQAdM6feQaHdJb30LTeLgHOdAf1GKTgZe7n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842481; c=relaxed/simple;
	bh=qT6ildm335dc1K62mmHT8TYw2Gn7JzXfWhx0ENV7Zjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c7KERFz3iKuJNpYPgbJM78Am9cTiZHjdVi4DtrKPd4rQbqsDE2NpYED9qb689wz/lxv76rqhwZ3H7hc59LUJWLN8nNUTxxhSyFv9ncgdK4M0pzYLJ7CZHkb0JyIDWpZ2zCvZLAT7F2OEQ3YO9B5CiZtsoNi82q8i24QiIGhg5X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MHcjzV53; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHcjzV53"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so1654518276.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Feb 2024 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707842478; x=1708447278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJhJew24ozyVA9C98AfJrJPvDiWyZHVUVWfPgZwILqM=;
        b=MHcjzV53eLg1A1iGEnufxctRlEX7pZUr1HtzJ8bQgX24mU4ygW4+Zpqytvg4FgElsE
         DunA8eP29O3qUhHqSdL2N3DV6tJaLYyD5kBSEqVcdmrM5FP/cdPSJixiNJ2QYZI8VFgQ
         mt9AfCTS1gWP++6ski6ITPO52ReJhpNxatBbia0q8KoGnnLtjJ498IW9DkMjzPrnzs8x
         FnhAi9FPcP2Rw9za2bejb1uPKxxLKx0jsbf48Qo0Jf8ihV7DjoIq3ppW8Wjgq8HxFGdO
         V/kHq2noNU3hIiDa76zDiyxhk6fhv8HLCxsqdAMHundLGUhCGbT8sWqe5yM9xp9NgG7t
         js/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707842478; x=1708447278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJhJew24ozyVA9C98AfJrJPvDiWyZHVUVWfPgZwILqM=;
        b=dGmUQMSfHXHGtPF3S4ynaVMLdg/xydoZpA9X3I74Oc6mDTkRA+QG2/JVreV+8GRkES
         MFg+lM3jibGdDEeazcXYb/ZiDMSAdHCjtlhuFokpDPVj3Z/60BuQDtWtu00kMOX5a+RR
         JPRJhQAskVqJfAxrBifb85h51iC0W9G+a0IK0nBdqiU1wkoeuWOZjNFVqP8+n0qLT5Va
         ozkxbpP0V1bKDiNsT+J0/vcOD1kG4JkohIuNx0OmBIRarPIVwBcdMymW0rtuN4ZRxk+1
         GOZPrKr5u0IEawtBlU7adHCge555PRJRs3UoepKG+4kJYZgkUsfF51KsG5Q4Z5b4MUgn
         xVag==
X-Gm-Message-State: AOJu0Yzp2Bn/0Sbfi6aBDcShpyjXuUKWTFTpd/eztfA8RrC/LZB2k/v8
	I2+i44Lf73wgaf5M0bc9f1ECKwfVKsqSieefpO6kXvgWaPofGAKSA+2wpV9sgLxRNGWT0bk7/XI
	UooUMDH/ZtdLf9BCwc82MAONB0VscTxBv/QcADQ==
X-Google-Smtp-Source: AGHT+IENn9D5l4/ILbj6q27aPhwq5fQVhrQe3jNxWxtUp6dSYkKkq6SxVAxcsv0B1JBIr6ctDy8VA7TbSCDo2ysG+80=
X-Received: by 2002:a0d:e609:0:b0:607:8475:23 with SMTP id p9-20020a0de609000000b0060784750023mr2273537ywe.20.1707842478622;
 Tue, 13 Feb 2024 08:41:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206172845.34316-1-ivan@semenov.dev>
In-Reply-To: <20240206172845.34316-1-ivan@semenov.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Feb 2024 17:40:42 +0100
Message-ID: <CAPDyKFpfHyhuRBT7yQ_jCe_XBg0VbP90fr3vLy6v-DLgq7sCzQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Fix eMMC initialization with 1-bit bus connection
To: Ivan Semenov <ivan@semenov.dev>
Cc: linux-mmc@vger.kernel.org, tgih.jun@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Feb 2024 at 18:28, Ivan Semenov <ivan@semenov.dev> wrote:
>
> The Linux mmc driver currently encounters a problem with eMMC chips conne=
cted via a 1-bit bus, when the chip supports a 4-bit bus. This regression w=
as introduced in commit 577fb13 after functioning correctly in kernel versi=
on 3.15.
>
> In the function mmc_select_bus_width, the driver attempts to switch to 8-=
bit and 4-bit modes, but if the 4-bit bus test fails, it does not fall back=
 to 1-bit mode and leaves eMMC in broken 4-bit mode. This results in I/O er=
rors and failure to read the partition table.
>
> This patch addresses the issue by ensuring that the driver fallback to 1-=
bit bus mode if the attempt to switch to 4-bit mode fails.
>
> dmesg log for Samsung eMMC 5.1 chip connected  via 1bit bus (only D0 pin)=
 before patch:

Wow, that was an old bug you found there.

Just to make sure I understand correctly, the platform only supports
1-bit bus, but the DTS doesn't reflect that correctly as it instead
indicates that 4 and 8-bit modes are supported?

Don't get me wrong, I think the initialization-error-path should be
able to cope with that, so we should certainly fix it!

>
> [134509.044225] mmc0: switch to bus width 4 failed
> [134509.044509] mmc0: new high speed MMC card at address 0001
> [134509.054594] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
> [134509.281602] mmc0: switch to bus width 4 failed
> [134509.282638] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 =
phys_seg 1 prio class 2
> [134509.282657] Buffer I/O error on dev mmcblk0, logical block 0, async p=
age read
> [134509.284598] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 =
phys_seg 1 prio class 2
> [134509.284602] Buffer I/O error on dev mmcblk0, logical block 0, async p=
age read
> [134509.284609] ldm_validate_partition_table(): Disk read failed.
> [134509.286495] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 =
phys_seg 1 prio class 2
> [134509.286500] Buffer I/O error on dev mmcblk0, logical block 0, async p=
age read
> [134509.288303] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 =
phys_seg 1 prio class 2
> [134509.288308] Buffer I/O error on dev mmcblk0, logical block 0, async p=
age read
> [134509.289540] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 =
phys_seg 1 prio class 2
> [134509.289544] Buffer I/O error on dev mmcblk0, logical block 0, async p=
age read
> [134509.289553]  mmcblk0: unable to read partition table
> [134509.289728] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
> [134509.290283] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB
> [134509.294577] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x80=
700 phys_seg 1 prio class 2
> [134509.295835] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags 0x0 =
phys_seg 1 prio class 2
> [134509.295841] Buffer I/O error on dev mmcblk0, logical block 0, async p=
age read
>
> After patch:
>
> [134551.089613] mmc0: switch to bus width 4 failed
> [134551.090377] mmc0: new high speed MMC card at address 0001
> [134551.102271] mmcblk0: mmc0:0001 BGUF4R 29.1 GiB
> [134551.113365]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 =
p15 p16 p17 p18 p19 p20 p21
> [134551.114262] mmcblk0boot0: mmc0:0001 BGUF4R 31.9 MiB
> [134551.114925] mmcblk0boot1: mmc0:0001 BGUF4R 31.9 MiB

To allow me to apply the patch, you need to provide your
Signed-off-by-tag. According to the below:

Signed-off-by: Ivan Semenov <ivan@semenov.dev>

Please tell me if you are okay with that, then I can amend the patch
when applying. No need for you to post a new version.

> ---
>  drivers/mmc/core/mmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index f410bee50132..58ed7193a3ca 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1015,10 +1015,12 @@ static int mmc_select_bus_width(struct mmc_card *=
card)
>         static unsigned ext_csd_bits[] =3D {
>                 EXT_CSD_BUS_WIDTH_8,
>                 EXT_CSD_BUS_WIDTH_4,
> +               EXT_CSD_BUS_WIDTH_1,
>         };
>         static unsigned bus_widths[] =3D {
>                 MMC_BUS_WIDTH_8,
>                 MMC_BUS_WIDTH_4,
> +               MMC_BUS_WIDTH_1,
>         };
>         struct mmc_host *host =3D card->host;
>         unsigned idx, bus_width =3D 0;

For my understanding, does your platform support HS200 mode too? Or
only high-speed mode?

The reason for my question is that it would be interesting to
understand whether we end up running the error path in
mmc_select_hs200() or not.

[...]

Kind regards
Uffe
