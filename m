Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6088FEB64DC
	for <linux-mmc@archiver.kernel.org>; Mon, 17 Jul 2023 07:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjGQHeb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 17 Jul 2023 03:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGQHeb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Jul 2023 03:34:31 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFFBFE
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 00:34:29 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31590e4e27aso3774163f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jul 2023 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689579268; x=1692171268;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HVE80BIsakHaIUe7xJ4uVnZABnfVcUAOqvs/cLsR9g=;
        b=C4JnGl+DKfY6PrBhMZimj7NfmoYLtrDIBOdWgwnDxKGSElsJNdQSh4wbvDQymzqqRs
         cSrR/Cj9cpiyHPoCSsbpqV4S20Okx6E3LWIxWlERP+yH8NB1tpy+ZNrLsd30Sr9FGA0j
         zuK6VYYddUK0wI7f1M2fwChbZAss+gbS6O9tzQ2EriEajb8xzNek6VmWVIhMM+sDSRNs
         KOC1YD4H9RQtmzB0sJZ5nLEfkbS8sQUSOCs39dhVI0jPknCi6ZXMpsm8UL5S6Dmk2U2V
         sMTzy1KrIn5dPLiUmzTA4vaeY13FKZ9iYDQjNYeKZeVJGZsNc2xw02VrqLPYtZDwIi8P
         QbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689579268; x=1692171268;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HVE80BIsakHaIUe7xJ4uVnZABnfVcUAOqvs/cLsR9g=;
        b=GhIvFjTNJ2AMPGn0pVTURK3IHVT+JNLoKv6XvO9nDdBzHIGeT/iA3An2i/AbYVRVFe
         yMblW/r89NIZPP9fPoqGQCEWPS3qCkv6vz/0S4p3aq2nkRgG9EBsPHY0Qlcm8Nce4fX5
         dLI9Kq98nNdAtKz32gs5Pvrz2/bfBQ77QoqJbKCIkZSKzkMnNrjEkOjRmUHd7syDJwvI
         irAclESvkmP/SLPxSXMwbFkRy4uz+TITBRu+9+lZuw0gZ+6uFyWBO0cuhsB2+p2zrcY3
         67dvbkzRNls2sqK/qTf2VC3pFqgc0lg6XN87gS2mi+xm60/HgocgtMou1WNyQ3SeKYXG
         KeLA==
X-Gm-Message-State: ABy/qLY/pnctvWkHmbpJwKIupikoeFAmq/rG4RrGFZhGuqMpaGuAswTi
        icgnEMSRCsrX1ApDebpripMH8b8aMdAznhZsUWY=
X-Google-Smtp-Source: APBJJlH/Kj0lGIDmx2Y8Amnh1idh+fXuWVt7w6AaY4WX2pKYMbAQG7cudsBJy5Uge70tzEKKJt09nw==
X-Received: by 2002:a05:6000:1c4:b0:314:133a:f04 with SMTP id t4-20020a05600001c400b00314133a0f04mr9573160wrx.49.1689579268158;
        Mon, 17 Jul 2023 00:34:28 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p7-20020a5d6387000000b003143801f8d8sm18360184wru.103.2023.07.17.00.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 00:34:25 -0700 (PDT)
Date:   Mon, 17 Jul 2023 10:34:21 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     tonyhuang.sunplus@gmail.com
Cc:     linux-mmc@vger.kernel.org
Subject: [bug report] mmc: Add mmc driver for Sunplus SP7021
Message-ID: <a3829ed3-d827-4b9d-827e-9cc24a3ec3bc@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Tony Huang,

The patch 4e268fed8b18: "mmc: Add mmc driver for Sunplus SP7021" from
Nov 21, 2022, leads to the following Smatch static checker warning
(linux-next):

	drivers/mmc/host/sunplus-mmc.c:901 spmmc_drv_probe()
	warn: missing unwind goto?

