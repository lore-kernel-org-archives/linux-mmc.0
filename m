Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42399322C65
	for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 13:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764075662; cv=none; b=GfC3HbJS1N5JRfkj/VTtomNTVL013mvImBeWM17ukLpfuxbWJSX03/x0k5WcG6wVHii/Refl0RS6YFwQKvSIucknygYdKyZuwKY82TVvvgiDF7v6yGRJ7UC1R/uMYZ0mpaYuLsDZWfRMy+e+t96A59jSbGG2DJiSm2OyMTtuSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764075662; c=relaxed/simple;
	bh=9tlj7eh1nYMEFcvTJszecqChW6IEzUZ36R84TFXZbmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVnBdvOAHu9gXi89tJIuSXkDf3Klux+sENpMxNBoH5yCIa1v2QtzTNQMXqhNtUhFP9yvZUqiY2LZlInmjfmNgyRWemwUg6U6D1d19qAN7eDbCpcM8615cYFXOrwmjq+SOlaaM4uT8IBg12Q+XWw9PQo4UK2u5xtoJbahby+KdKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A80PCNBz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A80PCNBz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-789314f0920so47584107b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2025 05:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764075659; x=1764680459; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EwtMj9Tn26+G/BK3TdcRoi2FFA98Db2aSv5nptXisyE=;
        b=A80PCNBzLcYxTf7/w4LbXGfOWvUXlmSlaFMVbRloV53kHn1SKwFGqH3lct59mG/klG
         ZaePMxB8OXoA8AMv2B8vdd/o09JRT8Q6wxwI7szAZp2OwhXwn3VwVwuXh4cjO/T5D65h
         u4CHIl9oL9yxB6q2v2ThZ9w40vzWyZ9/eQSLzZVDU0XFvQ8+NdmJd3bOt4B0uwFI5gGT
         Omk8rIoz9iAM3ldbN/ILH3g9zNFgG/i5N0IzAe6j5KnHSy04e1gAKChd1noyCJEESsbk
         ngNojKCWtHLGuL8E8UBqsfRB0+t5oqASz9U1ZVG77vvft8E2B6i2GKH82iTj8n8ZvBUH
         5f7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764075659; x=1764680459;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwtMj9Tn26+G/BK3TdcRoi2FFA98Db2aSv5nptXisyE=;
        b=HVu/QLkVk24HMfFlSv6xwJh3WKGblTWD3EPH0qfPNiUGbkF6Pp0P4sKuH5qr46aEvF
         nWBrjx7Jtat5YDRXlj9AvPI+5csIF6WK07g2aTJz6CkIANGDJEYeqTJjwlXmsxRMwPk7
         VEZG9troaBLoaX4JXXFvtxLXIfEiuApz/3Co59EwFnGnlD8gZC0rv/9tYA/WLGniUOBF
         DKeF/eNpLmzjxFzm+1ttpxmMbR5SF1D+e6n9iL6p2ZrZbh4R4wVjFdaU92htFu5WjWXY
         QugozBUZYTG/fk/IuptXot/R9yLjacjcOnWZ063pvxMioI/1Hq0pa7ttWmhCsEOII/CK
         9KKg==
X-Forwarded-Encrypted: i=1; AJvYcCWjhxQ+jIuELK5uS16Ptq2QOZ+2g/tnpIozS4OiXRlLQFnJ7nUocKuPErhc1+SkooJFfxnwBsd66k0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOWwp58wj7AP2nHTKm/30U0Y+sHxHR2pP3mOvJ9A1kHfuflnz1
	AecUR0Vg+7h8iRqo69ONsmTfMGcyddAtH2tGm9584OmlnpyBi6l9S2+NOwLKSm1tB/DEmYLBioo
	xtlSArkup5cTB3Ind5KrwgShtgR/9oofGkFP986trKw==
X-Gm-Gg: ASbGncsd8liFZt2FtRQsP0xWlbbPoYkLE9M6dsmPWgWxVgQAYAtKXTLT2Oz4sTEvnJ8
	16UvKTDybuHPb6ul6r63xGzDKbPNuz9Zb8aITuvbYNOcuKbHG2zF1/HTbj5kNnbwNB7BzPeREn1
	j3VymVV+oa7FwKgQz4bGli8K7JAuLEhNQs5vByET+S7+uinlDWq1FNHqs5hQIFrPG4EoAA+QYYW
	xQQiUV8nZmie/nN0caEUeHw1s/SM0HXD2TNr+GWlLLlGhGGjA5J8sbKntPet2idY1zhaxzy
X-Google-Smtp-Source: AGHT+IEVh0F28rwQ3ZIFgNUSGqQdc5k7F4nF8fGFXvLxcCwRiiYYXpgceMGfJqIyGaOZAKefzzRf+LWLBFk6M+BlOcs=
X-Received: by 2002:a05:690c:61c1:b0:788:bda:4895 with SMTP id
 00721157ae682-78ab6db10a1mr25538017b3.3.1764075658937; Tue, 25 Nov 2025
 05:00:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117000132.12131-1-jszhang@kernel.org>
