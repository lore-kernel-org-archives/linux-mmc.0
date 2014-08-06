From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v3 3/4] ARM: dts: Take the mmc slot node out of rk3288-evb
Date: Wed,  6 Aug 2014 10:09:43 -0700
Message-ID: <1407344984-14176-4-git-send-email-dianders@chromium.org>
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

In Jaehoon's (mmc: dw_mmc: Slot quirk "disable-wp" is deprecated) the
slot node is no longer used.  Remove it.

Note that if Jaehoon's patch lands before my (ARM: dts: Enable emmc
and sdmmc on the rk3288-evb boards) then this could be squashed into
the later.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v3: None
Changes in v2:
- Refer to the new title of Jaehoon's patch

 arch/arm/boot/dts/rk3288-evb.dtsi | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index c2cf72f..ebce49a 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -53,16 +53,12 @@
 	broken-cd;
 	bus-width = <8>;
 	cap-mmc-highspeed;
+	disable-wp;
 	non-removable;
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
 	status = "okay";
-
-	slot@0 {
-		reg = <0>;
-		disable-wp;
-	};
 };
 
 &sdmmc {
@@ -70,15 +66,11 @@
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
 	card-detect-delay = <200>;
+	disable-wp;			/* wp not hooked up */
 	num-slots = <1>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
 	status = "okay";
-
-	slot@0 {
-		reg = <0>;
-		disable-wp;		/* wp not hooked up */
-	};
 };
 
 &i2c0 {
-- 
2.0.0.526.g5318336
