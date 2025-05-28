Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290461367
	for <linux-mmc@vger.kernel.org>; Wed, 28 May 2025 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748403152; cv=none; b=YxTgJP7SQ94yA7+BpRU5+7vsZFBv2/hXuhkPdVDfXFuSbsCERIGtcc0l/73fw2mjJpbTsEvrr0l6HyK4b9E8dfR85Jnp6Awj+fe/ZpDBEovexuFU9aWg3y1R4DJm0Jo7zxiBdKTfI6Id+BWaCwmbt+mElshgGkZoReowAARIiBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748403152; c=relaxed/simple;
	bh=0QpmczGoIMlKNXsUuJXj3GdcqzR6pwkdBHyH9N65OIU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LA/v2KPFRNIog1vV+bNs5oQ5vvr3pJ9XsJCMRLZ53faSoq/kKaq9Vjt7MpReQvslIblGIZajZBlyyppitWh/IA7j0X5quvRMHG+3mb5MGFpD7EBC3/vdVQxddVFYoZ+NMskyxIiyYeIQzaBXuLD7kjtqnQD7MEJCxZtfQZwDq5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZXYu+lJB; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXYu+lJB"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2cc57330163so2422346fac.2
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2025 20:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748403149; x=1749007949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HWw3TzzmW76PuMGCvGJVQBcS6fcJ72imE1BYjd+nGQE=;
        b=ZXYu+lJBlmbbuKTUTiSlI/NKP34xhJ8tNI9H8+VsW9fmjJaHLNWKCmIYhfuIyeDaBJ
         RuycK3ATbndbZkt8R37djPAHrUDKx79rEnXOvBWoBT59LaxykwJbMt7dBRsVRt0W9R/L
         pZk78FnAJwP+qQaW5jNS8HZzjZdQ3pRfB2mnnxi3YdeeaN5yxvgOaEPN6RsEUPYLzNAd
         8E1yeEdeCwVTSDlFI9qNnwtfBsmceq0rg7snM8d460ugA74FcmI2rSsjxIfmoBc72RGb
         cP8TNSI+GGjhh4H8IFsqqHZ0mmRvbnDEg/FSsYvRwOyWk/Oqym4gQjquAuVNmUsNZFth
         Q5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748403149; x=1749007949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWw3TzzmW76PuMGCvGJVQBcS6fcJ72imE1BYjd+nGQE=;
        b=trQXSBWq1vZJINUnlwtRFAqlPyicgX7ubuubOZZa5V0udQXcy24vuG5Bd8j1an+pI8
         +YHOaYmFgQ3Hy7WyJQYfYbu8felq/yLRKUO1Fs98d6+88sYmjNfywG4NaAZYzyuKyO74
         i4Y8z7n4bdSBU7z/bHNeiE4NcjIWKh/AoTm+x3/juIDR5ZbkKFfGzIecCmW2zjaJqnZD
         8LH2ArKhsGigD+v/eSS2GOV+FBx8AGAssexoZW8gmVOm59imXxXrA2DCFIEk8QvyImyA
         zpgup18rKBsSTwlxZGsspZGe2uJyq20QEoLQ3UE1zWBc9ZwomFnRU2zdxqR/xps2uZRt
         qApQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBQkhOxaothLCrngiUZw81D/QOwVww4ecsH5xQ65+VuBCYOYnJspmZKVb21o3dzQEA5QpyDhUEJ5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzOGgLzPsTSGcHfJb4f5pmVVDkRiCWPW97TMDlhsJ7h8WK8X4/
	237VfaEfwp9JI8E92WpapJ5cs5b+t2LltKhYxW5R/BvUVElYjGQrI8j7NY8kXLUtiBCOU4FOWNf
	K/0iik7P/WsvMWnW55O/O9QklItWCCio=
X-Gm-Gg: ASbGncvBzDeDZe9u21dxDxq2EUEoYevgufEY4+7A3oJhQGUXBaCDUP+mBu5wm2q6QE3
	HH7V9BlkvG+QkGtqCzgJ6rCn5RM88ob+9+TWt1BEJbZJIIwW2kpJw8ijCa8Xx6SXTE6nrJ6qiK7
	yBfJnCJBg8M3Y8MC3JTE5OdWjyMcxLK2L4tKBbsEjXBmbB15sa4JhZnxPE3/9NuxQ=
X-Google-Smtp-Source: AGHT+IFsZ3w7HUvwTw0Wcrl7ZQ0q+G3x9OaCP4Yw9thK4cvJcPAB+FU/5QjbQlJD5cYFRQQqGcf/zmkzEwMTC0yLIVI=
X-Received: by 2002:a05:6870:7d8e:b0:2d5:25b6:ec14 with SMTP id
 586e51a60fabf-2e8e0f237e9mr280147fac.15.1748403149035; Tue, 27 May 2025
 20:32:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747792905.git.zhoubinbin@loongson.cn> <d7994a2655d27bc2cb6d740345747292b67e4a25.1747792905.git.zhoubinbin@loongson.cn>
