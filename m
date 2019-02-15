From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 7/8] dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
Date: Sat, 16 Feb 2019 00:50:32 +0530
Message-ID: <20190215192033.24203-8-faiz_abbas@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, kishon@ti.com, zhang.chunyan@linaro.org, faiz_abbas@ti.com
List-Id: linux-mmc@vger.kernel.org

Add binding for the TI's sdhci-omap controller present in am335x and
am437x devices.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 4485dbceb373..859291e83964 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -7,6 +7,8 @@ For UHS devices which require tuning, the device tree should have a "cpu_thermal
 Required properties:
 - compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
 	      Should be "ti,k2g-sdhci" for K2G
+	      Should be "ti,am335-sdhci" for am335x controllers
+	      Should be "ti,am437-sdhci" for am437x controllers
 - ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
 	     (Not required for K2G).
 - pinctrl-names: Should be subset of "default", "hs", "sdr12", "sdr25", "sdr50",
-- 
2.19.2
