From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Add the support for sdhci-5.1
Date: Tue, 11 Aug 2015 09:14:56 +0800
Message-ID: <1439255696-3263-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: jh80.chung@samsung.com, ulf.hansson@linaro.org
Cc: heiko@sntech.de, dianders@chromium.org, Vineet.Gupta1@synopsys.com, Wei Xu <xuwei5@hisilicon.com>, Joachim Eastwood <manabian@gmail.com>, Alexey Brodkin <abrodkin@synopsys.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Russell King <linux@arm.linux.org.uk>, Jun Nie <jun.nie@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Zhou Wang <wangzhou1@hisilicon.com>, Ralf Baechle <ralf@linux-mips.org>, Govindraj Raja <govindraj.raja@imgtec.com>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mips@linux-mips.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the quirks and compatible string in sdhci-of-arasan.c
to support sdhci-arasan5.1 version of controller.

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
