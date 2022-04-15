Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60637C433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Apr 2022 23:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiDOXOi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Apr 2022 19:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiDOXOh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2022 19:14:37 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC753BBE1
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2022 16:12:08 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc2so17456110ejb.12
        for <linux-mmc@vger.kernel.org>; Fri, 15 Apr 2022 16:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=EPTnUhcqYTiOpiX4Cdd1dlt3vybWZ5oAgXayn7jFUS0=;
        b=c9J2ZmChukJUKPILfJ1XwoVOwSOzEHgXi3hZRePBn8GW2a26K9GX1JZwnyXYY1SM2H
         cdOfQiBl3ow9D1OYsrIVkSMS92DMJpC1qtF6UB8GhosX47EqKLezI+Yn0qFwfdEHRb8I
         M6bhYlKIDiEzpWC2XVxRPlBUvfbG0XLE6EimbSsHCXg63RAPhPxLIbwz0wYdef9U8sDp
         l60msYcKuYAURSz4vGCCFWo7RMXdNBYD0JOg90nCMe8mBoK+/rVcenHHsnVuD/isobPT
         K5Ab0VRZrBApEaMyrzKeSZv7FlHK5S+/quUc3P0U9ocO1i2OBpG8L/rpjhKFSsk+EAJg
         h8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=EPTnUhcqYTiOpiX4Cdd1dlt3vybWZ5oAgXayn7jFUS0=;
        b=UFzaJEv4LdM0l37Dn046DY2rYGrBjpbE7FoyTa4jaHWG4aZdNhODe+PE1kPC/A7Yr3
         S5u47iDZNm2YGsjUa8seQY96mEsTJCXOaf3OlNh7eXMJq/qZBEn0xOvjpmnEoKsCTvNe
         0XOiQTubBNm48b+sfUHsPf+sqkyaxJBjuIbEwXo/8y9G+SQQgUtg1nlIAgyJJXzllzZH
         SLsBitloKng/wu+DOU8Z5Vd2XMQm0w39RJJ3+7AE6Dm97Web1E4t2mmy/qVTKVb9aeNV
         0dJOKB8d3UscJN4fZNOmlLG5uM7Gs7ErOV7Wm2kGxbIRZKlpSw2Os5HbtjPd8dCCh5q+
         dC8A==
X-Gm-Message-State: AOAM533U3FD2FALfvVGOjB7zfvfb8uriAyM8aA/gV6jV8QXeAUPHPcRj
        w66N1AC/P74RWuQ2fqGROZ0=
X-Google-Smtp-Source: ABdhPJySl3USeTNbzlkGtqhmGo1FM1w1eWuyuk8AWGxKLxFdL9mkQw8oDig8wFwYpqzOkWQ7MJnEwA==
X-Received: by 2002:a17:906:730c:b0:6ef:6d06:2a92 with SMTP id di12-20020a170906730c00b006ef6d062a92mr909477ejc.694.1650064326443;
        Fri, 15 Apr 2022 16:12:06 -0700 (PDT)
Received: from ?IPV6:2a01:c22:6faa:ed00:b906:e23f:946b:b9f7? (dynamic-2a01-0c22-6faa-ed00-b906-e23f-946b-b9f7.c22.pool.telefonica.de. [2a01:c22:6faa:ed00:b906:e23f:946b:b9f7])
        by smtp.googlemail.com with ESMTPSA id b23-20020a05640202d700b00422da9b980esm1046431edx.22.2022.04.15.16.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Apr 2022 16:12:05 -0700 (PDT)
Message-ID: <268b3cd5-2388-2553-bdba-c72853f91aa3@gmail.com>
Date:   Sat, 16 Apr 2022 01:12:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: meson-gx: switch to device-managed dmam_alloc_coherent()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Using the device-managed version allows to simplify clean-up in probe()
error path and remove().

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 9f815cfbd..d4134b18d 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1301,8 +1301,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		/* data bounce buffer */
 		host->bounce_buf_size = mmc->max_req_size;
 		host->bounce_buf =
-			dma_alloc_coherent(host->dev, host->bounce_buf_size,
-					   &host->bounce_dma_addr, GFP_KERNEL);
+			dmam_alloc_coherent(host->dev, host->bounce_buf_size,
+					    &host->bounce_dma_addr, GFP_KERNEL);
 		if (host->bounce_buf == NULL) {
 			dev_err(host->dev, "Unable to map allocate DMA bounce buffer.\n");
 			ret = -ENOMEM;
@@ -1310,12 +1310,12 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		}
 	}
 
-	host->descs = dma_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
-		      &host->descs_dma_addr, GFP_KERNEL);
+	host->descs = dmam_alloc_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
+					  &host->descs_dma_addr, GFP_KERNEL);
 	if (!host->descs) {
 		dev_err(host->dev, "Allocating descriptor DMA buffer failed\n");
 		ret = -ENOMEM;
-		goto err_bounce_buf;
+		goto err_free_irq;
 	}
 
 	mmc->ops = &meson_mmc_ops;
@@ -1323,10 +1323,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_bounce_buf:
-	if (!host->dram_access_quirk)
-		dma_free_coherent(host->dev, host->bounce_buf_size,
-				  host->bounce_buf, host->bounce_dma_addr);
 err_free_irq:
 	free_irq(host->irq, host);
 err_init_clk:
@@ -1348,13 +1344,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	writel(0, host->regs + SD_EMMC_IRQ_EN);
 	free_irq(host->irq, host);
 
-	dma_free_coherent(host->dev, SD_EMMC_DESC_BUF_LEN,
-			  host->descs, host->descs_dma_addr);
-
-	if (!host->dram_access_quirk)
-		dma_free_coherent(host->dev, host->bounce_buf_size,
-				  host->bounce_buf, host->bounce_dma_addr);
-
 	clk_disable_unprepare(host->mmc_clk);
 	clk_disable_unprepare(host->core_clk);
 
-- 
2.35.3

