From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 2/2] DMA: EDMA: Add comments for A-sync case calculations
Date: Wed, 26 Jun 2013 22:42:28 -0500
Message-ID: <1372304548-30777-1-git-send-email-joelf@ti.com>
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
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

A-sync case in EDMA driver is tricky and not so obvious.
Document the reasons for the calculations and the scenarious
they are used.

Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/edma.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index e008ed2..a1d9f3785 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -284,8 +284,24 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		 */
 		if (burst == 1) {
 			edesc->absync = false;
+			/*
+			 * For the A-sync case, bcnt and ccnt are the remainder
+			 * and quotient respectively of the division of:
+			 * (sg_dma_len(sg) / acnt) by (SZ_64K -1). This is so
+			 * that in case bcnt over flows, we have ccnt to use.
+			 * Note: In A-sync tranfer only, bcntrld is used, but it
+			 * only applies for sg_dma_len(sg) >= SZ_64K.
+			 * In this case, the best way adopted is- bccnt for the
+			 * first frame will be the remainder below. Then for
+			 * every successive frame, bcnt will be SZ_64K-1. This
+			 * is assured as bcntrld = 0xffff in end of function.
+			 */
 			ccnt = sg_dma_len(sg) / acnt / (SZ_64K - 1);
 			bcnt = sg_dma_len(sg) / acnt - ccnt * (SZ_64K - 1);
+			/*
+			 * If bcnt is non-zero, we have a remainder and hence an
+			 * extra frame to transfer, so increment ccnt.
+			 */
 			if (bcnt)
 				ccnt++;
 			else
@@ -343,6 +359,12 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 
 		edesc->pset[i].a_b_cnt = bcnt << 16 | acnt;
 		edesc->pset[i].ccnt = ccnt;
+		/*
+		 * Only time when (bcntrld) auto reload is required is for
+		 * A-sync case, and in this case, a requirement of reload value
+		 * of SZ_64K-1 only is assured. 'link' is initially set to NULL
+		 * and then later will be populated by edma_execute.
+		 */
 		edesc->pset[i].link_bcntrld = 0xffffffff;
 
 	}
-- 
1.7.9.5
