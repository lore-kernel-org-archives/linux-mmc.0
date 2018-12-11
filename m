From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2 1/2] dt-bindings: sdhci-omap: Add note for cpu_thermal
Date: Tue, 11 Dec 2018 19:52:52 +0530
Message-ID: <20181211142253.23747-2-faiz_abbas@ti.com>
References: <20181211142253.23747-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211142253.23747-1-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, kishon@ti.com, faiz_abbas@ti.com, j-keerthy@ti.com
List-Id: linux-mmc@vger.kernel.org

The driver fetches a thermal zone using the string "cpu_thermal" for
tuning operation. Add a note for the same.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-omap.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
index 393848c2138e..72c4dec7e1db 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
@@ -2,6 +2,8 @@
 
 Refer to mmc.txt for standard MMC bindings.
 
+For UHS devices which require tuning, the device tree should have a "cpu_thermal" node which maps to the appropriate thermal zone. This is used to get the temperature of the zone during tuning.
+
 Required properties:
 - compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
 	      Should be "ti,k2g-sdhci" for K2G
-- 
2.19.2
