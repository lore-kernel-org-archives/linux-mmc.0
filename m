Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A896C6FD1F
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Mar 2023 08:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCPIFY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Mar 2023 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCPIFV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2023 04:05:21 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7A04693;
        Thu, 16 Mar 2023 01:05:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32G84qZK110352;
        Thu, 16 Mar 2023 03:04:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678953893;
        bh=ZHrP5fje7dPf+XTaUk5DHeiHCHwdTb/l897KmkYWfbY=;
        h=From:To:CC:Subject:Date;
        b=ZKmFBTiLIa+vmixDr2QLXZ0FUod7Vve2Jv5sh6sc94eSrlbmkRvXL3FY/RHk8ZqJv
         PkrCMGxnnnvEtUE0S/1Wf8ShOwhtTqGkeKs5SmLIX8Rw98kmpQtnco8nSFu9QUKX75
         iyWjwGenTLo20Oq5rwZTpZK4GIMEoSwXuZMG2hXc=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32G84qRd106333
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 03:04:52 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 03:04:52 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 03:04:52 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32G84p5T116150;
        Thu, 16 Mar 2023 03:04:52 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <b-kapoor@ti.com>, <ulf.hansson@linaro.org>,
        <adrian.hunter@intel.com>, <vigneshr@ti.com>
Subject: [PATCH] mmc: sdhci_am654: Set HIGH_SPEED_ENA for SDR25 and SDR50
Date:   Thu, 16 Mar 2023 13:34:51 +0530
Message-ID: <20230316080451.475020-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Timing Information in Datasheet assumes that HIGH_SPEED_ENA=1 should be
set for SDR25 and SDR50 modes. But sdhci_am654 driver clears
HIGH_SPEED_ENA register. Thus, Modify sdhci_am654 to not clear
HIGH_SPEED_ENA (HOST_CONTROL[2]) bit for SDR12 and SDR25 speed modes.

Fixes: e374e87538f4 ("mmc: sdhci_am654: Clear HISPD_ENA in some lower speed modes")
Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
---
 drivers/mmc/host/sdhci_am654.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 7ef828942df3..ac90e86bb0a0 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -351,8 +351,6 @@ static void sdhci_am654_write_b(struct sdhci_host *host, u8 val, int reg)
 		 */
 		case MMC_TIMING_SD_HS:
 		case MMC_TIMING_MMC_HS:
-		case MMC_TIMING_UHS_SDR12:
-		case MMC_TIMING_UHS_SDR25:
 			val &= ~SDHCI_CTRL_HISPD;
 		}
 	}
-- 
2.34.1

