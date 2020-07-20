Return-Path: <SRS0=h0nN=A7=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F7C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 06:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14BA21775
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jul 2020 06:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="J7C/fXyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgGTG1t (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:27:49 -0400
Received: from condef-05.nifty.com ([202.248.20.70]:17566 "EHLO
        condef-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgGTG1t (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jul 2020 02:27:49 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jul 2020 02:27:48 EDT
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-05.nifty.com with ESMTP id 06K6CTPX019132
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jul 2020 15:12:29 +0900
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 06K6Bt9l014925;
        Mon, 20 Jul 2020 15:11:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 06K6Bt9l014925
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595225516;
        bh=ajfXrjRuB0rLVPDDQjNsmNcHActPPCJsNqB8ecJD89c=;
        h=From:To:Cc:Subject:Date:From;
        b=J7C/fXyhUPfJiiJlAhOEPPbDjm2vC8Z2dwTJfHtX0eN35TFplwpntwKPwp2s7LsQa
         p/AzyI9623hLu0yUZNFJwD1LsRpKV7LrKcogBMadLnWb+KlmnFuG6KzCq1faN+mo1L
         Peb1pVise7xPxuuCU4zfmIAp0QIIf+T4cKC6q+2lx8M3SiA4KmMKXp+Wx7JufdHACO
         MpUUWeY51qM6eoH0ztzbnHQw4NC4H3PjgZc3J5gXpvyaacbS7saWoF50pwRpt6TG7v
         +OwwSuBF+hRjqu/J9aUoALb+ZAwT3Uc7VIOxbxsiD/FWo/Qed9pkOnGlRtZRl08r3l
         TYB88tPEGehWQ==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: sdhci-cadence: do not use hardware tuning for SD mode
Date:   Mon, 20 Jul 2020 15:11:41 +0900
Message-Id: <20200720061141.172944-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

As commit ef6b75671b5f ("mmc: sdhci-cadence: send tune request twice to
work around errata") stated, this IP has an errata. This commit applies
the second workaround for the SD mode.

Due to the errata, it is not possible to use the hardware tuning provided
by SDHCI_HOST_CONTROL2.

Use the software-controlled tuning like the eMMC mode.

Set sdhci_host_ops::platform_execute_tuning instead of overriding
mmc_host_ops::execute_tuning.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-cadence.c | 123 ++++++++++++++++---------------
 1 file changed, 62 insertions(+), 61 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 4a6c9ba82538..4d9f7681817c 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -202,57 +202,6 @@ static u32 sdhci_cdns_get_emmc_mode(struct sdhci_cdns_priv *priv)
 	return FIELD_GET(SDHCI_CDNS_HRS06_MODE, tmp);
 }
 
-static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
-					 unsigned int timing)
-{
-	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
-	u32 mode;
-
-	switch (timing) {
-	case MMC_TIMING_MMC_HS:
-		mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
-		break;
-	case MMC_TIMING_MMC_DDR52:
-		mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
-		break;
-	case MMC_TIMING_MMC_HS200:
-		mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
-		break;
-	case MMC_TIMING_MMC_HS400:
-		if (priv->enhanced_strobe)
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
-		else
-			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
-		break;
-	default:
-		mode = SDHCI_CDNS_HRS06_MODE_SD;
-		break;
-	}
-
-	sdhci_cdns_set_emmc_mode(priv, mode);
-
-	/* For SD, fall back to the default handler */
-	if (mode == SDHCI_CDNS_HRS06_MODE_SD)
-		sdhci_set_uhs_signaling(host, timing);
-}
-
-static const struct sdhci_ops sdhci_cdns_ops = {
-	.set_clock = sdhci_set_clock,
-	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
-	.set_bus_width = sdhci_set_bus_width,
-	.reset = sdhci_reset,
-	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
-};
-
-static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
-	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-};
-
-static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
-	.ops = &sdhci_cdns_ops,
-};
-
 static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 {
 	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
@@ -286,23 +235,24 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 	return 0;
 }
 
