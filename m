From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 5/7] mmc: dt-bindings: add Mediatek MMC bindings
Date: Tue, 27 Jan 2015 14:15:30 +0800
Message-ID: <1422339332-27498-6-git-send-email-chaotian.jing@mediatek.com>
References: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422339332-27498-1-git-send-email-chaotian.jing@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, srv_heupstream@mediatek.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, Hongzhou Yang <hongzhou.yang@mediatek.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-mmc@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, Chaotian Jing <chaotian.jing@mediatek.com>, Sascha Hauer <kernel@pengutronix.de>, "Joe.C" <yingjoe.chen@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, bin.zhang@mediatek.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Document the device-tree binding of Mediatek MMC host

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 33 ++++++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/mtk-sd.txt

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
new file mode 100644
index 0000000..7667ec7
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -0,0 +1,33 @@
+* MTK MMC controller
+
+The MTK  MSDC can act as a MMC controller
+to support MMC, SD, and SDIO types of memory cards.
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the msdc driver.
+
+Required properties:
+- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc".
+- interrupts: Should contain MSDC interrupt number
+- core-power-supply: power to the Core
+- clocks: MSDC source clock
+- clock-names: "source"
+- pinctrl-names: should be "default", "state_uhs"
+- pinctrl-0: should contain default/high speed pin ctrl
+- pinctrl-1: should contain uhs mode pin ctrl
+
+Optional properties:
+- io-power-supply: power to the IO(for SD/SDIO)
+
+Examples:
+mmc0: mmc@11230000 {
+	compatible = "mediatek,mt8173-mmc","mediatek,mt8135-mmc";
+	reg = <0 0x11230000 0 0x108>;
+	interrupts = <GIC_SPI 39 IRQ_TYPE_LEVEL_LOW>;
+	core-power-supply = <&mt6397_vemc_3v3_reg>;
+	clocks = <&pericfg PERI_MSDC20_1_CK>;
+	clock-names = "source";
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc0_pins_default>;
+	pinctrl-1 = <&mmc0_pins_uhs>;
+};
-- 
1.8.1.1.dirty
