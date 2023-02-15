Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9038C636D4
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Feb 2023 20:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjBOUB6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Feb 2023 15:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBOUB6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 15:01:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E314E8C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:01:55 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id m10so11420336wrn.4
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 12:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4p/93qkHziK9obLRpx7s6x9Dm+hSwWIeNTx1UzQJzP0=;
        b=AZnqJPqMZOka5cvE6XA1KMdsK6oMOXVdbQ7FjkPlBB1BgHIhEh4r3ogIzFiaG8tsyI
         tSc8d0bryya78ZfL52bExaEBUbZdwhjYN3FkcuZMSZtajksr1XkwWc4b5osyc4py7D+o
         D/8x3LnttNM9yH7KypKgxAf8rhXkaIE7Wj1OySrNJ2PC8WnHj/IU9mTVDvKjq6QXV9wl
         i3daOcyKwwgHJUbd3Cf/fbb+pTPpR7FeW4Ibg4rzijX3ok+6Sk1W043t17vGv5elOK75
         VaGmlulcXv9+FkP03+9JILQp0adUqbAEH7tC5T+Z6DAz2NPMXo58SR3wA79/gyrcRf84
         vT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4p/93qkHziK9obLRpx7s6x9Dm+hSwWIeNTx1UzQJzP0=;
        b=p8W8PMZ1x+SkGLGAB3XEqIxMj+YTeBktb2ZpA6PJaaZToiCtfAonQDsiJD1uqvBx66
         liy0RbKr43vMrcorI1lDWR7fsJBzqzJKbt1k8k0+7ZN+d4XAtdaglJkoVg3TkSvNoILx
         NHHI/WflG8JPqWjkVw+z9JkxrpsTJwxC4AAxs4KXj99glVzIq75SyD3UnkOx1R/k/zY2
         Ae4KIOhe1bXtBJwKr2EPB9zw/NiiHvuhawj4OpgMz+MiqGvNb/WFmwMKmFbCm1xTYfId
         agBt6kWRLSfrxkNLRSsPyUsqhPWhU4BOaje8UUgwM/LTvT7qNqmzP9BE24X2w1q3ebEQ
         UnrQ==
X-Gm-Message-State: AO0yUKUKi02gywoBeEHCLoe5+OLrIN+TW98mmkeYVj8sJBYniN2FucwC
        spSKi+5Ep6KLMcg0wP7c62k=
X-Google-Smtp-Source: AK7set80hLi4T7IC40nFTB6niTVhOKpElP4k5KAJuhCtGhUbGJHMSCutnkaAQU/rTCdvZq14QTWSAg==
X-Received: by 2002:a5d:43c2:0:b0:2c3:e868:cf54 with SMTP id v2-20020a5d43c2000000b002c3e868cf54mr2575042wrr.13.1676491314038;
        Wed, 15 Feb 2023 12:01:54 -0800 (PST)
Received: from ?IPV6:2a01:c23:b9d5:9700:ccee:9a0d:2992:c73? (dynamic-2a01-0c23-b9d5-9700-ccee-9a0d-2992-0c73.c23.pool.telefonica.de. [2a01:c23:b9d5:9700:ccee:9a0d:2992:c73])
        by smtp.googlemail.com with ESMTPSA id w11-20020adff9cb000000b002c54e9f6bc2sm11892065wrr.77.2023.02.15.12.01.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:01:53 -0800 (PST)
Message-ID: <b316c6ba-a373-f1d2-27d2-9add5e25a9d2@gmail.com>
Date:   Wed, 15 Feb 2023 20:58:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] mmc: meson-gx: use devm_clk_get_enabled() for core clock
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use devm_clk_get_enabled() to simplify the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 079c52dbe..6ed95c555 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -155,7 +155,6 @@ struct meson_host {
 	struct	mmc_command	*cmd;
 
 	void __iomem *regs;
-	struct clk *core_clk;
 	struct clk *mux_clk;
 	struct clk *mmc_clk;
 	unsigned long req_rate;
@@ -1166,6 +1165,7 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct meson_host *host;
 	struct mmc_host *mmc;
+	struct clk *core_clk;
 	int cd_irq, ret;
 
 	mmc = devm_mmc_alloc_host(&pdev->dev, sizeof(struct meson_host));
@@ -1228,17 +1228,13 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		host->pins_clk_gate = NULL;
 	}
 
-	host->core_clk = devm_clk_get(&pdev->dev, "core");
-	if (IS_ERR(host->core_clk))
-		return PTR_ERR(host->core_clk);
-
-	ret = clk_prepare_enable(host->core_clk);
-	if (ret)
-		return ret;
+	core_clk = devm_clk_get_enabled(&pdev->dev, "core");
+	if (IS_ERR(core_clk))
+		return PTR_ERR(core_clk);
 
 	ret = meson_mmc_clk_init(host);
 	if (ret)
-		goto err_core_clk;
+		return ret;
 
 	/* set config to sane default */
 	meson_mmc_cfg_init(host);
@@ -1322,8 +1318,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 	free_irq(host->irq, host);
 err_init_clk:
 	clk_disable_unprepare(host->mmc_clk);
-err_core_clk:
-	clk_disable_unprepare(host->core_clk);
 	return ret;
 }
 
@@ -1338,7 +1332,6 @@ static int meson_mmc_remove(struct platform_device *pdev)
 	free_irq(host->irq, host);
 
 	clk_disable_unprepare(host->mmc_clk);
-	clk_disable_unprepare(host->core_clk);
 
 	return 0;
 }
-- 
2.39.1

