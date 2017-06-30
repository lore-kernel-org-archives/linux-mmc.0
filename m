From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 2/4] mmc: tmio: add references to bit defines in the header
Date: Fri, 30 Jun 2017 12:56:47 +0200
Message-ID: <20170630105649.16137-3-wsa+renesas@sang-engineering.com>
References: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170630105649.16137-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

When defining bits, make sure we always have a reference to the register
they belong to. For now, renaming all bits properly seems too intrusive,
so at least make sure we have proper documentation.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b161dfadfec25d..e3e96178acaab4 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -81,9 +81,11 @@
 #define TMIO_STAT_CMD_BUSY      BIT(30)
 #define TMIO_STAT_ILL_ACCESS    BIT(31)
 
+/* Definitions for values the CTL_SD_CARD_CLK_CTL register can take */
 #define	CLK_CTL_DIV_MASK	0xff
 #define	CLK_CTL_SCLKEN		BIT(8)
 
+/* Definitions for values the CTL_SD_MEM_CARD_OPT register can take */
 #define CARD_OPT_WIDTH8		BIT(13)
 #define CARD_OPT_WIDTH		BIT(15)
 
-- 
2.11.0
