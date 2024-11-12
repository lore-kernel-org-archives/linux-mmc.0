Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A6217F27
	for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 18:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731437065; cv=none; b=DbM3PCtKqFQMTjWRXVgpa/GOK5dUlvMNUsM5ixlmjjwVT5fcoKoeUJOAue5f9npkqZlilkvYObqjnjuz4s/XScj/NXUmrmzr8opAwkr0m6nw+URNJWRwnjNJNUGnuo0obEXTDKVv2X6RDeYR+gc8PhWr0dnBkGMZ7fjC+hJEDnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731437065; c=relaxed/simple;
	bh=vDUccWZshf4rzzFa312c9GTVGwP//SSu4LzFi89MZHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VbATwWI79sr8JHb0YjRcy+0mhyzrAOEUHQa7UdN0hPfMF/LzmN8rel9/4gWGAQYdwHW6ih0WbxjEpjGSWxwZg8rNqzqpzo+NXKfjIIlCq97BdZYRTOq3pvUYWpcr3vtYMfqFXvKKEgL++9AWWt1Y0RQCrlw8QGYtZiXh/orGKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zkn/M8+3; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkn/M8+3"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ea5003deccso63933027b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 12 Nov 2024 10:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731437063; x=1732041863; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cnJQV6SIrBEYfUH3huctmXM4bbWNUyEeoT62a05aBcE=;
        b=zkn/M8+3X5LNcXv2PrFoD70JAKMX9xJt65b4s1CQk0FvJAbAve9BafDkCLlTo2swGp
         0PH2xC1VA5A+T3eZHJ88jl6WyfUBin+Vvn7gzzfVaSylAiAhe3S4uQKv8dCCwy8UE61p
         746Xd+9fQ7tYc8KobVzGPIiPI/YcKQvAwC3x09uSurPzTQsIunf1vRsDULBG7zwl5Pnn
         ru64IG37Eyu0+TEX3lJkdNn8gygtaxl2mZpx8FLQXZ9D0WGUM6Jwh7+9/m59LBpJYWT/
         TzdI4bsywSpRhSm8UOLZGmItGmwV+yXl6DwqQtVIuqsNOcvGrHBooDqYeWdICdHtiNNb
         Kwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731437063; x=1732041863;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cnJQV6SIrBEYfUH3huctmXM4bbWNUyEeoT62a05aBcE=;
        b=ml4+GcNf0Os86ij4xAuQFjzc4a2fWZJMr2K07a5P+3JjhaWIj86c77Frtrh9d/PIdd
         X8k//dF7j1c6DwTR6vWqHm1FNWXLSfJxxNYx8esRcjs3jIQ+74Wq7fSd5A1JnfDU4NrW
         zxjedGXFAphldy+/3TtmRrSaYhDcoHRvNSwHOAAmvJqGq+7tNRUacWWx+lxbTRFiGQu5
         /2dSOKzAfCKd3Bt8qEebic9HE8M+XdQ6TQfcmOqe+ZmRbhYLVKed/cw92Yb1SdGEaiar
         7M702mknoj0ttZ+2A/hfwl/3Npo6QhkGZPUoMbSbgOfUDmpDf3bsT8aqGUZVyFMN+DPS
         fdwg==
X-Forwarded-Encrypted: i=1; AJvYcCUvddGCyrUR9MqHoJPShrpEeT3/lc2YuNLOCq7RH/zY4DYs0ZfsVglZy0ebt48cvpWne35EA85+BXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6QVt1Ins2iVg12Rfkwuh474td4KVK3eVGrZvDP9B655u6bdjZ
	LSHmLiZeh3yjmk9BvMr/wvvvDDK0bGSSavrCSabNM62AYjfSJ3K06aARjrK7z7yoceUt3ZnuDKH
	BSdkybgHLgAUcMijJkIaFUDRuaaz0N6h8URos8A==
