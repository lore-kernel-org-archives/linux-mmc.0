Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F45AC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AA2233F9
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 12:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbhAMMAO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 07:00:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39740 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbhAMMAO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 07:00:14 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 10DBxU34045945;
        Wed, 13 Jan 2021 05:59:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610539170;
        bh=GUonOkkIARDwv50MiC0wedALt3iHo3HDOz+ceuFKS6k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Dfwmwo1tUF+rV59CjRE9NXeX0YriplT+NTt1wCnet0BpHyozkQ7XNbH0Rry9X1Tw1
         6CFQ1hYaQYBg9jahsmDsiIS0ge7KveWxgn8Qq/N63+jpvL4HodQf9D7sbTK6wMYdq7
         eT+Fn3hTSNtAUcscVC/Y+zn6O/6ieGkCtRfrbbg4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 10DBxUHi030325
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Jan 2021 05:59:30 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 13
 Jan 2021 05:59:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 13 Jan 2021 05:59:30 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 10DBxDdl041723;
        Wed, 13 Jan 2021 05:59:26 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] mmc: sdhci_am654: Add Support for TI's AM64 SoC
Date:   Wed, 13 Jan 2021 17:29:08 +0530
Message-ID: <20210113115908.3882-3-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113115908.3882-1-a-govindraju@ti.com>
References: <20210113115908.3882-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

From: Faiz Abbas <faiz_abbas@ti.com>

Add support for the controller present on the AM64x SoC.

There are instances:
sdhci0: 8bit bus width, max 400 MBps
sdhci1: 4bit bus width, max 100 MBps

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
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

