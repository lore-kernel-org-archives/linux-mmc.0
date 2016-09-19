From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 1/6] mmc: add define for R1 response without CRC
Date: Mon, 19 Sep 2016 22:57:45 +0200
Message-ID: <20160919205750.4766-2-wsa+renesas@sang-engineering.com>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:37811 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbcISU6J (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 19 Sep 2016 16:58:09 -0400
In-Reply-To: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

The core uses it for polling. Give drivers a proper define handle this
case like for other response types.

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

