Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0D2F3646
	for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2025 10:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752660556; cv=none; b=Xb3hU5vjoPBqR+L7ymip5YJnYGX2xl1kqWZX1DB4CYH/7tmOhseDkH/QFVWe4ZhNw+cSXstsmVaWwKsdLIauGWYgPXl83FljuYg/Z4Cjntl6TPoC0VzG8s7ifiyz41qN9YWeR8kEvJvKVqUz+whKF6tepsKN4yVLGIdRiKrXUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752660556; c=relaxed/simple;
	bh=/VEjuhpOm4mcfJFH+WMwCKqtBLq/M4iABFtKjrJ49AU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZoi5pZuMcMiLay2OdIozlLW7vmNKIu7V4jfsopM8M4HxKgZIcxH8cprROhztc4xtG9ndgRjI+//X4P0AgML1o5op2Pxsyzc0e2klZ/PUD+LBNyIROkfxdi7bF27vijWz6sMGOsl2/FFcttACtlBXPPUF3oipaH0XIieWwxdbVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gMRR88LF; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gMRR88LF"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e812fc35985so5481824276.0
        for <linux-mmc@vger.kernel.org>; Wed, 16 Jul 2025 03:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752660553; x=1753265353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OnBWYwfo8wiUCGNtHhjPaLy845d6kgQBixwcMR4fh74=;
        b=gMRR88LFCRI7khBmWlXwAA9Y9pgGkwOaOozVaMjcDKYtqaWZMZBXDXZKPbUmPq+5wO
         ndjBEopxvFRzWxfK6lqWt4FGrPd22fhwTbQQCxVoEP2JyRbOxXW/aNRXtZjH/Ur9efGS
         jIMyxolMCJSIT0+VCUf2uRY9khquRqZ0tVzd/bpf6iXE42B1VdRkUOMNEWWl57yrx5CZ
         kYUvNrCqONf9xemub50nIc18t1gkDjYudNEmJRRFP6jU6lRUMLwjPYr6BKAeDCCb1Rny
         LfuZQY8HC1Vu4Gq9qSNeeWj0HkE047UbMNk8HIOk9wajKFY4Yd7fDHWTlqPFIqwb9H02
         X+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752660553; x=1753265353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OnBWYwfo8wiUCGNtHhjPaLy845d6kgQBixwcMR4fh74=;
        b=VHwWaNk2kMhskv+hrho61anx4KEUFvNnQphCY5Vq6r8aaUTOFpBCAfGxGo1Z5ue3GC
         KRV5lOtQcaY+Hub/7Z0mrlC3w7k4Hfhzj6/1f51fMCEHNpOjkg6aTqctZqrI7Y6Ie8SQ
         Ez+Vm3oyPTMTUMi7TqIrG0Kr6YJXRsr+49PMkj+3zoVNw5BGf9vc6DiRIAjxKWm0nwOM
         qkhWMTmDAb0QUJAs2PBUNSuwC36jzlIIp/S5dJ7EzZOktcv1yY5Q6j4ufH/oNEuTVQHM
         4pOGTNBOVuKfJ5M2w2dXOM/CArzXTndxsb62Quzcwetgd0AmY03O3dEAlmYd+i/+lkeQ
         yLvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm9AlBIuSSvjM0lPJbsfHwIGuuXy13ke3UxtQKmAIaXwKHr3OeyfgQyMXPhOyn71IPBQF3kUjy/HU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xGMApRr7AckbryiavhHueLz7pGqV/JF7vrphee4VVXUqxpsF
	gYJt4CeXoNwHQGPL/jsdy+HwcMeqURkRZz/NvZ4UnvvX5zD+zwFL5xuqmPw3/MqPm4s47/s/RBK
	nMWuIXkcYYuIpiLb2Ghnu7vg/UWyLo/5nOpQwB4vWzQ==
X-Gm-Gg: ASbGnct7UDnbm7wFHJ6VYYAwJbkO5pCyLN3/3t1IazLjF20tFCEXRxRVv+k7VilidFV
	23p0MDKXjXCjP+04EFp9xElTPH/DMHynCUA5YwREnieJgZxgsFWC17QE341U7ofBH/1EsBqpaul
	e3sutV568981ivzirl+HThrYvxtDsqrvrKv6H2+SCaMZfLdwbJ2AbSNDj8u8tiFDjM1K/OSUwso
	3RHZEo9
X-Google-Smtp-Source: AGHT+IGy3dipAywy/v3t7OOYtOeDboI5JlqIw7qcFV8Y/WnPRMS48rXs5U9ysQX+XZc7N3+MilbgU45XI/TSY+C1E/k=
X-Received: by 2002:a05:690c:9b0a:b0:6ef:652b:91cf with SMTP id
 00721157ae682-7183515bc8fmr34066097b3.27.1752660553188; Wed, 16 Jul 2025
 03:09:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716064421.3823418-1-zhoubinbin@loongson.cn>
