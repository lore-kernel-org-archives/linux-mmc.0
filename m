From: <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] dts: Fix misspelling of Synopsys
Date: Mon, 16 Sep 2013 15:57:48 -0500
Message-ID: <1379365068-18539-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

From: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>

s/Synopsis/Synopsys
s/synopsis/synopsys

Signed-off-by: Dinh Nguyen <dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
Cc: Pavel Machek <pavel-ynQEQJNshbs@public.gmane.org>
CC: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
CC: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>
Cc: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Cc: Ian Campbell <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
CC: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
---
 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   10 +++++-----
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   10 +++++-----
 .../{synopsis-dw-mshc.txt => synopsys-dw-mshc.txt} |    8 ++++----
 .../devicetree/bindings/pci/designware-pcie.txt    |    2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{synopsis-dw-mshc.txt => synopsys-dw-mshc.txt} (93%)

diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
index 6d1c098..c67b975 100644
--- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
@@ -1,11 +1,11 @@
-* Samsung Exynos specific extensions to the Synopsis Designware Mobile
+* Samsung Exynos specific extensions to the Synopsys Designware Mobile
   Storage Host Controller
 
-The Synopsis designware mobile storage host controller is used to interface
+The Synopsys designware mobile storage host controller is used to interface
 a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsis dw mshc controller properties described
-by synopsis-dw-mshc.txt and the properties used by the Samsung Exynos specific
-extensions to the Synopsis Designware Mobile Storage Host Controller.
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the Samsung Exynos specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
 
 Required Properties:
 
diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
index 8a3d91d..c559f3f 100644
--- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
@@ -1,11 +1,11 @@
-* Rockchip specific extensions to the Synopsis Designware Mobile
+* Rockchip specific extensions to the Synopsys Designware Mobile
   Storage Host Controller
 
-The Synopsis designware mobile storage host controller is used to interface
+The Synopsys designware mobile storage host controller is used to interface
 a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
-differences between the core Synopsis dw mshc controller properties described
-by synopsis-dw-mshc.txt and the properties used by the Rockchip specific
-extensions to the Synopsis Designware Mobile Storage Host Controller.
+differences between the core Synopsys dw mshc controller properties described
+by synopsys-dw-mshc.txt and the properties used by the Rockchip specific
+extensions to the Synopsys Designware Mobile Storage Host Controller.
 
 Required Properties:
 
diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
similarity index 93%
rename from Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
rename to Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
index cdcebea..066a78b 100644
--- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
@@ -1,14 +1,14 @@
-* Synopsis Designware Mobile Storage Host Controller
+* Synopsys Designware Mobile Storage Host Controller
 
-The Synopsis designware mobile storage host controller is used to interface
+The Synopsys designware mobile storage host controller is used to interface
 a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
 differences between the core mmc properties described by mmc.txt and the
-properties used by the Synopsis Designware Mobile Storage Host Controller.
+properties used by the Synopsys Designware Mobile Storage Host Controller.
 
 Required Properties:
 
 * compatible: should be
-	- snps,dw-mshc: for controllers compliant with synopsis dw-mshc.
+	- snps,dw-mshc: for controllers compliant with synopsys dw-mshc.
 * #address-cells: should be 1.
 * #size-cells: should be 0.
 
diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index eabcb4b..e216af3 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -1,4 +1,4 @@
-* Synopsis Designware PCIe interface
+* Synopsys Designware PCIe interface
 
 Required properties:
 - compatible: should contain "snps,dw-pcie" to identify the
-- 
1.7.9.5


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
