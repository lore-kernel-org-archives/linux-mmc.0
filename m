From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/11] mmc: moxart: handle highmem pages
Date: Mon, 14 Jan 2019 10:57:55 +0100
Message-ID: <20190114095804.27978-3-hch@lst.de>
References: <20190114095804.27978-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114095804.27978-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Nicolas Pitre <nico@fluxnic.net>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ben Dooks <ben-linux@fluff.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Instead of setting up a kernel pointer to track the current PIO address,
track the offset in the current page, and do a kmap for the page while
doing the actual PIO operations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/host/moxart-mmc.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a0670e9cd012..7142bca425c8 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -311,7 +311,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	if (host->data_len == data->bytes_xfered)
 		return;
 
-	sgp = sg_virt(host->cur_sg);
+	sgp = kmap(sg_page(host->cur_sg)) + host->cur_sg->offset;
 	remain = host->data_remain;
 
 	if (data->flags & MMC_DATA_WRITE) {
@@ -319,8 +319,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 			if (moxart_wait_for_status(host, FIFO_URUN, &status)
 			     == -ETIMEDOUT) {
 				data->error = -ETIMEDOUT;
-				complete(&host->pio_complete);
-				return;
+				goto done;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
 				iowrite32(*sgp, host->base + REG_DATA_WINDOW);
@@ -335,8 +334,7 @@ static void moxart_transfer_pio(struct moxart_host *host)
 			if (moxart_wait_for_status(host, FIFO_ORUN, &status)
 			    == -ETIMEDOUT) {
 				data->error = -ETIMEDOUT;
-				complete(&host->pio_complete);
-				return;
+				goto done;
 			}
 			for (len = 0; len < remain && len < host->fifo_width;) {
 				/* SCR data must be read in big endian. */
@@ -356,10 +354,15 @@ static void moxart_transfer_pio(struct moxart_host *host)
 	data->bytes_xfered += host->data_remain - remain;
 	host->data_remain = remain;
 
-	if (host->data_len != data->bytes_xfered)
+	if (host->data_len != data->bytes_xfered) {
+		kunmap(sg_page(host->cur_sg));
 		moxart_next_sg(host);
-	else
-		complete(&host->pio_complete);
+		return;
+	}
+
+done:
+	kunmap(sg_page(host->cur_sg));
+	complete(&host->pio_complete);
 }
 
 static void moxart_prepare_data(struct moxart_host *host)
-- 
2.20.1
