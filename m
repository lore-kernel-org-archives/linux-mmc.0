From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH] dma: edma: add device_slave_caps() support
Date: Tue, 23 Jul 2013 11:43:24 -0500
Message-ID: <1374597804-3961-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>
Cc: Balaji TK <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Sekhar Nori <nsekhar@ti.com>, Koen Kooi <koen@beagleboard.org>, Rob Herring <rob.herring@calxeda.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lokesh Vutla <lokeshvutla@ti.com>, Jason Kridner <jkridner@beagleboard.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Joel Fernandes <joelf@ti.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Matt Porter <matt@ohporter.com>
List-Id: linux-mmc@vger.kernel.org

Implement device_slave_caps(). EDMA has a limited number of slots.
Slave drivers such as omap_hsmmc will query the driver to make
sure they don't pass in more than these many scatter segments.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
Vinod, or Dan- If this patch looks ok, can you please merge in for
-rc cycle? This patch is required to fix MMC support on AM33xx. This
patch is blocking 3 other patches which fix various MMC things. Thanks!

Notes:
(1) this approach is temporary and only for -rc cycle to fix MMC on
AM335x. It will be replace by the RFC series in future kernels:
http://www.spinics.net/lists/arm-kernel/msg260094.html

(2) Patch depends Vinod's patch at:
http://permalink.gmane.org/gmane.linux.kernel/1525112

 drivers/dma/edma.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 7222cbe..81d5429 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -517,6 +517,14 @@ static void edma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&echan->vchan.lock, flags);
 }
 
+static inline int edma_slave_caps(struct dma_chan *chan,
+	struct dma_slave_caps *caps)
+{
+	caps->max_sg_nr = MAX_NR_SG;
+
+	return 0;
+}
+
 static size_t edma_desc_size(struct edma_desc *edesc)
 {
 	int i;
@@ -594,6 +602,7 @@ static void edma_dma_init(struct edma_cc *ecc, struct dma_device *dma,
 	dma->device_issue_pending = edma_issue_pending;
 	dma->device_tx_status = edma_tx_status;
 	dma->device_control = edma_control;
+	dma->device_slave_caps = edma_slave_caps;
 	dma->dev = dev;
 
 	INIT_LIST_HEAD(&dma->channels);
-- 
1.7.9.5
