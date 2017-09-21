From: Kyle Roeschley <kyle.roeschley@ni.com>
Subject: [PATCH] mmc: core: Wait for Vdd to settle on card power off
Date: Thu, 21 Sep 2017 12:47:54 -0500
Message-ID: <20170921174754.13648-1-kyle.roeschley@ni.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
lowered to less than 0.5V for a minimum of 1 ms when powering off a
card. Increase our wait to 10 ms so that voltage has time to drain down
to 0.5V and cards can power off correctly.

Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
---
 drivers/mmc/core/core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 66c9cf49ad2f..38630246de26 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1679,18 +1679,16 @@ void mmc_power_off(struct mmc_host *host)
 	mmc_set_initial_state(host);
 
 	/*
-	 * Some configurations, such as the 802.11 SDIO card in the OLPC
-	 * XO-1.5, require a short delay after poweroff before the card
-	 * can be successfully turned on again.
+	 * The SD spec requires at least 1 ms with Vdd at less than 0.5 V
+	 * before a card can be re-powered, but we need to wait longer so that
+	 * the voltage has time to drain.
 	 */
-	mmc_delay(1);
+	mmc_delay(10);
 }
 
 void mmc_power_cycle(struct mmc_host *host, u32 ocr)
 {
 	mmc_power_off(host);
-	/* Wait at least 1 ms according to SD spec */
-	mmc_delay(1);
 	mmc_power_up(host, ocr);
 }
 
-- 
2.14.1
