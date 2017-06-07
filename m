From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/3] Documentation: dt-bindings: Document deprecation of
 "vmmc_aux" and using "vqmmc"
Date: Wed, 7 Jun 2017 14:06:12 +0530
Message-ID: <20170607083612.14224-4-kishon@ti.com>
References: <20170607083612.14224-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170607083612.14224-1-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Document deprecation of "vmmc_aux" for io regulator and use of generic
mmc binding "vqmmc" in omap-hsmmc.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 74166a0d460d..0e026c151c1c 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -18,7 +18,7 @@ Required properties:
 Optional properties:
 ti,dual-volt: boolean, supports dual voltage cards
 <supply-name>-supply: phandle to the regulator device tree node
-"supply-name" examples are "vmmc", "vmmc_aux" etc
+"supply-name" examples are "vmmc", "vmmc_aux"(deprecated)/"vqmmc" etc
 ti,non-removable: non-removable slot (like eMMC)
 ti,needs-special-reset: Requires a special softreset sequence
 ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
-- 
2.11.0
