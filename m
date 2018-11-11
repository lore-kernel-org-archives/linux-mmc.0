From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 1/7] mmc: bcm2835: reset host on timeout
Date: Sun, 11 Nov 2018 21:23:53 +0100
Message-ID: <1541967839-2847-2-git-send-email-stefan.wahren@i2se.com>
References: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1541967839-2847-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Phil Elwell <phil@raspberrypi.org>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, Michal Suchanek <msuchanek@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Michal Suchanek <msuchanek@suse.de>

The bcm2835 mmc host tends to lock up for unknown reason so reset it on
timeout. The upper mmc block layer tries retransimitting with single
blocks which tends to work out after a long wait.

This is better than giving up and leaving the machine broken for no
obvious reason.

Fixes: 660fc733bd74 ("mmc: bcm2835: Add new driver for the sdhost controller.")
Signed-off-by: Michal Suchanek <msuchanek@suse.de>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 768972a..f1712df 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -286,6 +286,7 @@ static void bcm2835_reset(struct mmc_host *mmc)
 
 	if (host->dma_chan)
 		dmaengine_terminate_sync(host->dma_chan);
+	host->dma_chan = NULL;
 	bcm2835_reset_internal(host);
 }
 
@@ -837,6 +838,8 @@ static void bcm2835_timeout(struct work_struct *work)
 		dev_err(dev, "timeout waiting for hardware interrupt.\n");
 		bcm2835_dumpregs(host);
 
+		bcm2835_reset(host->mmc);
+
 		if (host->data) {
 			host->data->error = -ETIMEDOUT;
 			bcm2835_finish_data(host);
-- 
2.7.4
