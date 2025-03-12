Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAED823F39A
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778718; cv=none; b=qteSxNwMaIjJOzuJCkCrGnTl228qZBV1p4sRaojQ4+oH6U8IahKkGcZoNcBm1pYy9MiTtUIv83RglMZIq2aEhAdmh9VzzwnutP1YTIwayLsnNSkVcQh7xS9tsvSWZbZ+9NhEkovRdbiEVXvoPtLyI3dHbvhRCVEqBvqDj9Xt2qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778718; c=relaxed/simple;
	bh=yJT9aYzkvMylAdowSs6WsTAFy+j/UUPMrG1ntau1zII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o28uMDQIiZ2aNI6shKwhGJt7LnIYmuwmjkbtIAcHgzooQavg0gApD7OGzknCrCBDIljgQNIQUOgca2sojRwoZ/MwrgENzJFqxoZb5KqjZ6T9NTPc0DgTwx+DNyV25RQqnq5mQG/gtVUQ7zfzLKFgPX9F80Ukmyn4kpQWZnCjOUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+ErGcnt; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+ErGcnt"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f6ca9a3425so64879067b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778715; x=1742383515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=39KtkG89vqF5u+8eu4qsR2oUqY3Dea1DAXbw6D4lakg=;
        b=C+ErGcntrfZVEoWTfG2IFoc6sDXUiTPUv7oEnD6rDHdwWov6pkXK7xk0lODI4AKqMh
         umyJUUlYhE5VeBElQ0kCVUU3gak7lwRMnFPQ1Xi46ZyD1K5w5iuSg/uQmWHQnyu3G/+h
         ON2wGDa0iUjeQdCMDWsLnqu4+LOYH1dUC4E+BEo+VE6RvVG891NbypRvjdMhJhILtG+r
         Yt7VcRouVzABQ7Il63C8iMN3HYMfp8UXdja9DyvmYi8HdDrpkZI48AzGADn/5koX2KBJ
         0khwfFtmaDHyc+6HSE+pP9+PzoZIPpwdw9+0b9k+1dXsyPD9vx7QMsMlExYTYpfuKcKR
         lzzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778715; x=1742383515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39KtkG89vqF5u+8eu4qsR2oUqY3Dea1DAXbw6D4lakg=;
        b=i8KddIsnw87z9dFjH+PgXdiIK8ixtMZBuRm7GrZ59uX5Db8GCv/U7DyhPnA6ymZmOG
         i/oLe74m4kdODr0rP6vD63b4Oady63D0bH7sZzaZUUCs1Gq2ZfqrePPmc9FKVHkqNgbG
         fScDNaW8YT24m/xq3Gxnr/4Weu498on0z5oygpXNL8btYMymgeeqNIrO5Tg7ElD5c4w4
         NPm8odpFdlhLMHlDbd+i2UcDMfIdRLTx1piKiHAl8DjvuTPgl50bCGoCV7TjABN0Xs5+
         OdyvaXk3qzLjKB6t7Vi36Tu4ysQJAld2ptaMKEynC2Vdp7WX03ROCexd3b+uN7k3Fpob
         s6zA==
X-Gm-Message-State: AOJu0Yw9hLLTN933R4yNTgaF2JIxO+t3VOxipORNn25oAhw2Xgx20GMP
	O9Wkz91pL9MZrwdkU0UrwNk9bpW3qAIA1qVd84tC+Dca+133CiLWqnO6yYHHkciGHdNee2R5Wmr
	uPVTQDeW1y2sAoHaL9kUNwJnc9PB5zXuW1aFPWQ==
X-Gm-Gg: ASbGnctgJSXhoRg5izTeo6byckG+shZdIIdvI8fArgmXCXr1XBkZ89uGuB/hT3r6nEs
	rNCQobJHzLTS2kKEVk5QRzuTbQlV6nI/Py4v3O38O7bE5pUfxc9VWL+H3cmtpoah8dGJSyjg1q9
	iW2hSOhlK5I5RO05BP6WaXIuUe9s8=
