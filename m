From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 3/5] sdhci-s3c: increase the timeout value
Date: Wed, 09 Jun 2010 11:39:41 +0200
Message-ID: <1276076383-24825-4-git-send-email-m.szyprowski@samsung.com>
References: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1276076383-24825-1-git-send-email-m.szyprowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kyungmin.park@samsung.com, kgene.kim@samsung.com, ben-linux@fluff.org, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

This patch increases the timeout value on sdhci-s3c controller by using
SDHCI_QUIRK_BROKEN_TIMEOUT_VAL quirk. Without it most transfers from
external mmc cards fails on Samsung s5pv210 SoCs based systems. Tested
on Samsung Aquila board.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci-s3c.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index ad30f07..2b6cb44 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -331,6 +331,7 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	 * transfers, not sure if this is a problem with this specific
 	 * SDHCI block, or a missing configuration that needs to be set. */
 	host->quirks |= SDHCI_QUIRK_NO_BUSY_IRQ;
+	host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
 
 	host->quirks |= (SDHCI_QUIRK_32BIT_DMA_ADDR |
 			 SDHCI_QUIRK_32BIT_DMA_SIZE);
-- 
1.7.1.240.g225c
