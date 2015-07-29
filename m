From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 01/17] mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
Date: Wed, 29 Jul 2015 16:39:31 +0530
Message-ID: <1438168187-1614-2-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Since vmmc can be optional for some platforms, use
devm_regulator_get_optional() for vmmc. Now return error only
in the case of -EPROBE_DEFER and for all other cases set
host->vcc to NULL.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4d12032..b673e59 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -344,11 +344,13 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 	struct regulator *reg;
 	int ocr_value = 0;
 
-	reg = devm_regulator_get(host->dev, "vmmc");
+	reg = devm_regulator_get_optional(host->dev, "vmmc");
 	if (IS_ERR(reg)) {
-		dev_err(host->dev, "unable to get vmmc regulator %ld\n",
+		if (PTR_ERR(reg) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		host->vcc = NULL;
+		dev_dbg(host->dev, "unable to get vmmc regulator %ld\n",
 			PTR_ERR(reg));
-		return PTR_ERR(reg);
 	} else {
 		host->vcc = reg;
 		ocr_value = mmc_regulator_get_ocrmask(reg);
-- 
1.7.9.5
