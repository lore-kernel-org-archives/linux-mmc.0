From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/5] mmc: bcm2835-sdhost: reset tweaks. [fixup]
Date: Wed, 22 Jun 2016 13:42:17 +0200
Message-ID: <1466595738-2229-5-git-send-email-kraxel@redhat.com>
References: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466595738-2229-1-git-send-email-kraxel@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-rpi-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Kill any pending stuff before calling reset_internal(), so there
shouldn't be any completion callbacks interfering.  This allows
to call reset_internal without lock, which in turn allows to
turn the mdelay calls into msleep calls.  Also adjust the time
from 10ms to 20ms as checkpatch warns about the 10ms.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/mmc/host/bcm2835-sdhost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835-sdhost.c b/drivers/mmc/host/bcm2835-sdhost.c
index 8a05c02..a895561 100644
--- a/drivers/mmc/host/bcm2835-sdhost.c
+++ b/drivers/mmc/host/bcm2835-sdhost.c
@@ -321,9 +321,9 @@ static void bcm2835_sdhost_reset_internal(struct bcm2835_host *host)
 	temp |= (FIFO_READ_THRESHOLD << SDEDM_READ_THRESHOLD_SHIFT) |
 		(FIFO_WRITE_THRESHOLD << SDEDM_WRITE_THRESHOLD_SHIFT);
 	bcm2835_sdhost_write(host, temp, SDEDM);
-	mdelay(10);
+	msleep(20);
 	bcm2835_sdhost_set_power(host, true);
-	mdelay(10);
+	msleep(20);
 	host->clock = 0;
 	bcm2835_sdhost_write(host, host->hcfg, SDHCFG);
 	bcm2835_sdhost_write(host, host->cdiv, SDCDIV);
@@ -334,9 +334,10 @@ static void bcm2835_sdhost_reset(struct mmc_host *mmc)
 	struct bcm2835_host *host = mmc_priv(mmc);
 	unsigned long flags;
 
-	spin_lock_irqsave(&host->lock, flags);
+	if (host->dma_chan)
+		dmaengine_terminate_sync(host->dma_chan);
+	tasklet_kill(&host->finish_tasklet);
 	bcm2835_sdhost_reset_internal(host);
-	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void bcm2835_sdhost_set_ios(struct mmc_host *mmc, struct mmc_ios *ios);
-- 
1.8.3.1
