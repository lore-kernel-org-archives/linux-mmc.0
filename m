From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 02/15] mmc: host: omap_hsmmc: return on fatal errors from omap_hsmmc_reg_get
Date: Thu, 27 Aug 2015 14:43:54 +0530
Message-ID: <1440666847-12594-3-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Now return error only if the return value of
devm_regulator_get_optional() is not the same as -ENODEV, since with
-EPROBE_DEFER, the regulator can be obtained later and all other
errors are fatal.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 9b335af..2eafd6f 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -375,10 +375,28 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 	/* Allow an aux regulator */
 	reg = devm_regulator_get_optional(host->dev, "vmmc_aux");
-	host->vcc_aux = IS_ERR(reg) ? NULL : reg;
+	if (IS_ERR(reg)) {
+		ret = PTR_ERR(reg);
+		if (ret != -ENODEV)
+			return ret;
+		host->vcc_aux = NULL;
+		dev_dbg(host->dev, "unable to get vmmc_aux regulator %ld\n",
+			PTR_ERR(reg));
+	} else {
+		host->vcc_aux = reg;
+	}
 
 	reg = devm_regulator_get_optional(host->dev, "pbias");
-	host->pbias = IS_ERR(reg) ? NULL : reg;
+	if (IS_ERR(reg)) {
+		ret = PTR_ERR(reg);
+		if (ret != -ENODEV)
+			return ret;
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
