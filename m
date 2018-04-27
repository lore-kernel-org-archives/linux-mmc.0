From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v5 01/14] mmc: sdhci-omap: Fix when capabilities are obtained from SDHCI_CAPABILITIES reg
Date: Fri, 27 Apr 2018 17:17:10 +0530
Message-ID: <20180427114723.2687-2-kishon@ti.com>
References: <20180427114723.2687-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180427114723.2687-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

sdhci_omap_config_iodelay_pinctrl_state() requires caps and caps2 to be
initialized (speed mode capabilities like UHS/HS200) before it is
invoked. While mmc_of_parse() initializes caps/caps2 if capabilities is
populated in device tree, it will remain uninitialized for capabilities
obtained from SDHCI_CAPABILITIES register.
Fix sdhci_omap_config_iodelay_pinctrl_state() to be used even while
getting the capabilities from SDHCI_CAPABILITIES register by invoking
sdhci_setup_host() before sdhci_omap_config_iodelay_pinctrl_state().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-omap.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 1456abd5eeb9..e7e43f2ae224 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -916,10 +916,6 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 		goto err_put_sync;
 	}
 
-	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
-	if (ret)
-		goto err_put_sync;
-
 	host->mmc_host_ops.get_ro = mmc_gpio_get_ro;
 	host->mmc_host_ops.start_signal_voltage_switch =
 					sdhci_omap_start_signal_voltage_switch;
@@ -930,12 +926,23 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	sdhci_read_caps(host);
 	host->caps |= SDHCI_CAN_DO_ADMA2;
 
-	ret = sdhci_add_host(host);
+	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
 
+	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
+	if (ret)
+		goto err_cleanup_host;
+
+	ret = __sdhci_add_host(host);
+	if (ret)
+		goto err_cleanup_host;
+
 	return 0;
 
+err_cleanup_host:
+	sdhci_cleanup_host(host);
+
 err_put_sync:
 	pm_runtime_put_sync(dev);
 
-- 
2.17.0
