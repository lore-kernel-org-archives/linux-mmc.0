From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH 1/4] dt-bindings: mmc: sdhci-am654: Document bindings for the
 host controllers on TI's J721E devices.
Date: Tue, 4 Jun 2019 11:39:11 +0530
Message-ID: <20190604060914.10886-2-faiz_abbas@ti.com>
References: <20190604060914.10886-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190604060914.10886-1-faiz_abbas@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: nm@ti.com, ulf.hansson@linaro.org, robh+dt@kernel.org, nsekhar@ti.com, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Add binding documentation for mmc host controllers present on TI's J721E
SOC. The 4 bit IP on J721E doesn't have a phy DLL so make DLL related
properties as optional for that compatible. Also add an optional
strobe-sel property used for HS400 speed mode.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-am654.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
index 15dbbbace27e..50e87df47971 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
@@ -8,7 +8,10 @@ Only deviations are documented here.
   [3] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 
 Required Properties:
-	- compatible: should be "ti,am654-sdhci-5.1"
+	- compatible: should be one of:
+			"ti,am654-sdhci-5.1": SDHCI on AM654 device.
+			"ti,j721e-sdhci-8bit": 8 bit SDHCI on J721E device.
+			"ti,j721e-sdhci-4bit": 4 bit SDHCI on J721E device.
 	- reg: Must be two entries.
 		- The first should be the sdhci register space
 		- The second should the subsystem/phy register space
@@ -16,9 +19,13 @@ Required Properties:
 	- clock-names: Tuple including "clk_xin" and "clk_ahb"
 	- interrupts: Interrupt specifiers
 	- ti,otap-del-sel: Output Tap Delay select
+
+Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
 	- ti,trm-icp: DLL trim select
 	- ti,driver-strength-ohm: driver strength in ohms.
 				  Valid values are 33, 40, 50, 66 and 100 ohms.
+Optional Properties:
+	- ti,strobe-sel: strobe select delay for HS400 speed mode. Default value: 0x0.
 
 Example:
 
-- 
2.19.2
