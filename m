From: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v12 03/11] ARM: edma: Add EDMA crossbar event mux support
Date: Thu, 20 Jun 2013 16:06:39 -0500
Message-ID: <1371762407-24544-4-git-send-email-joelagnel@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1371762407-24544-1-git-send-email-joelagnel-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>

Changes by Joel:
* Split EDMA xbar support out of original EDMA DT parsing patch
to keep it easier for review.
* Rewrite shift and offset calculation.

Suggested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Suggested by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>

Reference:
[1] https://patchwork.kernel.org/patch/2226991/
---
 arch/arm/common/edma.c             |   62 +++++++++++++++++++++++++++++++++++-
 include/linux/platform_data/edma.h |    1 +
 2 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 407e01e..a03d4f0 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -568,7 +568,7 @@ static int prepare_unused_channel_list(struct device *dev, void *data)
 				(int)pdev->resource[i].start >= 0) {
 			ctlr = EDMA_CTLR(pdev->resource[i].start);
 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-					edma_cc[ctlr]->edma_unused);
+						edma_cc[ctlr]->edma_unused);
 		}
 	}
 
@@ -1393,6 +1393,52 @@ static int edma_of_read_u32_to_s16_array(const struct device_node *np,
 	return 0;
 }
 
+static int edma_xbar_event_map(struct device *dev,
+			       struct device_node *node,
+			       struct edma_soc_info *pdata, int len)
+{
+	int ret = 0;
+	int i;
+	struct resource res;
+	void __iomem *xbar;
+	const s16 (*xbar_chans)[2];
+	u32 shift, offset, mux;
+
+	xbar_chans = devm_kzalloc(dev,
+				  len/sizeof(s16) + 2*sizeof(s16),
+				  GFP_KERNEL);
+	if (!xbar_chans)
+		return -ENOMEM;
+
+	ret = of_address_to_resource(node, 1, &res);
+	if (ret)
+		return -EIO;
+
+	xbar = devm_ioremap(dev, res.start, resource_size(&res));
+	if (!xbar)
+		return -ENOMEM;
+
+	ret = edma_of_read_u32_to_s16_array(node,
+					    "ti,edma-xbar-event-map",
+					    (s16 *)xbar_chans,
+					    len/sizeof(u32));
+	if (ret)
+		return -EIO;
+
+	for (i = 0; xbar_chans[i][0] != -1; i++) {
+		shift = (xbar_chans[i][1] & 0x03) << 3;
+		offset = xbar_chans[i][1] & 0xfffffffc;
+		mux = readl(xbar + offset);
+		mux &= ~(0xff << shift);
+		mux |= xbar_chans[i][0] << shift;
+		writel(mux, (xbar + offset));
+	}
+
+	pdata->xbar_chans = xbar_chans;
+
+	return 0;
+}
+
 static int edma_of_parse_dt(struct device *dev,
 			    struct device_node *node,
 			    struct edma_soc_info *pdata)
@@ -1458,6 +1504,10 @@ static int edma_of_parse_dt(struct device *dev,
 
 	pdata->default_queue = 0;
 
+	prop = of_find_property(node, "ti,edma-xbar-event-map", &sz);
+	if (prop)
+		ret = edma_xbar_event_map(dev, node, pdata, sz);
+
 	return ret;
 }
 
@@ -1476,6 +1526,7 @@ static int edma_probe(struct platform_device *pdev)
 	int			status = -1;
 	const s16		(*rsv_chans)[2];
 	const s16		(*rsv_slots)[2];
+	const s16		(*xbar_chans)[2];
 	int			irq[EDMA_MAX_CC] = {0, 0};
 	int			err_irq[EDMA_MAX_CC] = {0, 0};
 	struct resource		*r[EDMA_MAX_CC] = {NULL};
@@ -1591,6 +1642,15 @@ static int edma_probe(struct platform_device *pdev)
 			}
 		}
 
+		/* Clear the xbar mapped channels in unused list */
+		xbar_chans = info[j]->xbar_chans;
+		if (xbar_chans) {
+			for (i = 0; xbar_chans[i][1] != -1; i++) {
+				off = xbar_chans[i][1];
+				clear_bits(off, 1,
+					  edma_cc[j]->edma_unused);
+			}
+		}
 
 		if (node) {
 			irq[j] = irq_of_parse_and_map(node, 0);
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index 317f2be..57300fd 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -177,6 +177,7 @@ struct edma_soc_info {
 
 	s8	(*queue_tc_mapping)[2];
 	s8	(*queue_priority_mapping)[2];
+	const s16	(*xbar_chans)[2];
 };
 
 #endif
-- 
1.7.9.5


------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
