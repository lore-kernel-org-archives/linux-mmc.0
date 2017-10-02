From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 2/3] mmc: meson-gx: fix rx phase reset
Date: Mon,  2 Oct 2017 14:27:42 +0200
Message-ID: <20171002122743.32334-3-jbrunet@baylibre.com>
References: <20171002122743.32334-1-jbrunet@baylibre.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:55001 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751281AbdJBM1x (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Oct 2017 08:27:53 -0400
Received: by mail-wm0-f50.google.com with SMTP id i124so10216776wmf.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Oct 2017 05:27:52 -0700 (PDT)
In-Reply-To: <20171002122743.32334-1-jbrunet@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Resetting the phase when POWER_ON is set the set_ios() call means that the
phase is reset almost every time the set_ios() is called, while the
expected behavior was to reset the phase on a power cycle.

This had gone unnoticed until now because in all mode (except hs400) the
tuning is done after the last to set_ios(). In such case, the tuning
result is used anyway.  In HS400, there are a few calls to set_ios() after
the tuning is done, overwriting the tuning result.

Resetting the phase on POWER_UP instead of POWER_ON solve the problem.

Fixes: d341ca88eead ("mmc: meson-gx: rework tuning function")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 421c8719c202..08a55c2e96e1 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -745,6 +745,10 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_UP:
 		if (!IS_ERR(mmc->supply.vmmc))
 			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, ios->vdd);
+
+		/* Reset rx phase */
+		clk_set_phase(host->rx_clk, 0);
+
 		break;
 
 	case MMC_POWER_ON:
@@ -758,8 +762,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				host->vqmmc_enabled = true;
 		}
 
-		/* Reset rx phase */
-		clk_set_phase(host->rx_clk, 0);
 		break;
 	}
 
-- 
2.13.5

