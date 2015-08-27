From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 04/15] mmc: host: omap_hsmmc: use the ocrmask provided by the vmmc regulator
Date: Thu, 27 Aug 2015 14:43:56 +0530
Message-ID: <1440666847-12594-5-git-send-email-kishon@ti.com>
References: <1440666847-12594-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440666847-12594-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, afenkart@gmail.com, tony@atomide.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: neilb@suse.de, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

If the vmmc regulator provides a valid ocrmask, use it. By this even if
the pdata has a valid ocrmask, it will be overwritten with the ocrmask
of the vmmc regulator.
Also remove the unnecessary compatibility check between the ocrmask in
the pdata and the ocrmask from the vmmc regulator.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/omap_hsmmc.c |   10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 3fde2f9..30f363d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -359,16 +359,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
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
 
 	/* Allow an aux regulator */
-- 
1.7.9.5
