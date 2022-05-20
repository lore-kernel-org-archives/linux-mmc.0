Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E959C4167D
	for <linux-mmc@archiver.kernel.org>; Fri, 20 May 2022 18:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352724AbiETSb6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 20 May 2022 14:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352744AbiETSby (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2022 14:31:54 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68894344C2;
        Fri, 20 May 2022 11:31:26 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 31so8409045pgp.8;
        Fri, 20 May 2022 11:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TrVBwi9ChEStDb414/EQSVLSr7SDyZse6yMzYWxEvEo=;
        b=UBL+P3X7ctSbd7Skb4jmW1zTGbI0arseg8tprz5invYnTFI6mLJBPkwWhZHwuOrBRo
         Y7KynSP2iDw8VCXkrcbOp18wQR1aHj11ADhnppvJgiGg6POma4kKwUctl5IzIheyezy9
         JjaPLnHnR3vZZMH7WtZA0+/cVHWMbp9lRVyq1S3E7reScBmpcb5Z11qh7i6VTpJCDv3f
         +T5DaJStwAjIdtYdVw48QjyaHq3TIQi0yJgzdTz9lWL2DTeQdjzi5NmA3aOqUXvWV8hG
         HtsZKqmzAdXv3lFl6bPFQ5LQ7zwdybdB3mBS2Z4lOCvgcdJKjoAA17GGFJzJwK6tmHF4
         tisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TrVBwi9ChEStDb414/EQSVLSr7SDyZse6yMzYWxEvEo=;
        b=bUDRVA7IOge3scGcMkLoSRp38xTE5ONY4vcDTC47pBq9boMXVFjoyZ0gNyE6h25ei7
         muJ9qQWe9aZplg7fYGWHwDBz6rPkpZcEhAYt69tVXEascBwIepKZmAur52PxLHo4tcQc
         Oo3O5uiPBAgS7kIifkPzYgHcahXwt66CB29PFsCftiwQwp2uNvv1U86UvseeE8e+8FHm
         xijRKhzTPYB6jJPA/vVueY6M0b37kdHf+2dFAkjwD2CyY6auxoQR/a76Q9lYzkqfQQ8x
         L0B1W6hJDTzBW+4PYTXzyCks8/X6BZnIvNW3Kj4RqmQgmZsbU/Yybmg9CtZpGdWScFcB
         qzyA==
X-Gm-Message-State: AOAM532UFg1FDj7CoXnYsO6bipJBfq7yoe72QZEeBitbT+s828w8MxzQ
        cymn9iB/Lr250URDNC/F9tg=
X-Google-Smtp-Source: ABdhPJwBo7UF6JOo07RO6EF+qP1fWBEV2SUIBn+kEMRUBayh3o4ygeHqrkqMQBkdxaNQ0BCsm9GY1w==
X-Received: by 2002:a65:6888:0:b0:3f5:f0e3:c443 with SMTP id e8-20020a656888000000b003f5f0e3c443mr9571332pgt.396.1653071485934;
        Fri, 20 May 2022 11:31:25 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.11.250])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b0016168e90f3fsm87476pla.5.2022.05.20.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:31:25 -0700 (PDT)
From:   Kamal Dasu <kdasu.kdev@gmail.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org,
        alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v3 2/2] mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0
Date:   Fri, 20 May 2022 14:31:08 -0400
Message-Id: <20220520183108.47358-3-kdasu.kdev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520183108.47358-1-kdasu.kdev@gmail.com>
References: <20220520183108.47358-1-kdasu.kdev@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

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
 drivers/mmc/host/sdhci-brcmstb.c | 69 +++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index 8eb57de48e0c..f8dff8537920 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -31,6 +31,8 @@
 struct sdhci_brcmstb_priv {
 	void __iomem *cfg_regs;
 	unsigned int flags;
+	struct clk *base_clk;
+	u32 base_freq_hz;
 };
 
 struct brcmstb_match_priv {
@@ -250,9 +252,11 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	struct sdhci_pltfm_host *pltfm_host;
 	const struct of_device_id *match;
 	struct sdhci_brcmstb_priv *priv;
+	u32 actual_clock_mhz;
 	struct sdhci_host *host;
 	struct resource *iomem;
 	struct clk *clk;
+	struct clk *base_clk;
 	int res;
 
 	match = of_match_node(sdhci_brcm_of_match, pdev->dev.of_node);
@@ -330,6 +334,35 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 	if (match_priv->flags & BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
+	/* Change the base clock frequency if the DT property exists */
+	if (device_property_read_u32(&pdev->dev, "clock-frequency",
+				     &priv->base_freq_hz) != 0)
+		goto add_host;
+
+	base_clk = devm_clk_get_optional(&pdev->dev, "sdio_freq");
+	if (IS_ERR(base_clk)) {
+		dev_warn(&pdev->dev, "Clock for \"sdio_freq\" not found\n");
+		goto add_host;
+	}
+
+	res = clk_prepare_enable(base_clk);
+	if (res)
+		goto err;
+
+	/* set improved clock rate */
+	clk_set_rate(base_clk, priv->base_freq_hz);
+	actual_clock_mhz = clk_get_rate(base_clk) / 1000000;
+
+	host->caps &= ~SDHCI_CLOCK_V3_BASE_MASK;
+	host->caps |= (actual_clock_mhz << SDHCI_CLOCK_BASE_SHIFT);
+	/* Disable presets because they are now incorrect */
+	host->quirks2 |= SDHCI_QUIRK2_PRESET_VALUE_BROKEN;
+
+	dev_dbg(&pdev->dev, "Base Clock Frequency changed to %dMHz\n",
+		actual_clock_mhz);
+	priv->base_clk = base_clk;
+
+add_host:
 	res = sdhci_brcmstb_add_host(host, priv);
 	if (res)
 		goto err;
@@ -340,6 +373,7 @@ static int sdhci_brcmstb_probe(struct platform_device *pdev)
 err:
 	sdhci_pltfm_free(pdev);
 err_clk:
+	clk_disable_unprepare(base_clk);
 	clk_disable_unprepare(clk);
 	return res;
 }
@@ -351,11 +385,44 @@ static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 
+#ifdef CONFIG_PM_SLEEP
+static int sdhci_brcmstb_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+
+	clk_disable_unprepare(priv->base_clk);
+	return sdhci_pltfm_suspend(dev);
+}
+
+static int sdhci_brcmstb_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	ret = sdhci_pltfm_resume(dev);
+	if (!ret && priv->base_freq_hz) {
+		ret = clk_prepare_enable(priv->base_clk);
+		if (!ret)
+			ret = clk_set_rate(priv->base_clk, priv->base_freq_hz);
+	}
+
+	return ret;
+}
+#endif
+
+static const struct dev_pm_ops sdhci_brcmstb_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sdhci_brcmstb_suspend, sdhci_brcmstb_resume)
+};
+
 static struct platform_driver sdhci_brcmstb_driver = {
 	.driver		= {
 		.name	= "sdhci-brcmstb",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &sdhci_pltfm_pmops,
+		.pm	= &sdhci_brcmstb_pmops,
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
-- 
2.17.1

