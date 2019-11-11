From: Markus Reichl <m.reichl@fivetechno.de>
Subject: arm64: dts: rockchip: Disable HS400 for mmc on rk3399-roc-pc
Date: Mon, 11 Nov 2019 10:51:04 +0100
Message-ID: <367bf78a-f079-f0b4-68fe-52c86823c174@fivetechno.de>
References: <20190301153348.29870-1-christoph.muellner@theobroma-systems.com>
 <20190301153348.29870-2-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301153348.29870-2-christoph.muellner@theobroma-systems.com>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Muellner <christoph.muellner@theobroma-systems.com>, robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com
Cc: devicetree@vger.kernel.org, Jeffy Chen <jeffy.chen@rock-chips.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Brian Norris <briannorris@chromium.org>, Douglas Anderson <dianders@chromium.org>, Vicente Bergas <vicencb@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-rockchip@lists.infradead.org, Tony Xie <tony.xie@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Randy Li <ayaka@soulik.info>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel@lists.infradead.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Working with rootfs on two 128GB mmcs on rk3399-roc-pc.

One (mmc name 128G72, one screw hole) works fine in HS400 mode.
Other (mmc name DJNB4R, firefly on pcb, two screw holes) gets lots of
mmc1: "running CQE recovery", even hangs with damaged fs,
when running under heavy load, e.g. compiling kernel.
Both run fine with HS200.

Disabling CQ with patch mmc: core: Add MMC Command Queue Support kernel parameter [0] did not help.
[0] https://gitlab.com/ayufan-repos/rock64/linux-mainline-kernel/commit/54e264154b87dfe32a8359b2726e2d5611adbaf3

Therefore I propose to disable HS400 mode on roc-pc for now.

Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>
---
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
index 29a50a083c42..33df95e384b4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc.dtsi
@@ -660,8 +660,6 @@
 
 &sdhci {
 	bus-width = <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
 	non-removable;
 	status = "okay";
 };
-- 
2.20.1
