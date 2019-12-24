Return-Path: <SRS0=inFY=2O=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E8EC2D0CF
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 08:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C8F206CB
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Dec 2019 08:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbfLXImb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Dec 2019 03:42:31 -0500
Received: from inva021.nxp.com ([92.121.34.21]:39532 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbfLXImb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Dec 2019 03:42:31 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1763E20105A;
        Tue, 24 Dec 2019 09:42:29 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B077D20106A;
        Tue, 24 Dec 2019 09:42:26 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 64940402DA;
        Tue, 24 Dec 2019 16:42:23 +0800 (SGT)
From:   Yangbo Lu <yangbo.lu@nxp.com>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 1/2] mmc: sdhci-of-esdhc: fix esdhc_reset() for different controller versions
Date:   Tue, 24 Dec 2019 16:41:21 +0800
Message-Id: <20191224084122.25381-1-yangbo.lu@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch is to fix operating in esdhc_reset() for different
controller versions, and to add bus-width restoring after data
reset for eSDHC (verdor version <= 2.2).

Also add annotation for understanding.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index cd3b676..502e317 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -758,23 +758,53 @@ static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
-	u32 val;
+	u32 val, bus_width = 0;
 
+	/* Add delay to make sure all the DMA transfers are finished
+	 * for quirk.
+	 */
 	if (esdhc->quirk_delay_before_data_reset &&
 	    (mask & SDHCI_RESET_DATA) &&
 	    (host->flags & SDHCI_REQ_USE_DMA))
 		mdelay(5);
 
+	/* Save bus-width for eSDHC whose vendor version is 2.2
+	 * or lower for data reset.
+	 */
+	if ((mask & SDHCI_RESET_DATA) &&
+	    (esdhc->vendor_ver <= VENDOR_V_22)) {
+		val = sdhci_readl(host, ESDHC_PROCTL);
+		bus_width = val & ESDHC_CTRL_BUSWIDTH_MASK;
+	}
+
 	sdhci_reset(host, mask);
 
-	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+	/* Restore bus-width setting and interrupt registers for eSDHC
+	 * whose vendor version is 2.2 or lower for data reset.
+	 */
+	if ((mask & SDHCI_RESET_DATA) &&
+	    (esdhc->vendor_ver <= VENDOR_V_22)) {
+		val = sdhci_readl(host, ESDHC_PROCTL);
+		val &= ~ESDHC_CTRL_BUSWIDTH_MASK;
+		val |= bus_width;
+		sdhci_writel(host, val, ESDHC_PROCTL);
+
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+	}
 
-	if (mask & SDHCI_RESET_ALL) {
+	/* Some bits have to be cleaned manually for eSDHC whose spec
+	 * version is higher than 3.0 for all reset.
+	 */
+	if ((mask & SDHCI_RESET_ALL) &&
+	    (esdhc->spec_ver >= SDHCI_SPEC_300)) {
 		val = sdhci_readl(host, ESDHC_TBCTL);
 		val &= ~ESDHC_TB_EN;
 		sdhci_writel(host, val, ESDHC_TBCTL);
 
+		/* Initialize eSDHC_DLLCFG1[DLL_PD_PULSE_STRETCH_SEL] to
+		 * 0 for quirk.
+		 */
 		if (esdhc->quirk_unreliable_pulse_detection) {
 			val = sdhci_readl(host, ESDHC_DLLCFG1);
 			val &= ~ESDHC_DLL_PD_PULSE_STRETCH_SEL;
-- 
2.7.4

