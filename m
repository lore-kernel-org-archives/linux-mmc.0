From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 4/4] arm: dts: rockchip: Enable post_ios_power_on and
 pre-power-on-delay-ms
Date: Wed,  1 Mar 2017 15:53:10 +0100
Message-ID: <20170301145310.22813-5-romain.perier@collabora.com>
References: <20170301145310.22813-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170301145310.22813-1-romain.perier@collabora.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This enables the property post_ios_power_on. With this property, the
driver pwrseq_simple will do its entire power sequence at the end of the
mmc_power_up() function. The property pre-power-on-delay-ms adds a delay
of 1ms between the enablement of the clk and the assertion of the reset
line.

It fixes the power-up sequence for the Wifi chipset AP6335.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/rk3288-rock2-square.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts b/arch/arm/boot/dts/rk3288-rock2-square.dts
index 818c4bf..9bf2991 100644
--- a/arch/arm/boot/dts/rk3288-rock2-square.dts
+++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
@@ -106,6 +106,8 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&wifi_enable>;
 		reset-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
+		pre-power-on-delay-ms = <1>;
+		post-ios-power-on;
 	};
 
 	vcc_usb_host: vcc-host-regulator {
-- 
2.9.3
