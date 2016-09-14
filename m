From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 1/4] mmc: add define for R1 response without CRC
Date: Wed, 14 Sep 2016 19:05:55 +0200
Message-ID: <20160914170558.1561-2-wsa+renesas@sang-engineering.com>
References: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

The core uses it for polling. Give drivers a proper define to handle
this case like all other response types.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 include/linux/mmc/core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index b01e77de1a74de..4caee099b63a28 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -55,6 +55,9 @@ struct mmc_command {
 #define MMC_RSP_R6	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 #define MMC_RSP_R7	(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
 
+/* Can be used by core to poll after switch to MMC HS mode */
+#define MMC_RSP_R1_NO_CRC	(MMC_RSP_PRESENT|MMC_RSP_OPCODE)
+
 #define mmc_resp_type(cmd)	((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
 
 /*
-- 
2.9.3
