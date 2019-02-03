From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 1/3] mmc: bcm2835: Drop DMA channel error pointer check
Date: Sun, 3 Feb 2019 09:27:00 +0100
Message-ID: <2c3a480c2b322ae81f489010ee68015487bac001.1549181242.git.lukas@wunner.de>
References: <cover.1549181242.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1549181242.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shraddha Barke <shraddha.6596-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vaishali Thakkar <me-c39Wob3KZ2c64PEq3mRLUp/QNRX+jHPU@public.gmane.org>, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

bcm2835_add_host() invokes IS_ERR_OR_NULL() on a DMA channel pointer,
however dma_request_slave_channel() (which was used to populate the
pointer) never returns an error pointer.  So a NULL pointer check is
sufficient.

Tested-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
---
 drivers/mmc/host/bcm2835.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index c9e7aa50bb0a..ab8d58a60352 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1286,7 +1286,7 @@ static int bcm2835_add_host(struct bcm2835_host *host)
 	spin_lock_init(&host->lock);
 	mutex_init(&host->mutex);
 
-	if (IS_ERR_OR_NULL(host->dma_chan_rxtx)) {
+	if (!host->dma_chan_rxtx) {
 		dev_warn(dev, "unable to initialise DMA channel. Falling back to PIO\n");
 		host->use_dma = false;
 	} else {
-- 
2.20.1