In-Reply-To: <20251117000132.12131-1-jszhang@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 25 Nov 2025 14:00:23 +0100
X-Gm-Features: AWmQ_bliF2cqFcUg4UKi8EZNWazRCGsNxtPq3ZxBiKjQc3YXZI2wOQx5_ZRt4HI
Message-ID: <CAPDyKFpu1Ag+dL6WqZPpE5B9kDBgo3VrpP7O64dqkgtqimUHdA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-dwcmshc: Promote the th1520 reset
 handling to ip level
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Nov 2025 at 01:19, Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Commit 27e8fe0da3b7 ("mmc: sdhci-of-dwcmshc: Prevent stale command
> interrupt handling") clears pending interrupts when resetting
> host->pending_reset to ensure no pending stale interrupts after
> sdhci_threaded_irq restores interrupts. But this fix is only added for
> th1520 platforms, in fact per my test, this issue exists on all
> dwcmshc users, such as cv1800b, sg2002, and synaptics platforms.
>
> So promote the above reset handling from th1520 to ip level. And keep
> reset handling on rk, sg2042 and bf3 as is, until it's confirmed that
> the same issue exists on these platforms too.
>
> Fixes: 017199c2849c ("mmc: sdhci-of-dwcmshc: Add support for Sophgo CV1800B and SG2002")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
> since v1:
>  - limit the promotion to only cv1800b, sg2002 and generic dwcmshc
>
>  drivers/mmc/host/sdhci-of-dwcmshc.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
> index eebd45389956..07e5df0f8beb 100644
> --- a/drivers/mmc/host/sdhci-of-dwcmshc.c
> +++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
> @@ -289,6 +289,19 @@ static void dwcmshc_adma_write_desc(struct sdhci_host *host, void **desc,
>         sdhci_adma_write_desc(host, desc, addr, len, cmd);
>  }
>
> +static void dwcmshc_reset(struct sdhci_host *host, u8 mask)
> +{
> +       sdhci_reset(host, mask);
> +
> +       /* The dwcmshc does not comply with the SDHCI specification
> +        * regarding the "Software Reset for CMD line should clear 'Command
> +        * Complete' in the Normal Interrupt Status Register." Clear the bit
> +        * here to compensate for this quirk.
> +        */
> +       if (mask & SDHCI_RESET_CMD)
> +               sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +}
> +
>  static unsigned int dwcmshc_get_max_clock(struct sdhci_host *host)
>  {
>         struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> @@ -832,15 +845,7 @@ static void th1520_sdhci_reset(struct sdhci_host *host, u8 mask)
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         u16 ctrl_2;
>
> -       sdhci_reset(host, mask);
> -
> -       /* The T-Head 1520 SoC does not comply with the SDHCI specification
> -        * regarding the "Software Reset for CMD line should clear 'Command
> -        * Complete' in the Normal Interrupt Status Register." Clear the bit
> -        * here to compensate for this quirk.
> -        */
> -       if (mask & SDHCI_RESET_CMD)
> -               sdhci_writel(host, SDHCI_INT_RESPONSE, SDHCI_INT_STATUS);
> +       dwcmshc_reset(host, mask);
>
>         if (priv->flags & FLAG_IO_FIXED_1V8) {
>                 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> @@ -886,7 +891,7 @@ static void cv18xx_sdhci_reset(struct sdhci_host *host, u8 mask)
>         struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
>         u32 val, emmc_caps = MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO;
>
> -       sdhci_reset(host, mask);
> +       dwcmshc_reset(host, mask);
>
>         if ((host->mmc->caps2 & emmc_caps) == emmc_caps) {
>                 val = sdhci_readl(host, priv->vendor_specific_area1 + CV18XX_SDHCI_MSHC_CTRL);
> @@ -958,7 +963,7 @@ static void cv18xx_sdhci_post_tuning(struct sdhci_host *host)
>         val |= SDHCI_INT_DATA_AVAIL;
>         sdhci_writel(host, val, SDHCI_INT_STATUS);
>
> -       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
> +       dwcmshc_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>  }
>
>  static int cv18xx_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
> @@ -1100,7 +1105,7 @@ static const struct sdhci_ops sdhci_dwcmshc_ops = {
>         .set_bus_width          = sdhci_set_bus_width,
>         .set_uhs_signaling      = dwcmshc_set_uhs_signaling,
>         .get_max_clock          = dwcmshc_get_max_clock,
> -       .reset                  = sdhci_reset,
> +       .reset                  = dwcmshc_reset,
>         .adma_write_desc        = dwcmshc_adma_write_desc,
>         .irq                    = dwcmshc_cqe_irq_handler,
>  };
> --
> 2.51.0
>
