From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 1/8] mmc: sdhci-esdhc-imx: remove duplicated lines
Date: Mon, 22 Sep 2014 17:12:04 +0800
Message-ID: <1411377131-19741-2-git-send-email-b29396@freescale.com>
References: <1411377131-19741-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411377131-19741-1-git-send-email-b29396@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.guo@linaro.org, b29396@freescale.com, chris@printf.net, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

There is already the same register check above, no need the later one.
Move them into one place and delete the later one.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |   12 +++++-------
 1 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 587ee0e..256c901 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -315,6 +315,11 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			data |= ESDHC_CTRL_D3CD;
 			writel(data, host->ioaddr + SDHCI_HOST_CONTROL);
 		}
+
+		if (val & SDHCI_INT_ADMA_ERROR) {
+			val &= ~SDHCI_INT_ADMA_ERROR;
+			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
+		}
 	}
 
 	if (unlikely((imx_data->socdata->flags & ESDHC_FLAG_MULTIBLK_NO_INT)
@@ -335,13 +340,6 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 			}
 	}
 
-	if (unlikely(reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)) {
-		if (val & SDHCI_INT_ADMA_ERROR) {
-			val &= ~SDHCI_INT_ADMA_ERROR;
-			val |= ESDHC_INT_VENDOR_SPEC_DMA_ERR;
-		}
-	}
-
 	writel(val, host->ioaddr + reg);
 }
 
-- 
1.7.8