-static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
+/*
+ * In SD mode, software must not use the hardware tuning and instead perform
+ * an almost identical procedure to eMMC.
+ */
+static int sdhci_cdns_execute_tuning(struct sdhci_host *host, u32 opcode)
 {
-	struct sdhci_host *host = mmc_priv(mmc);
 	int cur_streak = 0;
 	int max_streak = 0;
 	int end_of_streak = 0;
 	int i;
 
 	/*
-	 * This handler only implements the eMMC tuning that is specific to
-	 * this controller.  Fall back to the standard method for SD timing.
+	 * Do not execute tuning for UHS_SDR50 or UHS_DDR50.
+	 * The delay is set by probe, based on the DT properties.
 	 */
-	if (host->timing != MMC_TIMING_MMC_HS200)
-		return sdhci_execute_tuning(mmc, opcode);
-
-	if (WARN_ON(opcode != MMC_SEND_TUNING_BLOCK_HS200))
-		return -EINVAL;
+	if (host->timing != MMC_TIMING_MMC_HS200 &&
+	    host->timing != MMC_TIMING_UHS_SDR104)
+		return 0;
 
 	for (i = 0; i < SDHCI_CDNS_MAX_TUNING_LOOP; i++) {
 		if (sdhci_cdns_set_tune_val(host, i) ||
@@ -325,6 +275,58 @@ static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	return sdhci_cdns_set_tune_val(host, end_of_streak - max_streak / 2);
 }
 
+static void sdhci_cdns_set_uhs_signaling(struct sdhci_host *host,
+					 unsigned int timing)
+{
+	struct sdhci_cdns_priv *priv = sdhci_cdns_priv(host);
+	u32 mode;
+
+	switch (timing) {
+	case MMC_TIMING_MMC_HS:
+		mode = SDHCI_CDNS_HRS06_MODE_MMC_SDR;
+		break;
+	case MMC_TIMING_MMC_DDR52:
+		mode = SDHCI_CDNS_HRS06_MODE_MMC_DDR;
+		break;
+	case MMC_TIMING_MMC_HS200:
+		mode = SDHCI_CDNS_HRS06_MODE_MMC_HS200;
+		break;
+	case MMC_TIMING_MMC_HS400:
+		if (priv->enhanced_strobe)
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400ES;
+		else
+			mode = SDHCI_CDNS_HRS06_MODE_MMC_HS400;
+		break;
+	default:
+		mode = SDHCI_CDNS_HRS06_MODE_SD;
+		break;
+	}
+
+	sdhci_cdns_set_emmc_mode(priv, mode);
+
+	/* For SD, fall back to the default handler */
+	if (mode == SDHCI_CDNS_HRS06_MODE_SD)
+		sdhci_set_uhs_signaling(host, timing);
+}
+
+static const struct sdhci_ops sdhci_cdns_ops = {
+	.set_clock = sdhci_set_clock,
+	.get_timeout_clock = sdhci_cdns_get_timeout_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_reset,
+	.platform_execute_tuning = sdhci_cdns_execute_tuning,
+	.set_uhs_signaling = sdhci_cdns_set_uhs_signaling,
+};
+
+static const struct sdhci_pltfm_data sdhci_cdns_uniphier_pltfm_data = {
+	.ops = &sdhci_cdns_ops,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
+static const struct sdhci_pltfm_data sdhci_cdns_pltfm_data = {
+	.ops = &sdhci_cdns_ops,
+};
+
 static void sdhci_cdns_hs400_enhanced_strobe(struct mmc_host *mmc,
 					     struct mmc_ios *ios)
 {
@@ -385,7 +387,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	priv->hrs_addr = host->ioaddr;
 	priv->enhanced_strobe = false;
 	host->ioaddr += SDHCI_CDNS_SRS_BASE;
-	host->mmc_host_ops.execute_tuning = sdhci_cdns_execute_tuning;
 	host->mmc_host_ops.hs400_enhanced_strobe =
 				sdhci_cdns_hs400_enhanced_strobe;
 	sdhci_enable_v4_mode(host);
-- 
2.25.1

