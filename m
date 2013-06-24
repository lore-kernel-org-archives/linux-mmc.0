From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v13] ARM: edma: Add DT and runtime PM support to the
	private EDMA API
Date: Mon, 24 Jun 2013 15:36:41 +0530
Message-ID: <51C81A31.8080807@ti.com>
References: <51C41ED1.5040509@ti.com>
	<1371808390-17971-1-git-send-email-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371808390-17971-1-git-send-email-nsekhar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general@lists>
List-Id: linux-mmc@vger.kernel.org

On 6/21/2013 3:23 PM, Sekhar Nori wrote:
> From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> 
> Adds support for parsing the TI EDMA DT data into the required EDMA
> private API platform data. Enables runtime PM support to initialize
> the EDMA hwmod. Enables build on OMAP.
> 
> Changes by Joel:
> * Setup default one-to-one mapping for queue_priority and queue_tc
> mapping as discussed in [1].
> * Split out xbar stuff to separate patch. [1]
> * Dropped unused DT helper to convert to array
> 
> [1] https://patchwork.kernel.org/patch/2226761/
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> [nsekhar-l0cyMroinI0@public.gmane.org: fix checkpatch errors, build breakages. Introduce
> edma_setup_info_from_dt() as part of that effort]
> Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
> Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
> Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

So here is an updated version of this patch after merging your
fix sent over the weekend . I tested the on AM335x, DA850 and
DM644x boards using MMC/SD as the DMA client. With that I think
this has gotten enough testing now and I plan to send a pull
request for this later today and hope we make it in time.

Thanks,
Sekhar

---8<---
>From 6cba4355066bda19f14d4da66b8abbca0ffdfd59 Mon Sep 17 00:00:00 2001
From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Date: Thu, 20 Jun 2013 16:06:38 -0500
Subject: [PATCH 3/4] ARM: edma: Add DT and runtime PM support to the private
 EDMA API

Adds support for parsing the TI EDMA DT data into the required EDMA
private API platform data. Enables runtime PM support to initialize
the EDMA hwmod. Enables build on OMAP.

Changes by Joel:
* Setup default one-to-one mapping for queue_priority and queue_tc
mapping as discussed in [1].
* Split out xbar stuff to separate patch. [1]
* Dropped unused DT helper to convert to array
* Fixed dangling pointer issue with Sekhar's changes

[1] https://patchwork.kernel.org/patch/2226761/

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
[nsekhar-l0cyMroinI0@public.gmane.org: fix checkpatch errors, build breakages. Introduce
edma_setup_info_from_dt() as part of that effort]
Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/common/edma.c                    |  186 +++++++++++++++++++++++++++--
 arch/arm/mach-davinci/devices-da8xx.c     |    8 +-
 arch/arm/mach-davinci/devices-tnetv107x.c |    4 +-
 arch/arm/mach-davinci/dm355.c             |    4 +-
 arch/arm/mach-davinci/dm365.c             |    4 +-
 arch/arm/mach-davinci/dm644x.c            |    4 +-
 arch/arm/mach-davinci/dm646x.c            |    4 +-
 include/linux/platform_data/edma.h        |    4 +-
 8 files changed, 189 insertions(+), 29 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 7658874..5183a31 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -25,6 +25,13 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/edma.h>
+#include <linux/err.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/of_irq.h>
+#include <linux/pm_runtime.h>
 
 #include <linux/platform_data/edma.h>
 
@@ -1369,13 +1376,110 @@ void edma_clear_event(unsigned channel)
 }
 EXPORT_SYMBOL(edma_clear_event);
 
