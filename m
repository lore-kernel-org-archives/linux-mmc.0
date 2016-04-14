From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/7] mmc: sdhci-pltfm: bail out if register resource is too small
Date: Thu, 14 Apr 2016 11:29:44 +0900
Message-ID: <1460600990-10993-2-git-send-email-yamada.masahiro@socionext.com>
References: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460600990-10993-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This code checks the resource size and displays an error message if
it is too small, but still moves forward.  Let is fail in that case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci-pltfm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 072bb27..7d12203 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -127,8 +127,11 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		goto err;
 	}
 
-	if (resource_size(iomem) < 0x100)
+	if (resource_size(iomem) < 0x100) {
 		dev_err(&pdev->dev, "Invalid iomem size!\n");
+		ret = -EINVAL;
+		goto err;
+	}
 
 	host = sdhci_alloc_host(&pdev->dev,
 		sizeof(struct sdhci_pltfm_host) + priv_size);
-- 
1.9.1
