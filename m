From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 2/7] mmc: sdhci-pltfm: check return value of platform_get_irq()
Date: Wed, 20 Apr 2016 11:16:26 +0900
Message-ID: <1461118591-21595-3-git-send-email-yamada.masahiro@socionext.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:38194 "EHLO
	conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbcDTCP4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 22:15:56 -0400
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

The function platform_get_irq() can fail; it returns a negative error
code on failure.  A negative IRQ number will make sdhci_add_host() fail
to request IRQ anyway, but it makes sense to let it fail earlier here.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Add \n to the tail of the error message

 drivers/mmc/host/sdhci-pltfm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 03dbdeb..24377a3 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -146,6 +146,11 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 	}
 
 	host->irq = platform_get_irq(pdev, 0);
+	if (host->irq < 0) {
+		dev_err(&pdev->dev, "failed to get IRQ number\n");
+		ret = host->irq;
+		goto err_request;
+	}
 
 	if (!request_mem_region(iomem->start, resource_size(iomem),
 		mmc_hostname(host->mmc))) {
-- 
1.9.1