drivers/mmc/host/sunplus-mmc.c
    859 static int spmmc_drv_probe(struct platform_device *pdev)
    860 {
    861         struct mmc_host *mmc;
    862         struct resource *res;
    863         struct spmmc_host *host;
    864         int ret = 0;
    865 
    866         mmc = mmc_alloc_host(sizeof(*host), &pdev->dev);
    867         if (!mmc) {
    868                 ret = -ENOMEM;
    869                 goto probe_free_host;

This would be better as "return -ENOMEM;" but this goto is a no-op.

    870         }
    871 
    872         host = mmc_priv(mmc);
    873         host->mmc = mmc;
    874         host->dmapio_mode = SPMMC_DMA_MODE;
    875         host->dma_int_threshold = 1024;
    876 
    877         host->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
    878         if (IS_ERR(host->base))
    879                 return PTR_ERR(host->base);

On the other hand, these should be "goto probe_free_host;"

    880 
    881         host->clk = devm_clk_get(&pdev->dev, NULL);
    882         if (IS_ERR(host->clk))
    883                 return dev_err_probe(&pdev->dev, PTR_ERR(host->clk), "clk get fail\n");

goto

    884 
    885         host->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
    886         if (IS_ERR(host->rstc))
    887                 return dev_err_probe(&pdev->dev, PTR_ERR(host->rstc), "rst get fail\n");

goto

    888 
    889         host->irq = platform_get_irq(pdev, 0);
    890         if (host->irq <= 0)
    891                 return host->irq;

This should be < 0.  Otherwise if we are handling impossible situations
we start debating whether to set the error code in the impossible case?
goto

    892 
    893         ret = devm_request_threaded_irq(&pdev->dev, host->irq,
    894                                         spmmc_irq, spmmc_func_finish_req, IRQF_SHARED,
    895                         NULL, host);
    896         if (ret)
    897                 return ret;

goto

    898 
    899         ret = clk_prepare_enable(host->clk);
    900         if (ret)
--> 901                 return dev_err_probe(&pdev->dev, ret, "failed to enable clk\n");

goto

    902 
    903         ret = mmc_of_parse(mmc);
    904         if (ret)
    905                 goto clk_disable;

Good!

    906 
    907         mmc->ops = &spmmc_ops;
    908         mmc->f_min = SPMMC_MIN_CLK;
    909         if (mmc->f_max > SPMMC_MAX_CLK)
    910                 mmc->f_max = SPMMC_MAX_CLK;
    911 
    912         ret = mmc_regulator_get_supply(mmc);
    913         if (ret)
    914                 goto clk_disable;
    915 
    916         if (!mmc->ocr_avail)
    917                 mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
    918         mmc->max_seg_size = SPMMC_MAX_BLK_COUNT * 512;
    919         mmc->max_segs = SPMMC_MAX_DMA_MEMORY_SECTORS;
    920         mmc->max_req_size = SPMMC_MAX_BLK_COUNT * 512;
    921         mmc->max_blk_size = 512;
    922         mmc->max_blk_count = SPMMC_MAX_BLK_COUNT;
    923 
    924         dev_set_drvdata(&pdev->dev, host);
    925         spmmc_controller_init(host);
    926         spmmc_set_sdmmc_mode(host);
    927         host->tuning_info.enable_tuning = 1;
    928         pm_runtime_set_active(&pdev->dev);
    929         pm_runtime_enable(&pdev->dev);
    930         ret = mmc_add_host(mmc);
    931         if (ret)
    932                 goto pm_disable;
    933 
    934         return 0;
    935 
    936 pm_disable:
    937         pm_runtime_disable(&pdev->dev);
    938 
    939 clk_disable:
    940         clk_disable_unprepare(host->clk);
    941 
    942 probe_free_host:
    943         if (mmc)
    944                 mmc_free_host(mmc);
    945 
    946         return ret;
    947 }

regards,
dan carpenter
