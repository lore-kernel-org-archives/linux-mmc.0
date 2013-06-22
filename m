From: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2] ARM: common: edma: Fix dangling pointer dereference
Date: Fri, 21 Jun 2013 22:31:17 -0500
Message-ID: <1371871877-15269-1-git-send-email-joelagnel@ti.com>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Fixup for linux-davinci/soc-v2 branch. Please ignore v1 and use this.
Returning a pointer to a variable in the setup_from_dt function is
causing dangling pointer dereferences. This causes boot to fail
on AM33XX.

Add ninfo to the caller's stack and just return the kzalloc'ed ptr
from the calling function.

v2: Fixed last issue in davinci branch:
    ninfo 2D array is used for DT platforms.
    info is shared between DT and non-DT cases. So point info to ninfo.

With this MMC is working (rootfs mount) on AM33XX.

Signed-off-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
---
 arch/arm/common/edma.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 2b591b1..3567ba1 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1514,10 +1514,9 @@ static struct of_dma_filter_info edma_filter_info = {
 	.filter_fn = edma_filter_fn,
 };
 
-static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
+static struct edma_soc_info *edma_setup_info_from_dt(struct device *dev,
 						      struct device_node *node)
 {
-	static struct edma_soc_info **info;
 	struct edma_soc_info *ninfo;
 	int ret;
 
@@ -1539,9 +1538,7 @@ static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
 	of_dma_controller_register(dev->of_node, of_dma_simple_xlate,
 				   &edma_filter_info);
 
-	info = &ninfo;
-
-	return info;
+	return ninfo;
 }
 #else
 static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
@@ -1554,6 +1551,7 @@ static struct edma_soc_info **edma_setup_info_from_dt(struct device *dev,
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	**info = pdev->dev.platform_data;
+	struct edma_soc_info    *ninfo[EDMA_MAX_CC] = {NULL};
 	s8		(*queue_priority_mapping)[2];
 	s8		(*queue_tc_mapping)[2];
 	int			i, j, off, ln, found = 0;
@@ -1572,7 +1570,9 @@ static int edma_probe(struct platform_device *pdev)
 	int			ret;
 
 	if (node) {
-		info = edma_setup_info_from_dt(dev, node);
+		/* For now, for DT we populate only first ninfo element */
+		ninfo[0] = edma_setup_info_from_dt(dev, node);
+		info = ninfo;
 		if (IS_ERR(info)) {
 			dev_err(dev, "failed to get DT data\n");
 			return PTR_ERR(info);
-- 
1.7.9.5
