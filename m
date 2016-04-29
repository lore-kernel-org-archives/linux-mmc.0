From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH v2 4/4] ARM: dts: rockchip: Add mmc aliases for rk3288 platform
Date: Fri, 29 Apr 2016 10:32:19 -0700
Message-ID: <1461951139-6109-5-git-send-email-dianders@chromium.org>
References: <1461951139-6109-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1461951139-6109-1-git-send-email-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc: jszhang@marvell.com, mark.rutland@arm.com, linux@arm.linux.org.uk, Heiko Stuebner <heiko@sntech.de>, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, devicetree-spec@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, stefan@agner.ch, Douglas Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, computersforpeace@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Now that mmc aliases are officially in bindings, add them to rk3288.
This could be done to lots of platforms, but this is the one I tested
with.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v2:
- rk3288 patch new for v2

 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 31f7e20ef418..4cb15dcd1c1e 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -60,6 +60,10 @@
 		i2c3 = &i2c3;
 		i2c4 = &i2c4;
 		i2c5 = &i2c5;
+		mmc0 = &emmc;
+		mmc1 = &sdmmc;
+		mmc2 = &sdio0;
+		mmc3 = &sdio1;
 		mshc0 = &emmc;
 		mshc1 = &sdmmc;
 		mshc2 = &sdio0;
-- 
2.8.0.rc3.226.g39d4020
