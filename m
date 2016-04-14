From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 2/7] mmc: sdhci-pltfm: check return value of platform_get_irq()
Date: Thu, 14 Apr 2016 11:29:45 +0900
Message-ID: <1460600990-10993-3-git-send-email-yamada.masahiro@socionext.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-07.nifty.com ([210.131.2.74]:40573 "EHLO
	conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567AbcDNC3b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 22:29:31 -0400
In-Reply-To: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

The function platform_get_irq() can fail; it returns a negative error
code on error.  A negative IRQ number will make sdhci_add_host() fail
to request IRQ anyway, but it makes sense to let it fail earlier here.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 7d12203..3354a53 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -152,6 +152,11 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ number");
+		ret = host->irq;
+		goto err_request;
+	}
 
 	if (!request_mem_region(iomem->start, resource_size(iomem),
 		mmc_hostname(host->mmc))) {
-- 
1.9.1

