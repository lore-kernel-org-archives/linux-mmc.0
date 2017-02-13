From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 2/4] mmc: host: tmio: fix minor typos in comments
Date: Mon, 13 Feb 2017 19:03:40 +0100
Message-ID: <20170213180342.26172-3-wsa+renesas@sang-engineering.com>
References: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170213180342.26172-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Making sure we match the actual register names.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b20b451ad90daa..d192b562282bb2 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -54,7 +54,7 @@
 #define TMIO_STOP_STP		BIT(0)
 #define TMIO_STOP_SEC		BIT(8)
 
-/* Definitions for values the CTRL_STATUS register can take. */
+/* Definitions for values the CTL_STATUS register can take */
 #define TMIO_STAT_CMDRESPEND    BIT(0)
 #define TMIO_STAT_DATAEND       BIT(2)
 #define TMIO_STAT_CARD_REMOVE   BIT(3)
@@ -65,7 +65,7 @@
 #define TMIO_STAT_CARD_INSERT_A BIT(9)
 #define TMIO_STAT_SIGSTATE_A    BIT(10)
 
-/* These belong technically to CTRL_STATUS2, but the driver merges them */
+/* These belong technically to CTL_STATUS2, but the driver merges them */
 #define TMIO_STAT_CMD_IDX_ERR   BIT(16)
 #define TMIO_STAT_CRCFAIL       BIT(17)
 #define TMIO_STAT_STOPBIT_ERR   BIT(18)
@@ -89,7 +89,7 @@
 
 #define TMIO_BBS		512		/* Boot block size */
 
-/* Definitions for values the CTRL_SDIO_STATUS register can take. */
+/* Definitions for values the CTL_SDIO_STATUS register can take */
 #define TMIO_SDIO_STAT_IOIRQ	0x0001
 #define TMIO_SDIO_STAT_EXPUB52	0x4000
 #define TMIO_SDIO_STAT_EXWT	0x8000
-- 
2.11.0
