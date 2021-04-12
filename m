Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943E5C433ED
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B3361360
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Apr 2021 07:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237173AbhDLHxL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Apr 2021 03:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbhDLHxK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Apr 2021 03:53:10 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55854C06138C
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:53 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id x123so5343668vsb.10
        for <linux-mmc@vger.kernel.org>; Mon, 12 Apr 2021 00:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hHG46604vXSlChJZb1OLrV0NileKsJ9CNgyqfPD+Kp0=;
        b=fL8jni8nBGpccGv+OM78lQD7ibnD3f9bB/O6HR5XkA92yB+6h/x3ZrMsdMjfNk0A3o
         Ku4OQCPkvnhkJ06wAE810evYnWbYhr5yaBeaofcqVk24ub52ay5k5ryfXEJQecn3FcF3
         nUfAZSp17PfaGdEMABz+M4FMS1V8+SmLkLrIDz/pJn1yQA5b6uiSoM0YDKHyvtEc5Ut9
         mZ0XMWvbA3ohQRKVLDQkYvOWUcRHMnMU69w1nAAXd77M9Col5yl+odNyz1IwS6ohdQTV
         5F0rdj2wYU6F67Z3YJ3x8Q8BFRHqD5xUnckOwxQJCFW9rnJHEBiz2YjaTcaD/NufNuJ8
         Em3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hHG46604vXSlChJZb1OLrV0NileKsJ9CNgyqfPD+Kp0=;
        b=bX6rVPd4IZlXW/hSVp8rMA1vrIPhFXY5v1wMGl69V0cg7J9JD7sCUh1vpd/GoLWcNE
         fzmyf2iGQD65x/uU6KLMl62kP+NlZRLFxW7RkfbuIJK68L9yts49zUFQh7GV7rxyRETK
         TTRwVqmoU4VZrDr1cYmogxI7MyBU04PY15QytaQjDdaJejoR3ZZKBcn9gbDhdRR5bAM8
         ZC3YWGodwXBjLHJVjE02XoxQDxTOz0BXSP81wLJwJuzBjgWfhKXVts0mYGxzmtP9LNLP
         nKvqT/KsM54ffT7UA+K3OVDP7bQY1uWSlKxnMQ8lrRWPCX5YprxqFumQVtODJcLHmxm/
         YLQg==
X-Gm-Message-State: AOAM53199RK2/rtJYdHQ+W1DIE5NshCreLRz5iZInnZEoujgP0EQtIe0
        0AYNNl3z4tfhPA/U516jA9/p09B/gk0NI4iFjZdIG0gkMgQ=
X-Google-Smtp-Source: ABdhPJz2BJ5ZrQEKKWp9epIQZfUXJlXLmLw1XXmWWjM6eKrP0s3FUlE2HB6N8/FbLBjzwgl6hQ/RQse313Py7BcJoHM=
X-Received: by 2002:a67:6942:: with SMTP id e63mr19266513vsc.48.1618213972555;
 Mon, 12 Apr 2021 00:52:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210409094606.4317-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210409094606.4317-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 12 Apr 2021 09:52:15 +0200
Message-ID: <CAPDyKFoM7SvSPtsL_nRbHm84ALbHd206boQhsR_VR6=KVYG=HA@mail.gmail.com>
Subject: Re: [PATCH RFT v2] mmc: renesas_sdhi: enable WAIT_WHILE_BUSY
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 9 Apr 2021 at 11:46, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Now that we got the timeout handling in the driver correct, we can use
> this capability to avoid polling via the MMC core.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> Change since v1:
> * moved wrongly set flags from tmio_flags to capabilities
>
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 4 ++--
>  drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 8 +++++---
>  2 files changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index ff97f15e317c..e8f4863d8f1a 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -97,7 +97,7 @@ static const struct renesas_sdhi_of_data of_rza2_compatible = {
>                           TMIO_MMC_HAVE_CBSY,
>         .tmio_ocr_mask  = MMC_VDD_32_33,
>         .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> -                         MMC_CAP_CMD23,
> +                         MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
>         .bus_shift      = 2,
>         .scc_offset     = 0 - 0x1000,
>         .taps           = rcar_gen3_scc_taps,
> @@ -111,7 +111,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen3_compatible = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
>                           TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
>         .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> -                         MMC_CAP_CMD23,
> +                         MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
>         .capabilities2  = MMC_CAP2_NO_WRITE_PROTECT | MMC_CAP2_MERGE_CAPABLE,
>         .bus_shift      = 2,
>         .scc_offset     = 0x1000,
> diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> index c5f789675302..ffa64211f4de 100644
> --- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
> @@ -33,12 +33,14 @@ static const struct renesas_sdhi_of_data of_rz_compatible = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_32BIT_DATA_PORT |
>                           TMIO_MMC_HAVE_CBSY,
>         .tmio_ocr_mask  = MMC_VDD_32_33,
> -       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> +                         MMC_CAP_WAIT_WHILE_BUSY,
>  };
>
>  static const struct renesas_sdhi_of_data of_rcar_gen1_compatible = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL,
> -       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
> +       .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> +                         MMC_CAP_WAIT_WHILE_BUSY,
>         .capabilities2  = MMC_CAP2_NO_WRITE_PROTECT,
>  };
>
> @@ -58,7 +60,7 @@ static const struct renesas_sdhi_of_data of_rcar_gen2_compatible = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_CLK_ACTUAL |
>                           TMIO_MMC_HAVE_CBSY | TMIO_MMC_MIN_RCAR2,
>         .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
> -                         MMC_CAP_CMD23,
> +                         MMC_CAP_CMD23 | MMC_CAP_WAIT_WHILE_BUSY,
>         .capabilities2  = MMC_CAP2_NO_WRITE_PROTECT,
>         .dma_buswidth   = DMA_SLAVE_BUSWIDTH_4_BYTES,
>         .dma_rx_offset  = 0x2000,
> --
> 2.30.0
>
