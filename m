Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62637CDB474
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Oct 2023 11:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjJQLfJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Oct 2023 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbjJQLfI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Oct 2023 07:35:08 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB259F
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 04:35:06 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d84c24a810dso6507494276.2
        for <linux-mmc@vger.kernel.org>; Tue, 17 Oct 2023 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697542506; x=1698147306; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh+5aQU0pWh4M7KFBM2yAImrXdsiEPZTnqVA8vzwMs4=;
        b=eW0YDAW2YSLpZjyx6JZEEeogo/XdoINkNTPHfyWzziwmx4mnRTEPPtsDv+xGx76G1o
         z4n/xnybWBA4Il5VetUImLFrG8GYU95QROw7AYHGF0BJJidkKzmc8IFfSPsCCjQnY7I1
         95rcoT5jjC+dNOoi4lry01bFIbQhU/qQS8JMtvnkzNT2NnmOxTD85bOV5XFpa7Yx5Am+
         TCrNoogpJGib1jEKIw/YYAjmn3gHd5zCi5Y4q83baKraLGeMSBcfJqSG7HJzUF6SsqUQ
         qUtSW9tYftCY5HIRRlGqi9DcF6b0ecs14YKrDExqaJOBxYh8CoR9bb/v1bUtMO1peomh
         11JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697542506; x=1698147306;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh+5aQU0pWh4M7KFBM2yAImrXdsiEPZTnqVA8vzwMs4=;
        b=F2WJKlDc+BFumddFAhMSykBm4rQEzgidGmUlrk11sToePOzEp5KH1ggdrH9uTNE0MC
         p2I8lLp/apkLXHJ7qp8dXwQUexKnom1YrL5HewSNUGV4OdamAhgvnbRxFfKvI1sQVeoX
         kH52trY5wNcZbEmQSSux4yayHaHfxQZMdHfOTEqQF4elAcUiW4UdJ8IBUhI3rCSt2neY
         svFWhSq8k3BGelnEmS+8E0bP01qXH50/vpmBVuSAKVYyFozdTp1h/GKrDchsSryDeD9g
         C+ajqf1RGcJz9Sjo17Q+2wpM6i0jhnIT6Tu6FUdw7Vd/0lWc7yY9WQmCQ68/J202j3R6
         JJWg==
X-Gm-Message-State: AOJu0Yx+ckJK21Ah1TxPq2Kucesgq6xUibjtGOPzCnGs2zm2l3gBhllD
        2AthKZpdJAmcOUdptNrWud2dMeJ6LRGUtETp3BOkJP/go4MDCGf2G9Q=
X-Google-Smtp-Source: AGHT+IGHdjJGGj0qOIsIHXU7mAj9gkYSebk88P1C0BYV3GvOngTvN/VwF0VvcpRKS5V4O53REvIJzXBcmxAK8iZXhI8=
X-Received: by 2002:a25:ec09:0:b0:d78:6f1:41b4 with SMTP id
 j9-20020a25ec09000000b00d7806f141b4mr1627528ybh.30.1697542506166; Tue, 17 Oct
 2023 04:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231017073129.1406748-1-haibo.chen@nxp.com>
In-Reply-To: <20231017073129.1406748-1-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 17 Oct 2023 13:34:30 +0200
Message-ID: <CAPDyKFrffRvM51ZSzEffH9iHOWr7A0tu_e7aub7GiXdG49-iNA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-esdhc-imx: let usr to config the wakeup
 for gpio cd pin through sysfs
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 17 Oct 2023 at 09:26, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Currently default enable the gpio cd pin wakeup, this will waste
> power after system suspend if usr do not need this cd pin wakeup
> feature. Now let usr to config the wakeup for gpio cd pin through
> sysfs.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index 40a6e2f8145a..2e46648344ba 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -1797,9 +1797,12 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>         /*
>          * Setup the wakeup capability here, let user to decide
>          * whether need to enable this wakeup through sysfs interface.
> +        * First check the SDIO device, second check the gpio CD pin.
>          */
> -       if ((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> -                       (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ))
> +       if (((host->mmc->pm_caps & MMC_PM_KEEP_POWER) &&
> +                       (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)) ||
> +           ((host->mmc->caps & MMC_CAP_CD_WAKE) &&
> +                        host->mmc->slot.cd_irq >= 0))
>                 device_set_wakeup_capable(&pdev->dev, true);

If the wakeup is GPIO based, it doesn't mean that the device is wakeup
capable, so this is wrong.

In principle this must be managed through the GPIO irqchip driver instead.

>
>         pm_runtime_set_active(&pdev->dev);
> @@ -1878,7 +1881,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
>         if (ret)
>                 return ret;
>
> -       ret = mmc_gpio_set_cd_wake(host->mmc, true);
> +       if (device_may_wakeup(dev))

As I indicated above. It's not really the device that corresponds to
the mmc controller that can wake up the system, but rather the gpio
irqchip.

> +               ret = mmc_gpio_set_cd_wake(host->mmc, true);
>
>         return ret;
>  }
> @@ -1901,8 +1905,10 @@ static int sdhci_esdhc_resume(struct device *dev)
>
>         if (host->mmc->caps2 & MMC_CAP2_CQE)
>                 ret = cqhci_resume(host->mmc);
> +       if (ret)
> +               return ret;
>
> -       if (!ret)
> +       if (device_may_wakeup(dev))

Ditto.

>                 ret = mmc_gpio_set_cd_wake(host->mmc, false);
>
>         return ret;
> --
> 2.34.1
>

Kind regards
Uffe
