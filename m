From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3] ARM: EDMA: Fix clearing of unused list for DT DMA resources
Date: Thu, 26 Sep 2013 16:55:46 -0500
Message-ID: <1380232546-821-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

HWMOD removal for MMC is breaking edma_start as the events are being manually
triggered due to unused channel list not being clear.

The above issue is fixed by reading the "dmas" property from the DT node if it
exists and clearing the bits in the unused channel list if the dma controller
used by any device is EDMA. For this purpose we use the of_* helpers to parse
the arguments in the dmas phandle list.

Also introduced is a minor clean up of a checkpatch error in old code.

Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Reported-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Pantel Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
Cc: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>
Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
Just resending this patch after discussing with Sekhar and Olof.

AM335x is being booted by many users such as the beaglebone community. DT is
the only boot method available for all these users.  EDMA is required for the
operation for many common peripherals in AM335x SoC such as McASP, MMC and
Crypto.

Although EDMA DT nodes are going in only for 3.13, in reality the kernel has
been used for more than a year with EDMA code and out of tree EDMA DTS patches.
Hence though the DT nodes are still not in mainline, this patch can be still be
considered a critical fix as such and it would be great if it could be included
in 3.12-rc release. Thanks.

More details about why this broke an existing feature folks were using:
Previously the DMA resources for platform devices were being populated through
HWMOD, however with the recent clean ups with HWMOD, this data has been moved
to Device tree. The EDMA code though is not aware of this so it fails to fetch
the DMA resources correctly which it needs to prepare the unused channel list
(basically doesn't properly clear the channels that are in use, in the unused
list).

 arch/arm/common/edma.c | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 117f955..8e1a024 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -269,6 +269,11 @@ static const struct edmacc_param dummy_paramset = {
 	.ccnt = 1,
 };
 
+static const struct of_device_id edma_of_ids[] = {
+	{ .compatible = "ti,edma3", },
+	{}
+};
+
 /*****************************************************************************/
 
 static void map_dmach_queue(unsigned ctlr, unsigned ch_no,
@@ -560,14 +565,38 @@ static int reserve_contiguous_slots(int ctlr, unsigned int id,
 static int prepare_unused_channel_list(struct device *dev, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	int i, ctlr;
+	int i, count, ctlr;
+	struct of_phandle_args  dma_spec;
 
+	if (dev->of_node) {
+		count = of_property_count_strings(dev->of_node, "dma-names");
+		if (count < 0)
+			return 0;
+		for (i = 0; i < count; i++) {
+			if (of_parse_phandle_with_args(dev->of_node, "dmas",
+						       "#dma-cells", i,
+						       &dma_spec))
+				continue;
+
+			if (!of_match_node(edma_of_ids, dma_spec.np)) {
+				of_node_put(dma_spec.np);
+				continue;
+			}
+
+			clear_bit(EDMA_CHAN_SLOT(dma_spec.args[0]),
+				  edma_cc[0]->edma_unused);
+			of_node_put(dma_spec.np);
+		}
+		return 0;
+	}
+
+	/* For non-OF case */
 	for (i = 0; i < pdev->num_resources; i++) {
 		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
 				(int)pdev->resource[i].start >= 0) {
 			ctlr = EDMA_CTLR(pdev->resource[i].start);
 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
-					edma_cc[ctlr]->edma_unused);
+				  edma_cc[ctlr]->edma_unused);
 		}
 	}
 
@@ -1762,11 +1791,6 @@ static int edma_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id edma_of_ids[] = {
-	{ .compatible = "ti,edma3", },
-	{}
-};
-
 static struct platform_driver edma_driver = {
 	.driver = {
 		.name	= "edma",
-- 
1.8.1.2
