From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/6] mmc: rtsx_pci: use new macro for R1 without CRC
Date: Mon, 19 Sep 2016 14:49:17 +0200
Message-ID: <20160919124921.8172-3-wsa+renesas@sang-engineering.com>
References: <20160919124921.8172-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36546 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761561AbcISMtn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Sep 2016 08:49:43 -0400
In-Reply-To: <20160919124921.8172-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/rtsx_pci_sdmmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index 396c9b7e4121b0..3ccaa1415f33b2 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -126,7 +126,7 @@ static int sd_response_type(struct mmc_command *cmd)
 		return SD_RSP_TYPE_R0;
 	case MMC_RSP_R1:
 		return SD_RSP_TYPE_R1;
-	case MMC_RSP_R1 & ~MMC_RSP_CRC:
+	case MMC_RSP_R1_NO_CRC:
 		return SD_RSP_TYPE_R1 | SD_NO_CHECK_CRC7;
 	case MMC_RSP_R1B:
 		return SD_RSP_TYPE_R1b;
-- 
2.9.3

