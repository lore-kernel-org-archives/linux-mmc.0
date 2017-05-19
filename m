From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 03/41] mmc: host: omap_hsmmc: Program HCTL based on
 signal_voltage set by mmc core
Date: Fri, 19 May 2017 13:45:03 +0530
Message-ID: <20170519081541.26753-4-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, nsekhar@ti.com, Jonathan Corbet <corbet@lwn.net>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

HCTL is now set based on ios.signal_voltage set by mmc core and not
hardcoded to 3V0 if OMAP_HSMMC_SUPPORTS_DUAL_VOLT is set. If
OMAP_HSMMC_SUPPORTS_DUAL_VOLT is set, it means HCTL can be set to either
3V0 or 1V8. And it should be set to 3V0 or 1V8 depending on
ios.signal_voltage.
Also it is now set on power mode status being changed to MMC_POWER_ON.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 42954efe12f7..893d1624a5a3 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -229,6 +229,7 @@ struct omap_mmc_of_data {
 };
 
 static void omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host);
+static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host, int iov);
 
 static int omap_hsmmc_card_detect(struct device *dev)
 {
@@ -1664,6 +1665,7 @@ static void omap_hsmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			omap_hsmmc_set_power(host, 1, ios->vdd);
 			break;
 		case MMC_POWER_ON:
+			omap_hsmmc_conf_bus_power(host, ios->signal_voltage);
 			do_send_init_stream = 1;
 			break;
 		}
@@ -1824,17 +1826,12 @@ static void omap_hsmmc_set_capabilities(struct omap_hsmmc_host *host)
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
@@ -2144,7 +2141,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	mmc->pm_caps |= mmc_pdata(host)->pm_caps;
 
 	omap_hsmmc_set_capabilities(host);
-	omap_hsmmc_conf_bus_power(host);
 
 	host->rx_chan = dma_request_chan(&pdev->dev, "rx");
 	if (IS_ERR(host->rx_chan)) {
@@ -2281,6 +2277,7 @@ static int omap_hsmmc_suspend(struct device *dev)
 static int omap_hsmmc_resume(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
+	struct mmc_ios *ios;
 
 	if (!host)
 		return 0;
@@ -2290,8 +2287,9 @@ static int omap_hsmmc_resume(struct device *dev)
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
 
+	ios = &host->mmc->ios;
 	if (!(host->mmc->pm_flags & MMC_PM_KEEP_POWER))
-		omap_hsmmc_conf_bus_power(host);
+		omap_hsmmc_conf_bus_power(host, ios->signal_voltage);
 
 	omap_hsmmc_protect_card(host);
 	pm_runtime_mark_last_busy(host->dev);
-- 
2.11.0
