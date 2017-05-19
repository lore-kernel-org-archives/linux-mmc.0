From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 16/41] mmc: omap_hsmmc: Support non-1.8V IO controllers
Date: Fri, 19 May 2017 13:45:16 +0530
Message-ID: <20170519081541.26753-17-kishon@ti.com>
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

From: Sekhar Nori <nsekhar@ti.com>

OMAP HSMMC driver assumes that if the controller does
not support dual-volt, then it supports only 1.8V IO.

This assumption can be incorrect. For example, on K2G
MMC0 supports 3.3V IO only. AM57x Beagle-x15 and IDK
boards support only 3.3V IO on eMMC interface.

Support device-tree property "no-1-8-v" to for
controllers which are not dual-voltage and do not
support 1.8V IO.

Note that lack of support for this property has not
led to any known regression in affected platforms so
far. But it will be nice to be in sync with hardware
configuration.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c            | 15 ++++++++++++---
 include/linux/platform_data/hsmmc-omap.h |  5 +++++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index c6e3efb0f8fb..7c555e3ecce8 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -865,6 +865,9 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 		else
 			hctl = SDVS30;
 		capa = VS30 | VS18;
+	} else if (host->pdata->controller_flags & OMAP_HSMMC_NO_1_8_V) {
+		hctl = SDVS30;
+		capa = VS30;
 	} else {
 		hctl = SDVS18;
 		capa = VS18;
@@ -2121,11 +2124,14 @@ static void omap_hsmmc_set_capabilities(struct omap_hsmmc_host *host)
 
 	val = OMAP_HSMMC_READ(host->base, CAPA);
 
-	/* Only MMC1 supports 3.0V */
-	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT)
+	if (host->pdata->controller_flags & OMAP_HSMMC_SUPPORTS_DUAL_VOLT) {
 		val |= (VS30 | VS18);
-	else
+	} else if (host->pdata->controller_flags & OMAP_HSMMC_NO_1_8_V) {
+		val |= VS30;
+		val &= ~VS18;
+	} else {
 		val |= VS18;
+	}
 
 	OMAP_HSMMC_WRITE(host->base, CAPA, val);
 }
@@ -2567,6 +2573,9 @@ static struct omap_hsmmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	if (of_find_property(np, "ti,dual-volt", NULL))
 		pdata->controller_flags |= OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
 
+	if (of_find_property(np, "no-1-8-v", NULL))
+		pdata->controller_flags |= OMAP_HSMMC_NO_1_8_V;
+
 	pdata->gpio_cd = -EINVAL;
 	pdata->gpio_cod = -EINVAL;
 	pdata->gpio_wp = -EINVAL;
diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux/platform_data/hsmmc-omap.h
index c3f2a34db97a..d7be21dc9ffd 100644
--- a/include/linux/platform_data/hsmmc-omap.h
+++ b/include/linux/platform_data/hsmmc-omap.h
@@ -23,12 +23,17 @@
  *    for example Advisory 2.1.1.128 "MMC: Multiple Block Read
  *    Operation Issue" in _OMAP3530/3525/3515/3503 Silicon Errata_
  *    Revision F (October 2010) (SPRZ278F).
+ *
+ * OMAP_HSMMC_NO_1_8_V: The controller does not support 1.8V IO voltage
+ *    irrespective of what the capability states.
+ *
  */
 #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
 #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
 #define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
 #define OMAP_HSMMC_REQUIRE_IODELAY		BIT(3)
 #define OMAP_HSMMC_HAS_HWPARAM			BIT(4)
+#define OMAP_HSMMC_NO_1_8_V			BIT(5)
 
 struct omap_hsmmc_dev_attr {
 	u8 flags;
-- 
2.11.0
