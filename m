From: Andrew Jeffery <andrew@aj.id.au>
Subject: [PATCH v2 1/4] mmc: sdhci-of-aspeed: Fix link failure for SPARC
Date: Mon,  2 Sep 2019 13:28:39 +0930
Message-ID: <20190902035842.2747-2-andrew@aj.id.au>
References: <20190902035842.2747-1-andrew@aj.id.au>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190902035842.2747-1-andrew@aj.id.au>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Andrew Jeffery <andrew@aj.id.au>, adrian.hunter@intel.com, ulf.hansson@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, kbuild test robot <lkp@intel.com>
List-Id: linux-mmc@vger.kernel.org

Resolves the following build error reported by the 0-day bot:

    ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!

SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Guard the
callsite to maintain build coverage for the rest of the driver.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 38 ++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index d5acb5afc50f..96ca494752c5 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -224,10 +224,30 @@ static struct platform_driver aspeed_sdhci_driver = {
 	.remove		= aspeed_sdhci_remove,
 };
 
-static int aspeed_sdc_probe(struct platform_device *pdev)
-
+static int aspeed_sdc_create_sdhcis(struct platform_device *pdev)
 {
+#if defined(CONFIG_OF_ADDRESS)
 	struct device_node *parent, *child;
+
+	parent = pdev->dev.of_node;
+
+	for_each_available_child_of_node(parent, child) {
+		struct platform_device *cpdev;
+
+		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
+		if (!cpdev) {
+			of_node_put(child);
+			return -ENODEV;
+		}
+	}
+#endif
+
+	return 0;
+}
+
+static int aspeed_sdc_probe(struct platform_device *pdev)
+
+{
 	struct aspeed_sdc *sdc;
 	int ret;
 
@@ -256,17 +276,9 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(&pdev->dev, sdc);
 
-	parent = pdev->dev.of_node;
-	for_each_available_child_of_node(parent, child) {
-		struct platform_device *cpdev;
-
-		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
-		if (!cpdev) {
-			of_node_put(child);
-			ret = -ENODEV;
-			goto err_clk;
-		}
-	}
+	ret = aspeed_sdc_create_sdhcis(pdev);
+	if (ret)
+		goto err_clk;
 
 	return 0;
 
-- 
2.20.1
