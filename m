Return-Path: <SRS0=F8Hu=5Y=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E024C2D0EA
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 07:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED8EE2075E
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Apr 2020 07:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="CJM8hBIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgDHHW1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:22:27 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:30771 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDHHW1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2020 03:22:27 -0400
Received: from grover.flets-west.jp (softbank126125134031.bbtec.net [126.125.134.31]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 0387L6nF022210;
        Wed, 8 Apr 2020 16:21:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0387L6nF022210
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1586330468;
        bh=qUjbnQwwFsW5BDx+0XFBZvxfo0YILRG7lsOhsa6lmXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJM8hBIQHM5yg9Fgv/XaRVgl4w2vJrDrV36EYgJd7/9tq1pNrLovoR8ezfETs2oi3
         ZwHQa3LYuo9k+K7Lq9sr8JLd9dSfAaBAlLXH7aAfdq+stE0nBf2TNe7W1egbc4gUhE
         o7lzmgj+kHs98WGrLrJl6XMdfiKnxg2dyrHbykjxjSipiE4fy6bm/5aGqWblTBIONF
         zlRae7/BD6OQQwzRg0WJ4az5cVLGnhP5E1TAemV0XBNkEiQuOuaPelab50FNG06J6M
         /+14ZXJ1ffCTWwy1+FekMp96WB1Rxu2dKOOFz8k00+OBMMcVyLSX3Hq/hcy7UmxgZX
         poxbyc51XVUdg==
X-Nifty-SrcIP: [126.125.134.31]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     linux-mmc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fabio Estevam <festevam@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] mmc: sdhci: use FIELD_GET/PREP for capabilities bit masks
Date:   Wed,  8 Apr 2020 16:21:05 +0900
Message-Id: <20200408072105.422-2-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408072105.422-1-yamada.masahiro@socionext.com>
References: <20200408072105.422-1-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Use FIELD_GET and FIELD_PREP to get access to the register fields.
Delete the shift macros. I used GENMASK() for touched macros.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-esdhc-imx.c |  4 +++-
 drivers/mmc/host/sdhci-of-at91.c   |  5 +++--
 drivers/mmc/host/sdhci-pci-core.c  |  8 ++------
 drivers/mmc/host/sdhci.c           | 19 +++++++------------
 drivers/mmc/host/sdhci.h           | 17 ++++++-----------
 5 files changed, 21 insertions(+), 32 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 5ec8e4bf1ac7..38cd83118082 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -8,6 +8,7 @@
  *   Author: Wolfram Sang <kernel@pengutronix.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/delay.h>
@@ -399,7 +400,8 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 				val = SDHCI_SUPPORT_DDR50 | SDHCI_SUPPORT_SDR104
 					| SDHCI_SUPPORT_SDR50
 					| SDHCI_USE_SDR50_TUNING
-					| (SDHCI_TUNING_MODE_3 << SDHCI_RETUNING_MODE_SHIFT);
+					| FIELD_PREP(SDHCI_RETUNING_MODE_MASK,
+						     SDHCI_TUNING_MODE_3);
 
 			if (imx_data->socdata->flags & ESDHC_FLAG_HS400)
 				val |= SDHCI_SUPPORT_HS400;
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index c79bff5e2280..25f4e0f4f53b 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -6,6 +6,7 @@
  *		 2015 Ludovic Desroches <ludovic.desroches@atmel.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -179,9 +180,9 @@ static int sdhci_at91_set_clks_presets(struct device *dev)
 	clk_mul = gck_rate / clk_base_rate - 1;
 
 	caps0 &= ~SDHCI_CLOCK_V3_BASE_MASK;
-	caps0 |= (clk_base << SDHCI_CLOCK_BASE_SHIFT) & SDHCI_CLOCK_V3_BASE_MASK;
+	caps0 |= FIELD_PREP(SDHCI_CLOCK_V3_BASE_MASK, clk_base);
 	caps1 &= ~SDHCI_CLOCK_MUL_MASK;
-	caps1 |= (clk_mul << SDHCI_CLOCK_MUL_SHIFT) & SDHCI_CLOCK_MUL_MASK;
+	caps1 |= FIELD_PREP(SDHCI_CLOCK_MUL_MASK, clk_mul);
 	/* Set capabilities in r/w mode. */
 	writel(SDMMC_CACR_KEY | SDMMC_CACR_CAPWREN, host->ioaddr + SDMMC_CACR);
 	writel(caps0, host->ioaddr + SDHCI_CAPABILITIES);
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 525de2454a4d..a98c9476bfc8 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -249,12 +249,8 @@ static int ricoh_probe(struct sdhci_pci_chip *chip)
 static int ricoh_mmc_probe_slot(struct sdhci_pci_slot *slot)
 {
 	slot->host->caps =
-		((0x21 << SDHCI_TIMEOUT_CLK_SHIFT)
-			& SDHCI_TIMEOUT_CLK_MASK) |
-
-		((0x21 << SDHCI_CLOCK_BASE_SHIFT)
-			& SDHCI_CLOCK_BASE_MASK) |
-
+		FIELD_PREP(SDHCI_TIMEOUT_CLK_MASK, 0x21) |
+		FIELD_PREP(SDHCI_CLOCK_BASE_MASK, 0x21) |
 		SDHCI_TIMEOUT_CLK_UNIT |
 		SDHCI_CAN_VDD_330 |
 		SDHCI_CAN_DO_HISPD |
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3f716466fcfd..344a7e0e33fe 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -4117,11 +4117,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 	}
 
 	if (host->version >= SDHCI_SPEC_300)
