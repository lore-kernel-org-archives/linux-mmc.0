From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: [PATCH] mmc: sdhci-pxav3: do the mbus window configuration after enabling clocks
Date: Wed, 31 Dec 2014 11:54:10 +0100
Message-ID: <1420023250-20671-1-git-send-email-thomas.petazzoni@free-electrons.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@free-electrons.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Lior Amsalem <alior@marvell.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In commit 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada
38x SDHCI controller"), the sdhci-pxav3 driver was extended to include
support for the SDHCI controller found in the Armada 38x
processor. This mainly involved adding some MBus window related
configuration.

However, this configuration is currently done too early in ->probe():
it is done before clocks are enabled, while this configuration
involves touching the registers of the controller, which will hang the
SoC if the clock is disabled. It wasn't noticed until now because the
bootloader typically leaves gatable clocks enabled, but in situations
where we have a deferred probe (due to a CD GPIO that cannot be taken,
for example), then the probe will be re-tried later, after a clock
disable has been done in the exit path of the failed probe attempt of
the device. This second probe() will hang the system due to the clock
being disabled.

This can for example be produced on Armada 385 GP, which has a CD GPIO
connected to an I2C PCA9555. If the driver for the PCA9555 is not
compiled into the kernel, then we will have the following sequence of
events:

  1. The SDHCI probes
  2. It does the MBus configuration (which works, because the clock is
     left enabled by the bootloader)
  3. It enables the clock
  4. It tries to get the CD GPIO, which fails due to the driver being
     missing, so -EPROBE_DEFER is returned.
  5. Before returning -EPROBE_DEFER, the driver cleans up what was
     done, which includes disabling the clock.
  6. Later on, the SDHCI probe is tried again.
  7. It does the MBus configuration, which hangs because the clock is
     no longer enabled.

This commit does the obvious fix of doing the MBus configuration after
the clock has been enabled by the driver.

Fixes: 5491ce3f79ee ("mmc: sdhci-pxav3: add support for the Armada 38x SDHCI controller")
Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/mmc/host/sdhci-pxav3.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 4523887..ca3424e 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -300,13 +300,6 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
-	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
-		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
-		if (ret < 0)
-			goto err_mbus_win;
-	}
-
-
 	pltfm_host = sdhci_priv(host);
 	pltfm_host->priv = pxa;
 
@@ -325,6 +318,12 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (!IS_ERR(pxa->clk_core))
 		clk_prepare_enable(pxa->clk_core);
 
+	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
+		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
+		if (ret < 0)
+			goto err_mbus_win;
+	}
+
 	/* enable 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
@@ -396,11 +395,11 @@ err_add_host:
 	pm_runtime_disable(&pdev->dev);
 err_of_parse:
 err_cd_req:
+err_mbus_win:
 	clk_disable_unprepare(pxa->clk_io);
 	if (!IS_ERR(pxa->clk_core))
 		clk_disable_unprepare(pxa->clk_core);
 err_clk_get:
-err_mbus_win:
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
-- 
2.1.0
