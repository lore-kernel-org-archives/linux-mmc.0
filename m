From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH/RFT] mmc: meson-gx: include tx phase in the tuning process
Date: Mon, 18 Sep 2017 15:44:31 +0200
Message-ID: <20170918134431.17520-1-jbrunet@baylibre.com>
References: <b31253d8-38a3-dd25-1d74-6afde6ae8362@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:47866 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbdIRNog (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Sep 2017 09:44:36 -0400
Received: by mail-wm0-f48.google.com with SMTP id 13so2838206wmq.2
        for <linux-mmc@vger.kernel.org>; Mon, 18 Sep 2017 06:44:36 -0700 (PDT)
In-Reply-To: <b31253d8-38a3-dd25-1d74-6afde6ae8362@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org

It has been reported that some platforms (odroid-c2) may require
a different tx phase setting to operate at high speed.

To improve the situation, this patch includes tx phase in the tuning
process.

Reported-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Hi Heiner,

Would you mind trying this change with your setup and letting us know
if it helps ?

It seems like a good idea to add an initial Rx tuning before doing the
actual tuning but, honestly, I don't know if it is really necessary.

Regards

Jerome


 drivers/mmc/host/meson-gx-mmc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index c885c2d4b904..0254d8bfd536 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -717,6 +717,22 @@ static int meson_mmc_clk_phase_tuning(struct mmc_host *mmc, u32 opcode,
 static int meson_mmc_execute_tuning(struct mmc_host *mmc, u32 opcode)
 {
 	struct meson_host *host = mmc_priv(mmc);
+	int ret;
+
+	/*
+	 * If this is the initial tuning, try to get a sane Rx starting
+	 * phase before doing the actual tuning.
+	 */
+	if (!mmc->doing_retune) {
+		ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
+
+		if (ret)
+			return ret;
+	}
+
+	ret = meson_mmc_clk_phase_tuning(mmc, opcode, host->tx_clk);
+	if (ret)
+		return ret;
 
 	return meson_mmc_clk_phase_tuning(mmc, opcode, host->rx_clk);
 }
-- 
2.13.5

