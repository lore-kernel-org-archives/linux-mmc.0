From: Marcin Wojtas <mw@semihalf.com>
Subject: [PATCH 6/8] ARM: mvebu: enable SDHCI card detection using DAT3 pin on A388-GP
Date: Tue,  6 Oct 2015 03:22:40 +0200
Message-ID: <1444094562-31165-7-git-send-email-mw@semihalf.com>
References: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f42.google.com ([209.85.215.42]:33368 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751616AbbJFBQI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Oct 2015 21:16:08 -0400
Received: by lafb9 with SMTP id b9so46820897laf.0
        for <linux-mmc@vger.kernel.org>; Mon, 05 Oct 2015 18:16:06 -0700 (PDT)
In-Reply-To: <1444094562-31165-1-git-send-email-mw@semihalf.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com, andrew@lunn.ch, jason@lakedaemon.net, thomas.petazzoni@free-electrons.com, gregory.clement@free-electrons.com, nadavh@marvell.com, alior@marvell.com, tawfik@marvell.com, mw@semihalf.com, jaz@semihalf.com

The newest revisions of A388-GP (v1.5 and higher) support only
DAT3-based card detection, which is enabled by this commit. Hitherto
revisions, without such modification, will be impacted with a broken
card detection - in order to operate the cards have to be present
during kernel boot.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 391dea9..4855963 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -213,8 +213,9 @@
 			sdhci@d8000 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&sdhci_pins>;
-				cd-gpios = <&expander0 5 GPIO_ACTIVE_LOW>;
 				no-1-8-v;
+				dat3-cd;
+				cd-inverted;
 				wp-inverted;
 				bus-width = <8>;
 				status = "okay";
-- 
1.8.3.1

