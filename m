From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 3/5] mmc: sdhci-sirf: constify sdhci_pltfm_data and sdhci_ops structures
Date: Mon,  7 Aug 2017 11:50:42 +0200
Message-ID: <1502099444-10473-4-git-send-email-Julia.Lawall@lip6.fr>
References: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: bhumirks@gmail.com, kernel-janitors@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Barry Song <baohua@kernel.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The sdhci_pltfm_data structure is only passed as the second argument
of sdhci_pltfm_init, which is const, while the sdhci_ops structure
is only stored in the ops field of a sdhci_pltfm_data structure,
which is also const.  Thus both kinds of structures can be const as
well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/sdhci-sirf.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index c251c6c..556b0cf 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -146,7 +146,7 @@ static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return rc;
 }
 
-static struct sdhci_ops sdhci_sirf_ops = {
+static const struct sdhci_ops sdhci_sirf_ops = {
 	.read_l = sdhci_sirf_readl_le,
 	.read_w = sdhci_sirf_readw_le,
 	.platform_execute_tuning = sdhci_sirf_execute_tuning,
@@ -157,7 +157,7 @@ static int sdhci_sirf_execute_tuning(struct sdhci_host *host, u32 opcode)
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-static struct sdhci_pltfm_data sdhci_sirf_pdata = {
+static const struct sdhci_pltfm_data sdhci_sirf_pdata = {
 	.ops = &sdhci_sirf_ops,
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
