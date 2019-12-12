Return-Path: <SRS0=OcmH=2C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E87AC43603
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 07:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08506214D8
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Dec 2019 07:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbfLLHxK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:53:10 -0500
Received: from inva020.nxp.com ([92.121.34.13]:46530 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728095AbfLLHxK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 12 Dec 2019 02:53:10 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2E4471A02FE;
        Thu, 12 Dec 2019 08:53:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 01ED01A0939;
        Thu, 12 Dec 2019 08:53:06 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E23FA402B4;
        Thu, 12 Dec 2019 15:53:02 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/2] mmc: sdhci-of-esdhc: convert to use esdhc_tuning_window_ptr()
Date:   Thu, 12 Dec 2019 15:52:18 +0800
Message-Id: <20191212075219.48625-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert to use a new function esdhc_tuning_window_ptr() to
get tuning window start point and end point.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7f87a90..cd0f21e 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -882,20 +882,11 @@ static void esdhc_tuning_block_enable(struct sdhci_host *host, bool enable)
 	esdhc_clock_enable(host, true);
 }
 
-static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
+static void esdhc_tuning_window_ptr(struct sdhci_host *host, u8 *window_start,
 				    u8 *window_end)
 {
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
-	u8 tbstat_15_8, tbstat_7_0;
 	u32 val;
 
-	if (esdhc->quirk_tuning_erratum_type1) {
-		*window_start = 5 * esdhc->div_ratio;
-		*window_end = 3 * esdhc->div_ratio;
-		return;
-	}
-
 	/* Write TBCTL[11:8]=4'h8 */
 	val = sdhci_readl(host, ESDHC_TBCTL);
 	val &= ~(0xf << 8);
@@ -914,6 +905,25 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
 	val = sdhci_readl(host, ESDHC_TBSTAT);
 	val = sdhci_readl(host, ESDHC_TBSTAT);
 
+	*window_end = val & 0xff;
+	*window_start = (val >> 8) & 0xff;
+}
+
+static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
+				    u8 *window_end)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
+	u8 start_ptr, end_ptr;
+
+	if (esdhc->quirk_tuning_erratum_type1) {
+		*window_start = 5 * esdhc->div_ratio;
+		*window_end = 3 * esdhc->div_ratio;
+		return;
+	}
+
+	esdhc_tuning_window_ptr(host, &start_ptr, &end_ptr);
+
 	/* Reset data lines by setting ESDHCCTL[RSTD] */
 	sdhci_reset(host, SDHCI_RESET_DATA);
 	/* Write 32'hFFFF_FFFF to IRQSTAT register */
@@ -924,10 +934,8 @@ static void esdhc_prepare_sw_tuning(struct sdhci_host *host, u8 *window_start,
 	 * then program TBPTR[TB_WNDW_END_PTR] = 4 * div_ratio
 	 * and program TBPTR[TB_WNDW_START_PTR] = 8 * div_ratio.
 	 */
-	tbstat_7_0 = val & 0xff;
-	tbstat_15_8 = (val >> 8) & 0xff;
 
-	if (abs(tbstat_15_8 - tbstat_7_0) > (4 * esdhc->div_ratio)) {
+	if (abs(start_ptr - end_ptr) > (4 * esdhc->div_ratio)) {
 		*window_start = 8 * esdhc->div_ratio;
 		*window_end = 4 * esdhc->div_ratio;
 	} else {
-- 
2.7.4

