Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46863C43219
	for <linux-mmc@archiver.kernel.org>; Wed, 27 Apr 2022 18:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244676AbiD0SNO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 Apr 2022 14:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244782AbiD0SNK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2022 14:13:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B89245B5;
        Wed, 27 Apr 2022 11:09:49 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id i24so2226476pfa.7;
        Wed, 27 Apr 2022 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SC7RZFmFzY1cOQBSZIdDAHzv/8LeJtBuHEGLtHlFN68=;
        b=qpzCGKxw/occv4Nuka8IWzq7q96NZjmWekn+OP2qa4Nty8SX7WF1zE1e1B4x4tRgVJ
         u0JTdGcftj7uwIBthE117rEBdHqeAvgTGr2ttmLNqOA5588saUD4H9aAQu7JlXhm5+eH
         hs5qn12hvTorb8EKjKqOGUUBAxWx3auU2HTA/uhSSvJlKoYse5hX0GszJc56Eb40zvg2
         yy7vMUtAtscMZ4rNVhN5Paq0qM6mJjvasYgTUyC/oxLrxHUmTxxRmum1W1ZFffjqcOw6
         40m03OPCHXL0aeMj3ypX0VYluGsePdF8UjTTJHmRVhIy7p55pSV9JllHexou656CxYFn
         oj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SC7RZFmFzY1cOQBSZIdDAHzv/8LeJtBuHEGLtHlFN68=;
        b=T7agOKUUCy2oMGxktKkUiODWGNdCGndAfYw/Wk3M9UfGGUIHaGIvO8H4mCmc3Nd4vE
         oC6j7qI09+9bJZqZg4Ibb/mN05xbCtjYtMGRe0otzJ+DLTCCqfNg3niuUzTcu7Bc0RKI
         y2OjmGxs6TNTWotUK4C7VMu5nue8KQaKWOlUgqbRbOSJycVrp2urs/0gk/mfrrqcd+EN
         iViJH99w1wDwB8lD1ZkEfg716sfQIqKdw/y3htR7ySCvxGEewKurHp7d67k8ze7qASX1
         +7vRA+1serPfIWB8cqmTnCo/oSLMa9a01UCkBC5ZUrmWCduaL2YXPdO0xx3uEWNcvWhm
         02Zg==
X-Gm-Message-State: AOAM533Ha10v5nK/3xQtbr377Mzwfw8U51vQz2cjeqmbLgowIXk6uJbo
        AA6CsQFr1DWLwKvc2/qx2ww=
X-Google-Smtp-Source: ABdhPJyBfRvQK5ucNiOqjWVZwaDGd2EDnvC4GpPivMyaWL78F9cq64AYIKfXWqGw7aWexrgMeOqF6g==
X-Received: by 2002:a63:4f0b:0:b0:3a9:f4ad:6c30 with SMTP id d11-20020a634f0b000000b003a9f4ad6c30mr24900316pgb.88.1651082989059;
        Wed, 27 Apr 2022 11:09:49 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id u25-20020aa78399000000b00505f75651e7sm19076859pfm.158.2022.04.27.11.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:09:48 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v2 4/4] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
Date:   Wed, 27 Apr 2022 14:08:53 -0400
Message-Id: <20220427180853.35970-5-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220427180853.35970-1-kdasu.kdev@gmail.com>
References: <20220427180853.35970-1-kdasu.kdev@gmail.com>
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
index 683d0c685748..51a23e9f4535 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -250,6 +250,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	const struct of_device_id *match;
 	struct sdhci_brcmstb_priv *priv;
+	u32 base_clock_hz = 0;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct clk *clk;
@@ -330,6 +331,30 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	/* Change the base clock frequency if the DT property exists */
+	if (device_property_read_u32(&pdev->dev, "max-frequency",
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

