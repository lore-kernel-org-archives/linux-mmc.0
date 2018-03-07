From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 01/11] mmc: sdhci-omap: Fix when capabilities are obtained from SDHCI_CAPABILITIES reg
Date: Wed, 7 Mar 2018 18:50:10 +0530
Message-ID: <20180307132020.30951-2-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307132020.30951-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, kishon@ti.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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
---
 drivers/mmc/host/sdhci-omap.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 1456abd5eeb9..3cce30584d2f 100644
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
@@ -930,7 +926,15 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	sdhci_read_caps(host);
 	host->caps |= SDHCI_CAN_DO_ADMA2;
 
-	ret = sdhci_add_host(host);
+	ret = sdhci_setup_host(host);
+	if (ret)
+		goto err_put_sync;
+
+	ret = sdhci_omap_config_iodelay_pinctrl_state(omap_host);
+	if (ret)
+		goto err_put_sync;
+
+	ret = __sdhci_add_host(host);
 	if (ret)
 		goto err_put_sync;
 
-- 
2.11.0