-/*-----------------------------------------------------------------------*/
+#if IS_ENABLED(CONFIG_OF) && IS_ENABLED(CONFIG_DMADEVICES)
+
+static int edma_of_parse_dt(struct device *dev,
+			    struct device_node *node,
+			    struct edma_soc_info *pdata)
+{
+	int ret = 0, i;
+	u32 value;
+	struct edma_rsv_info *rsv_info;
+	s8 (*queue_tc_map)[2], (*queue_priority_map)[2];
+
+	memset(pdata, 0, sizeof(struct edma_soc_info));
+
+	ret = of_property_read_u32(node, "dma-channels", &value);
+	if (ret < 0)
+		return ret;
+	pdata->n_channel = value;
+
+	ret = of_property_read_u32(node, "ti,edma-regions", &value);
+	if (ret < 0)
+		return ret;
+	pdata->n_region = value;
+
+	ret = of_property_read_u32(node, "ti,edma-slots", &value);
+	if (ret < 0)
+		return ret;
+	pdata->n_slot = value;
+
+	pdata->n_cc = 1;
+
+	rsv_info = devm_kzalloc(dev, sizeof(struct edma_rsv_info), GFP_KERNEL);
+	if (!rsv_info)
+		return -ENOMEM;
+	pdata->rsv = rsv_info;
+
+	queue_tc_map = devm_kzalloc(dev, 8*sizeof(s8), GFP_KERNEL);
+	if (!queue_tc_map)
+		return -ENOMEM;
+
+	for (i = 0; i < 3; i++) {
+		queue_tc_map[i][0] = i;
+		queue_tc_map[i][1] = i;
+	}
+	queue_tc_map[i][0] = -1;
+	queue_tc_map[i][1] = -1;
+
+	pdata->queue_tc_mapping = queue_tc_map;
+
+	queue_priority_map = devm_kzalloc(dev, 8*sizeof(s8), GFP_KERNEL);
+	if (!queue_priority_map)
+		return -ENOMEM;
+
+	for (i = 0; i < 3; i++) {
+		queue_priority_map[i][0] = i;
+		queue_priority_map[i][1] = i;
+	}
+	queue_priority_map[i][0] = -1;
+	queue_priority_map[i][1] = -1;
+
+	pdata->queue_priority_mapping = queue_priority_map;
+
+	pdata->default_queue = 0;
 
-static int __init edma_probe(struct platform_device *pdev)
+	return ret;
+}
+
+static struct of_dma_filter_info edma_filter_info = {
+	.filter_fn = edma_filter_fn,
+};
+
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
+						      struct device_node *node)
+{
+	struct edma_soc_info *info;
+	int ret;
+
+	info = devm_kzalloc(dev, sizeof(struct edma_soc_info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	ret = edma_of_parse_dt(dev, node, info);
+	if (ret)
+		return ERR_PTR(ret);
+
+	dma_cap_set(DMA_SLAVE, edma_filter_info.dma_cap);
+	of_dma_controller_register(dev->of_node, of_dma_simple_xlate,
+				   &edma_filter_info);
+
+	return info;
+}
+#else
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
+						      struct device_node *node)
+{
+	return ERR_PTR(-ENOSYS);
+}
+#endif
+
+static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	**info = pdev->dev.platform_data;
-	const s8		(*queue_priority_mapping)[2];
-	const s8		(*queue_tc_mapping)[2];
+	struct edma_soc_info    *ninfo[EDMA_MAX_CC] = {NULL};
+	s8		(*queue_priority_mapping)[2];
+	s8		(*queue_tc_mapping)[2];
 	int			i, j, off, ln, found = 0;
 	int			status = -1;
 	const s16		(*rsv_chans)[2];
@@ -1383,17 +1487,56 @@ static int __init edma_probe(struct platform_device *pdev)
 	int			irq[EDMA_MAX_CC] = {0, 0};
 	int			err_irq[EDMA_MAX_CC] = {0, 0};
 	struct resource		*r[EDMA_MAX_CC] = {NULL};
+	struct resource		res[EDMA_MAX_CC];
 	char			res_name[10];
 	char			irq_name[10];
+	struct device_node	*node = pdev->dev.of_node;
+	struct device		*dev = &pdev->dev;
+	int			ret;
+
+	if (node) {
+		/* Check if this is a second instance registered */
+		if (arch_num_cc) {
+			dev_err(dev, "only one EDMA instance is supported via DT\n");
+			return -ENODEV;
+		}
+
+		ninfo[0] = edma_setup_info_from_dt(dev, node);
+		if (IS_ERR(ninfo[0])) {
+			dev_err(dev, "failed to get DT data\n");
+			return PTR_ERR(ninfo[0]);
+		}
+
+		info = ninfo;
+	}
 
 	if (!info)
 		return -ENODEV;
 
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret < 0) {
+		dev_err(dev, "pm_runtime_get_sync() failed\n");
+		return ret;
+	}
+
 	for (j = 0; j < EDMA_MAX_CC; j++) {
-		sprintf(res_name, "edma_cc%d", j);
-		r[j] = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+		if (!info[j]) {
+			if (!found)
+				return -ENODEV;
+			break;
+		}
+		if (node) {
+			ret = of_address_to_resource(node, j, &res[j]);
+			if (!ret)
+				r[j] = &res[j];
+		} else {
+			sprintf(res_name, "edma_cc%d", j);
+			r[j] = platform_get_resource_byname(pdev,
+						IORESOURCE_MEM,
 						res_name);
-		if (!r[j] || !info[j]) {
+		}
+		if (!r[j]) {
 			if (found)
 				break;
 			else
@@ -1440,7 +1583,7 @@ static int __init edma_probe(struct platform_device *pdev)
 					off = rsv_chans[i][0];
 					ln = rsv_chans[i][1];
 					clear_bits(off, ln,
-						edma_cc[j]->edma_unused);
+						  edma_cc[j]->edma_unused);
 				}
 			}
 
