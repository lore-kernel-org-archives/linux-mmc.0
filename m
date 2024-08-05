Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17462153804
	for <linux-mmc@vger.kernel.org>; Mon,  5 Aug 2024 10:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722852905; cv=none; b=V5oduBBZekG3x9VVr+FQlQo9gyy0D+U76pBIrveIAE5zDitwgL45i03a7xZOe7w0DCwXa09p4lUgKQmBJwsde9lVk8RrmxA+mDC03Riu3P6YPHViQVIPRRSI1ikouJqS2mPm6ltpFe/GHjHKujWdT9BYm1OeG2xaBLYg23nsoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722852905; c=relaxed/simple;
	bh=iRwmgmhT4KqFnsQ0P95yay3PR79n7RkGMBABFu5stiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKXQhwoOeW4bVTLvnoTVTbeFX+cY+YhlZ1qmhTakGL/f3UDzccH9dVab+PpdMa70Jx16zqp6baO0ssT6BUpewnwuPdTe12W3mwHyDz4fsYyEgnc1Fd7bqV1XPz131VLDkqpDOwdwdPcUISmPl5W72CoO52/7wDG2SVtoQ4LKnXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oI2ORlXd; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oI2ORlXd"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e0b286b922eso8054825276.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Aug 2024 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722852902; x=1723457702; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7PId6VbES8ejzo2uY7FaNwSx3/upuclSuKnTrgn0fnk=;
        b=oI2ORlXdxj30BjWwQtRlhPdHWB5M1cpzmnqde7c889eJPmacnpopMVYVQ99gReMkn2
         6/lIkc7DdJ0jhMKQWXVLeCaBHoh8YF5/xrWq5YHDIMH1etkHNP7l9dpT2bCJfL2ow8kH
         rgKGxRvI6yr14c3GVrMmkDvfJc1LR9J97Mwgr9pSrTJM203O5/PtdFu2H/XNiIvG1DRm
         GWNCjuMpN70WBH6DscIJTqQWJbvCsCDCKDiGOih1nFIKFNI083XT9hzEKPL8OHxQbzLE
         sIMtiCmM+XDaTyDZl8OGqNxIJrzdBuUqh5ZCe8+gusUCX7B0X+f+tBkoeVAqU+fmS7EL
         +KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722852902; x=1723457702;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7PId6VbES8ejzo2uY7FaNwSx3/upuclSuKnTrgn0fnk=;
        b=EgS1p8KpDtiHtaUOECLuTQCvLG8xvqq/LMVbdFql+Hgt2kTj9oOFvJBrod9cXlAYFx
         2aUx9qbTX6/RN0NubtljHbUFR2h4TXsV8c7UYg8Rq3GUwYyLVxHaCazSG9rai8UCs17t
         Jyytpy8BsRLRaGPKuYO7qJjo9KFDJ+JEI/YvUEHU5igazXs0Z64ppvKWnvtcy6c6KYJ+
         /2/CpOzKVgOxYDZ+EIm2wjUcqoNJB5/hJXt48PNzMUFoEn3c9Sf2DHBWTsfw4U3cbVr1
         tehfbkDeCrVIPNKhIgdW6Lyp/oNnenxX6w48i6zxuDKmX2wGTEPHWaddSxDaPpwo+Tz/
         GxfA==
X-Forwarded-Encrypted: i=1; AJvYcCVaDAU/fN4hZfCRpz4QvRWONOJW3TmjqnygMHjvB+ib3JtAhauDsq/AN3mTVavvPuhh6OIEUeF8wFajSsj2SopkMezrnrsUBI7i
X-Gm-Message-State: AOJu0Yzz582cfVQyUWnR571873QCDbwx4SPWWZA+1ZXSROkerSxD4oG4
	rec9byrGcGJjPTNweF5fvXtE+T9ypUTmWrnqgBTs6krP/DN5x5zMBu4xYuMm6UOW0yxjRQ0wY3v
	/WDnod3xs9hYajwsORloE6k+CqcAC142JlGZtEw==
