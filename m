From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci: Remove ->platform_init() callback as it's no longer used
Date: Tue, 30 Aug 2016 12:02:18 +0200
Message-ID: <1472551338-20019-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f43.google.com ([209.85.215.43]:35508 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755725AbcH3KC0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 06:02:26 -0400
Received: by mail-lf0-f43.google.com with SMTP id f93so9801365lfi.2
        for <linux-mmc@vger.kernel.org>; Tue, 30 Aug 2016 03:02:25 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

The commit 1ef5e49e46b9 ("mmc: sdhci-of-esdhc: add/remove some quirks
according to vendor version") moved sdhci-of-esdhc away from using the
->platform_init() callback.

As it was the only user of it and that it seems reasonable to believe that
it won't be needed again, let's remove just remove it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-pltfm.c | 7 -------
 drivers/mmc/host/sdhci.h       | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 1d17dcf..ad49bfa 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -156,13 +156,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		host->quirks2 = pdata->quirks2;
 	}
 
-	/*
-	 * Some platforms need to probe the controller to be able to
-	 * determine which caps should be used.
-	 */
-	if (host->ops && host->ops->platform_init)
-		host->ops->platform_init(host);
-
 	platform_set_drvdata(pdev, host);
 
 	return host;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0411c9f..a2bc9e1 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -555,7 +555,6 @@ struct sdhci_ops {
 	void	(*set_uhs_signaling)(struct sdhci_host *host, unsigned int uhs);
 	void	(*hw_reset)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
-	void	(*platform_init)(struct sdhci_host *host);
 	void    (*card_event)(struct sdhci_host *host);
 	void	(*voltage_switch)(struct sdhci_host *host);
 	int	(*select_drive_strength)(struct sdhci_host *host,
-- 
1.9.1

