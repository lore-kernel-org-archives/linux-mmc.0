From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH 01/12] mmc: dt-bindings: update Mediatek MMC bindings
Date: Tue, 12 Sep 2017 17:07:41 +0800
Message-ID: <1505207272-16983-2-git-send-email-chaotian.jing@mediatek.com>
References: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1505207272-16983-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

Change the comptiable for support of multi-platform
Add description for reg
Add description for source_cg
Add description for mediatek,latch-ck

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 4182ea3..405cd06 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -7,10 +7,15 @@ This file documents differences between the core properties in mmc.txt
 and the properties used by the msdc driver.
 
 Required properties:
-- compatible: Should be "mediatek,mt8173-mmc","mediatek,mt8135-mmc"
+- compatible: value should be either of the following.
+	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
+	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
+	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
+	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
+- reg: physical base address of the controller and length
 - interrupts: Should contain MSDC interrupt number
-- clocks: MSDC source clock, HCLK
-- clock-names: "source", "hclk"
+- clocks: MSDC source clock, HCLK, source_cg
+- clock-names: "source", "hclk", "source_cg"
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
@@ -30,6 +35,8 @@ Optional properties:
 - mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
 				       If present,HS400 command responses are sampled on rising edges.
 				       If not present,HS400 command responses are sampled on falling edges.
+- mediatek,latch-ck: Some projects do not support enhance_rx, need set correct latch-ck to avoid data crc
+		     error caused by stop clock(fifo full)
 
 Examples:
 mmc0: mmc@11230000 {
-- 
1.8.1.1.dirty
