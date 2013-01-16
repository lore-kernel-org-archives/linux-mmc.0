From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH] mmc: fix DT binding documentation SDHCI left-over
Date: Wed, 16 Jan 2013 17:20:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301161719310.19928@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:64160 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888Ab3APQUo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Jan 2013 11:20:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by axis700.grange (Postfix) with ESMTP id 19D2840B98
	for <linux-mmc@vger.kernel.org>; Wed, 16 Jan 2013 17:20:42 +0100 (CET)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

The file Documentation/devicetree/bindings/mmc/mmc.txt is common for all
MMC host drivers. Use a generic MMC host reference instead of an SDHCI
left-over.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index a591c67..34f28ed 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -10,7 +10,7 @@ Required properties:
 - bus-width: Number of data lines, can be <1>, <4>, or <8>
 
 Card detection:
-If no property below is supplied, standard SDHCI card detect is used.
+If no property below is supplied, host native card detect is used.
 Only one of the properties in this section should be supplied:
   - broken-cd: There is no card detection available; polling must be used.
   - cd-gpios: Specify GPIOs for card detection, see gpio binding
-- 
1.7.2.5

