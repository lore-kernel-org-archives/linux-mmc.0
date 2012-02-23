From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 4/6] mmc: omap_hsmmc: Get rid of omap_hsmmc_1_set_power
	function
Date: Thu, 23 Feb 2012 16:56:47 +0530
Message-ID: <1329996409-26861-5-git-send-email-rnayak@ti.com>
References: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1329996409-26861-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Use omap_hsmmc_235_set_poweri() (now renamed as omap_hsmmc_set_power())
for MMC1 instance as well and get rid of omap_hsmmc_1_set_power()
completely.
omap_hsmmc_235_set_power() seems to implemented as a superset of
omap_hsmmc_1_set_power() with additonal functionality implemented
based on additional checks and hence should just work for MMC1
as well.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Tested-by: Venkatraman S <svenkatr-l0cyMroinI0@public.gmane.org>
Tested-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
---
 drivers/mmc/host/omap_hsmmc.c |   30 +++---------------------------
 1 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 91faf42..f98c599 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -241,28 +241,7 @@ static int omap_hsmmc_resume_cdirq(struct device *dev, int slot)
 
 #ifdef CONFIG_REGULATOR
 
-static int omap_hsmmc_1_set_power(struct device *dev, int slot, int power_on,
-				  int vdd)
-{
-	struct omap_hsmmc_host *host =
-		platform_get_drvdata(to_platform_device(dev));
-	int ret;
-
-	if (mmc_slot(host).before_set_reg)
-		mmc_slot(host).before_set_reg(dev, slot, power_on, vdd);
-
-	if (power_on)
-		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
-	else
-		ret = mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
-
-	if (mmc_slot(host).after_set_reg)
-		mmc_slot(host).after_set_reg(dev, slot, power_on, vdd);
-
-	return ret;
-}
-
-static int omap_hsmmc_235_set_power(struct device *dev, int slot, int power_on,
+static int omap_hsmmc_set_power(struct device *dev, int slot, int power_on,
 				   int vdd)
 {
 	struct omap_hsmmc_host *host =
@@ -332,14 +311,11 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
 
 	switch (host->id) {
 	case OMAP_MMC1_DEVID:
-		/* On-chip level shifting via PBIAS0/PBIAS1 */
-		mmc_slot(host).set_power = omap_hsmmc_1_set_power;
-		break;
 	case OMAP_MMC2_DEVID:
 	case OMAP_MMC3_DEVID:
 	case OMAP_MMC5_DEVID:
-		/* Off-chip level shifting, or none */
-		mmc_slot(host).set_power = omap_hsmmc_235_set_power;
+		/* On-chip level shifting via PBIAS0/PBIAS1 */
+		mmc_slot(host).set_power = omap_hsmmc_set_power;
 		break;
 	case OMAP_MMC4_DEVID:
 		mmc_slot(host).set_power = omap_hsmmc_4_set_power;
-- 
1.7.1
