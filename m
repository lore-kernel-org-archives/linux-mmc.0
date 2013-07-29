From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 9/9] dma: edma: remove limits on number of slots
Date: Mon, 29 Jul 2013 08:29:55 -0500
Message-ID: <1375104595-16018-10-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375104595-16018-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Joel Fernandes <joelf@ti.com>
List-Id: linux-mmc@vger.kernel.org

With this series, this check is no longer required and
we shouldn't need to reject drivers DMA'ing more than the
MAX number of slots.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 0d3ebde..abf2e87 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -285,12 +285,6 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
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
1.7.9.5