-		host->max_clk = (host->caps & SDHCI_CLOCK_V3_BASE_MASK)
-			>> SDHCI_CLOCK_BASE_SHIFT;
+		host->max_clk = FIELD_GET(SDHCI_CLOCK_V3_BASE_MASK, host->caps);
 	else
-		host->max_clk = (host->caps & SDHCI_CLOCK_BASE_MASK)
-			>> SDHCI_CLOCK_BASE_SHIFT;
+		host->max_clk = FIELD_GET(SDHCI_CLOCK_BASE_MASK, host->caps);
 
 	host->max_clk *= 1000000;
 	if (host->max_clk == 0 || host->quirks &
@@ -4139,8 +4137,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * In case of Host Controller v3.00, find out whether clock
 	 * multiplier is supported.
 	 */
-	host->clk_mul = (host->caps1 & SDHCI_CLOCK_MUL_MASK) >>
-			SDHCI_CLOCK_MUL_SHIFT;
+	host->clk_mul = FIELD_GET(SDHCI_CLOCK_MUL_MASK, host->caps1);
 
 	/*
 	 * In case the value in Clock Multiplier is 0, then programmable
@@ -4173,8 +4170,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->f_max = max_clk;
 
 	if (!(host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)) {
-		host->timeout_clk = (host->caps & SDHCI_TIMEOUT_CLK_MASK) >>
-					SDHCI_TIMEOUT_CLK_SHIFT;
+		host->timeout_clk = FIELD_GET(SDHCI_TIMEOUT_CLK_MASK, host->caps);
 
 		if (host->caps & SDHCI_TIMEOUT_CLK_UNIT)
 			host->timeout_clk *= 1000;
@@ -4326,8 +4322,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
 
 	/* Initial value for re-tuning timer count */
-	host->tuning_count = (host->caps1 & SDHCI_RETUNING_TIMER_COUNT_MASK) >>
-			     SDHCI_RETUNING_TIMER_COUNT_SHIFT;
+	host->tuning_count = FIELD_GET(SDHCI_RETUNING_TIMER_COUNT_MASK,
+				       host->caps1);
 
 	/*
 	 * In case Re-tuning Timer is not disabled, the actual value of
@@ -4337,8 +4333,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		host->tuning_count = 1 << (host->tuning_count - 1);
 
 	/* Re-tuning mode supported by the Host Controller */
-	host->tuning_mode = (host->caps1 & SDHCI_RETUNING_MODE_MASK) >>
-			     SDHCI_RETUNING_MODE_SHIFT;
+	host->tuning_mode = FIELD_GET(SDHCI_RETUNING_MODE_MASK, host->caps1);
 
 	ocr_avail = 0;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b786b68e0302..d7f1441b0fc3 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -200,12 +200,10 @@
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
-#define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
-#define  SDHCI_TIMEOUT_CLK_SHIFT 0
+#define  SDHCI_TIMEOUT_CLK_MASK		GENMASK(5, 0)
 #define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
-#define  SDHCI_CLOCK_BASE_MASK	0x00003F00
-#define  SDHCI_CLOCK_V3_BASE_MASK	0x0000FF00
-#define  SDHCI_CLOCK_BASE_SHIFT	8
+#define  SDHCI_CLOCK_BASE_MASK		GENMASK(13, 8)
+#define  SDHCI_CLOCK_V3_BASE_MASK	GENMASK(15, 8)
 #define  SDHCI_MAX_BLOCK_MASK	0x00030000
 #define  SDHCI_MAX_BLOCK_SHIFT  16
 #define  SDHCI_CAN_DO_8BIT	0x00040000
@@ -227,13 +225,10 @@
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
-#define  SDHCI_RETUNING_TIMER_COUNT_MASK	0x00000F00
-#define  SDHCI_RETUNING_TIMER_COUNT_SHIFT	8
+#define  SDHCI_RETUNING_TIMER_COUNT_MASK	GENMASK(11, 8)
 #define  SDHCI_USE_SDR50_TUNING			0x00002000
-#define  SDHCI_RETUNING_MODE_MASK		0x0000C000
-#define  SDHCI_RETUNING_MODE_SHIFT		14
-#define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
-#define  SDHCI_CLOCK_MUL_SHIFT	16
+#define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
+#define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
 #define  SDHCI_CAN_DO_ADMA3	0x08000000
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
-- 
2.17.1

