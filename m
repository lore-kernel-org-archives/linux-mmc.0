From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 07/22] mmc: tmio, renesas_sdhi: set mmc_host_ops hooks directly
Date: Sat, 25 Nov 2017 01:24:42 +0900
Message-ID: <1511540697-27387-8-git-send-email-yamada.masahiro@socionext.com>
References: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511540697-27387-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <simon.horman@netronome.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Drivers can set any mmc_host_ops hooks between tmio_mmc_host_alloc()
and tmio_mmc_host_probe().  Remove duplicated hooks in tmio_mmc_host.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Changes in v2:
  - Rename "mmc_host_ops" to "ops" per Wolfram Sang

 drivers/mmc/host/renesas_sdhi_core.c | 4 ++--
 drivers/mmc/host/tmio_mmc.h          | 3 ---
 drivers/mmc/host/tmio_mmc_core.c     | 4 ----
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 9baf4d1..267e2e0 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -549,8 +549,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	/* SDR speeds are only available on Gen2+ */
 	if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
 		/* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
-		host->card_busy	= renesas_sdhi_card_busy;
-		host->start_signal_voltage_switch =
+		host->ops.card_busy = renesas_sdhi_card_busy;
+		host->ops.start_signal_voltage_switch =
 			renesas_sdhi_start_signal_voltage_switch;
 	}
 
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 4fdb51b..37409c5 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -186,9 +186,6 @@ struct tmio_mmc_host {
 	void (*clk_disable)(struct tmio_mmc_host *host);
 	int (*multi_io_quirk)(struct mmc_card *card,
 			      unsigned int direction, int blk_size);
-	int (*card_busy)(struct mmc_host *mmc);
-	int (*start_signal_voltage_switch)(struct mmc_host *mmc,
-					   struct mmc_ios *ios);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	void (*hw_reset)(struct tmio_mmc_host *host);
 	void (*prepare_tuning)(struct tmio_mmc_host *host, unsigned long tap);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index af9ed6a..46f77c3 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1205,10 +1205,6 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	if (ret < 0)
 		return ret;
 
-	_host->ops.card_busy = _host->card_busy;
-	_host->ops.start_signal_voltage_switch =
-		_host->start_signal_voltage_switch;
-
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
 	mmc->max_segs = pdata->max_segs ? : 32;
-- 
2.7.4
