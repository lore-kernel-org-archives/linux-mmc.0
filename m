From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH v6 7/9] ARM: dts: lager: Enable UHS-I SDR-104
Date: Fri,  2 Sep 2016 13:17:36 +0200
Message-ID: <1472815058-11562-8-git-send-email-horms+renesas@verge.net.au>
References: <1472815058-11562-1-git-send-email-horms+renesas@verge.net.au>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:39239 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753532AbcIBLSA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Sep 2016 07:18:00 -0400
In-Reply-To: <1472815058-11562-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

Add the sd-uhs-sdr104 property to SDHI0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 52b56fcaddf2..5e43763cec65 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -559,6 +559,7 @@
 	vqmmc-supply = <&vccq_sdhi0>;
 	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
 	sd-uhs-sdr50;
+	sd-uhs-sdr104;
 	status = "okay";
 };
 
-- 
2.7.0.rc3.207.g0ac5344

