From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 02/12] mmc: dt-bindings: Add reg/source_cg/latch-ck for
 Mediatek MMC bindings
Date: Tue, 10 Oct 2017 11:01:10 +0800
Message-ID: <1507604480-23246-3-git-send-email-chaotian.jing@mediatek.com>
References: <1507604480-23246-1-git-send-email-chaotian.jing@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1507604480-23246-1-git-send-email-chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, yong mao <yong.mao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Phong LE <ple-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Change the comptiable for support of multi-platform
Make compatible explicit
Add description for reg
Add description for source_cg
Add description for mediatek,latch-ck
Note that source_cg and mediatek,latch-ck are optional for some projects,
eg, MT2701 do not have source_cg, and MT2712 do not need
mediatek,latch-ck

Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
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
