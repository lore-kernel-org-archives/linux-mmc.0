From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v4 03/12] mmc: sdhci-omap: Workaround for Errata i843
Date: Wed, 25 Apr 2018 17:39:28 +0530
Message-ID: <20180425120937.29867-4-kishon@ti.com>
References: <20180425120937.29867-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180425120937.29867-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

Errata i843 in AM572x Sitara Processors Silicon Revision 2.0, 1.1
(SPRZ429L July 2014–Revised April 2018 [1]) mentions
PG 1.0/1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
can operate.

Use soc_device_match() to identify rev 1.0/1.1 silicon and
override mmc->f_max according to the errata workaround.
"max-frequency" dt property cannot be used since the device
tree is added for rev 2.0 silicon.

soc_device_match() is also used in order to get the IODelay values
for rev 1.0/1.1 silicon.

[1] -> http://www.ti.com/lit/er/sprz429l/sprz429l.pdf

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 drivers/mmc/host/sdhci-omap.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 6e2cf4cfeec0..b4400be0606f 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -26,6 +26,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/sys_soc.h>
 
 #include "sdhci-pltfm.h"
 
@@ -100,6 +101,7 @@ struct sdhci_omap_data {
 };
 
 struct sdhci_omap_host {
+	char			*version;
 	void __iomem		*base;
 	struct device		*dev;
 	struct	regulator	*pbias;
@@ -733,12 +735,21 @@ static struct pinctrl_state
 				  u32 *caps, u32 capmask)
 {
 	struct device *dev = omap_host->dev;
+	char *version = omap_host->version;
 	struct pinctrl_state *pinctrl_state = ERR_PTR(-ENODEV);
+	char str[20];
 
 	if (!(*caps & capmask))
 		goto ret;
 
-	pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
+	if (version) {
+		snprintf(str, 20, "%s-%s", mode, version);
+		pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, str);
+	}
+
+	if (IS_ERR(pinctrl_state))
+		pinctrl_state = pinctrl_lookup_state(omap_host->pinctrl, mode);
+
 	if (IS_ERR(pinctrl_state)) {
 		dev_err(dev, "no pinctrl state for %s mode", mode);
 		*caps &= ~capmask;
@@ -830,6 +841,16 @@ static int sdhci_omap_config_iodelay_pinctrl_state(struct sdhci_omap_host
 	return 0;
 }
 
+static const struct soc_device_attribute sdhci_omap_soc_devices[] = {
+	{
+		.machine = "DRA7[45]*",
+		.revision = "ES1.[01]",
+	},
+	{
+		/* sentinel */
+	}
+};
+
 static int sdhci_omap_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -841,6 +862,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	struct mmc_host *mmc;
 	const struct of_device_id *match;
 	struct sdhci_omap_data *data;
+	const struct soc_device_attribute *soc;
 
 	match = of_match_device(omap_sdhci_match, dev);
 	if (!match)
@@ -875,6 +897,17 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pltfm_free;
 
+	soc = soc_device_match(sdhci_omap_soc_devices);
+	if (soc) {
+		omap_host->version = "rev11";
+		if (!strcmp(dev_name(dev), "4809c000.mmc"))
+			mmc->f_max = 96000000;
+		if (!strcmp(dev_name(dev), "480b4000.mmc"))
+			mmc->f_max = 48000000;
+		if (!strcmp(dev_name(dev), "480ad000.mmc"))
+			mmc->f_max = 48000000;
+	}
+
 	pltfm_host->clk = devm_clk_get(dev, "fck");
 	if (IS_ERR(pltfm_host->clk)) {
 		ret = PTR_ERR(pltfm_host->clk);
-- 
2.17.0