In-Reply-To: <20250716064421.3823418-1-zhoubinbin@loongson.cn>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 16 Jul 2025 12:08:37 +0200
X-Gm-Features: Ac12FXxmbFb81p4o8_4QaHZmiOqrSxmwLRGTgDmrXWuWmSI0XGrHlo7coapF_Kk
Message-ID: <CAPDyKFrxVYaH+bxLSaXL3VjsPAdBEtxHk=PonT659GmVnc+n5A@mail.gmail.com>
Subject: Re: [PATCH] mmc: loongson2: Unify the function prefixes for loongson2_mmc_pdata
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, 
	linux-mmc@vger.kernel.org, wanghongliang@loongson.cn
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Jul 2025 at 08:44, Binbin Zhou <zhoubinbin@loongson.cn> wrote:
>
> The function prefixes for loongson2_mmc_pdata follow two naming
> conventions: SoC-based and DMA-based.
>
> First, DMA-based prefixes are the preferred choice, as they clearly
> highlight differences, such as prepare_dma; however, for functions
> related to SoC, such as reorder_cmd_data, it is agreed to use the
> smallest SoC name as the fallback prefix, such as ls2k0500.
>
> No functional change intended.
>
> Suggested-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/loongson2-mmc.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/loongson2-mmc.c b/drivers/mmc/host/loongson2-mmc.c
> index ba6bb8fd5535..27499f36477c 100644
> --- a/drivers/mmc/host/loongson2-mmc.c
> +++ b/drivers/mmc/host/loongson2-mmc.c
> @@ -594,7 +594,7 @@ static struct mmc_host_ops loongson2_mmc_ops = {
>         .ack_sdio_irq   = loongson2_mmc_ack_sdio_irq,
>  };
>
> -static const struct regmap_config ls2k1000_mmc_regmap_config = {
> +static const struct regmap_config ls2k0500_mmc_regmap_config = {
>         .reg_bits = 32,
>         .val_bits = 32,
>         .reg_stride = 4,
> @@ -610,8 +610,8 @@ static int loongson2_reorder_cmd_list[] = { SD_APP_SEND_SCR, SD_APP_SEND_NUM_WR_
>   * However sdio controller will send these datas in usual data format,
>   * so we need to adjust these datas to a protocol consistent byte order.
>   */
> -static void loongson2_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
> -                                          struct mmc_command *cmd)
> +static void ls2k0500_mmc_reorder_cmd_data(struct loongson2_mmc_host *host,
> +                                         struct mmc_command *cmd)
>  {
>         struct scatterlist *sg;
>         u32 *data;
> @@ -704,8 +704,8 @@ static int ls2k0500_mmc_set_external_dma(struct loongson2_mmc_host *host,
>  }
>
>  static struct loongson2_mmc_pdata ls2k0500_mmc_pdata = {
> -       .regmap_config          = &ls2k1000_mmc_regmap_config,
> -       .reorder_cmd_data       = loongson2_mmc_reorder_cmd_data,
> +       .regmap_config          = &ls2k0500_mmc_regmap_config,
> +       .reorder_cmd_data       = ls2k0500_mmc_reorder_cmd_data,
>         .setting_dma            = ls2k0500_mmc_set_external_dma,
>         .prepare_dma            = loongson2_mmc_prepare_external_dma,
>         .release_dma            = loongson2_mmc_release_external_dma,
> @@ -736,8 +736,8 @@ static int ls2k1000_mmc_set_external_dma(struct loongson2_mmc_host *host,
>  }
>
>  static struct loongson2_mmc_pdata ls2k1000_mmc_pdata = {
> -       .regmap_config          = &ls2k1000_mmc_regmap_config,
> -       .reorder_cmd_data       = loongson2_mmc_reorder_cmd_data,
> +       .regmap_config          = &ls2k0500_mmc_regmap_config,
> +       .reorder_cmd_data       = ls2k0500_mmc_reorder_cmd_data,
>         .setting_dma            = ls2k1000_mmc_set_external_dma,
>         .prepare_dma            = loongson2_mmc_prepare_external_dma,
>         .release_dma            = loongson2_mmc_release_external_dma,
> @@ -838,8 +838,8 @@ static int loongson2_mmc_prepare_internal_dma(struct loongson2_mmc_host *host,
>         return 0;
>  }
>
> -static int loongson2_mmc_set_internal_dma(struct loongson2_mmc_host *host,
> -                                         struct platform_device *pdev)
> +static int ls2k2000_mmc_set_internal_dma(struct loongson2_mmc_host *host,
> +                                        struct platform_device *pdev)
>  {
>         host->sg_cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
>                                           &host->sg_dma, GFP_KERNEL);
> @@ -860,7 +860,7 @@ static struct loongson2_mmc_pdata ls2k2000_mmc_pdata = {
>         .regmap_config          = &ls2k2000_mmc_regmap_config,
>         .reorder_cmd_data       = ls2k2000_mmc_reorder_cmd_data,
>         .fix_data_timeout       = ls2k2000_mmc_fix_data_timeout,
> -       .setting_dma            = loongson2_mmc_set_internal_dma,
> +       .setting_dma            = ls2k2000_mmc_set_internal_dma,
>         .prepare_dma            = loongson2_mmc_prepare_internal_dma,
>         .release_dma            = loongson2_mmc_release_internal_dma,
>  };
>
> base-commit: 4ad9e44c76b301e786eb4cdab890eac8c7eebd42
> --
> 2.47.3
>
