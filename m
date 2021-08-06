Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C88C4338F
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 10:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E6D261154
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Aug 2021 10:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245205AbhHFKmv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Aug 2021 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbhHFKmu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Aug 2021 06:42:50 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D71C061798;
        Fri,  6 Aug 2021 03:42:34 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b11so10504858wrx.6;
        Fri, 06 Aug 2021 03:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Fj67vOhz3zmXYi3Qy2zVy0So4Mw59Xgs1vAgB0E0YQ=;
        b=KnFYoJFHiqhapmSUUGCFGUDZh0IMJPp9qJHWp3iTHyXOdfFF4OSN6Gtf4egRQ1fCw5
         +pi5v7V4UFShrw5/hC5Mjfxuio88BndrAUh92piTUUUNY+yc/J7I+CB/PSKZz2XFU6RD
         mAR3geycppZUM3nP+oAX/l7VdWidLunwdInVG0lcK+XX+m9By8vbp7sxmsFodSkbmrV6
         GMXXZut9YmDc/jkBmbqlMsbu3gJ9BRAfw+79XSOxvJW7srdccSiHY2m0bjRWxSk95IR7
         ixngMx+hNYnOJ3jzP6ST5Rz6vXDx3AxMFE+Zvub/UqP7X9sb3oeuUiE2qHHcgnR4/JOc
         37TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Fj67vOhz3zmXYi3Qy2zVy0So4Mw59Xgs1vAgB0E0YQ=;
        b=Q+SzWXmLLtsHaOvxEubgE8YfLlBgi3ObEKujtSxPjAuj+HZj0MAhbdTt5CM2TZBFcW
         pSEGjXtYNPu6Cyqq+aqfsDPu7hEwtJMuBgSVjk37fhTegCsIq5z3BvRzx7ZUwAf80hfK
         QsIUwfkbU4Hfg1uMCCx2qXPd0DSiRdNIkSLP/XZ1sC0yLKiuduhzfWrDBT+Xa47TIMBH
         4WtSpt3YZ4RtTi8/hIPA7A+Auhc2AVSyvlJfNBUUEe22l3ALH0WRRYOhMUb3Y+W+iaqR
         TOeVSHp5c38bmP3DPQUX8Jv5Og/vxoWlE8Qem5uZPDDglxknBVe5U+/+WLvivQmUYyU9
         ktYA==
X-Gm-Message-State: AOAM533q+PDMQVj5GTZA8LIhyI5vQXyGMgPLYkIRA3s52kemh5GhHxR8
        OSerR/+f945gnmIfU9Wd90k=
X-Google-Smtp-Source: ABdhPJxbkatffN2NdQfvVb8GL6t7oz55edCNarBDIyq8u8iv+IFT4WDTO8j5qwIv7QK0j/7lzdDVqw==
X-Received: by 2002:adf:e0d1:: with SMTP id m17mr9870192wri.233.1628246553431;
        Fri, 06 Aug 2021 03:42:33 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id x9sm12066410wmj.41.2021.08.06.03.42.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Aug 2021 03:42:33 -0700 (PDT)
Subject: Re: [PATCH] mmc: mediatek: add wait dma stop done flow
To:     Derong Liu <derong.liu@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsp_upstream@mediatek.com, Peng Zhou <peng.zhou@mediatek.com>
References: <20210806023055.29524-1-derong.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <dae1e028-d817-aba3-cc11-546a07865cda@gmail.com>
Date:   Fri, 6 Aug 2021 12:42:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210806023055.29524-1-derong.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks for your patch.

On 06/08/2021 04:30, Derong Liu wrote:
> From: mtk13858 <derong.liu@mediatek.com>
> 
> it needs to wait for dma stop done after set dma stop.
> 

Please provide a better commit message. Which bug do you see on which SoC? Are
you sure you can apply that to all SoC without breaking stuff?

> Signed-off-by: mtk13858 <derong.liu@mediatek.com>

Full name please.

Regards,
Matthias

> ---
>  drivers/mmc/host/mtk-sd.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..1dfd2842471b 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -2339,6 +2339,8 @@ static void msdc_cqe_disable(struct mmc_host *mmc, bool recovery)
>  	if (recovery) {
>  		sdr_set_field(host->base + MSDC_DMA_CTRL,
>  			      MSDC_DMA_CTRL_STOP, 1);
> +		while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
> +			cpu_relax();
>  		msdc_reset_hw(host);
>  	}
>  }
> 
