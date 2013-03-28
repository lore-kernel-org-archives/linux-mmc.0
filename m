From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v7 4/5] ARM: davinci: da850: add mmc DT entries
Date: Thu, 28 Mar 2013 18:42:01 +0530
Message-ID: <1364476322-15882-5-git-send-email-prakash.pm@ti.com>
References: <1364476322-15882-3-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1364476322-15882-3-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: hs-ynQEQJNshbs@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, "Manjunathappa,
 Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Add DT entry for MMC. Also add entry for pinmux information.
Tested:
1) Without GPIO card detection and EDMA support as DT support for
   GPIO and EDMA are yet come.
2) By creating/deleting files and mounting/unmounting the partition.

Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/da850-evm.dts |    7 +++++++
 arch/arm/boot/dts/da850.dtsi    |   15 +++++++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index fe2bbe7..bc1f951 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -81,6 +81,13 @@
 				};
 			};
 		};
+		mmc0: mmc@1c40000 {
+			max-frequency = <50000000>;
+			bus-width = <4>;
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+		};
 	};
 	nand_cs3@62000000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 327fb06..ef22fa2 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -70,6 +70,15 @@
 					0x14 0x00111111 0x00ffffff
 				>;
 			};
+			mmc0_pins: pinmux_mmc_pins {
+				pinctrl-single,bits = <
+					/* MMCSD0_DAT[3] MMCSD0_DAT[2]
+					 * MMCSD0_DAT[1] MMCSD0_DAT[0]
+					 * MMCSD0_CMD    MMCSD0_CLK
+					 */
+					0x28 0x00222222  0x00ffffff
+				>;
+			};
 		};
 		serial0: serial@1c42000 {
 			compatible = "ns16550a";
@@ -115,6 +124,12 @@
 			reg = <0x21000 0x1000>;
 			status = "disabled";
 		};
+		mmc0: mmc@1c40000 {
+			compatible = "ti,da830-mmc";
+			reg = <0x40000 0x1000>;
+			interrupts = <16>;
+			status = "disabled";
+		};
 		spi1: spi@1f0e000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.7.4.1
