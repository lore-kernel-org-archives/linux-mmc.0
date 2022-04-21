Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECF1C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 18:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391352AbiDUSb2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387815AbiDUSb1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 14:31:27 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5B52BCC;
        Thu, 21 Apr 2022 11:28:37 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id c12so5639722plr.6;
        Thu, 21 Apr 2022 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6OnAIDQW3sc6araWzxfXt0/VxstxyDY8VarbwsPQALo=;
        b=TQsRMtP/nSoIfo8v8k0aiH9q97snuI0PxxN5VKekSM2GFL72T/D0BDKZvEoBRavUYu
         wXViadj4adwf984bBzbx0G4uuPFE4cEgvXuE4+MsarKST9kZepjHx9/92lZMxB7CYbQr
         n0Lx0dlZ8RDj0ucYY1y9F2iQyxF77+rCOqrst9qhH0FOVOeYxgSPonURzmHmle5ygMC1
         shpGNIkYIJ4T57hbmIe/RuU34qdHEM+7Ak0POFsvRgLgBt6MAMiYDQuO6s/vc0LBAHX/
         44/QUBxEUGrJuGIodbhPoC9EKfFDNisiU/Q/CBa7+Hqzc+qU138K8vcU7wkninyIUibX
         nvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6OnAIDQW3sc6araWzxfXt0/VxstxyDY8VarbwsPQALo=;
        b=XnZdnFtIncqtaGM00lG1N8mqBk1qBzPdVgTbqxPLqEpQiSV7uD6crPpZkp+KUCyO8p
         rqWYQrgNjI8di70ZDO3WdyxYfZnWnoNOD4Bi6s/fhM73O/f1189uimFpVOovMrtbxTn3
         4kt7D+LiarDrmVTK8YCuSlO37H5u8DGhuzXs01GqJnlhkMvpta2UIMH4EOt6NELjM3gl
         pJfPkA6paQT5d50sXUlGG586ySJQoAQ5TphJCI8rwL434YhTaxvCHR1f2JTmL08AD7tO
         ObN4Dek+5BIZL5RvqHOchFpUqTuTLQI+NHrEeGPAvPgLyPxxE40g0jkQe864+31fh5Uv
         Si7A==
X-Gm-Message-State: AOAM533r9AAPR019hYK+ixNzW48JnJCQER8LXQIAdt/y96uKWsy7Wy/2
        YCcGaSTPIj/9mPzVAxNiclc=
X-Google-Smtp-Source: ABdhPJwFGCkoraljSmR3iJJhYP4RZC535JY3Pskc//6GndiqXEWP5+mUzddU84uzLixZxyedNBzL+w==
X-Received: by 2002:a17:90b:1b01:b0:1d2:ef4a:98e1 with SMTP id nu1-20020a17090b1b0100b001d2ef4a98e1mr977058pjb.163.1650565717227;
        Thu, 21 Apr 2022 11:28:37 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id s62-20020a635e41000000b003a9eb7f65absm6509333pgb.85.2022.04.21.11.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:28:36 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH 5/5] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
Date:   Thu, 21 Apr 2022 14:28:03 -0400
Message-Id: <20220421182803.6495-6-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220421182803.6495-1-kdasu.kdev@gmail.com>
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
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
 drivers/mmc/host/sdhci-brcmstb.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index d5cb3e8978b2..4f3629a8e70a 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -250,6 +250,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	const struct of_device_id *match;
 	struct sdhci_brcmstb_priv *priv;
+	uint32_t base_clock_hz = 0;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct clk *clk;
@@ -330,6 +331,30 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	/* Change the base clock frequency if the DT property exists */
+	if (device_property_read_u32(&pdev->dev, "clock-frequency",
+				     &base_clock_hz) == 0) {
+		struct clk *master_clk;
+		u32 actual_clock_mhz;
+
+		master_clk = devm_clk_get(&pdev->dev, "sdio_freq");
+		if (IS_ERR(master_clk)) {
+			dev_warn(&pdev->dev,
+				 "Clock for \"sdio_freq\" was not found\n");
+		} else {
+			clk_set_rate(master_clk, base_clock_hz);
+			actual_clock_mhz = clk_get_rate(master_clk) / 1000000;
+
+			host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
+			host->caps |=
+				(actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
+			/* Disable presets because they are now incorrect */
+			host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+			dev_dbg(&pdev->dev,
+				"Base Clock Frequency changed to %dMHz\n",
+				actual_clock_mhz);
+		}
+	}
 	res = sdhci_brcmstb_add_host(host, priv);
 	if (res)
 		goto err;
-- 
2.17.1

