From: David Summers <beagleboard@davidjohnsummers.uk>
Subject: [PATCH v3 1/3] arm: dts: rk3288-tinker.dtsi: Fix SD card detection
Date: Sat,  9 Mar 2019 15:39:21 +0000
Message-ID: <20190309153923.22806-1-beagleboard@davidjohnsummers.uk>
References: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190217121513.22965-1-beagleboard@davidjohnsummers.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: heiko@sntech.de, robh+dt@kernel.org, frowand.list@gmail.com, ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, David Summers <beagleboard@davidjohnsummers.uk>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

The Problem:

On ASUS Tinker Board S, when booting from the eMMC, and there is card
in the sd slot, there are constant errors.

Also when warm reboot, uboot can not access the sd slot

Cause:

Identified by Robin Murphy @ ARM. The Card Detect on rk3288
devices is pulled up by vccio-sd; so when the regulator powers this
off, card detect gives spurious errors. A second problem, is during
power down, vccio-sd apprears to be powered down. This causes a
problem when warm rebooting from the sd card. This was identified by
Jonas Karlman.

History:

A common fault on these rk3288 board, which impliment the reference
design.

When this arose before:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-August/281153.html

And Ulf and Jaehoon clearly said this was a broken card detect design,
which should be solved via polling

Solution:

Hence broken-cd is set as a property. This cures the errors. The
powering down of vccio-sd during reboot is cured by adding
regulator-boot-on.

This solutions has been fairly widely reviewed and tested.

Signed-off-by: David Summers <beagleboard@davidjohnsummers.uk>
Reviewed by: Robin Murphy <robin.murphy@arm.com>
Reviewed by: Jonas Karlman <jonas@kwiboo.se>
Test by: TheSaint @ ArchLinux Arm
---
 arch/arm/boot/dts/rk3288-tinker.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3288-tinker.dtsi b/arch/arm/boot/dts/rk3288-tinker.dtsi
index aa107ee41b8b..ef653c3209bc 100644
--- a/arch/arm/boot/dts/rk3288-tinker.dtsi
+++ b/arch/arm/boot/dts/rk3288-tinker.dtsi
@@ -254,6 +254,7 @@
 			};
 
 			vccio_sd: LDO_REG5 {
+				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-name = "vccio_sd";
@@ -430,7 +431,7 @@
 	bus-width = <4>;
 	cap-mmc-highspeed;
 	cap-sd-highspeed;
-	card-detect-delay = <200>;
+	broken-cd;
 	disable-wp;			/* wp not hooked up */
 	pinctrl-names = "default";
 	pinctrl-0 = <&sdmmc_clk &sdmmc_cmd &sdmmc_cd &sdmmc_bus4>;
-- 
beagleboard@davidjohnsummers.uk
