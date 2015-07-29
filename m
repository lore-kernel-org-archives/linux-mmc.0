From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/17] mmc: host: omap_hsmmc: return error from omap_hsmmc_reg_get on -EPROBE_DEFER
Date: Wed, 29 Jul 2015 16:39:32 +0530
Message-ID: <1438168187-1614-3-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

EPROBE_DEFER is not fatal and it means the regulator can still be
obtained. Hence return error if devm_regulator_get_optional for
vmmc_aux and pbias returns -EPROBE_DEFER. This gives omap_hsmmc
driver another chance to get these regulators.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index b673e59..7f7625d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -369,10 +369,26 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 	/* Allow an aux regulator */
 	reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
-	host->vcc_aux = IS_ERR(reg) ? NULL : reg;
+	if (IS_ERR(reg)) {
+		if (PTR_ERR(reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		host->vcc_aux = NULL;
+		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
+			PTR_ERR(reg));
+	} else {
+		host->vcc_aux = reg;
+	}
 
 	reg = devm_regulator_get_optional(host->dev, "pbias");
-	host->pbias = IS_ERR(reg) ? NULL : reg;
+	if (IS_ERR(reg)) {
+		if (PTR_ERR(reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		host->pbias = NULL;
+		dev_dbg(host->dev, "unable to get pbias regulator %ld\n",
+			PTR_ERR(reg));
+	} else {
+		host->pbias = reg;
+	}
 
 	/* For eMMC do not power off when not in sleep state */
 	if (mmc_pdata(host)->no_regulator_off_init)
-- 
1.7.9.5
