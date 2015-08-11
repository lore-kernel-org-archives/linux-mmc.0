From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH] mmc: sdhci-of-arasan: Add the support for sdhci-5.1
Date: Tue, 11 Aug 2015 09:34:48 +0800
Message-ID: <1439256888-6658-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>, =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

This patch adds the quirks and compatible string in sdhci-of-arasan.c
to support sdhci-arasan5.1 version of controller. No documented controller
IP version is found in the TRM, so we use ths version of command queueing
engine integrated into this controller by arasan to specify our controller.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 2 +-
 drivers/mmc/host/sdhci-of-arasan.c                     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 7e94903..da541c3 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -9,7 +9,7 @@ Device Tree Bindings for the Arasan SDHCI Controller
 
 Required Properties:
   - compatible: Compatibility string. Must be 'arasan,sdhci-8.9a' or
-                'arasan,sdhci-4.9a'
+                'arasan,sdhci-4.9a' or 'arasan,sdhci-5.1'
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index ef5a7d2..c9012f5 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -175,6 +175,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	if (of_device_is_compatible(pdev->dev.of_node, "arasan,sdhci-4.9a")) {
 		host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
 		host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
+	} else if (of_device_is_compatible(pdev->dev.of_node,
+					   "arasan,sdhci-5.1")) {
+		host->quirks |= SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
 	}
 
 	sdhci_get_of_property(pdev);
@@ -217,6 +220,7 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 
 static const struct of_device_id sdhci_arasan_of_match[] = {
 	{ .compatible = "arasan,sdhci-8.9a" },
+	{ .compatible = "arasan,sdhci-5.1" },
 	{ .compatible = "arasan,sdhci-4.9a" },
 	{ }
 };
-- 
2.3.7
