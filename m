From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V2 7/7] mmc: bcm2835: Properly handle dmaengine_prep_slave_sg
Date: Sun, 11 Nov 2018 21:23:59 +0100
Message-ID: <1541967839-2847-8-git-send-email-stefan.wahren@i2se.com>
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

In case dmaengine_prep_slave_sg fails we need to call dma_unmap_sg.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index c42bdaa..82e4b08 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -518,13 +518,16 @@ void bcm2835_prepare_dma(struct bcm2835_host *host, struct mmc_data *data)
 	desc = dmaengine_prep_slave_sg(dma_chan, data->sg, sg_len, dir_slave,
 				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
 
-	if (desc) {
-		desc->callback = bcm2835_dma_complete;
-		desc->callback_param = host;
-		host->dma_desc = desc;
-		host->dma_chan = dma_chan;
-		host->dma_dir = dir_data;
+	if (!desc) {
+		dma_unmap_sg(dma_chan->device->dev, data->sg, sg_len, dir_data);
+		return;
 	}
+
+	desc->callback = bcm2835_dma_complete;
+	desc->callback_param = host;
+	host->dma_desc = desc;
+	host->dma_chan = dma_chan;
+	host->dma_dir = dir_data;
 }
 
 static void bcm2835_start_dma(struct bcm2835_host *host)
-- 
2.7.4