X-Google-Smtp-Source: AGHT+IFCM/YQXZvXfNBSmaz/cAFpspNvOVLULYqJyCw/EMY4ftdknxXA1awgfMfwmNSKO14pRLF0PWOPI4Ion3j3r6A=
X-Received: by 2002:a05:690c:6f89:b0:6fe:aa66:5d84 with SMTP id
 00721157ae682-6ff092b4964mr100316777b3.37.1741778715671; Wed, 12 Mar 2025
 04:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fb7fcecae737f3e8b279854d7c853000527cba9a.1740597891.git.dsimic@manjaro.org>
In-Reply-To: <fb7fcecae737f3e8b279854d7c853000527cba9a.1740597891.git.dsimic@manjaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:39 +0100
X-Gm-Features: AQ5f1Jr5S91VV_Tz9d4eCETof4zBBOKrOtbAIhSCQZb47janoVOkT7WCGo71hJI
Message-ID: <CAPDyKFpJcbEwbUqPCVXQEJ9hiiJOR545CndovqV4hqbdXfhhuA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Trim trailing whitespace from card product names
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-mmc@vger.kernel.org, git@hrdl.eu, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 20:26, Dragan Simic <dsimic@manjaro.org> wrote:
>
> Product names for some eMMC chips can include trailing whitespace, which
> seems to be rather uncommon, but makes emitted messages and /sys properties
> somewhat unsightly.  Here's such an example from a Pine64 PineNote, in which
> "Biwin ", as the eMMC product name, contains trailing whitespace:
>
>   mmc0: new HS200 MMC card at address 0001
>   mmcblk0: mmc0:0001 Biwin  115 GiB
>   mmcblk0: p1 p2 p3 p4 p5 p6 p7
>   mmcblk0boot0: mmc0:0001 Biwin  4.00 MiB
>   mmcblk0boot1: mmc0:0001 Biwin  4.00 MiB
>   mmcblk0rpmb: mmc0:0001 Biwin  4.00 MiB, chardev (249:0)
>
> Trailing whitespace in /sys properties may even cause some unforeseen issues
> with some scripts, so let's have the trailing whitespace trimmed in product
> names for eMMC chips.  Although not observed yet by the author of these
> changes, the same trailing whitespace may appear in SD card product names,
> so let's trim them as well, which can't hurt.
>
> Touch-up one commit as well, by using proper capitalization.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Applied for next and by updating "commit" to "comment" in the
commit-msg, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc.c | 6 +++++-
>  drivers/mmc/core/sd.c  | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 6a23be214543..1522fd2b517d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/string.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
>  #include <linux/sysfs.h>
> @@ -66,7 +67,7 @@ static int mmc_decode_cid(struct mmc_card *card)
>
>         /*
>          * The selection of the format here is based upon published
> -        * specs from sandisk and from what people have reported.
> +        * specs from SanDisk and from what people have reported.
>          */
>         switch (card->csd.mmca_vsn) {
>         case 0: /* MMC v1.0 - v1.2 */
> @@ -109,6 +110,9 @@ static int mmc_decode_cid(struct mmc_card *card)
>                 return -EINVAL;
>         }
>
> +       /* some product names include trailing whitespace */
> +       strim(card->cid.prod_name);
> +
>         return 0;
>  }
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index cc757b850e79..8eba697d3d86 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -11,6 +11,7 @@
>  #include <linux/sizes.h>
>  #include <linux/slab.h>
>  #include <linux/stat.h>
> +#include <linux/string.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
>  #include <linux/scatterlist.h>
> @@ -95,6 +96,9 @@ void mmc_decode_cid(struct mmc_card *card)
>         card->cid.month                 = unstuff_bits(resp, 8, 4);
>
>         card->cid.year += 2000; /* SD cards year offset */
> +
> +       /* some product names may include trailing whitespace */
> +       strim(card->cid.prod_name);
>  }
>
>  /*
