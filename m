From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: [PATCH 1/1] mmc: sdhci-esdhc-imx: Use pinctrl PM helpers
Date: Fri, 12 Jun 2015 11:31:13 +0200
Message-ID: <1434101473-4109-1-git-send-email-mirza.krak@hostmobility.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:34497 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbFLJb4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jun 2015 05:31:56 -0400
Received: by laew7 with SMTP id w7so17950916lae.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2015 02:31:54 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org
Cc: shawn.guo@linaro.org, dirk.behme@de.bosch.com, peter.griffin@linaro.org, stefan@agner.ch, linux-mmc@vger.kernel.org, Mirza Krak <mirza.krak@hostmobility.com>

From: Mirza Krak <mirza.krak@hostmobility.com>

Add support for current states of pinctrl, which are "default", "idle"
and "sleep".

The "default" pinctrl state is set by Drivers core before
calling the driver's probe, hence we do not need a initial call to
"default" state.

Signed-off-by: Mirza Krak <mirza.krak@hostmobility.com>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 84b3365e4773..6d51a4f48361 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1129,6 +1129,8 @@ static int sdhci_esdhc_suspend(struct device *dev)
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
+	pinctrl_pm_select_sleep_state(dev);
+
 	return ret;
 }
 
@@ -1137,6 +1139,8 @@ static int sdhci_esdhc_resume(struct device *dev)
 	int ret;
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
+	pinctrl_pm_select_default_state(dev);
+
 	pm_runtime_get_sync(dev);
 	ret = sdhci_resume_host(host);
 	pm_runtime_mark_last_busy(dev);
@@ -1160,6 +1164,8 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	}
 	clk_disable_unprepare(imx_data->clk_ahb);
 
+	pinctrl_pm_select_idle_state(dev);
+
 	return ret;
 }
 
@@ -1169,6 +1175,8 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
+	pinctrl_pm_select_default_state(dev);
+
 	if (!sdhci_sdio_irq_enabled(host)) {
 		clk_prepare_enable(imx_data->clk_per);
 		clk_prepare_enable(imx_data->clk_ipg);
-- 
2.1.0

