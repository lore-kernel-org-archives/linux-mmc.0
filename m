From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH v2 3/4] mmc: sdhci-pltfm: add function in sdhci_ops to parse
 dt property
Date: Tue, 12 Mar 2013 12:37:20 +0800
Message-ID: <CADz5_gLr4=s=t6S3pTvUs8DF8W=-3gTeQeR4OUxVRupDX8eibw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:60648 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751055Ab3CLEhU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Mar 2013 00:37:20 -0400
Received: by mail-oa0-f52.google.com with SMTP id k14so5403438oag.11
        for <linux-mmc@vger.kernel.org>; Mon, 11 Mar 2013 21:37:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chunhe Lan <Chunhe.Lan@freescale.com>, Stephen Warren <swarren@wwwdotorg.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <kliu5@marvell.com>

For sdhci based drivers, it's better to parse their host specific
device tree properties in their host's driver (sdhci-xxx.c) rather
than in the shared sdhci platform driver (sdhci-pltfm.c).
Otherwise function sdhci_get_of_property need to parse every host's
private dt property and will be bigger and bigger.

This patch add a function of_get_property in sdhci_ops to parse host
specific device tree property.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pltfm.c |    3 +++
 drivers/mmc/host/sdhci.h       |    1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c
b/drivers/mmc/host/sdhci-pltfm.c index 0c5eb6a..6bbbff7 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -108,6 +108,9 @@ void sdhci_get_of_property(struct platform_device *pdev)

 	if (of_find_property(np, "enable-sdio-wakeup", NULL))
 		host->mmc->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
+
+	if (host->ops->get_of_property)
+		host->ops->get_of_property(host);
 }
 #else
 void sdhci_get_of_property(struct platform_device *pdev) {} diff
--git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h index
379e09d..48562bc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -294,6 +294,7 @@ struct sdhci_ops {
 	void	(*platform_resume)(struct sdhci_host *host);
 	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
 	void	(*platform_init)(struct sdhci_host *host);
+	void    (*get_of_property)(struct sdhci_host *host);
 };

 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
--
1.7.9.5
