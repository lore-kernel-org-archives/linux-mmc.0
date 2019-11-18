From: Markus Reichl <m.reichl@fivetechno.de>
Subject: [PATCH v3 1/2] arm64: dts: rockchip: Use correct pin for lcd-reset
 pinctrl on rk3399-roc-pc
Date: Mon, 18 Nov 2019 12:23:18 +0100
Message-ID: <cd5fd3a8-b0eb-9dc1-c473-9355762cdaa5@fivetechno.de>
References: <25466090-3b24-2695-10fb-88c59be3f149@fivetechno.de>
 <1918981.kTmXGv9Lqf@phil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1918981.kTmXGv9Lqf@phil>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jagan Teki <jagan@amarulasolutions.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Fix typo according to schematics.
The original pin is needed to enable vcc3v0_sd in second patch of this series.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
v3: Split patch in two, generate this part 1/2
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 44617c8e0773..6d485712f47c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -576,7 +576,7 @@
 
 	lcd-panel {
 		lcd_panel_reset: lcd-panel-reset {
-			rockchip,pins = <4 RK_PD6 RK_FUNC_GPIO &pcfg_pull_up>;
+			rockchip,pins = <4 RK_PD5 RK_FUNC_GPIO &pcfg_pull_up>;
 		};
 	};
 
-- 
2.20.1
