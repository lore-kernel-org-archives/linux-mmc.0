From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 5/9] dma: edma: Leave linked to Null slot instead of DUMMY slot
Date: Mon, 29 Jul 2013 08:29:51 -0500
Message-ID: <1375104595-16018-6-git-send-email-joelf@ti.com>
References: <1375104595-16018-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1375104595-16018-1-git-send-email-joelf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sricharan R <r.sricharan@ti.com>, Rajendra Nayak <rnayak@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Matt Porter <matt@ohporter.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Mark Brown <broonie@linaro.org>, Benoit Cousson <benoit.cousson@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Balaji TK <balajitk@ti.com>, Gururaja Hebbar <gururaja.hebbar@ti.com>, Chris Ball <cjb@laptop.org>, Jason Kridner <jkridner@beagleboard.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Joel Fernandes <joelf@ti.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Dummy slot has been used as a way for missed-events not to be
reported as missing. This has been particularly troublesome for cases
where we might want to temporarily pause all incoming events.

For EDMA DMAC, there is no way to do any such pausing of events as
the occurence of the "next" event is not software controlled.
Using "edma_pause" in IRQ handlers doesn't help as by then the event
in concern from the slave is already missed.

Linking a dummy slot, is seen to absorb these events which we didn't
want to miss. So we don't link to dummy, but instead leave it linked
to NULL set, allow an error condition and detect the channel that
missed it.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 drivers/dma/edma.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index aa4989f..1eda5cc 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -159,9 +159,6 @@ static void edma_execute(struct edma_chan *echan)
 		/* Link to the previous slot if not the last set */
 		if (i != (total_process - 1))
 			edma_link(echan->slot[i], echan->slot[i+1]);
-		/* Final pset links to the dummy pset */
-		else
-			edma_link(echan->slot[i], echan->ecc->dummy_slot);
 	}
 
 	edesc->total_processed += total_process;
-- 
1.7.9.5
