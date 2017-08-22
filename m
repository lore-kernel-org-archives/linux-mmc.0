From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 22 Aug 2017 19:09:07 +0530
Message-ID: <20170822133907.21549-1-kishon@ti.com>
References: <20170821142132.GH6008@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170821142132.GH6008@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add binding for the TI's sdhci-omap controller. This now includes only
a subset of properties documented in ti-omap-hsmmc.txt but will eventually
include all the properties.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
Changes from v1:
*) Create a new sdhci-omap.txt document for TI's sdhci-omap controller instead
   of using the ti-omap-hsmmc.txt as suggested by Tony
 .../devicetree/bindings/mmc/sdhci-omap.txt         | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
new file mode 100644
index 000000000000..139695ad2d58
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -0,0 +1,22 @@
+* TI OMAP SDHCI Controller
+
+Refer to mmc.txt for standard MMC bindings.
+
+Required properties:
+- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
+- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
+
+Optional properties:
+- ti,dual-volt: boolean, supports dual voltage cards
+- ti,non-removable: non-removable slot (like eMMC)
+
+Example:
+	mmc1: mmc@0x4809c000 {
+		compatible = "ti,omap4-hsmmc";
+		reg = <0x4809c000 0x400>;
+		ti,hwmods = "mmc1";
+		ti,dual-volt;
+		bus-width = <4>;
+		vmmc-supply = <&vmmc>; /* phandle to regulator node */
+		ti,non-removable;
+	};
-- 
2.11.0
