From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 1/4] mmc: host: tmio: use defines for CTL_STOP_INTERNAL_ACTION values
Date: Tue, 14 Mar 2017 11:09:16 +0100
Message-ID: <20170314100919.25401-2-wsa+renesas@sang-engineering.com>
References: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc.h     | 4 ++++
 drivers/mmc/host/tmio_mmc_pio.c | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 2b349d48fb9a8a..b20b451ad90daa 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -50,6 +50,10 @@
 #define CTL_CLK_AND_WAIT_CTL 0x138
 #define CTL_RESET_SDIO 0x1e0
 
+/* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take */
+#define TMIO_STOP_STP		BIT(0)
+#define TMIO_STOP_SEC		BIT(8)
+
 /* Definitions for values the CTRL_STATUS register can take. */
 #define TMIO_STAT_CMDRESPEND    BIT(0)
 #define TMIO_STAT_DATAEND       BIT(2)
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 6b789a739d4dfe..ad2840e1bfae51 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -340,7 +340,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 
 	/* CMD12 is handled by hardware */
 	if (cmd->opcode == MMC_STOP_TRANSMISSION && !cmd->arg) {
-		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x001);
+		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_STP);
 		return 0;
 	}
 
@@ -367,7 +367,7 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
 	if (data) {
 		c |= DATA_PRESENT;
 		if (data->blocks > 1) {
-			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x100);
+			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_SEC);
 			c |= TRANSFER_MULTI;
 
 			/*
@@ -554,7 +554,7 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 
 	if (stop) {
 		if (stop->opcode == MMC_STOP_TRANSMISSION && !stop->arg)
-			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0x000);
+			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
 		else
 			BUG();
 	}
-- 
2.11.0
