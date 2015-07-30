From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 03/11] mmc: host: omap_hsmmc: program HCTL based on
 signal_voltage set by mmc core
Date: Thu, 30 Jul 2015 13:16:26 +0530
Message-ID: <1438242394-25599-4-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: mugunthanvnm@ti.com, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

HCTL is now set based on ios.signal_voltage set by mmc core and not
hardcoded to 3V0 if OMAP_HSMMC_SUPPORTS_DUAL_VOLT is set. If
OMAP_HSMMC_SUPPORTS_DUAL_VOLT is set, it means HCTL can be set to either
3V0 or 1V8. And it should be set to 3V0 or 1V8 depending on
ios.signal_voltage.
Also it is now set on power mode status being changed to MMC_POWER_ON.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2dfef11..306e5c0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -228,6 +228,7 @@ struct omap_mmc_of_data {
 };
 
 static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
+static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host, int iov);
 
 static int omap_hsmmc_card_detect(struct device *dev)
 {
@@ -1665,6 +1666,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			mmc_pdata(host)->set_power(host->dev, 1, ios->vdd);
 			break;
 		case MMC_POWER_ON:
+			omap_hsmmc_conf_bus_power(host, ios->signal_voltage);
 			do_send_init_stream = 1;
 			break;
 		}
@@ -1827,17 +1829,12 @@ static void omap_hsmmc_set_capabilities(struct omap_hsmmc_host *host)
 	OMAP_HSMMC_WRITE(host->base, CAPA, val);
 }
 
-static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
+static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host, int iov)
 {
 	u32 hctl, value;
 
-	/* Only MMC1 supports 3.0V */
-	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT)
-		hctl = SDVS30;
-	else
-		hctl = SDVS18;
-
 	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
+	hctl = (iov == MMC_SIGNAL_VOLTAGE_180) ? SDVS18 : SDVS30;
 	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
 
 	/* Set SD bus power bit */
@@ -2143,7 +2140,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->pm_caps |= mmc_pdata(host)->pm_caps;
 
 	omap_hsmmc_set_capabilities(host);
-	omap_hsmmc_conf_bus_power(host);
 
 	if (!pdev->dev.of_node) {
 		res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
@@ -2318,6 +2314,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 static int omap_hsmmc_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+	struct mmc_ios *ios;
 
 	if (!host)
 		return 0;
@@ -2327,8 +2324,9 @@ static int omap_hsmmc_resume(struct device *dev)
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
 
+	ios = &host->mmc->ios;
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
-		omap_hsmmc_conf_bus_power(host);
+		omap_hsmmc_conf_bus_power(host, ios->signal_voltage);
 
 	omap_hsmmc_protect_card(host);
 	pm_runtime_mark_last_busy(host->dev);
-- 
1.7.9.5
