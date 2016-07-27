From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: avoid unused function warnings
Date: Wed, 27 Jul 2016 09:10:41 +0200
Message-ID: <23920359.udOifghZQl@wuerfel>
References: <20160726123246.879426-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:64825 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbcG0HKy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jul 2016 03:10:54 -0400
In-Reply-To: <20160726123246.879426-1-arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Dong Aisheng <aisheng.dong@nxp.com>, Haibo Chen <haibo.chen@freescale.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, July 26, 2016 2:32:34 PM CEST Arnd Bergmann wrote:
> The driver has just gained a slightly incorrect pm-sleep implementation that causes
> warnings when CONFIG_PM is set but CONFIG_PM_SLEEP is not:
> 
> drivers/mmc/host/sdhci-esdhc-imx.c:1302:12: error: 'sdhci_esdhc_resume' defined but not used [-Werror=unused-function]
>  static int sdhci_esdhc_resume(struct device *dev)
>             ^~~~~~~~~~~~~~~~~~
> drivers/mmc/host/sdhci-esdhc-imx.c:1297:12: error: 'sdhci_esdhc_suspend' defined but not used [-Werror=unused-function]
>  static int sdhci_esdhc_suspend(struct device *dev)
> 
> This replaces the incorrect #ifdef with a __maybe_unused annotation that does
> the right thing in all configurations and is more readable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: b70d0b3b5b29 ("mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback")


It turns out that the version of the fix above requires another change
below. Fixing up the #ifdef as Ulf suggested would not require that,
but on the other hand, we generally don't hide declarations in header
files unless there is an alternative in the #else path, so we
probably want to do that anyway.

We could either fold this patch into the one I sent already, or
have this one applied separately and use the version that Ulf
preferred for the warning fix. I can send whichever we decide to
do with a proper changelog once we have consensus.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/mmc/host/sdhci-pltfm.h b/drivers/mmc/host/sdhci-pltfm.h
index d38053bf9e4d..173ef914281d 100644
--- a/drivers/mmc/host/sdhci-pltfm.h
+++ b/drivers/mmc/host/sdhci-pltfm.h
@@ -109,9 +109,9 @@ static inline void *sdhci_pltfm_priv(struct sdhci_pltfm_host *host)
 	return (void *)host->private;
 }
 
-#ifdef CONFIG_PM
 extern int sdhci_pltfm_suspend(struct device *dev);
 extern int sdhci_pltfm_resume(struct device *dev);
+#ifdef CONFIG_PM
 extern const struct dev_pm_ops sdhci_pltfm_pmops;
 #define SDHCI_PLTFM_PMOPS (&sdhci_pltfm_pmops)
 #else
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0411c9f36461..9a77cb009fc8 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -686,12 +686,10 @@ void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
 
-#ifdef CONFIG_PM
 extern int sdhci_suspend_host(struct sdhci_host *host);
 extern int sdhci_resume_host(struct sdhci_host *host);
 extern void sdhci_enable_irq_wakeups(struct sdhci_host *host);
 extern int sdhci_runtime_suspend_host(struct sdhci_host *host);
 extern int sdhci_runtime_resume_host(struct sdhci_host *host);
-#endif
 
 #endif /* __SDHCI_HW_H */

