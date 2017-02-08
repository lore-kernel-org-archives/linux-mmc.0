From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 4/4] ARM64: dts: meson-gxbb-odroidc2: add hw-reset capability
 flag for emmc port
Date: Wed, 8 Feb 2017 22:49:29 +0100
Message-ID: <2b339eac-d139-563f-5c6d-a990429ff558@gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35252 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdBHWPS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Feb 2017 17:15:18 -0500
Received: by mail-wr0-f195.google.com with SMTP id o16so10084656wra.2
        for <linux-mmc@vger.kernel.org>; Wed, 08 Feb 2017 14:15:17 -0800 (PST)
In-Reply-To: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Add hw-reset capability flag for emmc port.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c59403ad..2b68994a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -219,6 +219,7 @@
 	pinctrl-names = "default";
 
 	bus-width = <8>;
+	cap-mmc-hw-reset;
 	cap-sd-highspeed;
 	max-frequency = <200000000>;
 	non-removable;
-- 
2.11.0


