From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 6/7] mmc: bcm2835: Refactor dma_map_sg handling
Date: Sun, 11 Nov 2018 21:23:58 +0100
Message-ID: <1541967839-2847-7-git-send-email-stefan.wahren@i2se.com>
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

There are two variables len within bcm2835_prepare_dma. So rename the result
of dma_map_sg to sg_len. While we are at this add a bail out to simplify the
following change.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 2c7589f..c42bdaa 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -464,7 +464,7 @@ static void bcm2835_transfer_pio(struct bcm2835_host *host)
 static
 void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 {
-	int len, dir_data, dir_slave;
+	int sg_len, dir_data, dir_slave;
 	struct dma_async_tx_descriptor *desc = NULL;
 	struct dma_chan *dma_chan;
 
@@ -510,15 +510,13 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 				     &host->dma_cfg_rx :
 				     &host->dma_cfg_tx);
 
-	len = dma_map_sg(dma_chan->device->dev, data->sg, data->sg_len,
-			 dir_data);
+	sg_len = dma_map_sg(dma_chan->device->dev, data->sg, data->sg_len,
+			    dir_data);
+	if (!sg_len)
+		return;
 
-	if (len > 0) {
-		desc = dmaengine_prep_slave_sg(dma_chan, data->sg,
-					       len, dir_slave,
-					       DMA_PREP_INTERRUPT |
-					       DMA_CTRL_ACK);
-	}
+	desc = dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_slave,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
 	if (desc) {
 		desc->callback = bcm2835_dma_complete;
-- 
2.7.4
