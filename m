From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 3/4] arm/dts: OMAP4: Add mmc controller nodes and board data
Date: Thu, 23 Feb 2012 17:31:29 +0530
Message-ID: <1329998490-27555-4-git-send-email-rnayak@ti.com>
References: <1329998490-27555-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1329998490-27555-1-git-send-email-rnayak-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add omap mmc related device tree data for OMAP4.
Currenly limited to only omap4-panda and omap4-sdp
boards.

Signed-off-by: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/omap4-panda.dts |   10 ++++++++++
 arch/arm/boot/dts/omap4-sdp.dts   |   16 ++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi      |   31 +++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 29646dc..9fe51b9 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -52,3 +52,13 @@
 &i2c4 {
 	clock-frequency = <400000>;
 };
+
+&mmc1 {
+	vmmc-supply = <&vmmc>;
+	ti,bus-width = <8>;
+};
+
+&mmc5 {
+	ti,non-removable;
+	ti,bus-width = <4>;
+};
diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 01db8b7..2fca7a3 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -70,3 +70,19 @@
 		reg = <0x1e>;
 	};
 };
+
+&mmc1 {
+	vmmc-supply = <&vmmc>;
+	ti,bus-width = <8>;
+};
+
+&mmc2 {
+	vmmc-supply = <&vaux1>;
+	ti,bus-width = <8>;
+	ti,non-removable;
+};
+
+&mmc5 {
+	ti,bus-width = <4>;
+	ti,non-removable;
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 29f4589..9204f60 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -25,6 +25,11 @@
 		serial1 = &uart2;
 		serial2 = &uart3;
 		serial3 = &uart4;
+		mmc1 = &mmc1;
+		mmc2 = &mmc2;
+		mmc3 = &mmc3;
+		mmc4 = &mmc4;
+		mmc5 = &mmc5;
 	};
 
 	cpus {
@@ -155,5 +160,31 @@
 			#size-cells = <0>;
 			ti,hwmods = "i2c4";
 		};
+
+		mmc1: mmc@1 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc1";
+			ti,dual-volt;
+		};
+
+		mmc2: mmc@2 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc2";
+		};
+
+		mmc3: mmc@3 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc3";
+		};
+
+		mmc4: mmc@4 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc4";
+		};
+
+		mmc5: mmc@5 {
+			compatible = "ti,omap4-hsmmc";
+			ti,hwmods = "mmc5";
+		};
 	};
 };
-- 
1.7.1
