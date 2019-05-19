From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 2/2] mmc: mediatek: support 24bits segment size
Date: Sun, 19 May 2019 15:57:17 +0800
Message-ID: <1558252637-10556-3-git-send-email-chaotian.jing@mediatek.com>
References: <1558252637-10556-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1558252637-10556-1-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: srv_heupstream@mediatek.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Chaotian Jing <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

MSDC IP which support 64G DRAM will support 24bits BDMA buffer length,
so add support it.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 7d8502a..682e483 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -336,6 +336,7 @@ struct mt_bdma_desc {
 	u32 ptr;
 	u32 bd_data_len;
 #define BDMA_DESC_BUFLEN	(0xffff) /* bit0 ~ bit15 */
+#define BDMA_DESC_BUFLEN_EXT	(0xffffff) /* bit0 ~ bit23 */
 };
 
 struct msdc_dma {
@@ -649,8 +650,14 @@ static inline void msdc_dma_setup(struct msdc_host *host, struct msdc_dma *dma,
 			bd[j].bd_info |= (upper_32_bits(dma_address) & 0xf)
 					 << 28;
 		}
-		bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN;
-		bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN);
+
+		if (host->dev_comp->support_64g) {
+			bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN_EXT;
+			bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN_EXT);
+		} else {
+			bd[j].bd_data_len &= ~BDMA_DESC_BUFLEN;
+			bd[j].bd_data_len |= (dma_len & BDMA_DESC_BUFLEN);
+		}
 
 		if (j == data->sg_count - 1) /* the last bd */
 			bd[j].bd_info |= BDMA_DESC_EOL;
@@ -2280,7 +2287,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
 	/* MMC core transfer sizes tunable parameters */
 	mmc->max_segs = MAX_BD_NUM;
-	mmc->max_seg_size = BDMA_DESC_BUFLEN;
+	if (host->dev_comp->support_64g)
+		mmc->max_seg_size = BDMA_DESC_BUFLEN_EXT;
+	else
+		mmc->max_seg_size = BDMA_DESC_BUFLEN;
 	mmc->max_blk_size = 2048;
 	mmc->max_req_size = 512 * 1024;
 	mmc->max_blk_count = mmc->max_req_size / 512;
-- 
1.8.1.1.dirty
