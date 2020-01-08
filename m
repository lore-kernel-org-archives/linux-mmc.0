Return-Path: <SRS0=QNIT=25=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33123C33CA1
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F306C2075D
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jan 2020 15:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FCAECita"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgAHPIB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jan 2020 10:08:01 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40850 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726921AbgAHPIA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jan 2020 10:08:00 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 008F7tS8079315;
        Wed, 8 Jan 2020 09:07:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1578496075;
        bh=C95On3zrXVpNZIfD4WSB4JCmFKVorJGWzqrcKWJ7Rzg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FCAECitai3mdxOOfsbWPuJ3K1AyHifV1DWbondIDwD74qZ9U8vfYI6OGgnxopp2c9
         S5vwP6pvUc0bmA3/7tur85fYcdOgv4yM2po9jAvzzpRq5U+vtCFY/iNo1QNFylEjst
         RLW0aNnrjONliFemBWxYlZReBB4o1ZsNi3sw58mE=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 008F7tXg070702
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Jan 2020 09:07:55 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 8 Jan
 2020 09:07:55 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 8 Jan 2020 09:07:55 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 008F7ln2018107;
        Wed, 8 Jan 2020 09:07:53 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <faiz_abbas@ti.com>, <robh+dt@kernel.org>
Subject: [PATCH 2/3] mmc: sdhci_am654: Update OTAPDLY writes
Date:   Wed, 8 Jan 2020 20:39:19 +0530
Message-ID: <20200108150920.14547-3-faiz_abbas@ti.com>
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

According to the latest AM65x Data Manual[1], a different output tap
delay value is optimum for a given speed mode. Therefore, deprecate the
ti,otap-del-sel binding and introduce a new binding for each of the
possible MMC/SD speed modes. If the legacy mode is not found, fall back
to old binding to maintain dts compatibility.

