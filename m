From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RFC PATCH 5/7] dt-bindings: ti-omap-hsmmc: Document new compatible for sdhci omap
Date: Mon, 7 Aug 2017 21:31:40 +0530
Message-ID: <20170807160142.12134-6-kishon@ti.com>
References: <20170807160142.12134-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807160142.12134-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: kishon@ti.com, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Document the new compatible string "ti,dra7-sdhci" to be used for
MMC controllers in DRA7 and DRA72 SoCs.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 0e026c151c1c..db80fdfd05d7 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -13,6 +13,7 @@ Required properties:
  Should be "ti,omap3-pre-es3-hsmmc" for OMAP3 controllers pre ES3.0
  Should be "ti,omap4-hsmmc", for OMAP4 controllers
  Should be "ti,am33xx-hsmmc", for AM335x controllers
+ Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
 - ti,hwmods: Must be "mmc<n>", n is controller instance starting 1
 
 Optional properties:
-- 
2.11.0
