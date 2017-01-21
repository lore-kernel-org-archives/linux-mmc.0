From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v3 1/2] devicetree: document new marvell-8xxx and pwrseq-sd8787 options
Date: Fri, 20 Jan 2017 21:50:38 -0800
Message-ID: <20170121055039.10924-2-matt@ranostay.consulting>
References: <20170121055039.10924-1-matt@ranostay.consulting>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:35166 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750765AbdAUFul (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 21 Jan 2017 00:50:41 -0500
Received: by mail-pg0-f52.google.com with SMTP id 194so29166013pgd.2
        for <linux-mmc@vger.kernel.org>; Fri, 20 Jan 2017 21:50:41 -0800 (PST)
In-Reply-To: <20170121055039.10924-1-matt@ranostay.consulting>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ulf.hansson@linaro.org, Matt Ranostay <matt@ranostay.consulting>, devicetree@vger.kernel.org

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt          | 14 ++++++++++++++
 .../devicetree/bindings/net/wireless/marvell-8xxx.txt      |  7 ++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
new file mode 100644
index 000000000000..4bb56766982e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
@@ -0,0 +1,14 @@
+* Marvell SD8787 power sequence provider
+
+Required properties:
+- compatible: must be "mmc-pwrseq-sd8787".
+- powerdown-gpio: contains a power down GPIO specifier with active state
+- reset-gpio: contains a reset GPIO specifier with active state
+
+Example:
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-sd8787";
+		powerdown-gpio = <&twl_gpio 0 GPIO_ACTIVE_LOW>;
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

