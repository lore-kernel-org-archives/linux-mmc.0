From: Andreas Fenkart <afenkart@gmail.com>
Subject: [PATCH] mmc: pwrseq: dt: example with reset clock and active low pin
Date: Thu, 16 Apr 2015 10:03:14 +0200
Message-ID: <1429171394-16573-1-git-send-email-afenkart@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36746 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbbDPIDf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Apr 2015 04:03:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, devicetree@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>

Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index a462c50..ce0e767 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -21,5 +21,7 @@ Example:
 
 	sdhci0_pwrseq {
 		compatible = "mmc-pwrseq-simple";
-		reset-gpios = <&gpio1 12 0>;
+		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+		clocks = <&clk_32768_ck>;
+		clock-names = "ext_clock";
 	}
-- 
2.1.4

