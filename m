From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 13/15] ARM: dts: sun9i: Include SDC2_RST pin in
 mmc2_8bit_pins
Date: Thu, 21 Jan 2016 13:26:40 +0800
Message-ID: <1453354002-28366-14-git-send-email-wens@csie.org>
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

mmc2_8bit_pins is used with eMMC chips, which also have a reset pin.
The MMC controller also has a reset output that is supported.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f4f61b02be1a..f68b3242b33a 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -704,7 +704,8 @@
 			mmc2_8bit_pins: mmc2_8bit {
 				allwinner,pins = "PC6", "PC7", "PC8", "PC9",
 						 "PC10", "PC11", "PC12",
-						 "PC13", "PC14", "PC15";
+						 "PC13", "PC14", "PC15",
+						 "PC16";
 				allwinner,function = "mmc2";
 				allwinner,drive = <SUN4I_PINCTRL_30_MA>;
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
-- 
2.7.0.rc3
