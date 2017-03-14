From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 3/4] mmc: host: tmio: don't BUG on unsupported stop commands
Date: Tue, 14 Mar 2017 11:09:18 +0100
Message-ID: <20170314100919.25401-4-wsa+renesas@sang-engineering.com>
References: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170314100919.25401-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

Halting the kernel on an unsupported stop command seems overkill, report
the error and say what we already did (due to autocmd12) instead.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index ad2840e1bfae51..b47dd9195fe3fe 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -553,10 +553,11 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	}
 
 	if (stop) {
-		if (stop->opcode == MMC_STOP_TRANSMISSION && !stop->arg)
-			sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
-		else
-			BUG();
+		if (stop->opcode != MMC_STOP_TRANSMISSION || stop->arg)
+			dev_err(&host->pdev->dev, "unsupported stop: CMD%u,0x%x. We did CMD12,0\n",
+				stop->opcode, stop->arg);
+
+		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
 	}
 
 	schedule_work(&host->done);
-- 
2.11.0
