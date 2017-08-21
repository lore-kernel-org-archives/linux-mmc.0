From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/5] dt-bindings: ti-omap-hsmmc: Document new compatible for sdhci omap
Date: Mon, 21 Aug 2017 13:11:30 +0530
Message-ID: <20170821074132.4622-4-kishon@ti.com>
References: <20170821074132.4622-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:26635 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdHUHoM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Aug 2017 03:44:12 -0400
In-Reply-To: <20170821074132.4622-1-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, Ravikumar Kattekola <rk@ti.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kishon Vijay Abraham I <kishon@ti.com>

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

