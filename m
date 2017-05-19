From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 02/41] mmc: host: omap_hsmmc: Separate setting voltage
 capabilities from bus power
Date: Fri, 19 May 2017 13:45:02 +0530
Message-ID: <20170519081541.26753-3-kishon@ti.com>
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

Add a separate function to set the voltage capabilities of the host
controller. Voltage capabilities should be set only once during
controller initialization but bus power can be changed every time there
is a voltage switch and whenever a different card is inserted.
This allows omap_hsmmc_conf_bus_power to be invoked every time there
is a voltage switch.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 2000aaa359c8..42954efe12f7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1809,25 +1809,34 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
 	return ret;
 }
 
+static void omap_hsmmc_set_capabilities(struct omap_hsmmc_host *host)
+{
+	u32 val;
+
+	val = OMAP_HSMMC_READ(host->base, CAPA);
+
+	/* Only MMC1 supports 3.0V */
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT)
+		val |= (VS30 | VS18);
+	else
+		val |= VS18;
+
+	OMAP_HSMMC_WRITE(host->base, CAPA, val);
+}
+
 static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
 {
-	u32 hctl, capa, value;
+	u32 hctl, value;
 
 	/* Only MMC1 supports 3.0V */
-	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT)
 		hctl = SDVS30;
-		capa = VS30 | VS18;
-	} else {
+	else
 		hctl = SDVS18;
-		capa = VS18;
-	}
 
 	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
 	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
 
-	value = OMAP_HSMMC_READ(host->base, CAPA);
-	OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
-
 	/* Set SD bus power bit */
 	set_sd_bus_power(host);
 }
@@ -2134,6 +2143,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	mmc->pm_caps |= mmc_pdata(host)->pm_caps;
 
+	omap_hsmmc_set_capabilities(host);
 	omap_hsmmc_conf_bus_power(host);
 
 	host->rx_chan = dma_request_chan(&pdev->dev, "rx");
-- 
2.11.0
