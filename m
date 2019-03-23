From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 08/24] dt-bindings: mmc: mtk-sd: add mtk-sd support for MT8516
Date: Sat, 23 Mar 2019 22:15:56 +0100
Message-ID: <20190323211612.860-9-fparent@baylibre.com>
References: <20190323211612.860-1-fparent@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190323211612.860-1-fparent@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: matthias.bgg@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, ryder.lee@mediatek.com, linux-watchdog@vger.kernel.org, jjian.zhou@mediatek.com, wenzhen.yu@mediatek.com, stephane.leprovost@mediatek.com, sean.wang@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yong.mao@mediatek.com, linux-spi@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org, hsin-hsiung.wang@mediatek.com, linux-serial@vger.kernel.org, Fabien Parent <fparent@baylibre.com>, linux-clk@vger.kernel.org, chaotian.jing@mediatek.com, linux-i2c@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add binding documentation of mtk-sd for MT8516 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.txt b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
index f5bcda3980cc..91a2ec59e497 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.txt
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.txt
@@ -11,6 +11,7 @@ Required properties:
 	"mediatek,mt8135-mmc": for mmc host ip compatible with mt8135
 	"mediatek,mt8173-mmc": for mmc host ip compatible with mt8173
 	"mediatek,mt8183-mmc": for mmc host ip compatible with mt8183
+	"mediatek,mt8516-mmc": for mmc host ip compatible with mt8516
 	"mediatek,mt2701-mmc": for mmc host ip compatible with mt2701
 	"mediatek,mt2712-mmc": for mmc host ip compatible with mt2712
 	"mediatek,mt7622-mmc": for MT7622 SoC
-- 
2.20.1
