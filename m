From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 24/38] mmc: tegra: Remove tegra_sdhci_writew() from tegra210_sdhci_ops
Date: Thu, 30 Aug 2018 18:06:25 +0300
Message-ID: <20180830150639.21048-25-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

tegra_sdhci_writew() defers the write to SDHCI_TRANSFER_MODE until
SDHCI_COMMAND is written. This is not necessary on Tegra210 and Tegra186
and it breaks read-modify-write operations on SDHCI_TRANSFER_MODE
because writes to SDHCI_TRANSFER_MODE aren't visible until SDHCI_COMMAND
has been written to. This results in tuning failures on Tegra210.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f68557a01d5d..0bdce437e752 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -834,7 +834,6 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 static const struct sdhci_ops tegra210_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
-	.write_w    = tegra_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
-- 
2.18.0
