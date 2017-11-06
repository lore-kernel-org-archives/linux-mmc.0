From: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v2 1/2] dt-bindings: sdhci-fujitsu: document cmd-dat-delay property
Date: Mon,  6 Nov 2017 11:40:49 +0000
Message-ID: <20171106114050.15169-1-ard.biesheuvel@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Document a new boolean property of the sdhci-fujitsu binding that
indicates whether the CMD_DAT_DELAY bit needs to be set in the
F_SDH30_ESD_CONTROL register.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
index de2c53cff4f1..3ee9263adf73 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
+++ b/Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
@@ -15,6 +15,8 @@ Required properties:
 Optional properties:
 - vqmmc-supply: phandle to the regulator device tree node, mentioned
   as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+- fujitsu,cmd-dat-delay-select: boolean property indicating that this host
+  requires the CMD_DAT_DELAY control to be enabled.
 
 Example:
 
-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
