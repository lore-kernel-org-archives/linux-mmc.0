Return-Path: <SRS0=lEQw=EC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAD2C55179
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 10:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C7EC22281
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Oct 2020 10:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hgwBPyAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897763AbgJ0KT0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Oct 2020 06:19:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55879 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897233AbgJ0KTZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2020 06:19:25 -0400
Received: by mail-wm1-f66.google.com with SMTP id a72so801361wme.5;
        Tue, 27 Oct 2020 03:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dkwbI/0H97SZJixhQJH8dswlbjBm943gYERZ83AMoLY=;
        b=hgwBPyAwrmX4gfhR16//+HwE/aO/mjjEpeDp9bXYGGvxR27aJkVXE9ZcKeBAcja9+s
         hRwuJMyXDtLHzeW/+SBYpX3D0WQiiFP0tokRsDKAUmKIKLh/NainCGQvYP1PfEjbYhRo
         nl9yI/xz53C1OXFvwiYN+Kk66xL+N+hPA4nzRYVK1DQ6IxM8o1To/1o2wxt77Y9kJrqs
         /IXjY8qJONoNEoHojlr0UnHijYIMlWE0NrA0i7bn9nhPLAQKcXUtapjXk0BT1gPe0UoX
         xSQZx8QU6hXImlu6ohqnHkjEXlg6fVkAi93H7bm6rFRb1TBWmkxeGbs/ZLw1y9j1oUNH
         AEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dkwbI/0H97SZJixhQJH8dswlbjBm943gYERZ83AMoLY=;
        b=JXgvNCt5BOP/m2Yi+APs89Z0wKzxAPn8X28ZWJ0SwaNaDnniDZ5ygjtgKZljqc1h+T
         skEBO6/DAUQI1uZ/7UpVSzZdGG01QZ63vNjuExpP+oRvpcXNdj/5z1wB7EjRpuNpdtCS
         COHjXnQc2w210zAojZmqU4bwbckFtbZOccotVQWZ/UFiN4zw1xwwyVrD5O1Remfw1iII
         53lGPxIHkxQ1ZL/z/6NKl+8brBTigTqQL5SsF3c2p24I97pzt8Z/ToFSW1nV5/trQ8OD
         rxMKTDGUMwSR1qD6s75aRFBlnlzijmP+vfCDS0L8ts4R37qrbrUjr6MUZ2GHM//VKrJN
         Lj3Q==
X-Gm-Message-State: AOAM533dKi719t979VcylAcP876M4JogOkpfQgaO8lCn66KLBJOFVQop
        tCyuGiYqoEZTt47w5ovqqq0=
X-Google-Smtp-Source: ABdhPJxeO0DzMU+707HyJRwnPTQmDLgKCotn1ndnwrMruc4M8djY+myKe0PoeIdnRJJaD54MCVb9NQ==
X-Received: by 2002:a1c:9dcc:: with SMTP id g195mr1820127wme.113.1603793962048;
        Tue, 27 Oct 2020 03:19:22 -0700 (PDT)
Received: from ziggy.stardust ([213.195.117.206])
        by smtp.gmail.com with ESMTPSA id t7sm1367711wrx.42.2020.10.27.03.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 03:19:21 -0700 (PDT)
Subject: Re: [PATCH] mmc: host: mtk-sd: enable recheck_sdio_irq for MT8516 SoC
To:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     ulf.hansson@linaro.org, chaotian.jing@mediatek.com
References: <20201023122950.60903-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7820dbe9-ff62-7cc3-1e60-8d5c0a069abb@gmail.com>
Date:   Tue, 27 Oct 2020 11:19:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201023122950.60903-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 23/10/2020 14:29, Fabien Parent wrote:
> MT8516 SoC suffers from sometimes losing SDIO IRQs, this makes SDIO
> devices sometimes unstable. Make use of the new property
> recheck_sdio_irq to fix the SDIO stability issues on MT8516.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/mmc/host/mtk-sd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745e5882..3dc102eefe49 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -524,7 +524,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
>   
>   static const struct mtk_mmc_compatible mt8516_compat = {
>   	.clk_div_bits = 12,
> -	.recheck_sdio_irq = false,
> +	.recheck_sdio_irq = true,
>   	.hs400_tune = false,
>   	.pad_tune_reg = MSDC_PAD_TUNE0,
>   	.async_fifo = true,
> 
