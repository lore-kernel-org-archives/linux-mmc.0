Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CDCC0015E
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Aug 2023 11:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234020AbjHILeg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 9 Aug 2023 07:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbjHILef (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Aug 2023 07:34:35 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C900B1BFF
        for <linux-mmc@vger.kernel.org>; Wed,  9 Aug 2023 04:34:34 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-58451f0fefeso77422877b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Aug 2023 04:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691580874; x=1692185674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n/2n5ZogMMZyo3qLs2UqGgPWW+CbAuUt5sti3TBU+Oc=;
        b=UcVJhOd/4AC1LlG8modjcyPlzl+3+k0RtTwxOH61EhmZMzehuFg073sn7U1yyGBXZM
         vekkQuDbMpjSxkao8qmZe3GXKcIzrYcayPdF+KCkdcPz1C2bkaeAsREFL6qelVG/rpzB
         KU4UkHRTsovH66DlS2MObtYQOP7AH7sp9ZOPxM8R39A6H+U0P5jU3Kphd+MSGBAp1zfl
         SnPnhyTqfGdey5U68qyXgoABB/r6/9Zqfx5VB7BkiygL/f2pigkAr4BKkJ2bKrejCZyJ
         ++nJPhmkdSdx4naIBC8DhxiCVBHZI/NtkfIlQ0BXqYA80vu3XS5vG/Vi54DwbSOyanpU
         GHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691580874; x=1692185674;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/2n5ZogMMZyo3qLs2UqGgPWW+CbAuUt5sti3TBU+Oc=;
        b=kzcWHIZc4KkZkfbqqDkfQ9TzfoCVwFyRPYqIVRmih0+pkcemltSUYMr3UbMxA0kIFw
         bjSLojy1uz7XkVhB7m/7cPyzBrDts2WhxYyC/+nfi60kCL64Ei8tW3r1v7u+envsbXe3
         Htiv5CpzqLNQR7b25Xeax+YvsFawefUCL7SmBYA1LH58f3P7XsLjr4G2fmBU8GFW1sil
         Oa6kRcPhvQ/AiDKUpe4nU9/n6CP0K0qOaabWaRcpZQ0Qr1NccidTdG/UbvCb3wst0tE0
         kxY0l6nfAD40z2plJn5JiXZez+MQKYkFi2KqyGYk+6Gkh07ro9FJ1YfQkd83yLVD3XAC
         RtqA==
X-Gm-Message-State: AOJu0Yyp99U3mMCed4mJ868fWRlCuhmLCykmeOiqDB+kGtThZsu4HXWz
        sCPlx/iYhnf3lacS/iY1U1iuYeJs/Wnw6VkhCHRRFOpsuk4mzU3c
X-Google-Smtp-Source: AGHT+IEIBDeTVUFWCcfo4DLGXKVHsb/YlflNXqbaDPvU/GE6c0fCaDJBwY1SjQ3GDqdGaaBRc5/DwLIjeeC7icGW3zA=
X-Received: by 2002:a0d:d504:0:b0:577:1533:ea95 with SMTP id
 x4-20020a0dd504000000b005771533ea95mr2431371ywd.28.1691580874027; Wed, 09 Aug
 2023 04:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230808121513.553143-1-yangyingliang@huawei.com>
In-Reply-To: <20230808121513.553143-1-yangyingliang@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 9 Aug 2023 13:33:58 +0200
Message-ID: <CAPDyKFo69HCGaMbzoiH1Xj8J8T9xBp-FmEwCX_Y5A-Wq8-y=bQ@mail.gmail.com>
Subject: Re: [PATCH -next v2] mmc: remove unnecessary set_drvdata() function
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Aug 2023 at 14:19, Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> The driver data will be cleared in device_unbind_cleanup() in driver
> core code. So the set_drvdata(..., NULL) called in remove and error
> path in probe can be removed.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
> v1 -> v2:
>   Squash into one patch.
> ---
>  drivers/mmc/core/block.c       | 1 -
>  drivers/mmc/host/moxart-mmc.c  | 2 --
>  drivers/mmc/host/sunplus-mmc.c | 1 -
>  drivers/mmc/host/via-sdmmc.c   | 2 --
>  drivers/mmc/host/wbsd.c        | 2 --
>  5 files changed, 8 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index f701efb1fa78..2d734b325287 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -3025,7 +3025,6 @@ static void mmc_blk_remove(struct mmc_card *card)
>                 pm_runtime_disable(&card->dev);
>         pm_runtime_put_noidle(&card->dev);
>         mmc_blk_remove_req(md);
> -       dev_set_drvdata(&card->dev, NULL);
>         destroy_workqueue(card->complete_wq);
>  }
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index d0d6ffcf78d4..43c2a95bc29a 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -692,8 +692,6 @@ static int moxart_remove(struct platform_device *pdev)
>         struct mmc_host *mmc = dev_get_drvdata(&pdev->dev);
>         struct moxart_host *host = mmc_priv(mmc);
>
> -       dev_set_drvdata(&pdev->dev, NULL);
> -
>         if (!IS_ERR_OR_NULL(host->dma_chan_tx))
>                 dma_release_channel(host->dma_chan_tx);
>         if (!IS_ERR_OR_NULL(host->dma_chan_rx))
> diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
> index a55a87f64d2a..e9f33976c94e 100644
> --- a/drivers/mmc/host/sunplus-mmc.c
> +++ b/drivers/mmc/host/sunplus-mmc.c
> @@ -955,7 +955,6 @@ static int spmmc_drv_remove(struct platform_device *dev)
>         clk_disable_unprepare(host->clk);
>         pm_runtime_put_noidle(&dev->dev);
>         pm_runtime_disable(&dev->dev);
> -       platform_set_drvdata(dev, NULL);
>         mmc_free_host(host->mmc);
>
>         return 0;
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index a2b0d9461665..ba6044b16e07 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1160,7 +1160,6 @@ static int via_sd_probe(struct pci_dev *pcidev,
>  unmap:
>         iounmap(sdhost->mmiobase);
>  free_mmc_host:
> -       dev_set_drvdata(&pcidev->dev, NULL);
>         mmc_free_host(mmc);
>  release:
>         pci_release_regions(pcidev);
> @@ -1212,7 +1211,6 @@ static void via_sd_remove(struct pci_dev *pcidev)
>         writeb(gatt, sdhost->pcictrl_mmiobase + VIA_CRDR_PCICLKGATT);
>
>         iounmap(sdhost->mmiobase);
> -       dev_set_drvdata(&pcidev->dev, NULL);
>         mmc_free_host(sdhost->mmc);
>         pci_release_regions(pcidev);
>         pci_disable_device(pcidev);
> diff --git a/drivers/mmc/host/wbsd.c b/drivers/mmc/host/wbsd.c
> index bf2a92fba0ed..0589d169e8fb 100644
> --- a/drivers/mmc/host/wbsd.c
> +++ b/drivers/mmc/host/wbsd.c
> @@ -1264,8 +1264,6 @@ static void wbsd_free_mmc(struct device *dev)
>         del_timer_sync(&host->ignore_timer);
>
>         mmc_free_host(mmc);
> -
> -       dev_set_drvdata(dev, NULL);
>  }
>
>  /*
> --
> 2.25.1
>
