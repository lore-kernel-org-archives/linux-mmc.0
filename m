From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 2/3] dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am654
Date: Thu, 29 Nov 2018 21:45:12 +0530
Message-ID: <20181129161513.31734-3-faiz_abbas@ti.com>
References: <20181129161513.31734-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129161513.31734-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, kishon@ti.com, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

The "ti,am654-sdhci-5.1" binding has been moved to a new driver. Indicate
this by a deprecated message.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index e2effe17f05e..1edbb049cccb 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -16,6 +16,10 @@ Required Properties:
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
     - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
+	Note: This binding has been deprecated and moved to [5].
+
+  [5] Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
-- 
2.19.2
