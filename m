From: Manish Narani <manish.narani@xilinx.com>
Subject: [PATCH v4 4/8] dt-bindings: mmc: arasan: Add optional properties for Arasan SDHCI
Date: Tue, 29 Oct 2019 16:00:38 +0530
Message-ID: <1572345042-101207-4-git-send-email-manish.narani@xilinx.com>
References: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1572345042-101207-1-git-send-email-manish.narani@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, adrian.hunter@intel.com, michal.simek@xilinx.com, jolly.shah@xilinx.com, nava.manne@xilinx.com, rajan.vaja@xilinx.com, manish.narani@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, git@xilinx.com
List-Id: linux-mmc@vger.kernel.org

Add optional properties for Arasan SDHCI which are used to set clk delays
for different speed modes in the controller.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/mmc/arasan,sdhci.txt     | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index b51e40b2e0c5..c0f505b6cab5 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -46,6 +46,22 @@ Optional Properties:
     properly. Test mode can be used to force the controller to function.
   - xlnx,int-clock-stable-broken: when present, the controller always reports
     that the internal clock is stable even when it is not.
+  - arasan-clk-phase-legacy: Input/Output Clock Delay pair in degrees for Legacy Mode.
+  - arasan-clk-phase-mmc-hs: Input/Output Clock Delay pair degrees for MMC HS.
+  - arasan-clk-phase-sd-hs: Input/Output Clock Delay pair in degrees for SD HS.
+  - arasan-clk-phase-uhs-sdr12: Input/Output Clock Delay pair in degrees for SDR12.
+  - arasan-clk-phase-uhs-sdr25: Input/Output Clock Delay pair in degrees for SDR25.
+  - arasan-clk-phase-uhs-sdr50: Input/Output Clock Delay pair in degrees for SDR50.
+  - arasan-clk-phase-uhs-sdr104: Input/Output Clock Delay pair in degrees for SDR104.
+  - arasan-clk-phase-uhs-ddr50: Input/Output Clock Delay pair in degrees for SD DDR50.
+  - arasan-clk-phase-mmc-ddr52: Input/Output Clock Delay pair in degrees for MMC DDR52.
+  - arasan-clk-phase-mmc-hs200: Input/Output Clock Delay pair in degrees for MMC HS200.
+  - arasan-clk-phase-mmc-hs400: Input/Output Clock Delay pair in degrees for MMC HS400.
+
+  Above mentioned are the clock (phase) delays which are to be configured in the
+  controller while switching to particular speed mode. The range of values are
+  0 to 359 degrees. If not specified, driver will configure the default value
+  defined for particular mode in it.
 
 Example:
 	sdhci@e0100000 {
-- 
2.17.1
