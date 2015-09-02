From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/6] ARM: dts: omap243x: use "ti,
 pbias-omap2" compatible string for pbias
Date: Wed, 2 Sep 2015 16:17:30 +0530
Message-ID: <1441190853-7133-4-git-send-email-kishon@ti.com>
References: <1441190853-7133-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1441190853-7133-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, broonie@kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com
Cc: mark.rutland@arm.com, ulf.hansson@linaro.org, linux@arm.linux.org.uk, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, lgirdwood@gmail.com, kishon@ti.com, robh+dt@kernel.org, bcousson@baylibre.com, galak@codeaurora.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Use "ti,pbias-omap2" compatible string which is specifically added
for OMAP2.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap2430.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 2390f38..3961a6f 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -63,7 +63,7 @@
 					};
 
 					pbias_regulator: pbias_regulator {
-						compatible = "ti,pbias-omap";
+						compatible = "ti,pbias-omap2", "ti,pbias-omap";
 						reg = <0x230 0x4>;
 						syscon = <&scm_conf>;
 						pbias_mmc_reg: pbias_mmc_omap2430 {
-- 
1.7.9.5
