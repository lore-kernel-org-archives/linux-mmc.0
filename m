From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 1/3] dt-bindings: sdhci-omap: Add bindings for the sdhci-omap controller
Date: Wed, 6 Sep 2017 17:15:54 +0530
Message-ID: <20170906114556.32532-2-kishon@ti.com>
References: <20170906114556.32532-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170906114556.32532-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

Add binding for the TI's sdhci-omap controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
new file mode 100644
index 000000000000..51775a372c06
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -0,0 +1,16 @@
+* TI OMAP SDHCI Controller
+
+Refer to mmc.txt for standard MMC bindings.
+
+Required properties:
+- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
+- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
+
+Example:
+	mmc1: mmc@4809c000 {
+		compatible = "ti,dra7-sdhci";
+		reg = <0x4809c000 0x400>;
+		ti,hwmods = "mmc1";
+		bus-width = <4>;
+		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+	};
-- 
2.11.0
