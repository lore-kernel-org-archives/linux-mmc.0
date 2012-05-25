From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 1/8 v3] mmc: tmio: stop interface clock before runtime PM suspending
Date: Fri, 25 May 2012 17:45:27 +0200
Message-ID: <1337960752-4944-13-git-send-email-g.liakhovetski@gmx.de>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

The call to pm_runtime_put() in tmio-mmc's .set_ios() method can switch
off the supplying clock or even power down the whole unit. Therefore,
calling tmio_mmc_clk_stop() after that can be redundant, put it before.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/tmio_mmc_pio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 9a7996a..0d2643b 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -809,11 +809,11 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	} else if (ios->power_mode != MMC_POWER_UP) {
 		if (host->set_pwr && ios->power_mode == MMC_POWER_OFF)
 			host->set_pwr(host->pdev, 0);
+		tmio_mmc_clk_stop(host);
 		if (host->power) {
 			host->power = false;
 			pm_runtime_put(dev);
 		}
-		tmio_mmc_clk_stop(host);
 	}
 
 	switch (ios->bus_width) {
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
