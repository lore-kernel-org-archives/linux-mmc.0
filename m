From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v2 1/3] mmc: host: tmio: refactor calls to sdio irq
Date: Thu, 19 Jan 2017 21:07:16 +0100
Message-ID: <20170119200718.8115-2-wsa+renesas@sang-engineering.com>
References: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

tmio_mmc_sdio_irq() is not used as a seperate irq handler anymore, so we
can make it similar to the other irq helper functions, namely:

* only give the host as argument function which is what it really needs
* prefix function name with __

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/mmc/host/tmio_mmc_pio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a140848049ed81..6ab43892c132a9 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -756,9 +756,8 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host *host,
 	return false;
 }
 
-static void tmio_mmc_sdio_irq(int irq, void *devid)
+static void __tmio_mmc_sdio_irq(struct tmio_mmc_host *host)
 {
-	struct tmio_mmc_host *host = devid;
 	struct mmc_host *mmc = host->mmc;
 	struct tmio_mmc_data *pdata = host->pdata;
 	unsigned int ireg, status;
@@ -799,7 +798,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *devid)
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	tmio_mmc_sdio_irq(irq, devid);
+	__tmio_mmc_sdio_irq(host);
 
 	return IRQ_HANDLED;
 }
-- 
2.11.0