In-Reply-To: <d7994a2655d27bc2cb6d740345747292b67e4a25.1747792905.git.zhoubinbin@loongson.cn>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Wed, 28 May 2025 11:31:52 +0800
X-Gm-Features: AX0GCFsrjQTmqConBdGUgn8ZKXQRvomBVv2B2ZkebJ3K7mumYhW2x49Sn0IapiQ
Message-ID: <CAAfSe-vJuiM0yCLBhr7WmtoZxEdRNo9x7fn9Mm5dztQ6BpLzJQ@mail.gmail.com>
Subject: Re: [PATCH 29/34] mmc: sdhci-sprd: Drop the use of sdhci_pltfm_free()
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Huacai Chen <chenhuacai@kernel.org>, linux-mmc@vger.kernel.org, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 14:07, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> Since the devm_mmc_alloc_host() helper is already in
> use, sdhci_pltfm_free() is no longer needed.
>
> Cc: Orson Zhai <orsonzhai@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Reviewed-by: Chunyan Zhang <zhang.lyra@gmail.com>

Thanks,
Chunyan

> ---
>  drivers/mmc/host/sdhci-sprd.c | 33 ++++++++++-----------------------
>  1 file changed, 10 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> index db5e253b0f79..a5dec1a0e934 100644
> --- a/drivers/mmc/host/sdhci-sprd.c
> +++ b/drivers/mmc/host/sdhci-sprd.c
> @@ -764,7 +764,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret)
> -               goto pltfm_free;
> +               return ret;
>
>         if (!mmc_card_is_removable(host->mmc))
>                 host->mmc_host_ops.request_atomic = sdhci_sprd_request_atomic;
> @@ -778,34 +778,26 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>         if (!IS_ERR(sprd_host->pinctrl)) {
>                 sprd_host->pins_uhs =
>                         pinctrl_lookup_state(sprd_host->pinctrl, "state_uhs");
> -               if (IS_ERR(sprd_host->pins_uhs)) {
> -                       ret = PTR_ERR(sprd_host->pins_uhs);
> -                       goto pltfm_free;
> -               }
> +               if (IS_ERR(sprd_host->pins_uhs))
> +                       return PTR_ERR(sprd_host->pins_uhs);
>
>                 sprd_host->pins_default =
>                         pinctrl_lookup_state(sprd_host->pinctrl, "default");
> -               if (IS_ERR(sprd_host->pins_default)) {
> -                       ret = PTR_ERR(sprd_host->pins_default);
> -                       goto pltfm_free;
> -               }
> +               if (IS_ERR(sprd_host->pins_default))
> +                       return PTR_ERR(sprd_host->pins_default);
>         }
>
>         clk = devm_clk_get(&pdev->dev, "sdio");
> -       if (IS_ERR(clk)) {
> -               ret = PTR_ERR(clk);
> -               goto pltfm_free;
> -       }
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
>         sprd_host->clk_sdio = clk;
>         sprd_host->base_rate = clk_get_rate(sprd_host->clk_sdio);
>         if (!sprd_host->base_rate)
>                 sprd_host->base_rate = SDHCI_SPRD_CLK_DEF_RATE;
>
>         clk = devm_clk_get(&pdev->dev, "enable");
> -       if (IS_ERR(clk)) {
> -               ret = PTR_ERR(clk);
> -               goto pltfm_free;
> -       }
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
>         sprd_host->clk_enable = clk;
>
>         clk = devm_clk_get(&pdev->dev, "2x_enable");
> @@ -814,7 +806,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>
>         ret = clk_prepare_enable(sprd_host->clk_sdio);
>         if (ret)
> -               goto pltfm_free;
> +               return ret;
>
>         ret = clk_prepare_enable(sprd_host->clk_enable);
>         if (ret)
> @@ -891,9 +883,6 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
>
>  clk_disable:
>         clk_disable_unprepare(sprd_host->clk_sdio);
> -
> -pltfm_free:
> -       sdhci_pltfm_free(pdev);
>         return ret;
>  }
>
> @@ -907,8 +896,6 @@ static void sdhci_sprd_remove(struct platform_device *pdev)
>         clk_disable_unprepare(sprd_host->clk_sdio);
>         clk_disable_unprepare(sprd_host->clk_enable);
>         clk_disable_unprepare(sprd_host->clk_2x_enable);
> -
> -       sdhci_pltfm_free(pdev);
>  }
>
>  static const struct of_device_id sdhci_sprd_of_match[] = {
> --
> 2.47.1
>
