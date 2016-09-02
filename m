From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v3 1/4] Documentation: mmc: sdhci-of-arasan: Add clk_syscon as an optional one
Date: Fri,  2 Sep 2016 08:54:38 +0800
Message-ID: <1472777681-16656-2-git-send-email-shawn.lin@rock-chips.com>
References: <1472777681-16656-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1472777681-16656-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org, Douglas Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

We introduced soc-ctl-syscon to do several things, for instance, update
baseclk or update clkmul, etc. In odrder to access this physical block,
we need to explicitly enable its clock. Currently we don't control this
clock as we always add a CLK_IGNORE_UNUSED flag for it to indicate that
we will not gate it even if not referenced. This is not a correct way since
it is a clock parenting from clk_ahb which is used by sdhci-of-arasan now.
Without enabling clk_ahb, the flag don't guarantee we could access
soc-ctl-syscon. Moreover, we can't find a reason not to gate clk_syscon
once we remove/power-down emmc controller. So let's add clk_syscon and
enable/disable it explicitly when needed.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
index 3404afa..b04eb02 100644
--- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.txt
@@ -33,6 +33,9 @@ Optional Properties:
   - clock-output-names: If specified, this will be the name of the card clock
     which will be exposed by this device.  Required if #clock-cells is
     specified.
+  - clock-names: From clock bindings: Although we treat clock-names as required
+    property, there is still one, "clk_syscon", should be optional as it depends
+    on whether we need to control soc-ctl-syscon or not.
   - #clock-cells: If specified this should be the value <0>.  With this property
     in place we will export a clock representing the Card Clock.  This clock
     is expected to be consumed by our PHY.  You must also specify
@@ -62,8 +65,8 @@ Example:
 		compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
 		reg = <0x0 0xfe330000 0x0 0x10000>;
 		interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
-		clock-names = "clk_xin", "clk_ahb";
+		clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>, <&cru ACLK_EMMC_GRF>;
+		clock-names = "clk_xin", "clk_ahb", "clk_syscon";
 		arasan,soc-ctl-syscon = <&grf>;
 		assigned-clocks = <&cru SCLK_EMMC>;
 		assigned-clock-rates = <200000000>;
-- 
2.3.7
