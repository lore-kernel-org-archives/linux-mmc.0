From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v3 09/15] arm64: dts: rockchip: Add soc-ctl-syscon to sdhci
 for rk3399
Date: Mon, 20 Jun 2016 10:56:48 -0700
Message-ID: <1466445414-11974-10-git-send-email-dianders@chromium.org>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1466445414-11974-1-git-send-email-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, Heiko Stuebner <heiko@sntech.de>
Cc: mark.rutland@arm.com, catalin.marinas@arm.com, shawn.lin@rock-chips.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, groeck@chromium.org, zhengxing@rock-chips.com, briannorris@chromium.org, kishon@ti.com, linux-rockchip@lists.infradead.org, jay.xu@rock-chips.com, wxt@rock-chips.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, xzy.xu@rock-chips.com, linux-mmc@vger.kernel.org, Douglas Anderson <dianders@chromium.org>, galak@codeaurora.org
List-Id: linux-mmc@vger.kernel.org

On rk3399 we'd like to be able to properly set corecfg registers in the
Arasan SDHCI component.  Specify the syscon to enable that.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
Changes in v3:
- Add collected tags

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index a4383f359264..1b57e92e0093 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -220,6 +220,7 @@
 		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
 		reg = <0x0 0xfe330000 0x0 0x10000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
 		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
-- 
2.8.0.rc3.226.g39d4020
