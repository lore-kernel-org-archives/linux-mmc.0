From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/5] mmc: tmio: use BIT() within defines
Date: Thu, 14 Apr 2016 18:16:46 +0200
Message-ID: <1460650609-2105-3-git-send-email-wsa@the-dreams.de>
References: <1460650609-2105-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1460650609-2105-1-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

BIT() makes it easier to match the bits to the datasheet. This is
especially important here, since some variants have different names in
their datasheets (like with Renesas R-Car).

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h | 44 +++++++++++++++++++++++---------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e75e5ca220bc0a..74945c1a66ce81 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -49,27 +49,29 @@
 #define CTL_RESET_SDIO 0x1e0
 
 /* Definitions for values the CTRL_STATUS register can take. */
-#define TMIO_STAT_CMDRESPEND    0x00000001
-#define TMIO_STAT_DATAEND       0x00000004
-#define TMIO_STAT_CARD_REMOVE   0x00000008
-#define TMIO_STAT_CARD_INSERT   0x00000010
-#define TMIO_STAT_SIGSTATE      0x00000020
-#define TMIO_STAT_WRPROTECT     0x00000080
-#define TMIO_STAT_CARD_REMOVE_A 0x00000100
-#define TMIO_STAT_CARD_INSERT_A 0x00000200
-#define TMIO_STAT_SIGSTATE_A    0x00000400
-#define TMIO_STAT_CMD_IDX_ERR   0x00010000
-#define TMIO_STAT_CRCFAIL       0x00020000
-#define TMIO_STAT_STOPBIT_ERR   0x00040000
-#define TMIO_STAT_DATATIMEOUT   0x00080000
-#define TMIO_STAT_RXOVERFLOW    0x00100000
-#define TMIO_STAT_TXUNDERRUN    0x00200000
-#define TMIO_STAT_CMDTIMEOUT    0x00400000
-#define TMIO_STAT_RXRDY         0x01000000
-#define TMIO_STAT_TXRQ          0x02000000
-#define TMIO_STAT_ILL_FUNC      0x20000000
-#define TMIO_STAT_CMD_BUSY      0x40000000
-#define TMIO_STAT_ILL_ACCESS    0x80000000
+#define TMIO_STAT_CMDRESPEND    BIT(0)
+#define TMIO_STAT_DATAEND       BIT(2)
+#define TMIO_STAT_CARD_REMOVE   BIT(3)
+#define TMIO_STAT_CARD_INSERT   BIT(4)
+#define TMIO_STAT_SIGSTATE      BIT(5)
+#define TMIO_STAT_WRPROTECT     BIT(7)
+#define TMIO_STAT_CARD_REMOVE_A BIT(8)
+#define TMIO_STAT_CARD_INSERT_A BIT(9)
+#define TMIO_STAT_SIGSTATE_A    BIT(10)
+
+/* These belong technically to CTRL_STATUS2, but the driver merges them */
+#define TMIO_STAT_CMD_IDX_ERR   BIT(16)
+#define TMIO_STAT_CRCFAIL       BIT(17)
+#define TMIO_STAT_STOPBIT_ERR   BIT(18)
+#define TMIO_STAT_DATATIMEOUT   BIT(19)
+#define TMIO_STAT_RXOVERFLOW    BIT(20)
+#define TMIO_STAT_TXUNDERRUN    BIT(21)
+#define TMIO_STAT_CMDTIMEOUT    BIT(22)
+#define TMIO_STAT_RXRDY         BIT(24)
+#define TMIO_STAT_TXRQ          BIT(25)
+#define TMIO_STAT_ILL_FUNC      BIT(29)
+#define TMIO_STAT_CMD_BUSY      BIT(30)
+#define TMIO_STAT_ILL_ACCESS    BIT(31)
 
 #define TMIO_STATUS2_DAT0	BIT(7)
 
-- 
2.7.0
