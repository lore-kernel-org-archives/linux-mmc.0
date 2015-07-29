From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/17] mmc: host: omap_hsmmc: use the ocrmask provided by the vmmc regulator
Date: Wed, 29 Jul 2015 16:39:34 +0530
Message-ID: <1438168187-1614-5-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

If the vmmc regulator provides a valid ocrmask, use it. By this even if
the pdata has a valid ocrmask, it will be overwritten with the ocrmask
of the vmmc regulator.
Also remove the unnecessary compatibility check between the ocrmask in
the pdata and the ocrmask from the vmmc regulator.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index a78e15e..0e690d7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -352,16 +352,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 		host->vcc = NULL;
 	} else {
 		ocr_value = mmc_regulator_get_ocrmask(host->vcc);
-		if (!mmc_pdata(host)->ocr_mask) {
+		if (ocr_value > 0)
 			mmc_pdata(host)->ocr_mask = ocr_value;
-		} else {
-			if (!(mmc_pdata(host)->ocr_mask & ocr_value)) {
-				dev_err(host->dev, "ocrmask %x is not supported\n",
-					mmc_pdata(host)->ocr_mask);
-				mmc_pdata(host)->ocr_mask = 0;
-				return -EINVAL;
-			}
-		}
 	}
 	mmc_pdata(host)->set_power = omap_hsmmc_set_power;
 
-- 
1.7.9.5
