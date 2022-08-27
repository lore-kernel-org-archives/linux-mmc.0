Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC606ECAAD5
	for <linux-mmc@archiver.kernel.org>; Sat, 27 Aug 2022 20:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiH0UFx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 27 Aug 2022 16:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiH0UFw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Aug 2022 16:05:52 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D010474F1
        for <linux-mmc@vger.kernel.org>; Sat, 27 Aug 2022 13:05:51 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id f24so1744424plr.1
        for <linux-mmc@vger.kernel.org>; Sat, 27 Aug 2022 13:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc;
        bh=ADQPZHg3QwYPfT4wduph8wBYMiEMQoZJzpTw2u3Edmw=;
        b=WKyJ419VIwn7Q8wMCHQ1QrR++WttZ+PVvBaJVQX56LPhEyjt5236T7Zl03us8UHFs1
         3Qe7sE7eragqYRSNCE5UBHT3QCZH7Thyxqzj1ugjW65bGfPYb5JvWoQnJytRPwE90jyV
         WGtKaCECq1nXt/JKZf3F4JySwc+gpjXcECvaaZvXAracG9I2dbJrDZhVC44hi8gHF110
         Nw0BtfnmpSYthcEKlpVpeXIWWbsUgOvmpfgwNhbj5U1L/ta70JIyfscan+1iCnUqUhe1
         ZFXlTX+7UMd7raGyeYK3CgYHrWQJGnmr9Cq1ozJmIMxY874XvU1zLI9DATXdUvO5DWtK
         8+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=ADQPZHg3QwYPfT4wduph8wBYMiEMQoZJzpTw2u3Edmw=;
        b=xeH+AF8CGvhqpFvcG1yzr5gejW0PwA6HIiziTvCHNJklbWTaHrrHaLk5m6QhGBkmYO
         g5zqFxq4TOKyK9nX+5nkC6Vr+W5o7JJlFnl69usqgwBNcsy8kOpMFq8D3ahL+9lfZmH1
         gz3ima5fjqveT5e+xVeG++hkIWvLOec1/HwT0DCraDG3DOqarfylz+s8lGLy4yvAkmMm
         hpL6gUDo1XpBxJD0i2OzAtwvPTz7uhWYtsi5h+9mUeCqGZ+WX2qKe8ukuQGKOYcUazcT
         2bm18y+CVMQpQ/I0WWwkVZLXG2hGNfXPoft2xZ5AV8TU+Ri6G+ZAZqDcaMHn8qP3Hir4
         G8GA==
X-Gm-Message-State: ACgBeo2teO2l4vWudBxje/t2FzckUNHzdBIiosI9t0nebD2dW0jnv9ln
        17xTEjTLBsoI6em5g4slaic=
X-Google-Smtp-Source: AA6agR4GKef5Mf5Rhd/bsIhkp3PXen6Ot4K+43kYGZNaoNBg7jFRQv3zbynSi4EFjGQtz/zbzWV2NQ==
X-Received: by 2002:a17:90b:17ce:b0:1f4:d068:5722 with SMTP id me14-20020a17090b17ce00b001f4d0685722mr10599441pjb.28.1661630749876;
        Sat, 27 Aug 2022 13:05:49 -0700 (PDT)
Received: from x1 ([2601:1c2:1002:ab0:5155:d5df:1020:5344])
        by smtp.gmail.com with ESMTPSA id z75-20020a63334e000000b0041a67913d5bsm3496678pgz.71.2022.08.27.13.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 13:05:48 -0700 (PDT)
Date:   Sat, 27 Aug 2022 13:07:16 -0700
From:   Drew Fustini <pdp7pdp7@gmail.com>
To:     Jisheng Zhang <jszhang@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-mmc@vger.kernel.org
Subject: Designware MSHC: dw_mmc versus sdhci-of-dwcmshc?
Message-ID: <Ywp5dA3iQLZu/+2d@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello, I am bringing up Linux on an SoC which has Synopsys "DesignWare
Cores Mobile Storage Host Controller (Cryptographic)" IP configured to
support an eMMC 5.0 device (IS21ES08G) on the bring-up board. I am
trying to figure out why there are two seemingly similar drivers,
dw_mmc and sdhci-of-dwmshc, in drivers/mmc/host for Synopsys
DesignWare host controller IP. I am hoping someone might be able to
give me some insight into the history of these drivers.

I have found the following:

- dw_mmc.c is a "DW Multimedia Card Interface driver"
- created back in 2011 with f95f3850f7a9 ("mmc: dw_mmc: Add Synopsys
DesignWare mmc host driver.")
- CONFIG_MMC_DW  refers to it as "Synopsys DesignWare Memory Card
Interface" with description of "Synopsys DesignWare Mobile Storage IP
block, this provides host support for SD and MMC interfaces, in both
PIO, internal DMA mode and external DMA mode"
- "snps,dw-mshc" compatible supported in dw_mmc-pltfm.c and
synopsys-dw-mshc.yaml binding refers to it as "Synopsys Designware
Mobile Storage Host Controller"

- sdhci-of-dwcmshc.c is a "SDHCI platform driver for Synopsys DWC MSHC"
- created more recently in 2018 with e438cf49b305 ("mmc:
sdhci-of-dwcmshc: add SDHCI OF Synopsys DWC MSHC driver")
- CONFIG_MMC_SDHCI_OF_DWCMSHC refers to it as "SDHCI OF support for
the Synopsys DWC MSHC" with description of "Synopsys DesignWare Cores
Mobile Storage Controller support."
- the driver supports "snps,dwcmshc-sdhci" compatible and the
snps,dwcmshc-sdhci.yaml binding describes it as "Synopsys Designware
Mobile Storage Host Controller"

I would greatly appreciate any advice anyone may have on which driver
might be the best fit.

Thank you,
Drew
