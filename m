Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C154C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388232AbiDUN6E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388212AbiDUN6D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:58:03 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87E11164
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:13 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so8841052lfg.7
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1m4AunmkAyYhQRZKtO3MCeckkXGo7/NFOomuxmIZ6A=;
        b=NVmtpNbCAgcU4SAhBqvakdaIXemPxcZFwtW3Qhbc8JoUcLt9FPdViNgk+2srrxDCzI
         4ADj7w/uL94/xdK5X9XHHN8ROeXVEOiiT1Det4GzxGpUy8FGZz6rAkENZzCQDFiyXey9
         Uhk1Qwi/5s6lfP9t5YIHYwk/AkPsnuiXLg94gFwmhLL36qbwxDHgxNWPc6SHstxxVoxL
         r2PGSadZxcgopPoWesIbtr+ld615brFPNd5pUZIIp6a4AJTBD8BJ71FwVvbx5qVGGHm0
         MhL3iEnWfCjtpsSujnP41Vst/s0eDeWBt4gWeb5dTCGKQE2GkarZl5ZxN5RzJy8vyi9H
         fQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1m4AunmkAyYhQRZKtO3MCeckkXGo7/NFOomuxmIZ6A=;
        b=BFsT1NTK3OVWahtyLPfP40LwnOMbc4vl/6gKD4Xle6SanlikUTEJCHPJk2t3Qs2ZD9
         z4Fmpfb7kIRyZbJPvz8oCIb6UHchSSFkkG7pQ6GW9SoKZqq8Q22qeGMTWEurr5GwvoUN
         jT2vJQW1B6woH2cFRzgfeuhGrY6PvE7o59IXuEzduBWjgUdu08g2nxZkir9e5iS7Ohjk
         GCHU8CtlbKsgyBsdAc9EbX/lnx/vn0zkU35fYRr4MzCOTM+80/V4C78io/Zi03+oU0nL
         VEMHgNL4oW6w2PelBVkt3v2vM7JkKQ66JYnin8CJ4b5AidldJ/OZE3DfjQAaHKef/Whp
         4IIQ==
X-Gm-Message-State: AOAM5320BHZ95vUhAJBuOZsrLq5eUDF5Go0LQm7rQk+448uVK93C/z+X
        CRbPmMiQify0G1OyPL6RDlogFFuCl+2z2IWcjaHF3w==
X-Google-Smtp-Source: ABdhPJxJZwSkyFQ2LUAnHhiegRCncBeXq+peJMNyNpoOU7X7k97B4t1fIdaGDEvibP3Su+8xqgyAJGPkEUeZxSCg2YE=
X-Received: by 2002:ac2:5f0b:0:b0:448:1e32:4531 with SMTP id
 11-20020ac25f0b000000b004481e324531mr19086997lfq.167.1650549312018; Thu, 21
 Apr 2022 06:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <268b3cd5-2388-2553-bdba-c72853f91aa3@gmail.com>
In-Reply-To: <268b3cd5-2388-2553-bdba-c72853f91aa3@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:35 +0200
Message-ID: <CAPDyKFoG0zHrEUUSHPVQcLu0E9qzp7GjpTmLb19J8+Zf6TJtEA@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: switch to device-managed dmam_alloc_coherent()
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 16 Apr 2022 at 01:12, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Using the device-managed version allows to simplify clean-up in probe()
> error path and remove().
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/meson-gx-mmc.c | 21 +++++----------------
>  1 file changed, 5 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 9f815cfbd..d4134b18d 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1301,8 +1301,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 /* data bounce buffer */
>                 host->bounce_buf_size = mmc->max_req_size;
>                 host->bounce_buf =
> -                       dma_alloc_coherent(host->dev, host->bounce_buf_size,
> -                                          &host->bounce_dma_addr, GFP_KERNEL);
> +                       dmam_alloc_coherent(host->dev, host->bounce_buf_size,
> +                                           &host->bounce_dma_addr, GFP_KERNEL);
>                 if (host->bounce_buf == NULL) {
>                         dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
>                         ret = -ENOMEM;
> @@ -1310,12 +1310,12 @@ static int meson_mmc_probe(struct platform_device *pdev)
>                 }
>         }
>
> -       host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> -                     &host->descs_dma_addr, GFP_KERNEL);
> +       host->descs = dmam_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> +                                         &host->descs_dma_addr, GFP_KERNEL);
>         if (!host->descs) {
>                 dev_err(host->dev, "Allocating descriptor DMA buffer failed\n");
>                 ret = -ENOMEM;
> -               goto err_bounce_buf;
> +               goto err_free_irq;
>         }
>
>         mmc->ops = &meson_mmc_ops;
> @@ -1323,10 +1323,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
>
>         return 0;
>
> -err_bounce_buf:
> -       if (!host->dram_access_quirk)
> -               dma_free_coherent(host->dev, host->bounce_buf_size,
> -                                 host->bounce_buf, host->bounce_dma_addr);
>  err_free_irq:
>         free_irq(host->irq, host);
>  err_init_clk:
> @@ -1348,13 +1344,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
>         writel(0, host->regs + SD_EMMC_IRQ_EN);
>         free_irq(host->irq, host);
>
> -       dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
> -                         host->descs, host->descs_dma_addr);
> -
> -       if (!host->dram_access_quirk)
> -               dma_free_coherent(host->dev, host->bounce_buf_size,
> -                                 host->bounce_buf, host->bounce_dma_addr);
> -
>         clk_disable_unprepare(host->mmc_clk);
>         clk_disable_unprepare(host->core_clk);
>
> --
> 2.35.3
>
