From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 1/5] drivers/mmc/host: constify sdhci_pltfm_data structures
Date: Mon,  7 Aug 2017 11:50:40 +0200
Message-ID: <1502099444-10473-2-git-send-email-Julia.Lawall@lip6.fr>
References: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The sdhci_pltfm_data structure is only passed as the second argument
of sdhci_pltfm_init, which is const, so the sdhci_pltfm_data structure can
be const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/sdhci-pic32.c |    2 +-
 drivers/mmc/host/sdhci-pxav3.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pic32.c b/drivers/mmc/host/sdhci-pic32.c
index 72c13b6..a6caa49 100644
--- a/drivers/mmc/host/sdhci-pic32.c
+++ b/drivers/mmc/host/sdhci-pic32.c
@@ -97,7 +97,7 @@ static unsigned int pic32_sdhci_get_ro(struct sdhci_host *host)
 	.get_ro = pic32_sdhci_get_ro,
 };
 
-static struct sdhci_pltfm_data sdhci_pic32_pdata = {
+static const struct sdhci_pltfm_data sdhci_pic32_pdata = {
 	.ops = &pic32_sdhci_ops,
 	.quirks = SDHCI_QUIRK_NO_HISPD_BIT,
 	.quirks2 = SDHCI_QUIRK2_NO_1_8_V,
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f953f35..a344341 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -337,7 +337,7 @@ static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
 	.set_uhs_signaling = pxav3_set_uhs_signaling,
 };
 
-static struct sdhci_pltfm_data sdhci_pxav3_pdata = {
+static const struct sdhci_pltfm_data sdhci_pxav3_pdata = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK
 		| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
 		| SDHCI_QUIRK_32BIT_ADMA_SIZE
