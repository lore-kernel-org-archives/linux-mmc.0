From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v3 7/7] ARM: dts: bcm2837: add &sdhci and &sdhost
Date: Tue, 21 Feb 2017 10:07:06 +0100
Message-ID: <1487668026-7100-8-git-send-email-kraxel@redhat.com>
References: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751786AbdBUJHX (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 21 Feb 2017 04:07:23 -0500
In-Reply-To: <1487668026-7100-1-git-send-email-kraxel@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, linux@armlinux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>, Gerd Hoffmann <kraxel@redhat.com>

For the raspberry pi 3 we'll need both sdhci (handles sdio wifi) and
sdhost (handles sdcard).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Eric Anholt <eric@anholt.net>
---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index c309633..972f14d 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -22,3 +22,20 @@
 &uart1 {
 	status = "okay";
 };
+
+/* SDHCI is used to control the SDIO for wireless */
+&sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio34>;
+	status = "okay";
+	bus-width = <4>;
+	non-removable;
+};
+
+/* SDHOST is used to drive the SD card */
+&sdhost {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdhost_gpio48>;
+	status = "okay";
+	bus-width = <4>;
+};
-- 
1.8.3.1

