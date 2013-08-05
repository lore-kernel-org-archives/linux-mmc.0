From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH v3 10/12] dma: edma: Check if MAX_NR_SG is even in prep function
Date: Mon, 5 Aug 2013 11:14:55 -0500
Message-ID: <1375719297-12871-11-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Joel Fernandes <joelf@ti.com>
List-Id: linux-mmc@vger.kernel.org

Splitting of MAX available slots into 2 sets of size MAX_NR_LS
requires to the MAX_NR_SG function to be even. We ensure the same
in prep function.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 70923a2..061f0cf 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -354,6 +354,9 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 	int src_bidx, dst_bidx, src_cidx, dst_cidx;
 	int i, num_slots_needed;
 
+	if (MAX_NR_SG & 1)
+		dev_err(dev, "%s: MAX_NR_SG must be even\n", __func__);
+
 	if (unlikely(!echan || !sgl || !sg_len))
 		return NULL;
 
-- 
1.7.9.5
