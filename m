From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 6/6] mmc: dt: bus-width can be an optional property
Date: Mon, 21 Jan 2013 19:02:29 +0800
Message-ID: <1358766149-9534-7-git-send-email-shawn.guo@linaro.org>
References: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:46545
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751509Ab3AUKeL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Jan 2013 05:34:11 -0500
In-Reply-To: <1358766149-9534-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org

None of mmc drivers implements bus-width as a required device tree
property.  Instead, some drivers like atmel-mci, dw_mmc, sdhci-s3c
implement it as an optional one, and will force bus width to be 1
when the property is absent.  Let's change the common binding to
reflect what the drivers are usually doing.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index a591c67..cef217d 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -6,9 +6,6 @@ Interpreted by the OF core:
 - reg: Registers location and length.
 - interrupts: Interrupts used by the MMC controller.
 
-Required properties:
-- bus-width: Number of data lines, can be <1>, <4>, or <8>
-
 Card detection:
 If no property below is supplied, standard SDHCI card detect is used.
 Only one of the properties in this section should be supplied:
@@ -17,6 +14,8 @@ Only one of the properties in this section should be supplied:
   - non-removable: non-removable slot (like eMMC); assume always present.
 
 Optional properties:
+- bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
+  will be <1> if the property is absent.
 - wp-gpios: Specify GPIOs for write protection, see gpio binding
 - cd-inverted: when present, polarity on the cd gpio line is inverted
 - wp-inverted: when present, polarity on the wp gpio line is inverted
-- 
1.7.9.5


