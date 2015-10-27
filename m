From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: sh_mmcif: Document r8a7793 DT bindings
Date: Tue, 27 Oct 2015 17:56:31 +0100
Message-ID: <1445964991-7825-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from laurent.telenet-ops.be ([195.130.137.89]:38122 "EHLO
	laurent.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752411AbbJ0Q4l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Oct 2015 12:56:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
[geert: Rebased]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
index cae29eb5733d8a52..ff611fa66871dec9 100644
--- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
+++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
@@ -11,6 +11,7 @@ Required properties:
 	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
 	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
 	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
+	- "renesas,mmcif-r8a7793" for the MMCIF found in r8a7793 SoCs
 	- "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
 
 - clocks: reference to the functional clock
-- 
1.9.1

