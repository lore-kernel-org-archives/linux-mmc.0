From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 4/4] mmc: tmio: add eMMC support
Date: Wed, 14 Sep 2016 19:05:58 +0200
Message-ID: <20160914170558.1561-5-wsa+renesas@sang-engineering.com>
References: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160914170558.1561-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

We need to add R1 without CRC support, refactor the bus width routine a
little and extend a quirk check.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h     |  3 +++
 drivers/mmc/host/tmio_mmc_pio.c | 29 +++++++++++++++++------------
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 4b501f2d529f6e..637581faf756b1 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -79,6 +79,9 @@
 #define	CLK_CTL_DIV_MASK	0xff
 #define	CLK_CTL_SCLKEN		BIT(8)
 
+#define CARD_OPT_WIDTH8		BIT(13)
+#define CARD_OPT_WIDTH		BIT(15)
+
 #define TMIO_BBS		512		/* Boot block size */
 
 /* Definitions for values the CTRL_SDIO_STATUS register can take. */
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 46b5a456243b84..f21c92ec7121cc 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -340,7 +340,9 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 
 	switch (mmc_resp_type(cmd)) {
 	case MMC_RSP_NONE: c |= RESP_NONE; break;
-	case MMC_RSP_R1:   c |= RESP_R1;   break;
+	case MMC_RSP_R1:
+	case MMC_RSP_R1_NO_CRC:
+			   c |= RESP_R1;   break;
 	case MMC_RSP_R1B:  c |= RESP_R1B;  break;
 	case MMC_RSP_R2:   c |= RESP_R2;   break;
 	case MMC_RSP_R3:   c |= RESP_R3;   break;
@@ -737,12 +739,13 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	pr_debug("setup data transfer: blocksize %08x  nr_blocks %d\n",
 		 data->blksz, data->blocks);
 
-	/* Some hardware cannot perform 2 byte requests in 4 bit mode */
-	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
+	/* Some hardware cannot perform 2 byte requests in 4/8 bit mode */
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4 ||
+	    host->mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
 		int blksz_2bytes = pdata->flags & TMIO_MMC_BLKSZ_2BYTES;
 
 		if (data->blksz < 2 || (data->blksz < 4 && !blksz_2bytes)) {
-			pr_err("%s: %d byte block unsupported in 4 bit mode\n",
+			pr_err("%s: %d byte block unsupported in 4/8 bit mode\n",
 			       mmc_hostname(host->mmc), data->blksz);
 			return -EINVAL;
 		}
@@ -922,14 +925,16 @@ static void tmio_mmc_power_off(struct tmio_mmc_host *host)
 static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
 				unsigned char bus_width)
 {
-	switch (bus_width) {
-	case MMC_BUS_WIDTH_1:
-		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
-		break;
-	case MMC_BUS_WIDTH_4:
-		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
-		break;
-	}
+	u16 reg = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
+				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
+
+	/* reg now applies to MMC_BUS_WIDTH_4 */
+	if (bus_width == MMC_BUS_WIDTH_1)
+		reg |= CARD_OPT_WIDTH;
+	else if (bus_width == MMC_BUS_WIDTH_8)
+		reg |= CARD_OPT_WIDTH8;
+
+	sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, reg);
 }
 
 /* Set MMC clock / power.
-- 
2.9.3
