From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 5/5 RFC] DT: sdhci-iproc: add bcm2835 compatible
Date: Sun, 17 Jan 2016 14:59:04 +0000
Message-ID: <1453042744-16196-6-git-send-email-stefan.wahren@i2se.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:65194 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbcAQPAQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jan 2016 10:00:16 -0500
In-Reply-To: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Stefan Wahren <stefan.wahren@i2se.com>

Since sdhci-iproc can support bcm2835 we need to add the
compatible string to the binding.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 .../devicetree/bindings/mmc/brcm,sdhci-iproc.txt   |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
index 72cc9cc..a9330a4 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
@@ -4,7 +4,10 @@ This file documents differences between the core properties described
 by mmc.txt and the properties that represent the IPROC SDHCI controller.
 
 Required properties:
-- compatible : Should be "brcm,sdhci-iproc-cygnus".
+- compatible : Should be one of the following
+	       "brcm,bcm2835-sdhci"
+	       "brcm,sdhci-iproc-cygnus"
+
 - clocks : The clock feeding the SDHCI controller.
 
 Optional properties:
-- 
1.7.9.5

