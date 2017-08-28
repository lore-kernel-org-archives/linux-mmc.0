From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v3 11/13] mmc: meson-gx: implement voltage switch callback
Date: Mon, 28 Aug 2017 16:29:13 +0200
Message-ID: <20170828142915.27020-12-jbrunet@baylibre.com>
References: <20170828142915.27020-1-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170828142915.27020-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Implement voltage switch callback (shamelessly copied from sunxi mmc
driver). This allow, with the appropriate tuning function, to use
SD ultra high speed modes.

Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2fa18faa7f0f..0cffc705bfe3 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1049,6 +1049,27 @@ static int meson_mmc_card_busy(struct mmc_host *mmc)
 	return !(FIELD_GET(STATUS_DATI, regval) & 0xf);
 }
 
+static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	/* vqmmc regulator is available */
+	if (!IS_ERR(mmc->supply.vqmmc)) {
+		/*
+		 * The usual amlogic setup uses a GPIO to switch from one
+		 * regulator to the other. While the voltage ramp up is
+		 * pretty fast, care must be taken when switching from 3.3v
+		 * to 1.8v. Please make sure the regulator framework is aware
+		 * of your own regulator constraints
+		 */
+		return mmc_regulator_set_vqmmc(mmc, ios);
+	}
+
+	/* no vqmmc regulator, assume fixed regulator at 3/3.3V */
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+		return 0;
+
+	return -EINVAL;
+}
+
 static const struct mmc_host_ops meson_mmc_ops = {
 	.request	= meson_mmc_request,
 	.set_ios	= meson_mmc_set_ios,
@@ -1057,6 +1078,7 @@ static const struct mmc_host_ops meson_mmc_ops = {
 	.post_req	= meson_mmc_post_req,
 	.execute_tuning = meson_mmc_execute_tuning,
 	.card_busy	= meson_mmc_card_busy,
+	.start_signal_voltage_switch = meson_mmc_voltage_switch,
 };
 
 static int meson_mmc_probe(struct platform_device *pdev)
-- 
2.9.5
