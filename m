From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v8 4/6] mmc: tmio: Add hw reset support
Date: Thu,  3 Nov 2016 15:16:02 +0100
Message-ID: <1478182564-18762-5-git-send-email-horms+renesas@verge.net.au>
References: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1478182564-18762-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Ai Kyuse <ai.kyuse.uw@renesas.com>, Simon Horman <horms+renesas@verge.net.au>
List-Id: linux-mmc@vger.kernel.org

From: Ai Kyuse <ai.kyuse.uw@renesas.com>

Add hw reset support.

Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
This is required by tuning support which will
be introduced by follow-up patches.

v6
* Rely on core to retune on reset

v5
* As suggested by Ulf Hansson
  - Broke out of a larger patch
---
 drivers/mmc/host/tmio_mmc.h     | 1 +
 drivers/mmc/host/tmio_mmc_pio.c | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index b93762950e8f..c5adf52fc049 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -167,6 +167,7 @@ struct tmio_mmc_host {
 	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
 					   struct mmc_ios *ios);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
+	void (*hw_reset)(struct tmio_mmc_host *host);
 };
 
 struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 0ae967087ea1..ce6e93758576 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -759,6 +759,14 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
 	return 0;
 }
 
+static void tmio_mmc_hw_reset(struct mmc_host *mmc)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	if (host->hw_reset)
+		host->hw_reset(host);
+}
+
 /* Process requests from the MMC layer */
 static void tmio_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
@@ -975,6 +983,7 @@ static struct mmc_host_ops tmio_mmc_ops = {
 	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 	.multi_io_quirk	= tmio_multi_io_quirk,
+	.hw_reset	= tmio_mmc_hw_reset,
 };
 
 static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
-- 
2.7.0.rc3.207.g0ac5344
