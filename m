Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516DAC3DA79
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 20:05:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiL2UFC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiL2UFA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 15:05:00 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476D714D19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:00 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n4so19908199plp.1
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D6r2GlaNz1+YzI6wDR7hgOyWZe3jS4KnaVe8emuVcm0=;
        b=Jx7ayWpipJYx1V2Zz6YI+oqhOTf2hCPRcDx4+pt4+GpRUI8GjlocIDH/I55wrcAHHr
         a8xB3t7jUa22B4ke2tsyTwm4ssdu5FCXuOa0RRWMDZ6ioYakg652LoBKY0ONRPSTUJVu
         bCgq0+4w1KYw3Vu9NS+uDKc4uw452vmAUrmd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6r2GlaNz1+YzI6wDR7hgOyWZe3jS4KnaVe8emuVcm0=;
        b=a4Y4TLGUKiIwH9oIkwQhYvXDOLglX7z/dB5x2OTXeCG0E1pq9GcDMf1QMps7A56X/G
         gNrdev6gxtDWUVi5N+gAp4osmLgBUDI4qq3B8NkIAwsepwNwp2LcfdgUsvY/Mgvkw3Yv
         DzBnTeJfKT7U1i9xq7ekPb/LHhFiI47K2xXPBiTBQm33koE+DhLscOUMxfbXMdAi7h02
         sbK/3V75n54kt0p3tzGUii0ElXmiY+QCZBdG9cxDLeeNtb4TMh1TBvNHbSjU0hhdDuBH
         yQS4cJKH8EnZ5mBm+/nfJEr4897SCK3GYSVKLbKDHcP3lFeLf8iSDh03jqnaXf+I0jPH
         sVRA==
X-Gm-Message-State: AFqh2kqjIfdeXsj0EHRDlkF5aFr6AYpI15R6T4zfhVcFh6HDWJ0GVj4Y
        xJgNcuzDxjGxBC0JXuoqfXU+kk3vCf32JcYa4AIvQQ==
X-Google-Smtp-Source: AMrXdXt4jnO+nwqLg9k7tVFSzwfWxCncGvAMj63+hcAjF+UdoJLLIOYqMk/fR+q22DFODXF5DWdjmg==
X-Received: by 2002:a17:902:e74a:b0:192:8e0b:23d3 with SMTP id p10-20020a170902e74a00b001928e0b23d3mr14138994plf.23.1672344299598;
        Thu, 29 Dec 2022 12:04:59 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b00189ac5a2340sm13438589plg.124.2022.12.29.12.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:04:59 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 4/8] mmc: sdhci-pxav2: change clock name to match DT bindings
Date:   Thu, 29 Dec 2022 12:04:07 -0800
Message-Id: <20221229200411.295339-5-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229200411.295339-1-doug@schmorgal.com>
References: <20221229200411.295339-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The devicetree bindings for this driver specify that the two allowed
clock names are io and core. Change this driver to look for io, but
allow any name if it fails for backwards compatibility. Follow the same
pattern used in sdhci-pxav3, but add support for EPROBE_DEFER.

Get rid of an unnecessary pdev->dev while we're at it.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 5e01dab94426..f5c86e1ba734 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -199,16 +199,18 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
 	pltfm_host = sdhci_priv(host);
 
-	clk = devm_clk_get(dev, "PXA-SDHCLK");
+	clk = devm_clk_get(dev, "io");
+	if (IS_ERR(clk) && PTR_ERR(clk) != -EPROBE_DEFER)
+		clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get io clock\n");
 		ret = PTR_ERR(clk);
+		dev_err_probe(dev, ret, "failed to get io clock\n");
 		goto free;
 	}
 	pltfm_host->clk = clk;
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to enable io clock\n");
+		dev_err(dev, "failed to enable io clock\n");
 		goto free;
 	}
 
-- 
2.34.1

