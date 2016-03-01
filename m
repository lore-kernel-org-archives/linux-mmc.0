From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 1/2] mmc: sdhci: Set DMA mask
Date: Tue, 1 Mar 2016 13:32:43 +0900
Message-ID: <1456806764-16467-2-git-send-email-acourbot@nvidia.com>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456806764-16467-1-git-send-email-acourbot@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, gnurou@gmail.com, Alexandre Courbot <acourbot@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Set the DMA mask if specified by the host's dma_mask member, and
not only if the DMA flags are set.

Use dma_set_mask_and_coherent() to set it instead of messing directly
with the device's dma_mask.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 drivers/mmc/host/sdhci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fd9139947fa3..0693f52d238a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2997,10 +2997,12 @@ int sdhci_add_host(struct sdhci_host *host)
 	 * mask, but PIO does not need the hw shim so we set a new
 	 * mask here in that case.
 	 */
-	if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))) {
+	if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)))
 		host->dma_mask = DMA_BIT_MASK(64);
-		mmc_dev(mmc)->dma_mask = &host->dma_mask;
-	}
+
+	if (host->dma_mask &&
+	    dma_set_mask_and_coherent(mmc_dev(mmc), host->dma_mask))
+		pr_warn("%s: cannot set DMA mask\n", mmc_hostname(mmc));
 
 	if (host->version >= SDHCI_SPEC_300)
 		host->max_clk = (caps[0] & SDHCI_CLOCK_V3_BASE_MASK)
-- 
2.7.2