@@ -1456,8 +1599,13 @@ static int __init edma_probe(struct platform_device *pdev)
 			}
 		}
 
-		sprintf(irq_name, "edma%d", j);
-		irq[j] = platform_get_irq_byname(pdev, irq_name);
+
+		if (node) {
+			irq[j] = irq_of_parse_and_map(node, 0);
+		} else {
+			sprintf(irq_name, "edma%d", j);
+			irq[j] = platform_get_irq_byname(pdev, irq_name);
+		}
 		edma_cc[j]->irq_res_start = irq[j];
 		status = devm_request_irq(&pdev->dev, irq[j],
 					  dma_irq_handler, 0, "edma",
@@ -1469,8 +1617,12 @@ static int __init edma_probe(struct platform_device *pdev)
 			return status;
 		}
 
-		sprintf(irq_name, "edma%d_err", j);
-		err_irq[j] = platform_get_irq_byname(pdev, irq_name);
+		if (node) {
+			err_irq[j] = irq_of_parse_and_map(node, 2);
+		} else {
+			sprintf(irq_name, "edma%d_err", j);
+			err_irq[j] = platform_get_irq_byname(pdev, irq_name);
+		}
 		edma_cc[j]->irq_res_end = err_irq[j];
 		status = devm_request_irq(&pdev->dev, err_irq[j],
 					  dma_ccerr_handler, 0,
@@ -1516,9 +1668,17 @@ static int __init edma_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id edma_of_ids[] = {
+	{ .compatible = "ti,edma3", },
+	{}
+};
 
 static struct platform_driver edma_driver = {
-	.driver.name	= "edma",
+	.driver = {
+		.name	= "edma",
+		.of_match_table = edma_of_ids,
+	},
+	.probe = edma_probe,
 };
 
 static int __init edma_init(void)
diff --git a/arch/arm/mach-davinci/devices-da8xx.c b/arch/arm/mach-davinci/devices-da8xx.c
index bf57252..eb254fe 100644
--- a/arch/arm/mach-davinci/devices-da8xx.c
+++ b/arch/arm/mach-davinci/devices-da8xx.c
@@ -105,27 +105,27 @@ struct platform_device da8xx_serial_device = {
 	},
 };
 
