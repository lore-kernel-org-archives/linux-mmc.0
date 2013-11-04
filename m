From: Dong Aisheng <b29396@freescale.com>
Subject: [PATCH v2 1/5] mmc: sdhci-pltfm: export pltfm suspend/resume api
Date: Mon, 4 Nov 2013 16:38:25 +0800
Message-ID: <1383554309-29065-2-git-send-email-b29396@freescale.com>
References: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db9lp0249.outbound.messaging.microsoft.com ([213.199.154.249]:52089
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752315Ab3KDI6h (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Nov 2013 03:58:37 -0500
In-Reply-To: <1383554309-29065-1-git-send-email-b29396@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, b29396@freescale.com, ulf.hansson@linaro.org

It is helpful for platforms code to use to elimiate duplicated code.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    6 ++++--
 drivers/mmc/host/sdhci-pltfm.h |    2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index e2065a4..bef250e 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -237,19 +237,21 @@ int sdhci_pltfm_unregister(struct platform_device *pdev)
 EXPORT_SYMBOL_GPL(sdhci_pltfm_unregister);
 
 #ifdef CONFIG_PM
-static int sdhci_pltfm_suspend(struct device *dev)
+int sdhci_pltfm_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
 	return sdhci_suspend_host(host);
 }
+EXPORT_SYMBOL_GPL(sdhci_pltfm_suspend);
 
-static int sdhci_pltfm_resume(struct device *dev)
+int sdhci_pltfm_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 
 	return sdhci_resume_host(host);
 }
+EXPORT_SYMBOL_GPL(sdhci_pltfm_resume);
 
 const struct dev_pm_ops sdhci_pltfm_pmops = {
 	.suspend	= sdhci_pltfm_suspend,
diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index e15ced79..04bc248 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -111,6 +111,8 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 }
 
 #ifdef CONFIG_PM
+extern int sdhci_pltfm_suspend(struct device *dev);
+extern int sdhci_pltfm_resume(struct device *dev);
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
 #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
 #else
-- 
1.7.2.rc3


