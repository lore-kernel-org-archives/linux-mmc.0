From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH v4 2/2] ARM: dts: Enable emmc and sdmmc on the rk3288-evb boards
Date: Tue, 12 Aug 2014 16:21:14 -0700
Message-ID: <1407885674-16469-3-git-send-email-dianders@chromium.org>
References: <1407885674-16469-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1407885674-16469-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Addy Ke <addy.ke@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>, Sonny Rao <sonnyrao@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Doug Anderson <dianders@chromium.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

This enables basic SD and eMMC support.  Things are not yet running at
the fastest speed and we don't have the regulators specified, but we
can at least use the eMMC and SD cards now.

A note:
* Though MMC DDR50 mode is partially supported in the dw_mmc
  rk3288-specific code in Addy's patch, Addy's patch doesn't add
  tuning support.  That means DDR50 mode is not reliable.  From the
  3288 TRM: "Tuning is required for other speed modes-such as
  DDR50-even though the output delay from the card is less than one
  cycle."  Thus, we don't enable MMC DDR50 mode in this patch.

Signed-off-by: Doug Anderson <dianders@chromium.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
Changes in v4:
- Squashed patches #2 and #3 since Jaehoon's patch landed.

Changes in v3:
- Removed DDR50 mode since it needs tuning, which isn't there yet.

Changes in v2:
- Squashed in the DDR50 mode since Addy spun his patch.
- New patchwork link for Addy's patch
- Refer to the new title of Jaehoon's patch

 arch/arm/boot/dts/rk3288-evb.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index 4f57209..ebce49a 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -49,6 +49,30 @@
 	};
 };
 
+&emmc {
+	broken-cd;
+	bus-width = <8>;
+	cap-mmc-highspeed;
+	disable-wp;
+	non-removable;
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_clk &emmc_cmd &emmc_pwr &emmc_bus8>;
+	status = "okay";
+};
+
+&sdmmc {
+	bus-width = <4>;
+	cap-mmc-highspeed;
+	cap-sd-highspeed;
+	card-detect-delay = <200>;
+	disable-wp;			/* wp not hooked up */
+	num-slots = <1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
+	status = "okay";
+};
+
 &i2c0 {
 	status = "okay";
 };
-- 
2.1.0.rc2.206.gedb03e5
