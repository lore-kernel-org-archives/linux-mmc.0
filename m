From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 4/7] mmc: bcm2835: Avoid possible races on data requests
Date: Sun, 11 Nov 2018 14:45:27 +0100
Message-ID: <1541943930-23873-5-git-send-email-stefan.wahren@i2se.com>
References: <1541943930-23873-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1541943930-23873-1-git-send-email-stefan.wahren@i2se.com>
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

There are two accesses on the data requests which are not protected by
the mutex. So fix this accordingly.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/mmc/host/bcm2835.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 45724ef..1c60798 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1064,10 +1064,12 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
 {
 	struct bcm2835_host *host =
 		container_of(work, struct bcm2835_host, dma_work);
-	struct mmc_data *data = host->data;
+	struct mmc_data *data;
 
 	mutex_lock(&host->mutex);
 
+	data = host->data;
+
 	if (host->dma_chan) {
 		dma_unmap_sg(host->dma_chan->device->dev,
 			     data->sg, data->sg_len,
@@ -1192,9 +1194,6 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
-	if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
-		bcm2835_prepare_dma(host, mrq->data);
-
 	mutex_lock(&host->mutex);
 
 	WARN_ON(host->mrq);
@@ -1218,6 +1217,9 @@ static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 	}
 
+	if (host->use_dma && mrq->data && (mrq->data->blocks > PIO_THRESHOLD))
+		bcm2835_prepare_dma(host, mrq->data);
+
 	host->use_sbc = !!mrq->sbc && host->mrq->data &&
 			(host->mrq->data->flags & MMC_DATA_READ);
 	if (host->use_sbc) {
-- 
2.7.4
