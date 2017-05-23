From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH] mmc: tmio: make sure SDIO gets reinitialized after resume
Date: Tue, 23 May 2017 15:34:08 +0200
Message-ID: <20170523133408.11651-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
List-Id: linux-mmc@vger.kernel.org

To achieve that, we set the registers in the generic HW reset routine
which gets called at both, init and resume. We also make sure to move
SDIO initialization before reset gets called in probe().

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>
---

Changes since RFT:
* added tag from Hayakawa-san (thanks!)
* rebased to mmc/next (on top of the DMA refactor series)

 drivers/mmc/host/tmio_mmc_core.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index e1ad461c4b8c8f..ed40681253497a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -265,6 +265,12 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
 		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
 	msleep(10);
+
+	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
+		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
+		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
+	}
+
 }
 
 static void tmio_mmc_reset_work(struct work_struct *work)
@@ -1280,6 +1286,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (_host->native_hotplug)
 		pm_runtime_get_noresume(&pdev->dev);
 
+	_host->sdio_irq_enabled = false;
+	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
+		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
+
 	tmio_mmc_clk_stop(_host);
 	tmio_mmc_reset(_host);
 
@@ -1296,13 +1306,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	_host->sdcard_irq_mask &= ~irq_mask;
 
-	_host->sdio_irq_enabled = false;
-	if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
-		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
-		sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
-		sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0001);
-	}
-
 	spin_lock_init(&_host->lock);
 	mutex_init(&_host->ios_lock);
 
-- 
2.11.0
