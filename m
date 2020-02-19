Return-Path: <SRS0=5cIg=4H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF92C3404D
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EBBF2464E
	for <linux-mmc@archiver.kernel.org>; Wed, 19 Feb 2020 08:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgBSIbu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:31:50 -0500
Received: from inva021.nxp.com ([92.121.34.21]:38450 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726495AbgBSIbu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 19 Feb 2020 03:31:50 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D248A203957;
        Wed, 19 Feb 2020 09:31:47 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2F77120054C;
        Wed, 19 Feb 2020 09:31:44 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AF9EA402E1;
        Wed, 19 Feb 2020 16:31:39 +0800 (SGT)
From:   haibo.chen@nxp.com
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org
Cc:     linux-imx@nxp.com, haibo.chen@nxp.com, linus.walleij@linaro.org
Subject: [PATCH v4 07/14] mmc: sdhci-esdhc-imx: optimize the clock setting
Date:   Wed, 19 Feb 2020 16:25:50 +0800
Message-Id: <1582100757-20683-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

When force clock off, check the SDOFF of register PRSSTAT to make sure
the clock is gate off. Before force clock on, check the SDSTB of register
PRSSTAT to make sure the clock is stable, this will eliminate the clock
glitch.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 24 +++++++++++++++++++++++-
 drivers/mmc/host/sdhci-esdhc.h     |  1 +
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 3359153304a3..6ca01b766604 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -312,6 +313,17 @@ static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask, u32 val, i
 	writel(((readl(base) & ~(mask << shift)) | (val << shift)), base);
 }
 
+static inline void esdhc_wait_for_card_clock_gate_off(struct sdhci_host *host)
+{
+	u32 present_state;
+	int ret;
+
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, present_state,
+				(present_state & ESDHC_CLOCK_GATE_OFF), 2, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "%s: card clock still not gate off in 100us!.\n", __func__);
+}
+
 static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -525,6 +537,8 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
 		else
 			new_val &= ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON;
 		writel(new_val, host->ioaddr + ESDHC_VENDOR_SPEC);
+		if (!(new_val & ESDHC_VENDOR_SPEC_FRC_SDCLK_ON))
+			esdhc_wait_for_card_clock_gate_off(host);
 		return;
 	case SDHCI_HOST_CONTROL2:
 		new_val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
@@ -753,12 +767,14 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 	int ddr_pre_div = imx_data->is_ddr ? 2 : 1;
 	int pre_div = 1;
 	int div = 1;
+	int ret;
 	u32 temp, val;
 
 	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val & ~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 			host->ioaddr + ESDHC_VENDOR_SPEC);
+		esdhc_wait_for_card_clock_gate_off(host);
 	}
 
 	if (clock == 0) {
@@ -813,13 +829,18 @@ static inline void esdhc_pltfm_set_clock(struct sdhci_host *host,
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
+	/* need to wait the bit 3 of the PRSSTAT to be set, make sure card clock is stable */
+	ret = readl_poll_timeout(host->ioaddr + ESDHC_PRSSTAT, temp,
+				(temp & ESDHC_CLOCK_STABLE), 2, 100);
+	if (ret == -ETIMEDOUT)
+		dev_warn(mmc_dev(host->mmc), "card clock still not stable in 100us!.\n");
+
 	if (esdhc_is_usdhc(imx_data)) {
 		val = readl(host->ioaddr + ESDHC_VENDOR_SPEC);
 		writel(val | ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 			host->ioaddr + ESDHC_VENDOR_SPEC);
 	}
 
-	mdelay(1);
 }
 
 static unsigned int esdhc_pltfm_get_ro(struct sdhci_host *host)
@@ -1003,6 +1024,7 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
 	writel(readl(host->ioaddr + ESDHC_VENDOR_SPEC) &
 		~ESDHC_VENDOR_SPEC_FRC_SDCLK_ON,
 		host->ioaddr + ESDHC_VENDOR_SPEC);
+	esdhc_wait_for_card_clock_gate_off(host);
 
 	/* force a reset on strobe dll */
 	writel(ESDHC_STROBE_DLL_CTRL_RESET,
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index 9289bb4d633e..947212f16bc6 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -31,6 +31,7 @@
 
 /* Present State Register */
 #define ESDHC_PRSSTAT			0x24
+#define ESDHC_CLOCK_GATE_OFF		0x00000080
 #define ESDHC_CLOCK_STABLE		0x00000008
 
 /* Protocol Control Register */
-- 
2.17.1

