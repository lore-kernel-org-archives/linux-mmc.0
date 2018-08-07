From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [v0.1 PATCH 1/7] mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
Date: Tue,  7 Aug 2018 15:17:16 +0900
Message-ID: <1533622642-13989-2-git-send-email-yamada.masahiro@socionext.com>
References: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-renesas-soc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Jassi Brar <jaswinder.singh@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

tmio_mmc_clk_stop(host) is equivalent to tmio_mmc_set_clock(host, 0).
This replacement is needed for the next commit.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/tmio_mmc_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 3cb554c..991b340 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1032,7 +1032,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		tmio_mmc_power_off(host);
-		tmio_mmc_clk_stop(host);
+		tmio_mmc_set_clock(host, 0);
 		break;
 	case MMC_POWER_UP:
 		tmio_mmc_power_on(host, ios->vdd);
@@ -1269,7 +1269,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (pdata->flags & TMIO_MMC_SDIO_IRQ)
 		_host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
 
-	tmio_mmc_clk_stop(_host);
+	tmio_mmc_set_clock(_host, 0);
 	tmio_mmc_reset(_host);
 
 	_host->sdcard_irq_mask = sd_ctrl_read16_and_16_as_32(_host, CTL_IRQ_MASK);
@@ -1353,7 +1353,7 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
 
 	if (host->clk_cache)
-		tmio_mmc_clk_stop(host);
+		tmio_mmc_set_clock(host, 0);
 
 	tmio_mmc_clk_disable(host);
 
-- 
2.7.4
