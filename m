From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v3 4/8] dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
Date: Thu, 17 Oct 2019 11:51:46 +0530
Message-ID: <1571293310-92563-5-git-send-email-manish.narani@xilinx.com>
References: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1571293310-92563-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, jolly.shah@xilinx.com, rajan.vaja@xilinx.com, nava.manne@xilinx.com, mdf@kernel.org, manish.narani@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, git@xilinx.com
List-Id: linux-mmc@vger.kernel.org

Add optional propeties for Arasan SDHCI which are used to set clk delays
for different speed modes in the controller.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index b51e40b2e0c5..e0369dd7fb18 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -46,6 +46,21 @@ Optional Properties:
     properly. Test mode can be used to force the controller to function.
   - xlnx,int-clock-stable-broken: when present, the controller always reports
     that the internal clock is stable even when it is not.
+  - clk-phase-legacy: Input/Output Clock Delay pair in degrees for Legacy Mode.
+  - clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS.
+  - clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD HS.
+  - clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for SDR12.
+  - clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for SDR25.
+  - clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for SDR50.
+  - clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for SDR104.
+  - clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for SD DDR50.
+  - clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for MMC DDR52.
+  - clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for MMC HS200.
+  - clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for MMC HS400.
+
+  Above mentioned are the clock (phase) delays which are to be configured in the
+  controller while switching to particular speed mode. If not specified, driver
+  will configure the default value defined for particular mode in it.
 
 Example:
 	sdhci@e0100000 {
-- 
2.17.1
