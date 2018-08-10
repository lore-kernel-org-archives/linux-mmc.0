From: Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v2 21/40] mmc: tegra: Parse default trim and tap from dt
Date: Fri, 10 Aug 2018 21:08:23 +0300
Message-ID: <1533924522-1037-22-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Mikko Perttunen <mperttunen@nvidia.com>, Stefan Agner <stefan@agner.ch>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
List-Id: linux-mmc@vger.kernel.org

Parse the default inbound and outbound sampling trimmer values from
the device tree.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index e82fb92..0c39c54 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -107,6 +107,9 @@ struct sdhci_tegra {
 	struct pinctrl_state *pinctrl_state_1v8;
 
 	struct sdhci_tegra_autocal_offsets autocal_offsets;
+
+	u32 default_tap;
+	u32 default_trim;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -461,6 +464,23 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 		autocal->pull_down_hs400 = autocal->pull_down_1v8;
 }
 
+static void tegra_sdhci_parse_default_tap_and_trim(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	int err;
+
+	err = device_property_read_u32(host->mmc->parent, "nvidia,default-tap",
+				       &tegra_host->default_tap);
+	if (err)
+		tegra_host->default_tap = 0;
+
+	err = device_property_read_u32(host->mmc->parent, "nvidia,default-trim",
+				       &tegra_host->default_trim);
+	if (err)
+		tegra_host->default_trim = 0;
+}
+
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -866,6 +886,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	tegra_sdhci_parse_pad_autocal_dt(host);
 
+	tegra_sdhci_parse_default_tap_and_trim(host);
+
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
 	if (IS_ERR(tegra_host->power_gpio)) {
-- 
2.7.4
