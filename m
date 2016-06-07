From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 06/11] Documentation: mmc: sdhci-of-arasan: Add ability to export card clock
Date: Tue,  7 Jun 2016 15:44:39 -0700
Message-ID: <1465339484-969-7-git-send-email-dianders@chromium.org>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465339484-969-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Some SD/eMMC PHYs (like the PHY from Arasan that is designed to work
with arasan,sdhci-5.1) need to know the card clock in order to function
properly.  Let's expose this clock using a standard device tree
mechanism so that the PHY can get access to and query the card clock.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index b67e623ca1ff..074d03e630ec 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -30,6 +30,12 @@ Optional Properties:
   - arasan,soc-ctl-syscon: A phandle to a syscon device (see ../mfd/syscon.txt)
     used to access core corecfg registers.  Offsets of registers in this
     syscon are determined based on the main compatible string for the device.
+  - clock-output-names: If specified, this will be the name of the card clock
+    which will be exposed by this device.  Required if #clock-cells is
+    specified.
+  - #clock-cells: If specified this should be the value <0>.  With this property
+    in place we will export a clock representing the Card Clock.  This clock
+    is expected to be consumed by our PHY.  You must also specify
 
 Example:
 	sdhci@e0100000 {
@@ -61,7 +67,9 @@ Example:
 		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
+		clock-output-names = "emmc_cardclock";
 		phys = <&emmc_phy>;
 		phy-names = "phy_arasan";
+		#clock-cells = <0>;
 		status = "disabled";
 	};
-- 
2.8.0.rc3.226.g39d4020
