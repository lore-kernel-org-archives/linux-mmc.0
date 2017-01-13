From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH v3 1/2] devicetree: document new marvell-8xxx and pwrseq-sd8787 options
Date: Thu, 12 Jan 2017 21:29:36 -0800
Message-ID: <20170113052937.12538-2-matt@ranostay.consulting>
References: <20170113052937.12538-1-matt@ranostay.consulting>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170113052937.12538-1-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt          | 14 ++++++++++++++
 .../devicetree/bindings/net/wireless/marvell-8xxx.txt      |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
new file mode 100644
index 000000000000..1b658351629b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
@@ -0,0 +1,14 @@
+* Marvell SD8787 power sequence provider
+
+Required properties:
+- compatible: must be "mmc-pwrseq-sd8787".
+- pwndn-gpio: contains a power down GPIO specifier.
+- reset-gpio: contains a reset GPIO specifier.
+
+Example:
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-sd8787";
+		pwrdn-gpio = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
+		reset-gpio = <&twl_gpio 1 GPIO_ACTIVE_LOW>;
+	}
diff --git a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
index 980b16df74c3..0854451ff91d 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
+++ b/Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt
@@ -1,4 +1,4 @@
-Marvell 8897/8997 (sd8897/sd8997/pcie8997) SDIO/PCIE devices
+Marvell 8787/8897/8997 (sd8787/sd8897/sd8997/pcie8997) SDIO/PCIE devices
 ------
 
 This node provides properties for controlling the Marvell SDIO/PCIE wireless device.
@@ -8,6 +8,7 @@ connects the device to the system.
 Required properties:
 
   - compatible : should be one of the following:
+	* "marvell,sd8787"
 	* "marvell,sd8897"
 	* "marvell,sd8997"
 	* "pci11ab,2b42"
@@ -34,6 +35,9 @@ Optional properties:
 		 so that the wifi chip can wakeup host platform under certain condition.
 		 during system resume, the irq will be disabled to make sure
 		 unnecessary interrupt is not received.
+  - vmmc-supply: a phandle of a regulator, supplying VCC to the card
+  - mmc-pwrseq:  phandle to the MMC power sequence node. See "mmc-pwrseq-*"
+		 for documentation of MMC power sequence bindings.
 
 Example:
 
@@ -46,6 +50,7 @@ so that firmware can wakeup host using this device side pin.
 &mmc3 {
 	status = "okay";
 	vmmc-supply = <&wlan_en_reg>;
+	mmc-pwrseq = <&wifi_pwrseq>;
 	bus-width = <4>;
 	cap-power-off-card;
 	keep-power-in-suspend;
-- 
2.10.2
