Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8733DC3DA7A
	for <linux-mmc@archiver.kernel.org>; Thu, 29 Dec 2022 20:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiL2UFL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 29 Dec 2022 15:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbiL2UFJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Dec 2022 15:05:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE1E13EB5
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:08 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id j8-20020a17090a3e0800b00225fdd5007fso10213503pjc.2
        for <linux-mmc@vger.kernel.org>; Thu, 29 Dec 2022 12:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9GiNIVO9S3T0XmYGcrVLJsLr1WGPHInOFVHV7LsJK20=;
        b=b4KEaCoIxwQwZOFpCNuYpnmPK3aYfyGefR1lZnKhMnh4i3kLbVjIpQ7H8Z+2Z3aYP7
         j3S9jdBYbuj2MY/Tgcu847WkYpog9PpF84uruMJg0geEnIUUurhpGW+dP0dgOJVHIZ0+
         4Gg/NX8fwnH0tIDlbnT9Hf8Pqg9j0oWuPApwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9GiNIVO9S3T0XmYGcrVLJsLr1WGPHInOFVHV7LsJK20=;
        b=ZgNTDFKEXEQVylQGnDwsy86l7QHmQYcCDP1vqXgAvFp0WHxscvhbRvXvVZOhF0SnqW
         DRREEZqjGTS/1hwSZInazxZDDQltKlX+MvTy1BnOCNqnDH1mjgyIl8FPyFXMSEk/WomH
         Qq1Cxtwma4DR5i8Vn2CjzWSWqbRVRotw1oMck2SM/uCG/ujh1eHJdxjEdaXzG+HHlujb
         6kyMH/ubnlXwDXC/ILXIbKcSxlxKrOhHqOHChusVKGSafCtggLZaRtC1zz7I2eH1/MAc
         4hXLVYf2QNKvYnnReZlsU0NN2yi1R+xlEkjyd2HRLJBnDppX0RKWs8D9JLm+MKI+GH2l
         WV+Q==
X-Gm-Message-State: AFqh2ko0HMr9SKxSaj9tf0DOX5XVfsht/KpQQKbcId5Xy98Kx8ImTYda
        6TtTM8sNOeiTiFLMgXLUAsUFlQ==
X-Google-Smtp-Source: AMrXdXtSk9F/Vi2+G3LsvDxl9s5vw28VDM42UoWz58ANPPwl3463Zwxc0fO/Jypgm7++deZk2lJ/kw==
X-Received: by 2002:a17:902:8647:b0:192:549b:97c3 with SMTP id y7-20020a170902864700b00192549b97c3mr28424335plt.42.1672344307535;
        Thu, 29 Dec 2022 12:05:07 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902e89100b00189ac5a2340sm13438589plg.124.2022.12.29.12.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 12:05:07 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 7/8] mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
Date:   Thu, 29 Dec 2022 12:04:10 -0800
Message-Id: <20221229200411.295339-8-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229200411.295339-1-doug@schmorgal.com>
References: <20221229200411.295339-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The PXA168 errata recommends that the CMD signal should be detached from
the SD bus while performing the dummy CMD0 to restart the clock.
Implement this using pinctrl states.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 10fa9de14ad4..38edd1fcc992 100644
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
@@ -306,6 +322,21 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
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

