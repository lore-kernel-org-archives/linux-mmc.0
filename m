Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A70C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483AC20DD4
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ebdgNmPH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbgFSM6c (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:58:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55346 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732589AbgFSM6b (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 08:58:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwNCf058282;
        Fri, 19 Jun 2020 07:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571503;
        bh=11o/+hzZiiuyAsd9CjfzVDPRofsNTTdesYF9PK407RU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ebdgNmPH1qhWL0pCp7rhGRpbu//q/7JB32Bk5EbImZmRA4nh2ry6MYRipgq78vJxP
         BSnMgCSMIoSqLkirR/gjWyS8Y+OO4/qluVRG97oSQdDisbBS6FgaSbioCYGcIIwwmP
         Jc79crKk/pXKlK+Lal65q+Wvluyl/CV928Ba63yw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwNnP007298;
        Fri, 19 Jun 2020 07:58:23 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:22 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:22 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Ho015675;
        Fri, 19 Jun 2020 07:58:19 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 4/7] mmc: sdhci_am654: Fix conditions for enabling dll
Date:   Fri, 19 Jun 2020 18:27:58 +0530
Message-ID: <20200619125801.9530-5-faiz_abbas@ti.com>
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

The clock > CLOCK_TOO_SLOW_HZ condition gating phy configuration
is only required because dll should not be enabled at too low a
clock frequency or too low timing. Make sure that this condition
only gates dll enablement.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 42 ++++++++++++++++------------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 365eb2819dd9..8b0f69012d09 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -204,34 +204,32 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	sdhci_set_clock(host, clock);
 
-	if (clock > CLOCK_TOO_SLOW_HZ) {
-		/* Setup DLL Output TAP delay */
-		if (sdhci_am654->legacy_otapdly)
-			otap_del_sel = sdhci_am654->otap_del_sel[0];
-		else
-			otap_del_sel = sdhci_am654->otap_del_sel[timing];
+	/* Setup DLL Output TAP delay */
+	if (sdhci_am654->legacy_otapdly)
+		otap_del_sel = sdhci_am654->otap_del_sel[0];
+	else
+		otap_del_sel = sdhci_am654->otap_del_sel[timing];
 
-		otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
+	otap_del_ena = (timing > MMC_TIMING_UHS_SDR25) ? 1 : 0;
 
-		mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
-		val = (otap_del_ena << OTAPDLYENA_SHIFT) |
-		      (otap_del_sel << OTAPDLYSEL_SHIFT);
+	mask = OTAPDLYENA_MASK | OTAPDLYSEL_MASK;
+	val = (otap_del_ena << OTAPDLYENA_SHIFT) |
+	      (otap_del_sel << OTAPDLYSEL_SHIFT);
 
-		/* Write to STRBSEL for HS400 speed mode */
-		if (timing == MMC_TIMING_MMC_HS400) {
-			if (sdhci_am654->flags & STRBSEL_4_BIT)
-				mask |= STRBSEL_4BIT_MASK;
-			else
-				mask |= STRBSEL_8BIT_MASK;
+	/* Write to STRBSEL for HS400 speed mode */
+	if (timing == MMC_TIMING_MMC_HS400) {
+		if (sdhci_am654->flags & STRBSEL_4_BIT)
+			mask |= STRBSEL_4BIT_MASK;
+		else
+			mask |= STRBSEL_8BIT_MASK;
 
-			val |= sdhci_am654->strb_sel << STRBSEL_SHIFT;
-		}
+		val |= sdhci_am654->strb_sel << STRBSEL_SHIFT;
+	}
 
-		regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
+	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-		if (timing > MMC_TIMING_UHS_SDR25)
-			sdhci_am654_setup_dll(host, clock);
-	}
+	if (timing > MMC_TIMING_UHS_SDR25 && clock > CLOCK_TOO_SLOW_HZ)
+		sdhci_am654_setup_dll(host, clock);
 }
 
 static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
-- 
2.17.1

