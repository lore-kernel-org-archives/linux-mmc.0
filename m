From: Linus Walleij <linus.walleij@stericsson.com>
Subject: [PATCH 4/4] mmci: fixup sg buffer handling in pio_write
Date: Tue, 28 Jun 2011 09:57:49 +0200
Message-ID: <1309247869-17220-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

From: Ulf Hansson <ulf.hansson@stericsson.com>

Earlier code in pio_write was expecting that each
scatter-gather buffer was 4-bytes aligned which is
not always the case, especially when dealing with long
chains of SDIO packages. This patch fix the problem by
using a 4 bytes buffer to cache unaligned data between
each unaligned pio_write operation.

In the last transaction we pad the last write access
with zeroes.

Remove older fix for ST Micro since it was not a
variant-specific problem.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Reviewed-by: Henrik Carling <henrik.carling@stericsson.com>
Signed-off-by: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>
[Minor fixups like making the cache word a u32]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |  106 ++++++++++++++++++++++++++++++++++------------
 drivers/mmc/host/mmci.h |    3 +
 2 files changed, 81 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 93dcd2a..81aac79 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -533,6 +533,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 	host->size = data->blksz * data->blocks;
 	host->dataend = false;
 	data->bytes_xfered = 0;
+	host->cache_len = 0;
+	host->cache = 0;
 
 	clks = (unsigned long long)data->timeout_ns * host->cclk;
 	do_div(clks, 1000000000UL);
@@ -712,43 +714,88 @@ static int mmci_pio_write(struct mmci_host *host, char *buffer, unsigned int rem
 	struct variant_data *variant = host->variant;
 	void __iomem *base = host->base;
 	char *ptr = buffer;
+	unsigned int data_left = host->size;
+	unsigned int count, maxcnt;
+	char *cache_ptr;
+	int i;
 
 	do {
-		unsigned int count, maxcnt;
-
 		maxcnt = status & MCI_TXFIFOEMPTY ?
 			 variant->fifosize : variant->fifohalfsize;
-		count = min(remain, maxcnt);
 
 		/*
-		 * The ST Micro variant for SDIO transfer sizes
-		 * less then 8 bytes should have clock H/W flow
-		 * control disabled.
+		 * A write to the FIFO must always be done of 4 bytes aligned
+		 * data. If the buffer is not 4 bytes aligned we must pad the
+		 * data, but this must only be done for the final write for the
+		 * entire data transfer, otherwise we will corrupt the data.
+		 * Thus a buffer cache of four bytes is needed to temporary
+		 * store data.
 		 */
-		if (variant->sdio &&
-		    mmc_card_sdio(host->mmc->card)) {
-			if (count < 8)
-				writel(readl(host->base + MMCICLOCK) &
-					~variant->clkreg_enable,
-					host->base + MMCICLOCK);
-			else
-				writel(readl(host->base + MMCICLOCK) |
-					variant->clkreg_enable,
-					host->base + MMCICLOCK);
+		if (host->cache_len) {
+			cache_ptr = (char *)&host->cache;
+			cache_ptr = cache_ptr + host->cache_len;
+			data_left += host->cache_len;
+
+			while ((host->cache_len < 4) && (remain > 0)) {
+				*cache_ptr = *ptr;
+				cache_ptr++;
+				ptr++;
+				host->cache_len++;
+				remain--;
+			}
+
+			if ((host->cache_len == 4) ||
+				(data_left == host->cache_len)) {
+
+				writesl(base + MMCIFIFO, &host->cache, 1);
+				if (data_left == host->cache_len)
+					break;
+
+				host->cache = 0;
+				host->cache_len = 0;
+				maxcnt -= 4;
+				data_left -= 4;
+			}
+
+			if (remain == 0)
+				break;
 		}
 
-		/*
-		 * SDIO especially may want to send something that is
-		 * not divisible by 4 (as opposed to card sectors
-		 * etc), and the FIFO only accept full 32-bit writes.
-		 * So compensate by adding +3 on the count, a single
-		 * byte become a 32bit write, 7 bytes will be two
-		 * 32bit writes etc.
-		 */
-		writesl(base + MMCIFIFO, ptr, (count + 3) >> 2);
+		count = min(remain, maxcnt);
 
-		ptr += count;
-		remain -= count;
+		if (!(count % 4) || (data_left == count)) {
+			/*
+			 * The data is either 4-bytes aligned or it is the
+			 * last data to write. It is thus fine to potentially
+			 * pad the data if needed.
+			 */
+			writesl(base + MMCIFIFO, ptr, (count + 3) >> 2);
+			ptr += count;
+			remain -= count;
+			data_left -= count;
+
+		} else {
+
+			host->cache_len = count % 4;
+			count = (count >> 2) << 2;
+
+			if (count)
+				writesl(base + MMCIFIFO, ptr, count >> 2);
+
+			ptr += count;
+			remain -= count;
+			data_left -= count;
+
+			i = 0;
+			cache_ptr = (char *)&host->cache;
+			while (i < host->cache_len) {
+				*cache_ptr = *ptr;
+				cache_ptr++;
+				ptr++;
+				remain--;
+				i++;
+			}
+		}
 
 		if (remain == 0)
 			break;
@@ -803,7 +850,10 @@ static irqreturn_t mmci_pio_irq(int irq, void *dev_id)
 		if (status & MCI_TXACTIVE)
 			len = mmci_pio_write(host, buffer, remain, status);
 
-		sg_miter->consumed = len;
+		if (len > sg_miter->consumed)
+			len = sg_miter->consumed;
+		else
+			sg_miter->consumed = len;
 
 		host->size -= len;
 		remain -= len;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 79156a0..ff93a9c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -196,6 +196,9 @@ struct mmci_host {
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
 	unsigned int		size;
+	u32			cache;
+	unsigned int		cache_len;
+
 	struct regulator	*vcc;
 
 	/* sync of DATAEND irq */
-- 
1.7.3.2
