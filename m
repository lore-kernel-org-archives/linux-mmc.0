From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 13/17] mmc: host: omap_hsmmc: enable/disable vmmc_aux regulator based on prior state
Date: Wed, 29 Jul 2015 16:39:43 +0530
Message-ID: <1438168187-1614-14-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

enable vmmc_aux regulator only if it is in disabled state and disable
vmmc_aux regulator only if it is in enabled state.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 58bda42..001f8a0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -258,7 +258,7 @@ static int omap_hsmmc_enable_supply(struct mmc_host *mmc, int vdd)
 	}
 
 	/* Enable interface voltage rail, if needed */
-	if (mmc->supply.vqmmc) {
+	if (mmc->supply.vqmmc && !regulator_is_enabled(mmc->supply.vqmmc)) {
 		ret = regulator_enable(mmc->supply.vqmmc);
 		if (ret) {
 			dev_err(mmc_dev(mmc), "vmmc_aux reg enable failed\n");
@@ -280,7 +280,7 @@ static int omap_hsmmc_disable_supply(struct mmc_host *mmc)
 	int ret;
 	int status;
 
-	if (mmc->supply.vqmmc) {
+	if (mmc->supply.vqmmc && regulator_is_enabled(mmc->supply.vqmmc)) {
 		ret = regulator_disable(mmc->supply.vqmmc);
 		if (ret) {
 			dev_err(mmc_dev(mmc), "vmmc_aux reg disable failed\n");
-- 
1.7.9.5
