From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH] Documentation: dt: update ti,am33xx-hsmmc swakeup workaround
Date: Tue,  7 Jul 2015 19:53:10 +0200
Message-ID: <1436291591-31271-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33515 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932198AbbGGRx0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2015 13:53:26 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>

Before 5b83b2234be6733cf the driver was hard coding the wakeup irq to
be active low. The generic pm wakeirq does not override the active
high/low parameter, hence it must be specified correctly in the
device tree.
Mind that SDIO IRQ is active low as defined in the SDIO specification

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
index 76bf087..74166a0 100644
--- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
+++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
@@ -102,7 +102,7 @@ not every application needs SDIO irq, e.g. MMC cards.
 		pinctrl-1 = <&mmc1_idle>;
 		pinctrl-2 = <&mmc1_sleep>;
 		...
-		interrupts-extended = <&intc 64 &gpio2 28 0>;
+		interrupts-extended = <&intc 64 &gpio2 28 GPIO_ACTIVE_LOW>;
 	};
 
 	mmc1_idle : pinmux_cirq_pin {
-- 
2.1.4

