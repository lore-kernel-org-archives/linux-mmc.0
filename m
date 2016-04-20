From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v2 1/7] mmc: sdhci-pltfm: drop error message for too small MMIO resource size
Date: Wed, 20 Apr 2016 11:16:25 +0900
Message-ID: <1461118591-21595-2-git-send-email-yamada.masahiro@socionext.com>
References: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conuserg-11.nifty.com ([210.131.2.78]:38197 "EHLO
	conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbcDTCP4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 22:15:56 -0400
In-Reply-To: <1461118591-21595-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>

The requirement resource_size >= 0x100 may not necessarily be
reasonable; for example, sdhci-dove appears to sidestep some
registers in sdhci_dove_readw().

Moreover, current code displays an error message for too small
resource size, but still moves forward.

Every DT should be responsible for describing its properties
correctly, so lets's remove this error message from the common
framework.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Remove resource size checking rather than fix it.

 drivers/mmc/host/sdhci-pltfm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 072bb27..03dbdeb 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -127,9 +127,6 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err;
 	}
 
-	if (resource_size(iomem) < 0x100)
-		dev_err(&pdev->dev, "Invalid iomem size!\n");
-
 	host = sdhci_alloc_host(&pdev->dev,
 		sizeof(struct sdhci_pltfm_host) + priv_size);
 
-- 
1.9.1

