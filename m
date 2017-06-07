From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 5/8] ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2
Date: Wed, 7 Jun 2017 15:07:46 +0530
Message-ID: <20170607093749.15656-6-kishon@ti.com>
References: <20170607093749.15656-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170607093749.15656-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, kishon@ti.com, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

On DRA75x EVM, MMC2 vdd/ios are connected to a common supply fixed at 1.8V
not 3.3V

Fixes: 6cf02dbb4b71 ("ARM: dts: dra7-evm: Add mmc2 node for eMMC support")
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 31a9e061ddd0..e5d7e7f5f645 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -25,6 +25,14 @@
 		stdout-path = &uart1;
 	};
 
+	evm_1v8_sw: fixedregulator-evm_1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_1v8";
+		vin-supply = <&smps9_reg>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	evm_3v3_sd: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3_sd";
@@ -451,7 +459,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins_default>;
-	vmmc-supply = <&evm_3v3_sw>;
+	vmmc-supply = <&evm_1v8_sw>;
 	bus-width = <8>;
 };
 
-- 
2.11.0
