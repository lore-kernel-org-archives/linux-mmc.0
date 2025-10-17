Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38C234AAE7
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707850; cv=none; b=ezDxnb0f2hjads3ftJ4jPaHRlXA56cqYgLjomxqe+83vLsssWxsCOo+pPpKzCNb59qdLmuoHYDh+/kXzkZIVH8wCRRNbzg8/qEouuUG/7PtehMA6Fb1YXFBTMwBsPDAZXjdqrn1HT6pwxx3GlNDvpBPWDsQWA8tdVq3qxJeie2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707850; c=relaxed/simple;
	bh=ZLJ7IUyXufEocFPryGY1hojv1hZQsh9Uj9GaYGkEwr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pIPPCcKMohQeg2u3y4jX8GGUoQ3s9TVQsMp4I0ipIHPgR4b4WD6tREaxjVbYPN66uuYxcmzhViXaO39BFVLXar5DozN0xE2vWYzx+GMbNVMl8SMmni8QxB9v+wvFH+prfuWtn4Y1BLGGODG+dBFO/ftAc6zbKAAfyowWZZtgDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCsH9JqH; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCsH9JqH"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-63e0dd765a0so1688895d50.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707847; x=1761312647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QHxcRD3TuvdrKpFi85Y2nID1/TFiVbXCPwnmjQCKM4c=;
        b=MCsH9JqHxa4Ni2pcjNBQEs1Lctot43RtueluZj7MMi/LC2yPFTd147FPnzmm0r3kTj
         zMtQxfwQqXy2RREuZxpJ3AHpSQQ/hzBbaqgU9tfP/xUJ+zZ/UhtXhOSpC+TG2snBuDn1
         mC4xUmb3yFAgsYLZoqBpoQJb14xul6eXABe804XXgPnT9zaHlWlYTrLEaIvcau/mdq9k
         9pkKijmazGUkZgkGct3p83fFnkfpxYOsD44nK8mISNSiBJ1bjvPXapaJCwZ07InllYPy
         /Pmba1JZNbCvpJG+xwjmTbo9QFTm3Meyy1NEE3+1rYRULRjVuw/PhgnkzcXi4Cts6i40
         QeAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707847; x=1761312647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHxcRD3TuvdrKpFi85Y2nID1/TFiVbXCPwnmjQCKM4c=;
        b=uyhb8uDxrNQgQH50ZhaCsbNymTx8Fe8V/gg1itooe4JXUgZr8Ak0X95rCfUhvcqKDK
         /tAKBGuV8xpgDNBwbWoVbMb+z7ekkS4H4YvoKGeJg1frWHQf1Sa6SbecJey02COs6Trp
         cJAXnvTVQEGUHi2rX2xMiAFaQ4Gck/9dQBxvEYWsfWN3yyC5z9x3qniAPEByBnpn/vBW
         zfVjH3nrfOeVH0yhYER/n7hA1f/wqtrn9TMFQ5VGjOWO3x1ntshOcIXXyRVCIkLhyxIJ
         uEAYSUCvztn9wwH4N6+z3QioVnZ1qL3AJcGpE9TuEJ0q1XRgpGFEzzrdjXM9OlgOE5+Q
         0BVA==
X-Forwarded-Encrypted: i=1; AJvYcCXt5FbdjeO/v/MixT4UBrZ40quGdjQeBxo8cce6qnSr5McR8p4ud/2y4ID8huooqJI+qjzlmaCXA78=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdO5gCbPgYPC9rZqkhjpzKBH7ImnjaMvoxsKgQDu+sTi2Tz/mi
	JF0rHCmyVZyASbzwwCqj93ebTBHxmPv7c3BKfclom/mjBRXHG4EEDWm1AvDx+CBORds4W/2ejPj
	cY3oP0OdKBS3o7gbygZed8drs4flaVuVCtSkL/f1/5JspcSlxN5iN
X-Gm-Gg: ASbGncu2d/Vw7WV4lgwkpyJATlEEwPGSYjgDrJdkXW/oLbe58mGpo8hJWgFDY24+92w
	RS8XyzyIrbxE3wsVO2+bJ8Uu+qw6EuKr1v02QNBZOCJ6u/HP/6/4vTU26LegCFtsyxpbUQNqQQi
	EvwkhU0Dlm0xXw5CWlKFE7YO/I3ZpZtOa6CSdZUWemDc1PB0m7u7FhOQLNRsNi2SVASNXhUtChR
	PVFVp7wyGT2mWnlblrnfu41ffzikRMYTd5eryUom1LmIkOCLYFG6+6gPcZerw==
X-Google-Smtp-Source: AGHT+IEh1Q8BQTUAezAQ54PPKSM6CJ+S6rgBfiV+ZkyPFZoubPsABBu/bd/m3/6F3igXzEdzFK/HtMhcvBca1Iz6srk=
X-Received: by 2002:a05:690c:6308:b0:780:e0ac:5246 with SMTP id
 00721157ae682-7836d16addfmr64752717b3.14.1760707847445; Fri, 17 Oct 2025
 06:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923161915.3172-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250923161915.3172-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:11 +0200
X-Gm-Features: AS18NWDfBdIMUEuWE_8bRmEi2vdOeTrIKmJDYd0sSCasQXgjfBn-14kl0lOpprw
Message-ID: <CAPDyKFroUEASykqp-cPHnhDLOvox9jPQHCGucpTx6KMjwK9Qkw@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: enable bigger data ports where available
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 18:19, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> R-Car Gen2 SoCs have a 32 bit dataport, V3M even 64 bit. Make use of
> the bigger size in the rare case DMA is failing.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Tested on a Renesas Lager board (Gen2) and Eagle + extension board
> (V3M). SDHI driver was hacked to avoid DMA and use PIO.
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 3 ++-
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 9e3ed0bcddd6..73c84fd8a2d8 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -124,7 +124,8 @@ static const struct renesas_sdhi_of_data of_data_rcar_gen3 = {
>
>  static const struct renesas_sdhi_of_data of_data_rcar_gen3_no_sdh_fallback = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
> -                         TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
> +                         TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
> +                         TMIO_MMC_64BIT_DATA_PORT,
>         .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>                           MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
>         .capabilities2  = MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index 822a310c9bba..543ad1d0ed1c 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -60,7 +60,8 @@ static struct renesas_sdhi_scc rcar_gen2_scc_taps[] = {
>
>  static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
> -                         TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
> +                         TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2 |
> +                         TMIO_MMC_32BIT_DATA_PORT,
>         .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
>                           MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
>         .capabilities2  = MMC_CAP2_NO_WRITE_PROTECT,
> --
> 2.47.2
>
