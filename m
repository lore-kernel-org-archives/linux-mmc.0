From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: [PATCH v2] mmc: sdhci-of-esdhc: set proper dma mask for ls104x chips
Date: Wed,  4 Jul 2018 14:34:20 +0300
Message-ID: <20180704113420.22204-1-laurentiu.tudor@nxp.com>
References: <CAPDyKFrabODyn4qgprFS4+Pfg0Xvy1tBzqDofJOwWuM7HK=0ZQ@mail.gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrabODyn4qgprFS4+Pfg0Xvy1tBzqDofJOwWuM7HK=0ZQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yangbo.lu@nxp.com, Laurentiu Tudor <laurentiu.tudor@nxp.com>
List-Id: linux-mmc@vger.kernel.org

SDHCI controller in ls1043a and ls1046a generate 40-bit wide addresses
when doing DMA. Make sure that the corresponding dma mask is correctly
configured.

Context: when enabling smmu on these chips the following problem is
encountered: the smmu input address size is 48 bits so the dma mappings
for sdhci end up 48-bit wide. However, on these chips sdhci only use
40-bits of that address size when doing dma.
So you end up with a 48-bit address translation in smmu but the device
generates transactions with clipped 40-bit addresses, thus smmu context
faults are triggered. Setting up the correct dma mask fixes this
situation.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Changes in v2:
 - updated commit log with some context

 drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 4ffa6b173a21..8332f56e6c0d 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -22,6 +22,7 @@
 #include <linux/sys_soc.h>
 #include <linux/clk.h>
 #include <linux/ktime.h>
+#include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include "sdhci-pltfm.h"
 #include "sdhci-esdhc.h"
@@ -427,6 +428,11 @@ static void esdhc_of_adma_workaround(struct sdhci_host *host, u32 intmask)
 static int esdhc_of_enable_dma(struct sdhci_host *host)
 {
 	u32 value;
+	struct device *dev = mmc_dev(host->mmc);
+
+	if (of_device_is_compatible(dev->of_node, "fsl,ls1043a-esdhc") ||
+	    of_device_is_compatible(dev->of_node, "fsl,ls1046a-esdhc"))
+		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
 
 	value = sdhci_readl(host, ESDHC_DMA_SYSCTL);
 	value |= ESDHC_DMA_SNOOP;
-- 
2.17.1
