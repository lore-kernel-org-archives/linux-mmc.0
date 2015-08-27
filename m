From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 01/15] mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
Date: Thu, 27 Aug 2015 14:43:53 +0530
Message-ID: <1440666847-12594-2-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Since vmmc can be optional for some platforms, use
devm_regulator_get_optional() for vmmc. Now return error only
if the return value of devm_regulator_get_optional() is not the
same as -ENODEV, since with -EPROBE_DEFER, the regulator can be
obtained later and all other errors are fatal.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 19ae7e6..9b335af 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -345,15 +345,19 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 {
 	struct regulator *reg;
 	int ocr_value = 0;
+	int ret;
 
 	if (mmc_pdata(host)->set_power)
 		return 0;
 
-	reg = devm_regulator_get(host->dev, "vmmc");
+	reg = devm_regulator_get_optional(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
-		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
+		ret = PTR_ERR(reg);
+		if (ret != -ENODEV)
+			return ret;
+		host->vcc = NULL;
+		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
 			PTR_ERR(reg));
-		return PTR_ERR(reg);
 	} else {
 		host->vcc = reg;
 		ocr_value = mmc_regulator_get_ocrmask(reg);
-- 
1.7.9.5
