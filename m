From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH v3 08/12] dma: edma: Add one more required slot to MAX slots
Date: Mon, 5 Aug 2013 11:14:53 -0500
Message-ID: <1375719297-12871-9-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Joel Fernandes <joelf@ti.com>
List-Id: linux-mmc@vger.kernel.org

We'd now need a separate slot just for the channel and separate
ones for the 2 linked sets, so we make adjustments to allocate
an extra channel accordingly.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index a242269..df50a04 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -48,7 +48,7 @@
 
 /* Max of 16 segments per channel to conserve PaRAM slots */
 #define MAX_NR_SG		16
-#define EDMA_MAX_SLOTS		MAX_NR_SG
+#define EDMA_MAX_SLOTS		(MAX_NR_SG+1)
 #define EDMA_DESCRIPTORS	16
 
 struct edma_desc {
@@ -311,6 +311,9 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 
 	num_slots_needed = sg_len > MAX_NR_SG ? MAX_NR_SG : sg_len;
 
+	/* Allocate one extra to account for the channel itself */
+	num_slots_needed++;
+
 	for (i = 0; i < num_slots_needed; i++) {
 		if (echan->slot[i] < 0) {
 			echan->slot[i] =
-- 
1.7.9.5
