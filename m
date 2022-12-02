Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2458C4708E
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 03:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231573AbiLBDOJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Dec 2022 22:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiLBDOH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Dec 2022 22:14:07 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E79D49E0
        for <linux-mmc@vger.kernel.org>; Thu,  1 Dec 2022 19:14:06 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q71so3324181pgq.8
        for <linux-mmc@vger.kernel.org>; Thu, 01 Dec 2022 19:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mC6IIMdrc2kWrH4cM3iTLyZCSKVZhI59iaav8S/Ntlo=;
        b=NljT8mvUB340mtKyCuc5NQlIOHs5veP4HYd5lNSZa7ibVKeLK7RkYp2aRkJPgFlmbo
         3Cm5sM3+bKw0VuZx2BC1btJLQz0GMo+J0Eb92jF3dRBGb7pWOUIn5A5BArWNW7llYC86
         +kBfVBBXnhWfjcdbLUFKfaAQzeN+ZH4RuzS88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mC6IIMdrc2kWrH4cM3iTLyZCSKVZhI59iaav8S/Ntlo=;
        b=hltRoMuy17twVJoBpT6ZQ9zDjOfM0Qjr0Wmbqdbnzbei4RqXTOMbA/YkLJYhLeFIuI
         S56XsXPwEFGvteeZKYxDeK//05+C8Rsvx5F5uW9Kegu0Re8TkJE5h3aq/xCOlpKk8ZQZ
         /xsq3LwftszQZpGkK4zjTGAHkXrjGFQTjH4fuGbuhGeMXGVJpOkM3RCHDsfvRbcPQu1w
         ozdBm9zmKJnqWZAzvX+SzPVaOdqsc9HFK8DPfdDCLHxZoYZvpaX6RAStNEKDLhRS6a4m
         GkyjCdN5qlrbC+cpaReZdOryPEBMtrgSrD+Pj9uC6hevvPWqeyrUhV2pKxPCpAH0v5D1
         klhw==
X-Gm-Message-State: ANoB5pkvXvKoAjuxUPs5XqS1NOv5hecyIu+UTEdb9+LgUX1FrvkeDLuM
        6lELYz9t0Q5+FDgpgJFr5J9N4w==
X-Google-Smtp-Source: AA0mqf44HNlDaySKJ7Hgc4m/csRaFmZXfLp5mSpGf3oXOINx9IQDhgV4l8C7dUd/l+9r/bgVs6EeSQ==
X-Received: by 2002:a63:5a10:0:b0:476:c39b:bd67 with SMTP id o16-20020a635a10000000b00476c39bbd67mr49312308pgb.46.1669950846093;
        Thu, 01 Dec 2022 19:14:06 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id jx24-20020a17090b46d800b00213202d77d9sm3708410pjb.43.2022.12.01.19.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 19:14:05 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 7/8] mmc: sdhci-pxav2: add optional pinctrl for SDIO IRQ workaround
Date:   Thu,  1 Dec 2022 19:13:29 -0800
Message-Id: <20221202031330.94130-8-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221202031330.94130-1-doug@schmorgal.com>
References: <20221202031330.94130-1-doug@schmorgal.com>
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
 drivers/mmc/host/sdhci-pxav2.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 912b2aad9f2e..88927549b425 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -22,6 +22,7 @@
 #include <linux/of_device.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/mmc.h>
+#include <linux/pinctrl/consumer.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -46,6 +47,9 @@
 struct sdhci_pxav2_host {
 	struct clk *clk_core;
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
 		mmc_request_done(host->mmc, pxav2_host->sdio_mrq);
 		pxav2_host->sdio_mrq = NULL;
 	}
@@ -128,6 +137,11 @@ static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
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
@@ -298,6 +312,21 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	if (match && of_device_is_compatible(dev->of_node, "mrvl,pxav1-mmc")) {
 		host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ | SDHCI_QUIRK_32BIT_DMA_SIZE;
 		host->ops = &pxav1_sdhci_ops;
+
+		/* Set up optional pinctrl for PXA168 SDIO IRQ fix */
+		pxav2_host->pinctrl = devm_pinctrl_get(&pdev->dev);
+		if (!IS_ERR(pxav2_host->pinctrl)) {
+			pxav2_host->pins_cmd_gpio = pinctrl_lookup_state(pxav2_host->pinctrl,
+									 "state_cmd_gpio");
+			if (IS_ERR(pxav2_host->pins_cmd_gpio))
+				pxav2_host->pins_cmd_gpio = NULL;
+			pxav2_host->pins_default = pinctrl_lookup_state(pxav2_host->pinctrl,
+									"default");
+			if (IS_ERR(pxav2_host->pins_default))
+				pxav2_host->pins_default = NULL;
+		} else {
+			pxav2_host->pinctrl = NULL;
+		}
 	} else {
 		host->ops = &pxav2_sdhci_ops;
 	}
-- 
2.34.1

