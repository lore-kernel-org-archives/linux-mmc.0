From: Marek Vasut <marex@denx.de>
Subject: [PATCH] mmc: mxs-mmc: Fix merge issue causing build error
Date: Mon,  1 Oct 2012 22:52:43 +0200
Message-ID: <1349124763-10840-1-git-send-email-marex@denx.de>
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
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The following error appeared due to trivial merge problem:

drivers/mmc/host/mxs-mmc.c: In function 'mxs_mmc_enable_sdio_irq':
drivers/mmc/host/mxs-mmc.c:527:3: error: 'struct mxs_mmc_host' has no member named 'base'
drivers/mmc/host/mxs-mmc.c:527:3: error: 'struct mxs_mmc_host' has no member named 'devid'
make[3]: *** [drivers/mmc/host/mxs-mmc.o] Error 1

This patches corrects the issue.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index bb4c2bf..80d1e6d 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -525,7 +525,7 @@ static void mxs_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
 		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 		writel(BM_SSP_CTRL1_SDIO_IRQ_EN,
-		       host->base + HW_SSP_CTRL1(host) + STMP_OFFSET_REG_SET);
+		       ssp->base + HW_SSP_CTRL1(ssp) + STMP_OFFSET_REG_SET);
 	} else {
 		writel(BM_SSP_CTRL0_SDIO_IRQ_CHECK,
 		       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_CLR);
-- 
1.7.10.4
