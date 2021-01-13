Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06A2C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D41423359
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbhAMLTf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:19:35 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33388 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbhAMLTf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:19:35 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DBHulC034417;
        Wed, 13 Jan 2021 05:17:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610536676;
        bh=7QTv8FmNHOlwNjQhB0rw7xqLzcR5LnI5ud9jwmBnq3I=;
        h=From:To:CC:Subject:Date;
        b=PvnHFRqfqUsGm9exImCHMGs6B1x+UKQxA3aLhIjKfM7w5qdJj7NzuAlCOGQNvOyVo
         b21Pfnq7O5g5+ow1JI7KjXd9abrbHwjptl2JSYbrL8MHL4r1SefVpoRM2/KAEczhLH
         eaLnaMOhw+r5fekVR7upxP+Lu79J5x9t0hd1KJXE=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DBHuGH033246
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 05:17:56 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 05:17:56 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 05:17:56 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DBHq7h047012;
        Wed, 13 Jan 2021 05:17:53 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] mmc: sdhci_am654: Add Support for TI's AM64 SoC
Date:   Wed, 13 Jan 2021 16:47:42 +0530
Message-ID: <20210113111742.29645-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Add support for the controller present on the AM64x SoC.

There are two instances:
sdhci0: 8bit bus width, max 400 MBps
sdhci1: 4bit bus width, max 100 MBps

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

This patch is dependent on,
https://lore.kernel.org/patchwork/patch/1361560/

 drivers/mmc/host/sdhci_am654.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index a64ea143d185..7a34649b0754 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -514,6 +514,26 @@ static const struct sdhci_am654_driver_data sdhci_j721e_4bit_drvdata = {
 	.flags = IOMUX_PRESENT,
 };
 
+static const struct sdhci_pltfm_data sdhci_am64_8bit_pdata = {
+	.ops = &sdhci_j721e_8bit_ops,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
+static const struct sdhci_am654_driver_data sdhci_am64_8bit_drvdata = {
+	.pdata = &sdhci_am64_8bit_pdata,
+	.flags = DLL_PRESENT | DLL_CALIB,
+};
+
+static const struct sdhci_pltfm_data sdhci_am64_4bit_pdata = {
+	.ops = &sdhci_j721e_4bit_ops,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
+};
+
+static const struct sdhci_am654_driver_data sdhci_am64_4bit_drvdata = {
+	.pdata = &sdhci_am64_4bit_pdata,
+	.flags = IOMUX_PRESENT,
+};
+
 static const struct soc_device_attribute sdhci_am654_devices[] = {
 	{ .family = "AM65X",
 	  .revision = "SR1.0",
@@ -737,6 +757,14 @@ static const struct of_device_id sdhci_am654_of_match[] = {
 		.compatible = "ti,j721e-sdhci-4bit",
 		.data = &sdhci_j721e_4bit_drvdata,
 	},
+	{
+		.compatible = "ti,am64-sdhci-8bit",
+		.data = &sdhci_am64_8bit_drvdata,
+	},
+	{
+		.compatible = "ti,am64-sdhci-4bit",
+		.data = &sdhci_am64_4bit_drvdata,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, sdhci_am654_of_match);
-- 
2.17.1

