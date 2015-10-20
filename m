From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 5/9] mmc: mediatek: fix got GPD checksum error interrupt
 when data transfer
Date: Tue, 20 Oct 2015 17:13:07 +0800
Message-ID: <1445332391-30530-6-git-send-email-chaotian.jing@mediatek.com>
References: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1445332391-30530-1-git-send-email-chaotian.jing@mediatek.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Minda Chen <Minda.Chen@csr.com>, Dong Aisheng <b29396@freescale.com>, Lars-Peter Clausen <lars@metafoo.de>, Weijun Yang <Weijun.Yang@csr.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, Howard Chen <ibanezchen@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ivan.ivanov@linaro.org, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias>
List-Id: linux-mmc@vger.kernel.org

Even if we only use one gpd, we need alloc 2 gpd and make
the gpd->next pointer to the second gpd, or may get gpd checksum
error, this was checked by hardware

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 drivers/mmc/host/mtk-sd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index c877ded..3858163 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1145,11 +1145,14 @@ static void msdc_init_gpd_bd(struct msdc_host *host, struct msdc_dma *dma)
 	struct mt_bdma_desc *bd = dma->bd;
 	int i;
 
-	memset(gpd, 0, sizeof(struct mt_gpdma_desc));
+	memset(gpd, 0, sizeof(struct mt_gpdma_desc) * 2);
 
 	gpd->gpd_info = GPDMA_DESC_BDP; /* hwo, cs, bd pointer */
 	gpd->ptr = (u32)dma->bd_addr; /* physical address */
-
+	/* gpd->next is must set for desc DMA
+	 * That's why must alloc 2 gpd structure.
+	 */
+	gpd->next = (u32)dma->gpd_addr + sizeof(struct mt_gpdma_desc);
 	memset(bd, 0, sizeof(struct mt_bdma_desc) * MAX_BD_NUM);
 	for (i = 0; i < (MAX_BD_NUM - 1); i++)
 		bd[i].next = (u32)dma->bd_addr + sizeof(*bd) * (i + 1);
@@ -1306,7 +1309,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->timeout_clks = 3 * 1048576;
 	host->dma.gpd = dma_alloc_coherent(&pdev->dev,
-				sizeof(struct mt_gpdma_desc),
+				2 * sizeof(struct mt_gpdma_desc),
 				&host->dma.gpd_addr, GFP_KERNEL);
 	host->dma.bd = dma_alloc_coherent(&pdev->dev,
 				MAX_BD_NUM * sizeof(struct mt_bdma_desc),
@@ -1347,7 +1350,7 @@ release:
 release_mem:
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,
-			sizeof(struct mt_gpdma_desc),
+			2 * sizeof(struct mt_gpdma_desc),
 			host->dma.gpd, host->dma.gpd_addr);
 	if (host->dma.bd)
 		dma_free_coherent(&pdev->dev,
-- 
1.8.1.1.dirty
