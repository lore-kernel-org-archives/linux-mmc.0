Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D68CC433E3
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DE2208C7
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zCPXUfb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732590AbgFSM6a (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:58:30 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51676 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732495AbgFSM6a (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 08:58:30 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwEZk082648;
        Fri, 19 Jun 2020 07:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571494;
        bh=1yyZ02rdUuurElexq779NNOoFqWvEfOJ8Vx4K01CaMQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=zCPXUfb33ipipjCsbHs074rbzD6imzHxj+jvtm9s9hOx63ZR4eX80uUnwrq4GyTZR
         pH9dUrN1fJQQyb56D98ERrxE7SSuS2CmZNp/qts1kgrrgigIoobK6je0BTNyifqaue
         iJhXPf2aEGDpL2kxlZbHtQscelfeBM2pcFieRuns=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05JCwEYN105675
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 07:58:14 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:14 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:14 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Hm015675;
        Fri, 19 Jun 2020 07:58:11 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 2/7] mmc: sdhci_am654: Add flag for PHY calibration
Date:   Fri, 19 Jun 2020 18:27:56 +0530
Message-ID: <20200619125801.9530-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619125801.9530-1-faiz_abbas@ti.com>
References: <20200619125801.9530-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Not all controllers need calibration for the PHY DLL. Add a DLL_CALIB flag
to indicate the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 061b4398a4f1..85a05344f825 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -97,6 +97,7 @@ struct sdhci_am654_driver_data {
 #define FREQSEL_2_BIT	(1 << 1)
 #define STRBSEL_4_BIT	(1 << 2)
 #define DLL_PRESENT	(1 << 3)
+#define DLL_CALIB	(1 << 4)
 };
 
 struct timing_data {
@@ -325,7 +326,8 @@ static const struct sdhci_pltfm_data sdhci_am654_pdata = {
 
 static const struct sdhci_am654_driver_data sdhci_am654_drvdata = {
 	.pdata = &sdhci_am654_pdata,
-	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT,
+	.flags = IOMUX_PRESENT | FREQSEL_2_BIT | STRBSEL_4_BIT | DLL_PRESENT |
+		 DLL_CALIB,
 };
 
 static struct sdhci_ops sdhci_j721e_8bit_ops = {
@@ -348,7 +350,7 @@ static const struct sdhci_pltfm_data sdhci_j721e_8bit_pdata = {
 
 static const struct sdhci_am654_driver_data sdhci_j721e_8bit_drvdata = {
 	.pdata = &sdhci_j721e_8bit_pdata,
-	.flags = DLL_PRESENT,
+	.flags = DLL_PRESENT | DLL_CALIB,
 };
 
 static struct sdhci_ops sdhci_j721e_4bit_ops = {
@@ -469,7 +471,7 @@ static int sdhci_am654_init(struct sdhci_host *host)
 	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, 0x0);
 
-	if (sdhci_am654->flags & DLL_PRESENT) {
+	if (sdhci_am654->flags & DLL_CALIB) {
 		regmap_read(sdhci_am654->base, PHY_STAT1, &val);
 		if (~val & CALDONE_MASK) {
 			/* Calibrate IO lines */
-- 
2.17.1

