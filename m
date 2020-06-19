Return-Path: <SRS0=u+69=AA=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B11EC433E3
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D7522083B
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Jun 2020 12:59:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VCEh6Zra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732696AbgFSM6j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 Jun 2020 08:58:39 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:51696 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732677AbgFSM6g (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jun 2020 08:58:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05JCwRex082673;
        Fri, 19 Jun 2020 07:58:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1592571507;
        bh=gGgeNDrwJZDmhTBHIA/rEns/YYGEnKJCgBn0VXHZTQg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=VCEh6ZraffXfp5+42J0kt9MPgGJyWtMrXIQr6UBcA4kXsJy/r1QMxUoq/04fBOgoS
         aBEYk65lorUnsMSG8M+Upns3K3IewUPkFw8OM//PUUB0H0RqJcNGYi44y+4qLe+NiN
         gzc9e2cJXeeVwVfI2wGRJW+kRLEx6OPIBTiVwS7w=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05JCwRbB105835
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 19 Jun 2020 07:58:27 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 19
 Jun 2020 07:58:27 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 19 Jun 2020 07:58:26 -0500
Received: from a0230074-Latitude-E7470.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05JCw2Hp015675;
        Fri, 19 Jun 2020 07:58:23 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <adrian.hunter@intel.com>,
        <will@kernel.org>, <catalin.marinas@arm.com>, <robh+dt@kernel.org>,
        <ulf.hansson@linaro.org>
CC:     <faiz_abbas@ti.com>
Subject: [PATCH 5/7] mmc: sdhci_am654: Update delay chain configuration
Date:   Fri, 19 Jun 2020 18:27:59 +0530
Message-ID: <20200619125801.9530-6-faiz_abbas@ti.com>
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

For speed modes where DLL is not enabled write to TXDLYCLK to enable
transmitter delay chain mode.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 8b0f69012d09..f7535ee3a232 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -61,6 +61,8 @@
 #define CALDONE_MASK		BIT(CALDONE_SHIFT)
 #define RETRIM_SHIFT		17
 #define RETRIM_MASK		BIT(RETRIM_SHIFT)
+#define SELDLYTXCLK_SHIFT	17
+#define SELDLYTXCLK_MASK	BIT(SELDLYTXCLK_SHIFT)
 
 #define DRIVER_STRENGTH_50_OHM	0x0
 #define DRIVER_STRENGTH_33_OHM	0x1
@@ -228,8 +230,14 @@ static void sdhci_am654_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	regmap_update_bits(sdhci_am654->base, PHY_CTRL4, mask, val);
 
-	if (timing > MMC_TIMING_UHS_SDR25 && clock > CLOCK_TOO_SLOW_HZ)
+	if (timing > MMC_TIMING_UHS_SDR25 && clock > CLOCK_TOO_SLOW_HZ) {
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
+				   SELDLYTXCLK_MASK, 0);
 		sdhci_am654_setup_dll(host, clock);
+	} else {
+		regmap_update_bits(sdhci_am654->base, PHY_CTRL5,
+				   SELDLYTXCLK_MASK, 1 << SELDLYTXCLK_SHIFT);
+	}
 }
 
 static void sdhci_j721e_4bit_set_clock(struct sdhci_host *host,
-- 
2.17.1

