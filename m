From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 3/4] mmc: sdhci-pltfm: dt device does not pass parent to sdhci_alloc_host
Date: Thu, 7 Jul 2011 00:47:49 +0800
Message-ID: <1309970870-13336-4-git-send-email-shawn.guo@linaro.org>
References: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:5479
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754670Ab1GFQlk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Jul 2011 12:41:40 -0400
In-Reply-To: <1309970870-13336-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Chris Ball <cjb@laptop.org>

Neither platform based nor dt based device needs to pass the parent
to sdhci_alloc_host.  There is no difference between platform and dt
on this point.

The patch makes the change to pass device itself than its parent to
sdhci_alloc_host for dt case too.  Otherwise the probe function of
sdhci based drivers which is shared between platform and dt will
fail on dt case.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Cc: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/sdhci-pltfm.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index 71c0ce1..6414efe 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -85,6 +85,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 {
 	struct sdhci_host *host;
 	struct sdhci_pltfm_host *pltfm_host;
+	struct device_node *np = pdev->dev.of_node;
 	struct resource *iomem;
 	int ret;
 
@@ -98,7 +99,7 @@ struct sdhci_host *sdhci_pltfm_init(struct platform_device *pdev,
 		dev_err(&pdev->dev, "Invalid iomem size!\n");
 
 	/* Some PCI-based MFD need the parent here */
-	if (pdev->dev.parent != &platform_bus)
+	if (pdev->dev.parent != &platform_bus && !np)
 		host = sdhci_alloc_host(pdev->dev.parent, sizeof(*pltfm_host));
 	else
 		host = sdhci_alloc_host(&pdev->dev, sizeof(*pltfm_host));
-- 
1.7.4.1


