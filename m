From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 15/15] ARM: dts: sun9i: cubieboard4: Enable hardware reset
 and HS-DDR for eMMC
Date: Thu, 21 Jan 2016 13:26:42 +0800
Message-ID: <1453354002-28366-16-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

mmc2 has a special pin for eMMC hardware reset, which is controllable
from the controller. Add the "mmc-cap-hw-reset" property to denote that
this controller supports this function, and the pins are actually used.

Also increase the signal drive strength for mmc2 pins, for HS-DDR mode
support.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 382bd9fc5647..eb2ccd0a3bd5 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -111,9 +111,15 @@
 	vmmc-supply = <&reg_vcc3v0>;
 	bus-width = <8>;
 	non-removable;
+	cap-mmc-hw-reset;
 	status = "okay";
 };
 
+&mmc2_8bit_pins {
+	/* Increase drive strength for DDR modes */
+	allwinner,drive = <SUN4I_PINCTRL_40_MA>;
+};
+
 &r_ir {
 	status = "okay";
 };
-- 
2.7.0.rc3
