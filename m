Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20417C46467
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjAPTo6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbjAPTo4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:44:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBDB2CC4A
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:55 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id x2-20020a17090a46c200b002295ca9855aso3921106pjg.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNCb69k3ByDfC6LZuX4viR5JDtj1JNUJ8FP3LJLwHLc=;
        b=UEyMdO+Nlp95F6hncj03l4VHttkKrSnrhEhJopmwZWObBfgdbgEwoyRmDPsJP16G96
         aRhzS3wRGJsG3nIHfTslrx3OoONUj0uz+Xhoj3L0z3oeupuwa6ib51/j3Pf1XuldMNVk
         O80AhHXZaI9aveuo/6LyK0LSl5cXJ4MeHMo3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNCb69k3ByDfC6LZuX4viR5JDtj1JNUJ8FP3LJLwHLc=;
        b=sA46U0m8LV8/ztbyMD+/xtfCJazy01S39CBOuiz0jML0SfKLQpd52TP44yoRS/ERED
         hOqibdUxoprpacgLX/ObvcPU7S6xFFsn5IZEdmJiqTOnhXAjvjf/KsCb4PKzIrMRCE7p
         FYqvR5+65eflmRsbAkBlaL+3eidrYd1oI9lUIn3r6nzj2auoQjyYh8x9HMDx2dTWgXGj
         b1/s0oc1fJ+pE/AtupJ+SKA2bUanLxszQHpmsq/mKUPpRbxIC64l6xvsI07lBdiCQ1N3
         SderMnjaqycnGOhY2INRG5YfOlII+Kew+A7essXBTl2ycVgW4ps/nxYXruYt08TxRCtS
         3hLg==
X-Gm-Message-State: AFqh2kp4+TxdGvFog3AqfnD6Kel3iAm67kltPq4n0IWnlNFyHWChfIlY
        poeDWgqmxVik4fV5+lAyHmd9Gw==
X-Google-Smtp-Source: AMrXdXvdrhYqD2+S0CbXDUQG4OugVDR2F26nMLV76Qw5DOgS/6/ztMxAc6DPQe4aB9e3gQ6FHIo9kg==
X-Received: by 2002:a17:903:260f:b0:194:9b5e:28d8 with SMTP id jd15-20020a170903260f00b001949b5e28d8mr809091plb.7.1673898294959;
        Mon, 16 Jan 2023 11:44:54 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001926a76e8absm19734663plr.114.2023.01.16.11.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:44:54 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v5 7/8] mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
Date:   Mon, 16 Jan 2023 11:44:00 -0800
Message-Id: <20230116194401.20372-8-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The PXA168 errata recommends that the CMD signal should be detached from
the SD bus while performing the dummy CMD0 to restart the clock.
Implement this using pinctrl states.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 3dafffaa0c6e..fc306eb1f845 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/mmc.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -45,6 +46,9 @@
 
 struct sdhci_pxav2_host {
 	struct mmc_request *sdio_mrq;
+	struct pinctrl *pinctrl;
+	struct pinctrl_state *pins_default;
+	struct pinctrl_state *pins_cmd_gpio;
 };
 
 static void pxav2_reset(struct sdhci_host *host, u8 mask)
@@ -104,6 +108,11 @@ static u32 pxav1_irq(struct sdhci_host *host, u32 intmask)
 		/* The dummy CMD0 for the SDIO workaround just completed */
 		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
 		intmask &= ~SDHCI_INT_CMD_MASK;
+
+		/* Restore MMC function to CMD pin */
+		if (pxav2_host->pinctrl && pxav2_host->pins_default)
+			pinctrl_select_state(pxav2_host->pinctrl, pxav2_host->pins_default);
+
 		sdio_mrq = pxav2_host->sdio_mrq;
 		pxav2_host->sdio_mrq = NULL;
 		mmc_request_done(host->mmc, sdio_mrq);
@@ -129,6 +138,11 @@ static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
 		/* Clock is now stopped, so restart it by sending a dummy CMD0 */
 		pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
 		pxav2_host->sdio_mrq = mrq;
+
+		/* Set CMD as high output rather than MMC function while we do CMD0 */
+		if (pxav2_host->pinctrl && pxav2_host->pins_cmd_gpio)
+			pinctrl_select_state(pxav2_host->pinctrl, pxav2_host->pins_cmd_gpio);
+
 		sdhci_writel(host, 0, SDHCI_ARGUMENT);
 		sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
 		sdhci_writew(host, SDHCI_MAKE_CMD(MMC_GO_IDLE_STATE, SDHCI_CMD_RESP_NONE),
@@ -240,6 +254,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 {
 	struct sdhci_pltfm_host *pltfm_host;
 	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
+	struct sdhci_pxav2_host *pxav2_host;
 	struct device *dev = &pdev->dev;
 	struct sdhci_host *host = NULL;
 	const struct sdhci_pxa_variant *variant;
@@ -247,11 +262,12 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	int ret;
 	struct clk *clk, *clk_core;
 
-	host = sdhci_pltfm_init(pdev, NULL, sizeof(struct sdhci_pxav2_host));
+	host = sdhci_pltfm_init(pdev, NULL, sizeof(*pxav2_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
+	pxav2_host = sdhci_pltfm_priv(pltfm_host);
 
 	clk = devm_clk_get(dev, "io");
 	if (IS_ERR(clk) && PTR_ERR(clk) != -EPROBE_DEFER)
@@ -307,6 +323,21 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	host->quirks |= variant->extra_quirks;
 	host->ops = variant->ops;
 
+	/* Set up optional pinctrl for PXA168 SDIO IRQ fix */
+	pxav2_host->pinctrl = devm_pinctrl_get(dev);
+	if (!IS_ERR(pxav2_host->pinctrl)) {
+		pxav2_host->pins_cmd_gpio = pinctrl_lookup_state(pxav2_host->pinctrl,
+								 "state_cmd_gpio");
+		if (IS_ERR(pxav2_host->pins_cmd_gpio))
+			pxav2_host->pins_cmd_gpio = NULL;
+		pxav2_host->pins_default = pinctrl_lookup_state(pxav2_host->pinctrl,
+								"default");
+		if (IS_ERR(pxav2_host->pins_default))
+			pxav2_host->pins_default = NULL;
+	} else {
+		pxav2_host->pinctrl = NULL;
+	}
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto disable_clk;
-- 
2.34.1

