From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 2/4] mmc: dt-bindings: update Mediatek MMC bindings
Date: Tue, 13 Oct 2015 17:37:56 +0800
Message-ID: <1444729078-26585-3-git-send-email-chaotian.jing@mediatek.com>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Howard Chen <ibanezchen@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Kumar Gala <galak@codeaurora.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>
List-Id: linux-mmc@vger.kernel.org

Add 400Mhz clock source for HS400 mode

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index a1adfa4..745bee2 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -17,6 +17,11 @@ Required properties:
 - vmmc-supply: power to the Core
 - vqmmc-supply: power to the IO
 
+Optional properties:
+- clocks: 400mhz clock source for HS400
+- clock-names: "400mhz"
+- hs400-ds-delay: HS400 DS delay setting
+
 Examples:
 mmc0: mmc@11230000 {
 	compatible = "mediatek,mt8173-mmc", "mediatek,mt8135-mmc";
@@ -24,9 +29,12 @@ mmc0: mmc@11230000 {
 	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
 	vmmc-supply = <&mt6397_vemc_3v3_reg>;
 	vqmmc-supply = <&mt6397_vio18_reg>;
-	clocks = <&pericfg CLK_PERI_MSDC30_0>, <&topckgen CLK_TOP_MSDC50_0_H_SEL>;
-	clock-names = "source", "hclk";
+	clocks = <&pericfg CLK_PERI_MSDC30_0>,
+	         <&topckgen CLK_TOP_MSDC50_0_H_SEL>,
+		 <&topckgen CLK_TOP_MSDCPLL_D2> ;
+	clock-names = "source", "hclk", "400mhz";
 	pinctrl-names = "default", "state_uhs";
 	pinctrl-0 = <&mmc0_pins_default>;
 	pinctrl-1 = <&mmc0_pins_uhs>;
+	hs400-ds-delay = <0x14015>;
 };
-- 
1.8.1.1.dirty
