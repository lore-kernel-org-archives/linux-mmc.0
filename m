From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH RFT] mmc: tmio: use usleep_range consistently
Date: Tue, 14 Nov 2017 23:51:04 +0100
Message-ID: <20171114225104.6743-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

There are a few udelay() left which are in a range that they should be
usleep_range() these days.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Works fine for me on Lager (R-Car H2) and Salvator-X (R-Car M3-W).
Testing on other platforms very welcome even though this should be
independent of the IP core.

 drivers/mmc/host/tmio_mmc_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 583bf3262df5d4..d6ca57be16c2fd 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -806,7 +806,7 @@ static int tmio_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (ret == 0)
 			set_bit(i, host->taps);
 
-		mdelay(1);
+		usleep_range(1000, 1200);
 	}
 
 	ret = host->select_tuning(host);
@@ -958,7 +958,7 @@ static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 		 * 100us were not enough. Is this the same 140us delay, as in
 		 * tmio_mmc_set_ios()?
 		 */
-		udelay(200);
+		usleep_range(200, 300);
 	}
 	/*
 	 * It seems, VccQ should be switched on after Vcc, this is also what the
@@ -966,7 +966,7 @@ static void tmio_mmc_power_on(struct tmio_mmc_host *host, unsigned short vdd)
 	 */
 	if (!IS_ERR(mmc->supply.vqmmc) && !ret) {
 		ret = regulator_enable(mmc->supply.vqmmc);
-		udelay(200);
+		usleep_range(200, 300);
 	}
 
 	if (ret < 0)
@@ -1059,7 +1059,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	/* Let things settle. delay taken from winCE driver */
-	udelay(140);
+	usleep_range(140, 200);
 	if (PTR_ERR(host->mrq) == -EINTR)
 		dev_dbg(&host->pdev->dev,
 			"%s.%d: IOS interrupted: clk %u, mode %u",
-- 
2.11.0
