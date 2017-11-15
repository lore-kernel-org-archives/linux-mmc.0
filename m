From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH 4/4] dt-bindings: mmc: renesas_sdhi: Add r8a77995 support
Date: Wed, 15 Nov 2017 16:25:49 +0100
Message-ID: <1510759549-30404-5-git-send-email-ulrich.hecht+renesas@gmail.com>
References: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:42557 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758440AbdKOP0C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Nov 2017 10:26:02 -0500
In-Reply-To: <1510759549-30404-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, horms@verge.net.au, wsa@the-dreams.de, geert@linux-m68k.org
Cc: magnus.damm@gmail.com, linux-mmc@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Adds bindings for the R-Car D3 SoC's SDHI IP.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
index 3c67624..d8685cb 100644
--- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
@@ -26,6 +26,7 @@ Required properties:
 		"renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
 		"renesas,sdhi-r8a7795" - SDHI IP on R8A7795 SoC
 		"renesas,sdhi-r8a7796" - SDHI IP on R8A7796 SoC
+		"renesas,sdhi-r8a77995" - SDHI IP on R8A77995 SoC
 		"renesas,sdhi-shmobile" - a generic sh-mobile SDHI controller
 		"renesas,rcar-gen1-sdhi" - a generic R-Car Gen1 SDHI controller
 		"renesas,rcar-gen2-sdhi" - a generic R-Car Gen2 or RZ/G1
-- 
2.7.4

