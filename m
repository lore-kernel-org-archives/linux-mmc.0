From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 10/14] ARM: dts: dra71-evm: Correct evm_sd regulator max
 voltage
Date: Thu, 14 Dec 2017 19:10:50 +0530
Message-ID: <20171214134054.7749-11-kishon@ti.com>
References: <20171214134054.7749-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171214134054.7749-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Santosh Shilimkar <ssantosh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, kishon@ti.com, nsekhar@ti.com, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

Correct vpo_sd_1v8_3v3 regulator max voltage to 3.3V

Fixes: 9868bc585ae2 ("ARM: dts: Add support for dra718-evm")
Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra71-evm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra71-evm.dts b/arch/arm/boot/dts/dra71-evm.dts
index 41c9132eb550..64363f75c01a 100644
--- a/arch/arm/boot/dts/dra71-evm.dts
+++ b/arch/arm/boot/dts/dra71-evm.dts
@@ -24,13 +24,13 @@
 
 		regulator-name = "vddshv8";
 		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <3000000>;
+		regulator-max-microvolt = <3300000>;
 		regulator-boot-on;
 		vin-supply = <&evm_5v0>;
 
 		gpios = <&gpio7 11 GPIO_ACTIVE_HIGH>;
 		states = <1800000 0x0
-			  3000000 0x1>;
+			  3300000 0x1>;
 	};
 
 	evm_1v8_sw: fixedregulator-evm_1v8 {
-- 
2.11.0
