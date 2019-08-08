From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v1] Revert "mmc: sdhci-tegra: drop ->get_ro() implementation"
Date: Fri,  9 Aug 2019 01:24:30 +0300
Message-ID: <20190808222430.28477-1-digetx@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The WRITE_PROTECT bit is always in a "protected mode" on Tegra and
WP-GPIO state need to be used instead. In a case of the GPIO absence,
write-enable should be assumed. External SD is writable once again as
a result of this patch because the offending commit changed behaviour for
the case of a missing WP-GPIO to fall back to WRITE_PROTECT bit-checking,
which is incorrect for Tegra.

Cc: stable@vger.kernel.org # v5.1+
Fixes: e8391453e27f ("mmc: sdhci-tegra: drop ->get_ro() implementation")
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/host/sdhci-tegra.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f4d4761cf20a..02d8f524bb9e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -258,6 +258,16 @@ static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
 	}
 }
 
+static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
+{
+	/*
+	 * Write-enable shall be assumed if GPIO is missing in a board's
+	 * device-tree because SDHCI's WRITE_PROTECT bit doesn't work on
+	 * Tegra.
+	 */
+	return mmc_gpio_get_ro(host->mmc);
+}
+
 static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1224,6 +1234,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
 };
 
 static const struct sdhci_ops tegra_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
@@ -1279,6 +1290,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra30 = {
 };
 
 static const struct sdhci_ops tegra114_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
 	.write_w    = tegra_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
@@ -1332,6 +1344,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 };
 
 static const struct sdhci_ops tegra210_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
 	.write_w    = tegra210_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
@@ -1366,6 +1379,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 };
 
 static const struct sdhci_ops tegra186_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
-- 
2.22.0
