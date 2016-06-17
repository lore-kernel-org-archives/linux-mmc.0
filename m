From: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc for generic usb power sequence driver
Date: Fri, 17 Jun 2016 18:09:21 +0800
Message-ID: <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1466158165-9380-1-git-send-email-peter.chen-3arQi8VN3Tc@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add binding doc for generic usb power sequence driver, and update
generic usb device binding-doc accordingly.

Signed-off-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
---
 .../bindings/power/pwrseq/pwrseq-usb-generic.txt   | 31 ++++++++++++++++++++++
 .../devicetree/bindings/usb/usb-device.txt         |  2 ++
 2 files changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt

diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
new file mode 100644
index 0000000..8ad98382
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
@@ -0,0 +1,31 @@
+The power sequence for generic USB Devices
+
+Some hard-wired USB devices need to do power sequence to let the
+device work normally, the typical power sequence like: enable USB
+PHY clock, toggle reset pin, etc. But current Linux USB driver
+lacks of such code to do it, it may cause some hard-wired USB devices
+works abnormal or can't be recognized by controller at all. The
+power sequence will be done before this device can be found at USB
+bus.
+
+Required properties:
+- compatible : contains "usb-pwrseq-generic".
+
+Optional properties:
+- clocks: the input clock for USB device.
+- clock-frequency: the frequency for device's clock.
+- reset-gpios: Should specify the GPIO for reset.
+- reset-duration-us: the duration in microsecond for assert reset signal.
+- enable-gpios: Should specify the GPIO for enable.
+- power-supply: The regulator of the power
+
+Example:
+
+usb2415_pwrseq: usb2415_pwrseq {
+	compatible = "usb-pwrseq-generic";
+	clocks = <&clks IMX6QDL_CLK_CKO>;
+	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+	reset-duration-us = <3000>;
+	enable-gpios = <&gpio7 11 GPIO_ACTIVE_LOW>;
+	power-supply = <&reg_usb_power>;
+};
diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
index 1c35e7b..4c8a25e 100644
--- a/Documentation/devicetree/bindings/usb/usb-device.txt
+++ b/Documentation/devicetree/bindings/usb/usb-device.txt
@@ -12,6 +12,7 @@ Required properties:
   for usbVID,PID.
 - reg: the port number which this device is connecting to, the range
   is 1-31.
+- usb-pwrseq: phandle for power sequence.
 
 Example:
 
@@ -24,5 +25,6 @@ Example:
 	hub: genesys@1 {
 		compatible = "usb5e3,608";
 		reg = <1>;
+		usb-pwrseq = <&usb_genesys_pwrseq>;
 	};
 }
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
