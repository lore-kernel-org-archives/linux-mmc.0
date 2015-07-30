From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/7] ARM: dts: dra7-evm: add evm_3v3_sd regulator
Date: Thu, 30 Jul 2015 13:43:35 +0530
Message-ID: <1438244020-4244-3-git-send-email-kishon@ti.com>
References: <1438244020-4244-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438244020-4244-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: mark.rutland@arm.com, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, nsekhar@ti.com, kishon@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

Add a node for evm_3v3_sd using onboard pcf GPIO expander which feeds
on to mmc vdd.

Update mapping for vmmc-supply and vmmc_aux-supply.
evm_3v3_sd supplies to SD card vdd, and ldo1 to sdcard i/o lines.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 096f68b..1e0c88e 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -19,6 +19,15 @@
 		reg = <0x80000000 0x60000000>; /* 1536 MB */
 	};
 
+	evm_3v3_sd: fixedregulator-sd {
+		compatible = "regulator-fixed";
+		regulator-name = "evm_3v3_sd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		enable-active-high;
+		gpio = <&pcf_gpio_21 5 GPIO_ACTIVE_HIGH>;
+	};
+
 	mmc2_3v3: fixedregulator-mmc2 {
 		compatible = "regulator-fixed";
 		regulator-name = "mmc2_3v3";
@@ -462,7 +471,8 @@
 
 &mmc1 {
 	status = "okay";
-	vmmc-supply = <&ldo1_reg>;
+	vmmc-supply = <&evm_3v3_sd>;
+	vmmc_aux-supply = <&ldo1_reg>;
 	bus-width = <4>;
 };
 
-- 
1.7.9.5
