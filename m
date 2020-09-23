Return-Path: <SRS0=GgYk=DA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72998C2D0A8
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D23E235FC
	for <linux-mmc@archiver.kernel.org>; Wed, 23 Sep 2020 10:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EtvXU8Ic"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgIWKws (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 23 Sep 2020 06:52:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48644 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgIWKwn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2020 06:52:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NAqRSb128234;
        Wed, 23 Sep 2020 05:52:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600858347;
        bh=/6BDAGRQF0WKkZ8xIuhyw1VeH6QWPu369/khQGKbmXY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EtvXU8Ic4nh4Va5oNMWromgVwRs90A0w7X+P/nn/Q8Vzobuz8cb0GaaSky5tcX4cd
         P3HWqSnUmOwkWMUsbYFgQpC5PpnC3B2x3IOwT8E3XsU+AcM+DaaDfpybNDaqBzjat3
         QAe/zdjPrsqM7EeVKsWWDkaB0i9iotSGx879iUkk=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NAqRMM005691
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 23 Sep 2020 05:52:27 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 05:52:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 05:52:27 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NAq7qk059762;
        Wed, 23 Sep 2020 05:52:23 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     <adrian.hunter@intel.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 3/6] mmc: sdhci_am654: Fix hard coded otap delay array size
Date:   Wed, 23 Sep 2020 16:22:03 +0530
Message-ID: <20200923105206.7988-4-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200923105206.7988-1-faiz_abbas@ti.com>
References: <20200923105206.7988-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Change hard coded array size value to depend on struct timing_data
array size.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 42 +++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index a4c6d9d80e88..9f3347bc3757 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -85,10 +85,30 @@ static struct regmap_config sdhci_am654_regmap_config = {
 	.fast_io = true,
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
 struct sdhci_am654_data {
 	struct regmap *base;
 	bool legacy_otapdly;
-	int otap_del_sel[11];
+	int otap_del_sel[ARRAY_SIZE(td)];
 	int clkbuf_sel;
 	int trm_icp;
 	int drv_strength;
@@ -107,26 +127,6 @@ struct sdhci_am654_driver_data {
 #define DLL_CALIB	(1 << 4)
 };
 
-struct timing_data {
-	const char *binding;
-	u32 capability;
-};
-
-static const struct timing_data td[] = {
-	[MMC_TIMING_LEGACY] = {"ti,otap-del-sel-legacy", 0},
-	[MMC_TIMING_MMC_HS] = {"ti,otap-del-sel-mmc-hs", MMC_CAP_MMC_HIGHSPEED},
-	[MMC_TIMING_SD_HS]  = {"ti,otap-del-sel-sd-hs", MMC_CAP_SD_HIGHSPEED},
-	[MMC_TIMING_UHS_SDR12] = {"ti,otap-del-sel-sdr12", MMC_CAP_UHS_SDR12},
-	[MMC_TIMING_UHS_SDR25] = {"ti,otap-del-sel-sdr25", MMC_CAP_UHS_SDR25},
-	[MMC_TIMING_UHS_SDR50] = {"ti,otap-del-sel-sdr50", MMC_CAP_UHS_SDR50},
-	[MMC_TIMING_UHS_SDR104] = {"ti,otap-del-sel-sdr104",
-				   MMC_CAP_UHS_SDR104},
-	[MMC_TIMING_UHS_DDR50] = {"ti,otap-del-sel-ddr50", MMC_CAP_UHS_DDR50},
-	[MMC_TIMING_MMC_DDR52] = {"ti,otap-del-sel-ddr52", MMC_CAP_DDR},
-	[MMC_TIMING_MMC_HS200] = {"ti,otap-del-sel-hs200", MMC_CAP2_HS200},
-	[MMC_TIMING_MMC_HS400] = {"ti,otap-del-sel-hs400", MMC_CAP2_HS400},
-};
-
 static void sdhci_am654_setup_dll(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-- 
2.17.1

