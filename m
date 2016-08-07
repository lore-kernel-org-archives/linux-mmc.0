From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 2/2] dt: bindings: Add binding for ESP8089 wifi chips
Date: Sun,  7 Aug 2016 20:57:49 +0200
Message-ID: <1470596269-20572-2-git-send-email-hdegoede@redhat.com>
References: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470596269-20572-1-git-send-email-hdegoede@redhat.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.xyz>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

The ESP8089 chips can mostly be enumerated via their sdio interface,
but they are clocked by an external crystal which may differ from one
board to the other.

This commit adds a binding for the sdio child node for these chips,
allowing to specify the external crystal type (for now, this binding
could be be extended with e.g. OOB irq support later).

The Android driver for this chip uses a text file with key,value pairs
which gets loaded as firmware to pass this info to the firmware.
The "esp,crystal_26M_en" name is chosen to match the crystal_26M_en
key-name in that text file.

Note that at this point there only is an out of tree driver for this
hardware, there is no clear timeline / path for merging this. Still
I believe it would be good to specify the binding for this in tree
now, so that any future migration to an in tree driver will not cause
compatiblity issues.

Cc: Icenowy Zheng <icenowy@aosc.xyz>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../bindings/net/wireless/esp,esp8089.txt          | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/esp,esp8089.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/esp,esp8089.txt b/Documentation/devicetree/bindings/net/wireless/esp,esp8089.txt
new file mode 100644
index 0000000..898a149
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/esp,esp8089.txt
@@ -0,0 +1,31 @@
+Espressif ESP8089 wireless SDIO devices
+
+This node provides properties for controlling the ESP8089 wireless device.
+The node is expected to be specified as a child node to the SDIO controller
+that connects the device to the system.
+
+Required properties:
+
+ - compatible : Should be "esp,esp8089".
+
+Optional properties:
+ - esp,crystal_26M_en: Integer value for the crystal_26M_en firmware parameter
+
+Example:
+
+&mmc1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	vmmc-supply = <&reg_dldo1>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	esp8089: sdio_wifi@1 {
+		compatible = "esp,esp8089";
+		reg = <1>;
+		esp,crystal_26M_en = <2>;
+	};
+};
-- 
2.7.4
