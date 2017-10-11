From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v5 01/12] mmc: dt-bindings: Add reg/source_cg/latch-ck for Mediatek MMC bindings
Date: Wed, 11 Oct 2017 10:41:25 +0800
Message-ID: <1507689696-25928-2-git-send-email-chaotian.jing@mediatek.com>
References: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

Change the comptiable for support of multi-platform
Make compatible explicit
Add description for reg
Add description for source_cg
Add description for mediatek,latch-ck
Note that source_cg and mediatek,latch-ck are optional for some projects,
eg, MT2701 do not have source_cg, and MT2712 do not need
mediatek,latch-ck

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 4182ea3..2bb585b 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -7,10 +7,18 @@ This file documents differences between the core properties in mmc.txt
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
+- clocks: Should contain phandle for the clock feeding the MMC controller
+- clock-names: Should contain the following:
+	"source" - source clock (required)
+	"hclk" - HCLK which used for host (required)
+	"source_cg" - independent source clock gate (required for MT2712)
 - pinctrl-names: should be "default", "state_uhs"
 - pinctrl-0: should contain default/high speed pin ctrl
 - pinctrl-1: should contain uhs mode pin ctrl
@@ -30,6 +38,8 @@ Optional properties:
 - mediatek,hs400-cmd-resp-sel-rising:  HS400 command response sample selection
 				       If present,HS400 command responses are sampled on rising edges.
 				       If not present,HS400 command responses are sampled on falling edges.
+- mediatek,latch-ck: Some SoCs do not support enhance_rx, need set correct latch-ck to avoid data crc
+		     error caused by stop clock(fifo full)
 
 Examples:
 mmc0: mmc@11230000 {
-- 
1.8.1.1.dirty
