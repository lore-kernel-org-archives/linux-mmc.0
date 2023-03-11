Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED94C6FD1F
	for <linux-mmc@archiver.kernel.org>; Sat, 11 Mar 2023 22:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCKWld (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 11 Mar 2023 17:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCKWld (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 11 Mar 2023 17:41:33 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1421B38B68
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:41:32 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id r29so136683wra.13
        for <linux-mmc@vger.kernel.org>; Sat, 11 Mar 2023 14:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678574490;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zUm1Ql4A6dJNjfOmVJq8BeI+WEiUEaG4afPfgrOMYF8=;
        b=hfUr87fRvgRB1LqgOKiiKK8wFryHTeFjxhnBFEZJvp1Doyc67cGgtTIkoJukPmW/fU
         g5gSDJooqXtvZlrG+edrx5xo0UNvu+QqJPh1+omlRzLynKLm6qk/hhLQjojfa4TvSDhP
         KPoVUWGrIuMIg8RkwrLl3e1nKeo3c5JdnJ7bO6XIivn6RsD0oGY49LJn2IWfWvsiIYYi
         XRIIY34PI/ardAPj9t1mt/u+pm8JwKA4Ey3GMIRex+7ON1oKi0M4+fzpn2TsYjVmkQmy
         FeySLn4IOKI0Y25XPhjYLQ+hD/ouQpvd+O11HeT42aAjBzkMl3DIrXyS87bCZanlLI9u
         JUXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678574490;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zUm1Ql4A6dJNjfOmVJq8BeI+WEiUEaG4afPfgrOMYF8=;
        b=fC8rm2T/RGqZbZI6EAwKcYMvwb463ike2A93VMBFBIOU7ac/57/B7T3hlAtOvXHKmZ
         rwbvnxGHaijHiiY7oljlbLh4xmxT/t2/C6U4GQVPNA3oE50MkOniVgnKBT9y+fOj2MFI
         9Dxs511j+PTdrjNh71WT9wF7tOeiRBdF9f+6kpD1zxuQIbOqNWmc9S0yxRDDv+L38cZK
         /pizuT0pH6cdFwePBUjqd5QfvNRffQ2XdNO19EbeEz7PzFd2ghv8yXS3JW6w8LQ0TvsA
         juxzLOFtK5TUN1NyyIHOq3TqXR44yojM37qqe7MzkqjbMhQ5Wr8GSH6F9Xf7JsN0vD+Q
         NBNg==
X-Gm-Message-State: AO0yUKVzbQ+uhF8SpEJPxvkzlLKqABWeY5EndMu60/Nkd7P1shY0WEFf
        lwi2RnTn6cXVNvRAmd3iW4KpBJ730LI=
X-Google-Smtp-Source: AK7set/Vm/Xkk5kfHEqPkh8r+McdnQ9cdSuz3+aw3vdYYfTd1gZJQkVRkErfnzH3SQvUEgg3zOIlYw==
X-Received: by 2002:a5d:4a8b:0:b0:2c5:5234:882c with SMTP id o11-20020a5d4a8b000000b002c55234882cmr18700423wrq.7.1678574490405;
        Sat, 11 Mar 2023 14:41:30 -0800 (PST)
Received: from ?IPV6:2a01:c22:7697:7600:79dc:4e28:a7d7:a00c? (dynamic-2a01-0c22-7697-7600-79dc-4e28-a7d7-a00c.c22.pool.telefonica.de. [2a01:c22:7697:7600:79dc:4e28:a7d7:a00c])
        by smtp.googlemail.com with ESMTPSA id y7-20020a056000108700b002ce9f0e4a8fsm3200065wrw.84.2023.03.11.14.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 14:41:30 -0800 (PST)
Message-ID: <2ceb62da-07e6-bafc-c29e-13cc1cdde93a@gmail.com>
Date:   Sat, 11 Mar 2023 23:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: [PATCH 2/2] mmc: meson-gx: use new helpers
 mmc_regulator_enable/disable_vqmmc
Content-Language: en-US
From:   Heiner Kallweit <hkallweit1@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com>
In-Reply-To: <9ae6f90e-e1ea-d088-cdae-7dd8a541f00f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use new helpers mmc_regulator_enable/disable_vqmmc to simplify
the code.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 28e04dc4e..b8514d9d5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -174,7 +174,6 @@ struct meson_host {
 
 	int irq;
 
-	bool vqmmc_enabled;
 	bool needs_pre_post_req;
 
 	spinlock_t lock;
@@ -605,11 +604,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
-
-		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled) {
-			regulator_disable(mmc->supply.vqmmc);
-			host->vqmmc_enabled = false;
-		}
+		mmc_regulator_disable_vqmmc(mmc);
 
 		break;
 
@@ -619,15 +614,7 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_ON:
-		if (!IS_ERR(mmc->supply.vqmmc) && !host->vqmmc_enabled) {
-			int ret = regulator_enable(mmc->supply.vqmmc);
-
-			if (ret < 0)
-				dev_err(host->dev,
-					"failed to enable vqmmc regulator\n");
-			else
-				host->vqmmc_enabled = true;
-		}
+		mmc_regulator_enable_vqmmc(mmc);
 
 		break;
 	}
@@ -1179,7 +1166,6 @@ static int meson_mmc_probe(struct platform_device *pdev)
 					"amlogic,dram-access-quirk");
 
 	/* Get regulators and the supported OCR mask */
-	host->vqmmc_enabled = false;
 	ret = mmc_regulator_get_supply(mmc);
 	if (ret)
 		return ret;
-- 
2.39.2


