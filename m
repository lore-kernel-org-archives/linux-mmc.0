From: Chris Ball <cjb@laptop.org>
Subject: [PATCH] mmc: dt: Add reg/interrupts to mmc.txt for clarity.
Date: Mon, 11 Jun 2012 22:10:31 -0400
Message-ID: <877gvd5lgo.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:51939 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751856Ab2FLCKl (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 11 Jun 2012 22:10:41 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Even though these aren't parsed by the MMC driver, make clear that
they're required by the OF core.  (Also, a few typo fixes.)

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 6e70dcd..8a6811f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -2,13 +2,17 @@ These properties are common to multiple MMC host controllers. Any host
 that requires the respective functionality should implement them using
 these definitions.
 
+Interpreted by the OF core:
+- reg: Registers location and length.
+- interrupts: Interrupts used by the MMC controller.
+
 Required properties:
 - bus-width: Number of data lines, can be <1>, <4>, or <8>
 
 Optional properties:
-- cd-gpios : Specify GPIOs for card detection, see gpio binding
-- wp-gpios : Specify GPIOs for write protection, see gpio binding
-- cd-inverted: when present, polarity on the wp gpio line is inverted
+- cd-gpios: Specify GPIOs for card detection, see gpio binding
+- wp-gpios: Specify GPIOs for write protection, see gpio binding
+- cd-inverted: when present, polarity on the cd gpio line is inverted
 - wp-inverted: when present, polarity on the wp gpio line is inverted
 - non-removable: non-removable slot (like eMMC)
 - max-frequency: maximum operating clock frequency
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
