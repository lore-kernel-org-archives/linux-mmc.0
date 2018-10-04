From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 3/6] dt-bindings: mmc: sdhci-of-arasan: Add new compatible for AM654 MMC PHY
Date: Thu, 4 Oct 2018 16:44:48 +0530
Message-ID: <20181004111451.9539-4-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111451.9539-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: kishon@ti.com, faiz_abbas@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, catalin.marinas@arm.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Add a new compatible to use the host controller driver with the
MMC PHY on TI's AM654 SOCs

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index f6ddba31cb73..e2effe17f05e 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -15,6 +15,7 @@ Required Properties:
     - "arasan,sdhci-5.1": generic Arasan SDHCI 5.1 PHY
     - "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1": rk3399 eMMC PHY
       For this device it is strongly suggested to include arasan,soc-ctl-syscon.
+    - "ti,am654-sdhci-5.1", "arasan,sdhci-5.1": TI AM654 MMC PHY
   - reg: From mmc bindings: Register location and length.
   - clocks: From clock bindings: Handles to clock inputs.
   - clock-names: From clock bindings: Tuple including "clk_xin" and "clk_ahb"
-- 
2.18.0
