From: Chaotian Jing <chaotian.jing@mediatek.com>
Subject: [PATCH v2 03/13] mmc: dt-bindings: make compatible explicit
Date: Mon, 9 Oct 2017 19:35:16 +0800
Message-ID: <1507548926-9555-4-git-send-email-chaotian.jing@mediatek.com>
References: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1507548926-9555-1-git-send-email-chaotian.jing@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Chaotian Jing <chaotian.jing@mediatek.com>, yong mao <yong.mao@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Heiner Kallweit <hkallweit1@gmail.com>, Phong LE <ple@baylibre.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com
List-Id: linux-mmc@vger.kernel.org

the driver has updated to have an explicit compatible, so update
binding file according to the driver change.

Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index 3e0a97c..2bb585b 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -8,8 +8,8 @@ and the properties used by the msdc driver.
 
 Required properties:
 - compatible: value should be either of the following.
-	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
-	"mediatek,mt8173-mmc","mediatek,mt8135-mmc": for mmc host ip compatible with mt8173
+	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
+	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 - reg: physical base address of the controller and length
-- 
1.8.1.1.dirty
