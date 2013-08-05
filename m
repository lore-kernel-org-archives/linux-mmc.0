From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH v3 07/12] dma: edma: Add function to dump a PaRAM set from PaRAM
Date: Mon, 5 Aug 2013 11:14:52 -0500
Message-ID: <1375719297-12871-8-git-send-email-joelf@ti.com>
References: <1375719297-12871-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1375719297-12871-1-git-send-email-joelf@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Joel Fernandes <joelf@ti.com>
List-Id: linux-mmc@vger.kernel.org

Previously, such a dump function was used but it wasn't reading
from the PaRAM, rather just from a edmacc_param structure, we
add a helpful function for debugging that directly reads from
the PaRAM and gives the current state correctly (including links
and interrupt information).

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 080d669..a242269 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -102,6 +102,37 @@ static void edma_desc_free(struct virt_dma_desc *vdesc)
 	kfree(container_of(vdesc, struct edma_desc, vdesc));
 }
 
+static inline void dump_pset(struct edma_chan *echan, int slot,
+		     struct edmacc_param *pset_unused, int pset_idx)
+{
+	struct edmacc_param pset_local, *pset;
+	pset = &pset_local;
+
+	edma_read_slot(slot, pset);
+
+	dev_dbg(echan->vchan.chan.device->dev,
+		"\n pset[%d]:\n"
+		"  chnum\t%d\n"
+		"  slot\t%d\n"
+		"  opt\t%08x\n"
+		"  src\t%08x\n"
+		"  dst\t%08x\n"
+		"  abcnt\t%08x\n"
+		"  ccnt\t%08x\n"
+		"  bidx\t%08x\n"
+		"  cidx\t%08x\n"
+		"  lkrld\t%08x\n",
+		pset_idx, echan->ch_num, slot,
+		pset[0].opt,
+		pset[0].src,
+		pset[0].dst,
+		pset[0].a_b_cnt,
+		pset[0].ccnt,
+		pset[0].src_dst_bidx,
+		pset[0].src_dst_cidx,
+		pset[0].link_bcntrld);
+}
+
 /* Dispatch a queued descriptor to the controller (caller holds lock) */
 static void edma_execute(struct edma_chan *echan)
 {
-- 
1.7.9.5