[1] http://www.ti.com/lit/gpn/am6526

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 123 ++++++++++++++++++++++++++++-----
 include/linux/mmc/host.h       |   2 +
 2 files changed, 107 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index b8fe94fd9525..bb977de43f7d 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -81,7 +81,8 @@ static struct regmap_config sdhci_am654_regmap_config = {
 
 struct sdhci_am654_data {
 	struct regmap *base;
-	int otap_del_sel;
+	bool legacy_otapdly;
+	int otap_del_sel[11];
 	int trm_icp;
 	int drv_strength;
 	bool dll_on;
@@ -98,11 +99,34 @@ struct sdhci_am654_driver_data {
 #define DLL_PRESENT	(1 << 3)
 };
 
+struct timing_data {
+	const char *binding;
+	u32 capability;
+};
+
+static const struct timing_data td[] = {
+	[MMC_TIMING_LEGACY] = {"ti,otap-del-sel-legacy", 0},
+	[MMC_TIMING_MMC_HS] = {"ti,otap-del-sel-mmc-hs", MMC_CAP_MMC_HIGHSPEED},
+	[MMC_TIMING_SD_HS]  = {"ti,otap-del-sel-sd-hs", MMC_CAP_SD_HIGHSPEED},
+	[MMC_TIMING_UHS_SDR12] = {"ti,otap-del-sel-sdr12", MMC_CAP_UHS_SDR12},
+	[MMC_TIMING_UHS_SDR25] = {"ti,otap-del-sel-sdr25", MMC_CAP_UHS_SDR25},
+	[MMC_TIMING_UHS_SDR50] = {"ti,otap-del-sel-sdr50", MMC_CAP_UHS_SDR50},
+	[MMC_TIMING_UHS_SDR104] = {"ti,otap-del-sel-sdr104",
+				   MMC_CAP_UHS_SDR104},
+	[MMC_TIMING_UHS_DDR50] = {"ti,otap-del-sel-ddr50", MMC_CAP_UHS_DDR50},
+	[MMC_TIMING_MMC_DDR52] = {"ti,otap-del-sel-ddr52", MMC_CAP_DDR},
+	[MMC_TIMING_MMC_HS200] = {"ti,otap-del-sel-hs200", MMC_CAP2_HS200},
+	[MMC_TIMING_MMC_HS400] = {"ti,otap-del-sel-hs400", MMC_CAP2_HS400},
+};
+
 static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
+	unsigned char timing = host->mmc->ios.timing;
 	int sel50, sel100, freqsel;
+	u32 otap_del_sel;
+	u32 otap_del_ena;
 	u32 mask, val;
 	int ret;
 
@@ -116,22 +140,29 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	if (clock > CLOCK_TOO_SLOW_HZ) {
 		/* Setup DLL Output TAP delay */
+		if (sdhci_am654->legacy_otapdly)
+			otap_del_sel = sdhci_am654->otap_del_sel[0];
+		else
+			otap_del_sel = sdhci_am654->otap_del_sel[timing];
+
+		otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
+
 		mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-		val = (1 << OTAPDLYENA_SHIFT) |
-		      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
+		val = (otap_del_ena << OTAPDLYENA_SHIFT) |
+		      (otap_del_sel << OTAPDLYSEL_SHIFT);
+
 		/* Write to STRBSEL for HS400 speed mode */
-		if (host->mmc->ios.timing == MMC_TIMING_MMC_HS400) {
+		if (timing == MMC_TIMING_MMC_HS400) {
 			if (sdhci_am654->flags & STRBSEL_4_BIT)
-				mask = STRBSEL_4BIT_MASK;
+				mask |= STRBSEL_4BIT_MASK;
 			else
-				mask = STRBSEL_8BIT_MASK;
+				mask |= STRBSEL_8BIT_MASK;
 
-			regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask,
-					   sdhci_am654->strb_sel <<
-					   STRBSEL_SHIFT);
+			val |= sdhci_am654->strb_sel << STRBSEL_SHIFT;
 		}
 
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
+
 		if (sdhci_am654->flags & FREQSEL_2_BIT) {
 			switch (clock) {
 			case 200000000:
@@ -198,11 +229,19 @@ static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
-	int val, mask;
+	unsigned char timing = host->mmc->ios.timing;
+	u32 otap_del_sel;
+	u32 mask, val;
+
+	/* Setup DLL Output TAP delay */
+	if (sdhci_am654->legacy_otapdly)
+		otap_del_sel = sdhci_am654->otap_del_sel[0];
+	else
+		otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-	val = (1 << OTAPDLYENA_SHIFT) |
-	      (sdhci_am654->otap_del_sel << OTAPDLYSEL_SHIFT);
+	val = (0x1 << OTAPDLYENA_SHIFT) |
+	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
 	sdhci_set_clock(host, clock);
@@ -371,6 +410,55 @@ static int sdhci_am654_cqe_add_host(struct sdhci_host *host)
 	return ret;
 }
 
+static int sdhci_am654_get_otap_delay(struct sdhci_host *host,
+				      struct sdhci_am654_data *sdhci_am654)
+{
+	struct device *dev = mmc_dev(host->mmc);
+	int i;
+	int ret;
+
+	ret = device_property_read_u32(dev, td[MMC_TIMING_LEGACY].binding,
+				 &sdhci_am654->otap_del_sel[MMC_TIMING_LEGACY]);
+	if (ret) {
+		/*
+		 * ti,otap-del-sel-legacy is mandatory, look for old binding
+		 * if not found.
+		 */
+		ret = device_property_read_u32(dev, "ti,otap-del-sel",
+					       &sdhci_am654->otap_del_sel[0]);
+		if (ret) {
+			dev_err(dev, "Couldn't find otap-del-sel\n");
+
+			return ret;
+		}
+
+		dev_info(dev, "Using legacy binding ti,otap-del-sel\n");
+		sdhci_am654->legacy_otapdly = true;
+
+		return 0;
+	}
+
+	for (i = MMC_TIMING_MMC_HS; i <= MMC_TIMING_MMC_HS400; i++) {
+
+		ret = device_property_read_u32(dev, td[i].binding,
+					       &sdhci_am654->otap_del_sel[i]);
+		if (ret) {
+			dev_dbg(dev, "Couldn't find %s\n",
+				td[i].binding);
+			/*
+			 * Remove the corresponding capability
+			 * if an otap-del-sel value is not found
+			 */
+			if (i <= MMC_TIMING_MMC_DDR52)
+				host->mmc->caps &= ~td[i].capability;
+			else
+				host->mmc->caps2 &= ~td[i].capability;
+		}
+	}
+
+	return 0;
+}
+
 static int sdhci_am654_init(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -419,6 +507,10 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	if (ret)
 		goto err_cleanup_host;
 
+	ret = sdhci_am654_get_otap_delay(host, sdhci_am654);
+	if (ret)
+		goto err_cleanup_host;
+
 	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_cleanup_host;
@@ -437,11 +529,6 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
 	int drv_strength;
 	int ret;
 
-	ret = device_property_read_u32(dev, "ti,otap-del-sel",
-				       &sdhci_am654->otap_del_sel);
-	if (ret)
-		return ret;
-
 	if (sdhci_am654->flags & DLL_PRESENT) {
 		ret = device_property_read_u32(dev, "ti,trm-icp",
 					       &sdhci_am654->trm_icp);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index ba703384bea0..a22a10456c62 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -322,6 +322,8 @@ struct mmc_host {
 #define MMC_CAP_3_3V_DDR	(1 << 11)	/* Host supports eMMC DDR 3.3V */
 #define MMC_CAP_1_8V_DDR	(1 << 12)	/* Host supports eMMC DDR 1.8V */
 #define MMC_CAP_1_2V_DDR	(1 << 13)	/* Host supports eMMC DDR 1.2V */
+#define MMC_CAP_DDR		(MMC_CAP_3_3V_DDR | MMC_CAP_1_8V_DDR | \
+				 MMC_CAP_1_2V_DDR)
 #define MMC_CAP_POWER_OFF_CARD	(1 << 14)	/* Can power off after boot */
 #define MMC_CAP_BUS_WIDTH_TEST	(1 << 15)	/* CMD14/CMD19 bus width ok */
 #define MMC_CAP_UHS_SDR12	(1 << 16)	/* Host supports UHS SDR12 mode */
-- 
2.19.2

