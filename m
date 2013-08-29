From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 6/6] dma: edma: Remove limits on number of slots
Date: Thu, 29 Aug 2013 18:05:45 -0500
Message-ID: <1377817545-18015-7-git-send-email-joelf@ti.com>
References: <1377817545-18015-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1377817545-18015-1-git-send-email-joelf-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Franklin Cooper <fcooper-l0cyMroinI0@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

With this series, this check is no longer required and
we shouldn't need to reject drivers DMA'ing more than the
MAX number of slots.

Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 drivers/dma/edma.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 25e47d4..d966413 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -287,12 +287,6 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 		return NULL;
 	}
 
-	if (sg_len > MAX_NR_SG) {
-		dev_err(dev, "Exceeded max SG segments %d > %d\n",
-			sg_len, MAX_NR_SG);
-		return NULL;
-	}
-
 	edesc = kzalloc(sizeof(*edesc) + sg_len *
 		sizeof(edesc->pset[0]), GFP_ATOMIC);
 	if (!edesc) {
-- 
1.8.1.2
