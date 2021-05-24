Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BC8C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26376108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhEXOMn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbhEXOMl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:41 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E90EC061574
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:12 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id x13so14293322vsh.1
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtaxpJ3ZIqpbUxLnGdserLZmqNzbhH1N5iJJI4iZESw=;
        b=O4jM4bSYSS7J58eJ1fb121TCHbnOVl9LqBduEc7SGBX/YCXdfSI46H4Wtka1LkxRS7
         8h5kPKFQpPZcA+Ca3Rmzk7NVImyE9jZi4KUPNBd23Q44W/5sVRURZ+oTZlE9diZCsekz
         2I2M2Z4PefHOLr/5yuYaUowwknRfVV3CCpuPffOo2hSQQ5NCc8Y7seAZfU0ScrEePnQU
         1fK776YmoVWqh2nKRFv/8JY765zcPiQCPxZTrruhpPj1mTuq9GbuEAe/xQt0uN1tZdPE
         uJwHz3IrZ74D3spFamWzHnDOnclKG9UmNxZE8t+X4EjSgJKUhrmeWLGZr5rjcyyA6b8X
         gGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtaxpJ3ZIqpbUxLnGdserLZmqNzbhH1N5iJJI4iZESw=;
        b=dKoeu9Kp9k8te/Y80HvSaBjx/FQyXaxpldNxeBz3QixGP77Naqft1HuL0dRAhLOzLV
         qgPmTo5dghxVT6fvDGkLLszL/xKatjRbboqqC6Xnxi5gIWDDYT9s7CLCRJEpNcnbXSV+
         rRRXCV4zJk5sw6UDf/gR0jFRwEdUEf5i1zqKXCyf9OoteAH1XNPErKe972REYh3s9cgT
         M7wj8Fc2NHpLVsQuqqMCJDVS3Pi0uzd6X99ntSCQXaT/tF3B2rSJx+yGCPSlpzr4vbgq
         J97eF/G5T3zVD0H7qBXxylfW1fsPlEWe9j9nABZKWcsuVeCo1n2Jkx3Bngd49RR4bfm0
         yQ6Q==
X-Gm-Message-State: AOAM533j8KRkKBqDY5q5zboYL1kyqVqn+Dob8vkflZmm11V3RMgvTPri
        xcBZ73yrLg50B/HX0GaG3wnXm/qKXb4KHE0bV2LBcEvbX5divA==
X-Google-Smtp-Source: ABdhPJyJxoEXg38Ru3anDaOR89iyQH6Z608DJmvgu1cLXp9ByLGDvmMUflZvo2udH4W1HBCqQ8ERHRYs9TOLCeqKR4M=
X-Received: by 2002:a67:1087:: with SMTP id 129mr20526217vsq.42.1621865471594;
 Mon, 24 May 2021 07:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210517100900.1620-1-zbestahu@gmail.com>
In-Reply-To: <20210517100900.1620-1-zbestahu@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:33 +0200
Message-ID: <CAPDyKFoPKSCoh6udphtGY210rB-QonJF-MAT0ZQJa+kJn-o6aQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: use data instead of mrq parameter from msdc_{un}prepare_data()
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yue Hu <huyue2@yulong.com>, zbestahu@163.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 May 2021 at 12:09, Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> We already have 'mrq->data' before calling these two functions, no
> need to find it again via 'mrq->data' internally. Also remove local
> data variable accordingly.
>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 898ed1b..c4db944 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -724,10 +724,8 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
>         writel(lower_32_bits(dma->gpd_addr), host->base + MSDC_DMA_SA);
>  }
>
> -static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
> +static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
>  {
> -       struct mmc_data *data = mrq->data;
> -
>         if (!(data->host_cookie & MSDC_PREPARE_FLAG)) {
>                 data->host_cookie |= MSDC_PREPARE_FLAG;
>                 data->sg_count = dma_map_sg(host->dev, data->sg, data->sg_len,
> @@ -735,10 +733,8 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_request *mrq)
>         }
>  }
>
> -static void msdc_unprepare_data(struct msdc_host *host, struct mmc_request *mrq)
> +static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
>  {
> -       struct mmc_data *data = mrq->data;
> -
>         if (data->host_cookie & MSDC_ASYNC_FLAG)
>                 return;
>
> @@ -1140,7 +1136,7 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>
>         msdc_track_cmd_data(host, mrq->cmd, mrq->data);
>         if (mrq->data)
> -               msdc_unprepare_data(host, mrq);
> +               msdc_unprepare_data(host, mrq->data);
>         if (host->error)
>                 msdc_reset_hw(host);
>         mmc_request_done(mmc_from_priv(host), mrq);
> @@ -1311,7 +1307,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>         host->mrq = mrq;
>
>         if (mrq->data)
> -               msdc_prepare_data(host, mrq);
> +               msdc_prepare_data(host, mrq->data);
>
>         /* if SBC is required, we have HW option and SW option.
>          * if HW option is enabled, and SBC does not have "special" flags,
> @@ -1332,7 +1328,7 @@ static void msdc_pre_req(struct mmc_host *mmc, struct mmc_request *mrq)
>         if (!data)
>                 return;
>
> -       msdc_prepare_data(host, mrq);
> +       msdc_prepare_data(host, data);
>         data->host_cookie |= MSDC_ASYNC_FLAG;
>  }
>
> @@ -1340,14 +1336,14 @@ static void msdc_post_req(struct mmc_host *mmc, struct mmc_request *mrq,
>                 int err)
>  {
>         struct msdc_host *host = mmc_priv(mmc);
> -       struct mmc_data *data;
> +       struct mmc_data *data = mrq->data;
>
> -       data = mrq->data;
>         if (!data)
>                 return;
> +
>         if (data->host_cookie) {
>                 data->host_cookie &= ~MSDC_ASYNC_FLAG;
> -               msdc_unprepare_data(host, mrq);
> +               msdc_unprepare_data(host, data);
>         }
>  }
>
> --
> 1.9.1
>
