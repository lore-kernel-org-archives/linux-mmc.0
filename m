From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 4/4] ARM: dts: mmc slot node gone on rk3288 => no more
 address / size cells
Date: Wed,  6 Aug 2014 10:09:44 -0700
Message-ID: <1407344984-14176-5-git-send-email-dianders@chromium.org>
References: <1407344984-14176-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1407344984-14176-1-git-send-email-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Heiko Stuebner <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Addy Ke <addy.ke@rock-chips.com>, linux@arm.linux.org.uk, pawel.moll@arm.com, Arnd Bergmann <arnd@arndb.de>, ijc+devicetree@hellion.org.uk, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Kever Yang <kever.yang@rock-chips.com>, Doug Anderson <dianders@chromium.org>, robh+dt@kernel.org, galak@codeaurora.org, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

We've removed the slot node from all rk3288 device trees, so we no
longer need address-cells or size-cells.

If Jaehoon's (mmc: dw_mmc: Slot quirk "disable-wp" is deprecated)
patch lands before my (ARM: dts: Add emmc and sdmmc to the rk3288
device tree) then this could be squashed into the later patch.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v3: None
Changes in v2:
- Refer to the new title of Jaehoon's patch

 arch/arm/boot/dts/rk3288.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index dc98a5b..8774e83 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -85,8 +85,6 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0c0000 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 	};
 
 	emmc: dwmmc@ff0f0000 {
@@ -96,8 +94,6 @@
 		fifo-depth = <0x100>;
 		interrupts = <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
 		reg = <0xff0f0000 0x4000>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 	};
 
 	i2c1: i2c@ff140000 {
-- 
2.0.0.526.g5318336
