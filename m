Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1264DC432BE
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDCAD6023F
	for <linux-mmc@archiver.kernel.org>; Sun, 25 Jul 2021 09:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhGYIkX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 25 Jul 2021 04:40:23 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:53611 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhGYIkU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sun, 25 Jul 2021 04:40:20 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4GXcwx5HRhzX8;
        Sun, 25 Jul 2021 11:20:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1627204849; bh=1Dh9I3kd3eb7ekmNgoI4uO3splOMZvkaUguQIWSFtiY=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=rRAFQD/SsMTiOWCq0Bi0B0HGSG6V57HwuD7UEcYdHSYJVOEbGTCA0sh+3F6zMondr
         C2e3Yqt3hoeNv0GMEJg8VlmjZ5tFJCyvEomYtXSCDxj4RZqImYiJ6AmJeHzRki/kZE
         2TGOEvmrYAVMCNTQeSu7ivAwDTfvgzpTw5ItHWnUnNiIYh/Vr7v/gAZp7nrOJ/aMgg
         t+UcQ7Fn4KaFvyJQ+4mwS3/0mp6NWJTWSgJcL50OVaqdIMnbaDz5CIS2DqEIDPBwnW
         EnYI62ioXXQ5xonSShs4jCmoja2QWmvgbreCAhsRk79OWZR4tRZMFMzOd3MqWxD4On
         XzBBkVm6/DVLQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.2 at mail
Date:   Sun, 25 Jul 2021 11:20:49 +0200
Message-Id: <ff3907df3aa91f83a4a0a22b63d51bfe491ed039.1627204633.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
References: <cover.1627204633.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v4 4/5] mmc: sdhci: move SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN
 frequency limit
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Michal Simek <michal.simek@xilinx.com>,
        Kevin Liu <kliu5@marvell.com>,
        Suneel Garapati <suneel.garapati@xilinx.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        Al Cooper <alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Push handling of clock frequency dependence for
SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN quirk to the drivers that use it.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
v4: fix build issue reported by kernel test robot
v3: rebased on v5.14-rc2 and reworded commitmsg
v2: reworded commitmsg
---
 drivers/mmc/host/sdhci-of-arasan.c  | 11 ++++-------
 drivers/mmc/host/sdhci-of-dwcmshc.c |  8 +++++---
 drivers/mmc/host/sdhci.c            |  3 +--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 737e2bfdedc2..f2a6441ab540 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -452,8 +452,7 @@ static const struct sdhci_ops sdhci_arasan_cqe_ops = {
 static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 	.ops = &sdhci_arasan_cqe_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
 #ifdef CONFIG_PM_SLEEP
@@ -1118,7 +1117,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
@@ -1141,7 +1139,6 @@ static const struct sdhci_pltfm_data sdhci_keembay_emmc_pdata = {
 		SDHCI_QUIRK_32BIT_DMA_SIZE |
 		SDHCI_QUIRK_32BIT_ADMA_SIZE,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
 		SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
 		SDHCI_QUIRK2_STOP_WITH_TC |
 		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
@@ -1156,7 +1153,6 @@ static const struct sdhci_pltfm_data sdhci_keembay_sd_pdata = {
 		SDHCI_QUIRK_32BIT_DMA_SIZE |
 		SDHCI_QUIRK_32BIT_ADMA_SIZE,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
 		SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
 		SDHCI_QUIRK2_STOP_WITH_TC |
 		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
@@ -1171,7 +1167,6 @@ static const struct sdhci_pltfm_data sdhci_keembay_sdio_pdata = {
 		SDHCI_QUIRK_32BIT_DMA_SIZE |
 		SDHCI_QUIRK_32BIT_ADMA_SIZE,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
 		SDHCI_QUIRK2_HOST_OFF_CARD_ON |
 		SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
 };
@@ -1197,7 +1192,6 @@ static struct sdhci_arasan_of_data intel_lgm_sdxc_data = {
 static const struct sdhci_pltfm_data sdhci_arasan_zynqmp_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
 			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
@@ -1502,6 +1496,9 @@ static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 	bool dma64;
 	int ret;
 
+	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
+		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
+
 	if (!sdhci_arasan->has_cqe)
 		return sdhci_add_host(host);
 
diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index bac874ab0b33..b6b7c4068e90 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -283,14 +283,13 @@ static const struct sdhci_pltfm_data sdhci_dwcmshc_rk3568_pdata = {
 	.ops = &sdhci_dwcmshc_rk3568_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
 };
 
 static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc_priv)
 {
-	int err;
 	struct rk3568_priv *priv = dwc_priv->priv;
+	int err;
 
 	priv->rockchip_clks[0].id = "axi";
 	priv->rockchip_clks[1].id = "block";
@@ -318,6 +317,9 @@ static int dwcmshc_rk3568_init(struct sdhci_host *host, struct dwcmshc_priv *dwc
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_TXCLK);
 	sdhci_writel(host, 0, DWCMSHC_EMMC_DLL_STRBIN);
 
+	if (sdhci_pltfm_clk_get_max_clock(host) <= 25000000)
+		host->quirks2 |= SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0993f7d0ce8e..cfa314e659bc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1905,8 +1905,7 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 			/* Version 3.00 divisors must be a multiple of 2. */
 			if (host->max_clk <= clock) {
 				div = 1;
-				if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
-					&& host->max_clk <= 25000000)
+				if (host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
 					div = 2;
 			} else {
 				for (div = 2; div < SDHCI_MAX_DIV_SPEC_300;
-- 
2.30.2

