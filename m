From: Joel Fernandes <joelf@ti.com>
Subject: [PATCH 7/9] ARM: edma: Don't clear EMR of channel in edma_stop
Date: Mon, 29 Jul 2013 08:29:53 -0500
Message-ID: <1375104595-16018-8-git-send-email-joelf@ti.com>
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

We certainly don't want error conditions to be cleared anywhere
as this will make us 'forget' about missed events. We depend on
knowing which events were missed in order to be able to reissue them.

This fixes a race condition where the EMR was being cleared
by the transfer completion interrupt handler.

Basically, what was happening was:

            Missed event
             |
             |
             V
SG1-SG2-SG3-Null
         \
          \__TC Interrupt (Almost same time as ARM is executing
TC interrupt handler, an event got missed and also forgotten
by clearing the EMR).

The EMR is ultimately being cleared by the Error interrupt
handler once it is handled so we don't have to do it in edma_stop.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/common/edma.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 10995b2..dec772e 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1328,7 +1328,6 @@ void edma_stop(unsigned channel)
 		edma_shadow0_write_array(ctlr, SH_EECR, j, mask);
 		edma_shadow0_write_array(ctlr, SH_ECR, j, mask);
 		edma_shadow0_write_array(ctlr, SH_SECR, j, mask);
-		edma_write_array(ctlr, EDMA_EMCR, j, mask);
 
 		pr_debug("EDMA: EER%d %08x\n", j,
 				edma_shadow0_read_array(ctlr, SH_EER, j));
-- 
1.7.9.5
