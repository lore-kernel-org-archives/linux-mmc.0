From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 01/15] dmaengine: core: Skip mask matching when it is not
 provided to private_candidate
Date: Wed, 2 Dec 2015 15:59:11 +0200
Message-ID: <1449064765-27427-2-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: tony@atomide.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

If mask is NULL skip the mask matching against the DMA device capabilities.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index daf54a39bcc7..6311e1fc80be 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -515,7 +515,7 @@ static struct dma_chan *private_candidate(const dma_cap_mask_t *mask,
 {
 	struct dma_chan *chan;
 
-	if (!__dma_device_satisfies_mask(dev, mask)) {
+	if (mask && !__dma_device_satisfies_mask(dev, mask)) {
 		pr_debug("%s: wrong capabilities\n", __func__);
 		return NULL;
 	}
-- 
2.6.3
