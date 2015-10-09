From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH v2 3/5] ARM: mvebu: set SW polling as SDHCI card detection on A388-GP
Date: Fri,  9 Oct 2015 03:03:53 +0200
Message-ID: <1444352635-21965-4-git-send-email-mw@semihalf.com>
References: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36336 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754996AbbJIA4q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Oct 2015 20:56:46 -0400
Received: by lbcao8 with SMTP id ao8so65579229lbc.3
        for <linux-mmc@vger.kernel.org>; Thu, 08 Oct 2015 17:56:44 -0700 (PDT)
In-Reply-To: <1444352635-21965-1-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com

The newest revisions of A388-GP (v1.5 and higher) support only
DAT3-based card detection. Revisions < v1.5 based on GPIO detection
via I2C expander, but this solution is supposed to be deprecated on
new boards. In order to satisfy all type of hardware this commit
changes card detection to use software polling mechanism.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 391dea9..403a86b 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -213,8 +213,8 @@
 			sdhci@d8000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&sdhci_pins>;
-				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
 				no-1-8-v;
+				broken-cd;
 				wp-inverted;
 				bus-width = <8>;
 				status = "okay";
-- 
1.8.3.1