X-Google-Smtp-Source: AGHT+IF6cpXW9+0uAdL1AcqfGK/UqMHI+Wl5nRA87bwUhFwtmph6r68HcLuRG/ke7CBRwoAUdGOvA7rO7EOcH7M2vUo=
X-Received: by 2002:a05:690c:6f8f:b0:6ea:7c46:8c23 with SMTP id
 00721157ae682-6eaddfb0191mr188491367b3.35.1731437063141; Tue, 12 Nov 2024
 10:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20241107121215.5201-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 12 Nov 2024 19:43:47 +0100
Message-ID: <CAPDyKFoe3rv49oQ+qAF9fq41S3XwKO6dhg7uhgb1ho7nApDrbw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: mtk-sd: Fix error handle of probe function
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Nov 2024 at 13:12, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
> In the probe function, it goes to 'release_mem' label and returns after
> some procedure failure. But if the clocks (partial or all) have been
> enabled previously, they would not be disabled in msdc_runtime_suspend,
> since runtime PM is not yet enabled for this case.
>
> That cause mmc related clocks always on during system suspend and block
> suspend flow. Below log is from a SDCard issue of MT8196 chromebook, it
> returns -ETIMEOUT while polling clock stable in the msdc_ungate_clock()
> and probe failed, but the enabled clocks could not be disabled anyway.
>
> [  129.059253] clk_chk_dev_pm_suspend()
> [  129.350119] suspend warning: msdcpll is on
> [  129.354494] [ck_msdc30_1_sel : enabled, 1, 1, 191999939,   ck_msdcpll_d2]
> [  129.362787] [ck_msdcpll_d2   : enabled, 1, 1, 191999939,         msdcpll]
> [  129.371041] [ck_msdc30_1_ck  : enabled, 1, 1, 191999939, ck_msdc30_1_sel]
> [  129.379295] [msdcpll         : enabled, 1, 1, 383999878,          clk26m]
>
> Add a new 'release_clk' label and reorder the error handle functions to
> make sure the clocks be disabled after probe failure.
>
> Fixes: ffaea6ebfe9c ("mmc: mtk-sd: Use readl_poll_timeout instead of open-coded polling")
> Fixes: 7a2fa8eed936 ("mmc: mtk-sd: use devm_mmc_alloc_host")
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>

This didn't apply on fixes the branch, but only on next. That said, I
have queued this up for next and added a stable tag.

Note that, this means that the fix needs to be backported manually,
but I leave that to you or someone else to take care of.

Thanks and kind regards
Uffe



> ---
> Changes in v2:
> - Add the relevant fixes tags.
>
> ---
>  drivers/mmc/host/mtk-sd.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a2750a45c1b7..022526a1f754 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -3007,7 +3007,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         ret = msdc_ungate_clock(host);
>         if (ret) {
>                 dev_err(&pdev->dev, "Cannot ungate clocks!\n");
> -               goto release_mem;
> +               goto release_clk;
>         }
>         msdc_init_hw(host);
>
> @@ -3017,14 +3017,14 @@ static int msdc_drv_probe(struct platform_device *pdev)
>                                              GFP_KERNEL);
>                 if (!host->cq_host) {
>                         ret = -ENOMEM;
> -                       goto release_mem;
> +                       goto release;
>                 }
>                 host->cq_host->caps |= CQHCI_TASK_DESC_SZ_128;
>                 host->cq_host->mmio = host->base + 0x800;
>                 host->cq_host->ops = &msdc_cmdq_ops;
>                 ret = cqhci_init(host->cq_host, mmc, true);
>                 if (ret)
> -                       goto release_mem;
> +                       goto release;
>                 mmc->max_segs = 128;
>                 /* cqhci 16bit length */
>                 /* 0 size, means 65536 so we don't have to -1 here */
> @@ -3064,9 +3064,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  end:
>         pm_runtime_disable(host->dev);
>  release:
> -       platform_set_drvdata(pdev, NULL);
>         msdc_deinit_hw(host);
> +release_clk:
>         msdc_gate_clock(host);
> +       platform_set_drvdata(pdev, NULL);
>  release_mem:
>         if (host->dma.gpd)
>                 dma_free_coherent(&pdev->dev,
> --
> 2.46.0
>