X-Google-Smtp-Source: AGHT+IFvONQFJleLY7L+1QwTRWODvOHPNAHqljS/7GjMMR/pJEw+N3kl7iJ2pkiOBpcqDAPkdX1gmWCfDTI6SBhQwvw=
X-Received: by 2002:a05:6902:120e:b0:e0b:c297:8a1f with SMTP id
 3f1490d57ef6-e0bde2e1809mr11328079276.24.1722852902080; Mon, 05 Aug 2024
 03:15:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240802032121.GA4019194@sony.com>
In-Reply-To: <20240802032121.GA4019194@sony.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Aug 2024 12:14:25 +0200
Message-ID: <CAPDyKFoTdMpvuXR16OqY8G6t_4jCJDW9+wz=_fBc=kZSL1KbqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: apply SD quirks earlier during probe
To: Keita Aihara <keita.aihara@sony.com>
Cc: Jonathan Bell <jonathan@raspberrypi.com>, Tim.Bird@sony.com, Shingo.Takeuchi@sony.com, 
	Masaya.Takahashi@sony.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Aug 2024 at 05:21, Keita Aihara <keita.aihara@sony.com> wrote:
>
> Applying MMC_QUIRK_BROKEN_SD_CACHE is broken, as the card's extended
> registers are parsed prior to the quirk being applied in mmc_blk.

In what way is it a problem to read the extended registers first?

>
> Split this out into an SD-specific list of quirks and apply in
> mmc_sd_init_card instead.
>
> Fixes: c467c8f08185 ("mmc: Add MMC_QUIRK_BROKEN_SD_CACHE for Kingston Canvas Go Plus from 11/2019")
> Authored-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Jonathan Bell <jonathan@raspberrypi.com>
> Signed-off-by: Keita Aihara <keita.aihara@sony.com>

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.h | 22 +++++++++++++---------
>  drivers/mmc/core/sd.c     |  4 ++++
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index cca71867bc4a..92905fc46436 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -15,6 +15,19 @@
>
>  #include "card.h"
>
> +static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
> +       /*
> +        * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> +        * This has so far only been observed on cards from 11/2019, while new
> +        * cards from 2023/05 do not exhibit this behavior.
> +        */
> +       _FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> +                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +                  MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> +
> +       END_FIXUP
> +};
> +
>  static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>  #define INAND_CMD38_ARG_EXT_CSD  113
>  #define INAND_CMD38_ARG_ERASE    0x00
> @@ -53,15 +66,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("MMC32G", CID_MANFID_TOSHIBA, CID_OEMID_ANY, add_quirk_mmc,
>                   MMC_QUIRK_BLK_NO_CMD23),
>
> -       /*
> -        * Kingston Canvas Go! Plus microSD cards never finish SD cache flush.
> -        * This has so far only been observed on cards from 11/2019, while new
> -        * cards from 2023/05 do not exhibit this behavior.
> -        */
> -       _FIXUP_EXT("SD64G", CID_MANFID_KINGSTON_SD, 0x5449, 2019, 11,
> -                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> -                  MMC_QUIRK_BROKEN_SD_CACHE, EXT_CSD_REV_ANY),
> -
>         /*
>          * Some SD cards lockup while using CMD23 multiblock transfers.
>          */
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdda50..ee37ad14e79e 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -26,6 +26,7 @@
>  #include "host.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> +#include "quirks.h"
>  #include "sd.h"
>  #include "sd_ops.h"
>
> @@ -1475,6 +1476,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
>                         goto free_card;
>         }
>
> +       /* Apply quirks prior to card setup */
> +       mmc_fixup_device(card, mmc_sd_fixups);
> +
>         err = mmc_sd_setup_card(host, card, oldcard != NULL);
>         if (err)
>                 goto free_card;
> --
> 2.43.2
>
