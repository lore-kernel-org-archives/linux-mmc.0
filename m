From: <micky_ching@realsil.com.cn>
Subject: [PATCH 11/12] mmc: sdhci: set DMA configure for SD4.0 mode
Date: Wed, 29 Apr 2015 09:23:43 +0800
Message-ID: <c0d23a5d274fd741970fe8150faccc055d000c5a.1429845922.git.micky_ching@realsil.com.cn>
References: <cover.1429845922.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1429845922.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: chris@printf.net, ulf.hansson@linaro.org, sameo@linux.intel.com
Cc: gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, devel@linuxdriverproject.org, rogerable@realtek.com, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

From: Micky Ching <micky_ching@realsil.com.cn>

SD4.0 mode not using SDMA any more, and UHSII mode using different register
to specify block size/count.

Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
Signed-off-by: Wei Wang <wei_wang@realsil.com.cn>
---
 drivers/mmc/host/sdhci.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 03df58c..15bd7c8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -883,8 +883,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 				host->flags &= ~SDHCI_REQ_USE_DMA;
 			} else {
 				WARN_ON(sg_cnt != 1);
-				sdhci_writel(host, sg_dma_address(data->sg),
-					SDHCI_DMA_ADDRESS);
+				if (host->uhsii_if_enabled)
+					sdhci_writel(host,
+						sg_dma_address(data->sg),
+						SDHCI_ADMA_ADDRESS);
+				else
+					sdhci_writel(host,
+						sg_dma_address(data->sg),
+						SDHCI_DMA_ADDRESS);
 			}
 		}
 	}
@@ -924,9 +930,15 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	sdhci_set_transfer_irqs(host);
 
 	/* Set the DMA boundary value and block size */
-	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
-		data->blksz), SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	if (host->uhsii_if_enabled) {
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
+			data->blksz), SDHCI_UHSII_BLOCK_SIZE);
+		sdhci_writew(host, data->blocks, SDHCI_UHSII_BLOCK_COUNT);
+	} else {
+		sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
+			data->blksz), SDHCI_BLOCK_SIZE);
+		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	}
 }
 
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
-- 
1.9.1
