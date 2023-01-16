Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866D0C67871
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjAPToy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbjAPTox (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 14:44:53 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA172CC4A
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:52 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q23-20020a17090a065700b002290913a521so12617272pje.5
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 11:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WH9Ep3uciWgkLfBeEVh7HFxTyVvCPCqhIdElzlqZypI=;
        b=lp7kZdOssvwiag2+7RvuTbYpYcK6IBTol756TLJwt+drgLeZlrksEptqLDO2TAyaWA
         T7Q2G0TRnk/CJs6P3c/WZVZsEvBlCZHF4l7FcBvEMOaR6RtFrr9IK688DTA527Mk/+9e
         E9vvRnZwkTUptPu9xt3Wnw+kBKxnz2gml2HJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WH9Ep3uciWgkLfBeEVh7HFxTyVvCPCqhIdElzlqZypI=;
        b=IkMHk7Nv7sK9U74B/e3UhTjQiJ2vVdv8KGPK+c7lj67XteiPHWh6hf2axcUjXOOPCh
         Mxb5+hdzhwzXO79zsc+NsFoq78AmkJcJifq+c+llRLxr35RMb7nUloqmCsfVROrlrI0z
         7tE2vW4e4JNWlA5+snym264iM9/jMEui+ccIQCahsOlcZW4e7t3+41G6a3pUeFDZzhcV
         5v3DliSyQumLwjytOWO+BbQ3Ln9wVlGoRWtWNq8a+3ifzklZrKcka8k9bsdOM0Chs9sk
         bdjuVhUdm/4093r66oQz3WZcfZkjl+i8ph70AEcpAoHMUB5htF5iNNts/9RP85PUOj9G
         vTBQ==
X-Gm-Message-State: AFqh2kpa/udcXMhcwB48W5VrBMNZEEq8aStPKaXmMzElf47CzwFpH2OC
        wIWpOXb9TNUljPXtNaApT6KfKA==
X-Google-Smtp-Source: AMrXdXtxosTU5MyCo7GT+yWFkfjdSfPuhQBubAD4FukTuZ2NwUt2FbGyylzJkecuzexk+KRlcpSyIw==
X-Received: by 2002:a17:902:7e47:b0:193:3215:9621 with SMTP id a7-20020a1709027e4700b0019332159621mr20647429pln.33.1673898292063;
        Mon, 16 Jan 2023 11:44:52 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001926a76e8absm19734663plr.114.2023.01.16.11.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 11:44:51 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Doug Brown <doug@schmorgal.com>
Subject: [PATCH v5 6/8] mmc: sdhci-pxav2: add SDIO card IRQ workaround for PXA168 V1 controller
Date:   Mon, 16 Jan 2023 11:43:59 -0800
Message-Id: <20230116194401.20372-7-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230116194401.20372-1-doug@schmorgal.com>
References: <20230116194401.20372-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

The PXA168 has a documented silicon bug that causes SDIO card IRQs to be
missed. Implement the first half of the suggested workaround, which
involves resetting the data port logic and issuing a dummy CMD0 to
restart the clock.

Signed-off-by: Doug Brown <doug@schmorgal.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 56 +++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 3141901e1558..3dafffaa0c6e 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -20,6 +20,8 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/mmc.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -41,6 +43,10 @@
 #define MMC_CARD		0x1000
 #define MMC_WIDTH		0x0100
 
+struct sdhci_pxav2_host {
+	struct mmc_request *sdio_mrq;
+};
+
 static void pxav2_reset(struct sdhci_host *host, u8 mask)
 {
 	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
@@ -89,6 +95,52 @@ static u16 pxav1_readw(struct sdhci_host *host, int reg)
 	return readw(host->ioaddr + reg);
 }
 
+static u32 pxav1_irq(struct sdhci_host *host, u32 intmask)
+{
+	struct sdhci_pxav2_host *pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
+	struct mmc_request *sdio_mrq;
+
+	if (pxav2_host->sdio_mrq && (intmask & SDHCI_INT_CMD_MASK)) {
+		/* The dummy CMD0 for the SDIO workaround just completed */
+		sdhci_writel(host, intmask & SDHCI_INT_CMD_MASK, SDHCI_INT_STATUS);
+		intmask &= ~SDHCI_INT_CMD_MASK;
+		sdio_mrq = pxav2_host->sdio_mrq;
+		pxav2_host->sdio_mrq = NULL;
+		mmc_request_done(host->mmc, sdio_mrq);
+	}
+
+	return intmask;
+}
+
+static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
+{
+	u16 tmp;
+	struct sdhci_pxav2_host *pxav2_host;
+
+	/* If this is an SDIO command, perform errata workaround for silicon bug */
+	if (mrq->cmd && !mrq->cmd->error &&
+	    (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
+	     mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
+		/* Reset data port */
+		tmp = readw(host->ioaddr + SDHCI_TIMEOUT_CONTROL);
+		tmp |= 0x400;
+		writew(tmp, host->ioaddr + SDHCI_TIMEOUT_CONTROL);
+
+		/* Clock is now stopped, so restart it by sending a dummy CMD0 */
+		pxav2_host = sdhci_pltfm_priv(sdhci_priv(host));
+		pxav2_host->sdio_mrq = mrq;
+		sdhci_writel(host, 0, SDHCI_ARGUMENT);
+		sdhci_writew(host, 0, SDHCI_TRANSFER_MODE);
+		sdhci_writew(host, SDHCI_MAKE_CMD(MMC_GO_IDLE_STATE, SDHCI_CMD_RESP_NONE),
+			     SDHCI_COMMAND);
+
+		/* Don't finish this request until the dummy CMD0 finishes */
+		return;
+	}
+
+	mmc_request_done(host->mmc, mrq);
+}
+
 static void pxav2_mmc_set_bus_width(struct sdhci_host *host, int width)
 {
 	u8 ctrl;
@@ -118,10 +170,12 @@ struct sdhci_pxa_variant {
 static const struct sdhci_ops pxav1_sdhci_ops = {
 	.read_w        = pxav1_readw,
 	.set_clock     = sdhci_set_clock,
+	.irq           = pxav1_irq,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = pxav2_mmc_set_bus_width,
 	.reset         = pxav2_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.request_done  = pxav1_request_done,
 };
 
 static const struct sdhci_pxa_variant __maybe_unused pxav1_variant = {
@@ -193,7 +247,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 	int ret;
 	struct clk *clk, *clk_core;
 
-	host = sdhci_pltfm_init(pdev, NULL, 0);
+	host = sdhci_pltfm_init(pdev, NULL, sizeof(struct sdhci_pxav2_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-- 
2.34.1

