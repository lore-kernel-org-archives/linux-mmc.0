Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD60C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 13 May 2022 20:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384036AbiEMUTz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 May 2022 16:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383936AbiEMUTy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2022 16:19:54 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C2841608;
        Fri, 13 May 2022 13:19:52 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id a19so8279122pgw.6;
        Fri, 13 May 2022 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvZttYhUnQZO05Iul5VPuf2RdNy/ac1Sb29Ps74XOGg=;
        b=dCr8d2xzcHEb/GjkcDn9ZAojzAUWLNRxE8qELtBBzGupMbxdqYogWT69eStBwGl5jO
         RW/+dysJ9s3y2teQTCleZMVJrs4rCsF5CaHUUx5M+SyNglRZJYdOQwIYuhTqoNA2SLw7
         WTy5iEFleBmQh1Je/gcIFcHr52kRihX7K4nsVy4T7B69vKIveVi5+Aha3STUlOf9Vnbg
         44JijqG1wfavkFszhpG8hunbXSYcj6k9O8GDrgsUqDjM3Ykf/dz2+4B6Zv/LOxYwhR6N
         XJZn+IHpGeMqpR8XAcVS6WaH8h6t7SYHxFWTz5lEBvTG1P7r2igfxg8f1ZT+8Qbqtbwu
         IW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvZttYhUnQZO05Iul5VPuf2RdNy/ac1Sb29Ps74XOGg=;
        b=boSuZ3wwzPgU5+AfLBs5VkIs9EyzzkSetJkIhZ2BhKCi1KzHYtogYo+vxG/8cRCEvd
         oPj3kNvJtuIR/ZlCEFoX4L7YAtwgXJDRl7X/oTk+1W25xQZ2Q09R8ZLmQRG/hyO8Qquz
         670uEBS9Q4UCMbn+UZhOwKGtIZjlzVP2QvoEq9jL50o2z0OLlZXOHxAPeUMQPwsm1wVI
         zDuuS12rXIS+LNqbJRMTUwRU75/5cmCiqkKyhtock5417YpszuFAiDFBov4Dl3QzCtOn
         DMMYFo43GWX5Xt9ZH4NQg7h41sIt8U/OdDw3A1cszIVsASQ1PTqKFsy600jM7Hian99y
         Fimg==
X-Gm-Message-State: AOAM530X4TfB7SELgk0R/axJV09MO8xTyz4CavO0PjgfTq8cr4qfFhe7
        usf3dhqVhvQoG86gi/1RKL0=
X-Google-Smtp-Source: ABdhPJyClCIC5/EqwKMj94z5OEHG8u3Ck8jtsh9Dt0XyeYJaiz19WQSq2NubicQM220UOeUiEumOCQ==
X-Received: by 2002:a05:6a00:2181:b0:4f6:f1b1:1ba7 with SMTP id h1-20020a056a00218100b004f6f1b11ba7mr5976072pfi.73.1652473191575;
        Fri, 13 May 2022 13:19:51 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id b190-20020a621bc7000000b0050dc762819csm2182229pfb.118.2022.05.13.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 13:19:51 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 2/2] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
Date:   Fri, 13 May 2022 16:19:07 -0400
Message-Id: <20220513201907.36470-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513201907.36470-1-kdasu.kdev@gmail.com>
References: <20220513201907.36470-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Al Cooper <alcooperx@gmail.com>

The 72116B0 has improved SDIO controllers that allow the max clock
rate to be increased from a max of 100MHz to a max of 150MHz. The
driver will need to get the clock and increase it's default rate
and override the caps register, that still indicates a max of 100MHz.
The new clock will be named "sdio_freq" in the DT node's "clock-names"
list. The driver will use a DT property, "clock-frequency", to
enable this functionality and will get the actual rate in MHz
from the property to allow various speeds to be requested.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 8eb57de48e0c..a1ffdd3f1640 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -250,6 +250,9 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	const struct of_device_id *match;
 	struct sdhci_brcmstb_priv *priv;
+	struct clk *master_clk;
+	u32 base_clock_hz = 0;
+	u32 actual_clock_mhz;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct clk *clk;
@@ -330,6 +333,33 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	/* Change the base clock frequency if the DT property exists */
+	if (device_property_read_u32(&pdev->dev, "max-frequency",
+				     &base_clock_hz) != 0)
+		goto add_host;
+
+	master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
+	if (IS_ERR(master_clk)) {
+		dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
+		goto add_host;
+	} else {
+		res = clk_prepare_enable(master_clk);
+		if (res)
+			goto err;
+	}
+
+	/* set improved clock rate */
+	clk_set_rate(master_clk, base_clock_hz);
+	actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
+
+	host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
+	host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
+	/* Disable presets because they are now incorrect */
+	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+	dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
+		actual_clock_mhz);
+
+add_host:
 	res = sdhci_brcmstb_add_host(host, priv);
 	if (res)
 		goto err;
-- 
2.17.1

