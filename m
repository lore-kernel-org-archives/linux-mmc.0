Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232D2C33CA2
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92342075D
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LrQIp9Lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgAHPIH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:08:07 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40878 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgAHPIF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 10:08:05 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008F7vEb079329;
        Wed, 8 Jan 2020 09:07:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578496077;
        bh=4z+bifZE71KtY+TAZ/V2h1d+jTbA9mP+HP5hK+rrBaM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LrQIp9Lwn+24oU/6JXg7a7d2yDEbWDhSN7VTKga69eoMBAI2VqvYZlWpwv6c0YrLQ
         gAr9EAghY1vEALmon8ZWlj7I02P3RqfMaWk8XhIvT5rP4s6qpDI3HdceC5Pk3cFnSz
         KyITl9BwCjTzUV483/lK6K7NTYvnkqR576hn226s=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7vwA105519;
        Wed, 8 Jan 2020 09:07:57 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 09:07:57 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 09:07:57 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7ln3018107;
        Wed, 8 Jan 2020 09:07:55 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <robh+dt@kernel.org>
Subject: [PATCH 3/3] mmc: sdhci_am654: Enable DLL only for some speed modes
Date:   Wed, 8 Jan 2020 20:39:20 +0530
Message-ID: <20200108150920.14547-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20200108150920.14547-1-faiz_abbas@ti.com>
References: <20200108150920.14547-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Its recommended that DLL must only be enabled for SDR50, DDR50, DDR52,
SDR104, HS200 and HS400 speed modes. Move DLL configuration to its own
function and call it only in the above speed modes.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 128 +++++++++++++++++----------------
 1 file changed, 68 insertions(+), 60 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index bb977de43f7d..575bbab1a6ed 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -119,16 +119,80 @@ static const struct timing_data td[] = {
 	[MMC_TIMING_MMC_HS400] = {"ti,otap-del-sel-hs400", MMC_CAP2_HS400},
 };
 
+static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	int sel50, sel100, freqsel;
+	u32 mask, val;
+	int ret;
+
+	if (sdhci_am654->flags & FREQSEL_2_BIT) {
+		switch (clock) {
+		case 200000000:
+			sel50 = 0;
+			sel100 = 0;
+			break;
+		case 100000000:
+			sel50 = 0;
+			sel100 = 1;
+			break;
+		default:
+			sel50 = 1;
+			sel100 = 0;
+		}
+
+		/* Configure PHY DLL frequency */
+		mask = SEL50_MASK | SEL100_MASK;
+		val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask, val);
+
+	} else {
+		switch (clock) {
+		case 200000000:
+			freqsel = 0x0;
+			break;
+		default:
+			freqsel = 0x4;
+		}
+
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL5, FREQSEL_MASK,
+				   freqsel << FREQSEL_SHIFT);
+	}
+	/* Configure DLL TRIM */
+	mask = DLL_TRIM_ICP_MASK;
+	val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
+
+	/* Configure DLL driver strength */
+	mask |= DR_TY_MASK;
+	val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, mask, val);
+
+	/* Enable DLL */
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK,
+			   0x1 << ENDLL_SHIFT);
+	/*
+	 * Poll for DLL ready. Use a one second timeout.
+	 * Works in all experiments done so far
+	 */
+	ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1, val,
+				       val & DLLRDY_MASK, 1000, 1000000);
+	if (ret) {
+		dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
+		return;
+	}
+
+	sdhci_am654->dll_on = true;
+}
+
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
 	unsigned char timing = host->mmc->ios.timing;
-	int sel50, sel100, freqsel;
 	u32 otap_del_sel;
 	u32 otap_del_ena;
 	u32 mask, val;
-	int ret;
 
 	if (sdhci_am654->dll_on) {
 		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK, 0);
@@ -163,64 +227,8 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-		if (sdhci_am654->flags & FREQSEL_2_BIT) {
-			switch (clock) {
-			case 200000000:
-				sel50 = 0;
-				sel100 = 0;
-				break;
-			case 100000000:
-				sel50 = 0;
-				sel100 = 1;
-				break;
-			default:
-				sel50 = 1;
-				sel100 = 0;
-			}
-
-			/* Configure PHY DLL frequency */
-			mask = SEL50_MASK | SEL100_MASK;
-			val = (sel50 << SEL50_SHIFT) | (sel100 << SEL100_SHIFT);
-			regmap_update_bits(sdhci_am654->base, PHY_CTRL5, mask,
-					   val);
-		} else {
-			switch (clock) {
-			case 200000000:
-				freqsel = 0x0;
-				break;
-			default:
-				freqsel = 0x4;
-			}
-
-			regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
-					   FREQSEL_MASK,
-					   freqsel << FREQSEL_SHIFT);
-		}
-
-		/* Configure DLL TRIM */
-		mask = DLL_TRIM_ICP_MASK;
-		val = sdhci_am654->trm_icp << DLL_TRIM_ICP_SHIFT;
-
-		/* Configure DLL driver strength */
-		mask |= DR_TY_MASK;
-		val |= sdhci_am654->drv_strength << DR_TY_SHIFT;
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, mask, val);
-		/* Enable DLL */
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL1, ENDLL_MASK,
-				   0x1 << ENDLL_SHIFT);
-		/*
-		 * Poll for DLL ready. Use a one second timeout.
-		 * Works in all experiments done so far
-		 */
-		ret = regmap_read_poll_timeout(sdhci_am654->base, PHY_STAT1,
-					       val, val & DLLRDY_MASK, 1000,
-					       1000000);
-		if (ret) {
-			dev_err(mmc_dev(host->mmc), "DLL failed to relock\n");
-			return;
-		}
-
-		sdhci_am654->dll_on = true;
+		if (timing > MMC_TIMING_UHS_SDR25)
+			sdhci_am654_setup_dll(host, clock);
 	}
 }
 
-- 
2.19.2

