From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] mmc: tmio: move MFD variant reset to a platform hook
Date: Mon,  1 Oct 2018 21:31:01 +0900
Message-ID: <1538397062-19162-2-git-send-email-yamada.masahiro@socionext.com>
References: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538397062-19162-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

CTL_RESET_SDIO register is specific to the TMIO MFD (tmio_mmc.c).

Add a new hook host->reset for performing a platform-specific reset
sequence, and move CTL_RESET_SDIO over there.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc.c      | 9 +++++++++
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 7 +++----
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e04c322..c8e90cf 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -78,6 +78,14 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	tmio_mmc_clk_start(host);
 }
 
+static void tmio_mmc_reset(struct tmio_mmc_host *host)
+{
+	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
+	usleep_range(10000, 11000);
+	sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
+	usleep_range(10000, 11000);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int tmio_mmc_suspend(struct device *dev)
 {
@@ -156,6 +164,7 @@ static int tmio_mmc_probe(struct platform_device *pdev)
 	/* SD control register space size is 0x200, 0x400 for bus_shift=1 */
 	host->bus_shift = resource_size(res) >> 10;
 	host->set_clock = tmio_mmc_set_clock;
+	host->reset = tmio_mmc_reset;
 
 	host->mmc->f_max = pdata->hclk;
 	host->mmc->f_min = pdata->hclk / 512;
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index e6aa13a..a1a661b 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -176,6 +176,7 @@ struct tmio_mmc_host {
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	void (*reset)(struct tmio_mmc_host *host);
 	void (*hw_reset)(struct tmio_mmc_host *host);
 	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
 	bool (*check_scc_error)(struct tmio_mmc_host *host);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 0611824..fad840a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -164,14 +164,13 @@ static void tmio_mmc_reset(struct tmio_mmc_host *host)
 {
 	/* FIXME - should we set stop clock reg here */
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0000);
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
-		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0000);
 	usleep_range(10000, 11000);
 	sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
-	if (host->pdata->flags & TMIO_MMC_HAVE_HIGH_REG)
-		sd_ctrl_write16(host, CTL_RESET_SDIO, 0x0001);
 	usleep_range(10000, 11000);
 
+	if (host->reset)
+		host->reset(host);
+
 	if (host->pdata->flags & TMIO_MMC_SDIO_IRQ) {
 		sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
 		sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
-- 
2.7.4
