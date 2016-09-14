From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/4] mmc: rtsx_pci: use new macro for R1 without CRC
Date: Wed, 14 Sep 2016 19:05:56 +0200
Message-ID: <20160914170558.1561-3-wsa+renesas@sang-engineering.com>
References: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

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
