From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH v2 02/11] mmc: deprecate redundant cd-inverted and wp-inverted DT properties
Date: Wed, 23 Jan 2013 16:32:29 +0100
Message-ID: <1358955158-1510-3-git-send-email-g.liakhovetski@gmx.de>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62887 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755945Ab3AWPkS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Jan 2013 10:40:18 -0500
In-Reply-To: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

GPIO DT bindings have a standard way to specify GPIO polarity - the
OF_GPIO_ACTIVE_LOW flag. Use that instead of custom cd-inverted and
wp-inverted properties.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 34f28ed..e180892 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -19,11 +19,19 @@ Only one of the properties in this section should be supplied:
 Optional properties:
 - wp-gpios: Specify GPIOs for write protection, see gpio binding
 - cd-inverted: when present, polarity on the cd gpio line is inverted
+  (deprecated)
 - wp-inverted: when present, polarity on the wp gpio line is inverted
+  (deprecated)
 - max-frequency: maximum operating clock frequency
 - no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
   this system, even if the controller claims it is.
 
+cd-inverted and wp-inverted properties are deprecated ans shouldn't be used,
+instead pleaseuse the OF_GPIO_ACTIVE_LOW flag in respective GPIO bindings. Note,
+that the default (as defined by the SDHCI standard) CD and WP polarity is
+active-low, so, OF_GPIO_ACTIVE_LOW should normally be set, and only be left
+clear, if the polarity is inverted.
+
 Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
-- 
1.7.2.5