-static const s8 da8xx_queue_tc_mapping[][2] = {
+static s8 da8xx_queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
 	{1, 1},
 	{-1, -1}
 };
 
-static const s8 da8xx_queue_priority_mapping[][2] = {
+static s8 da8xx_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
 	{1, 7},
 	{-1, -1}
 };
 
-static const s8 da850_queue_tc_mapping[][2] = {
+static s8 da850_queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
 	{-1, -1}
 };
 
-static const s8 da850_queue_priority_mapping[][2] = {
+static s8 da850_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
 	{-1, -1}
diff --git a/arch/arm/mach-davinci/devices-tnetv107x.c b/arch/arm/mach-davinci/devices-tnetv107x.c
index 612a085..128cb9a 100644
--- a/arch/arm/mach-davinci/devices-tnetv107x.c
+++ b/arch/arm/mach-davinci/devices-tnetv107x.c
@@ -58,14 +58,14 @@
 #define TNETV107X_DMACH_SDIO1_RX		28
 #define TNETV107X_DMACH_SDIO1_TX		29
 
-static const s8 edma_tc_mapping[][2] = {
+static s8 edma_tc_mapping[][2] = {
 	/* event queue no	TC no	*/
 	{	 0,		 0	},
 	{	 1,		 1	},
 	{	-1,		-1	}
 };
 
-static const s8 edma_priority_mapping[][2] = {
+static s8 edma_priority_mapping[][2] = {
 	/* event queue no	Prio	*/
 	{	 0,		 3	},
 	{	 1,		 7	},
diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 526cf7d..42ef53f 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -569,7 +569,7 @@ static u8 dm355_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
-static const s8
+static s8
 queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
@@ -577,7 +577,7 @@ queue_tc_mapping[][2] = {
 	{-1, -1},
 };
 
-static const s8
+static s8
 queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index c4b7411..fa7af5e 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -826,7 +826,7 @@ static u8 dm365_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 };
 
 /* Four Transfer Controllers on DM365 */
-static const s8
+static s8
 dm365_queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
@@ -836,7 +836,7 @@ dm365_queue_tc_mapping[][2] = {
 	{-1, -1},
 };
 
-static const s8
+static s8
 dm365_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 7},
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index dd156d5..a49d182 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -497,7 +497,7 @@ static u8 dm644x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 
 /*----------------------------------------------------------------------*/
 
-static const s8
+static s8
 queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
@@ -505,7 +505,7 @@ queue_tc_mapping[][2] = {
 	{-1, -1},
 };
 
-static const s8
+static s8
 queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 3},
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 6d52a32..d1259e8 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -531,7 +531,7 @@ static u8 dm646x_default_priorities[DAVINCI_N_AINTC_IRQ] = {
 /*----------------------------------------------------------------------*/
 
 /* Four Transfer Controllers on DM646x */
-static const s8
+static s8
 dm646x_queue_tc_mapping[][2] = {
 	/* {event queue no, TC no} */
 	{0, 0},
@@ -541,7 +541,7 @@ dm646x_queue_tc_mapping[][2] = {
 	{-1, -1},
 };
 
-static const s8
+static s8
 dm646x_queue_priority_mapping[][2] = {
 	/* {event queue no, Priority} */
 	{0, 4},
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 2344ea2..317f2be 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -175,8 +175,8 @@ struct edma_soc_info {
 	/* Resource reservation for other cores */
 	struct edma_rsv_info	*rsv;
 
-	const s8	(*queue_tc_mapping)[2];
-	const s8	(*queue_priority_mapping)[2];
+	s8	(*queue_tc_mapping)[2];
+	s8	(*queue_priority_mapping)[2];
 };
 
 #endif
-- 
1.7.10.1
