From: ludovic.desroches@atmel.com
Subject: [PATCH 4/4] arm: at91: dt: sam9g25ek add mci support
Date: Wed, 21 Mar 2012 19:03:14 +0100
Message-ID: <1332352994-20983-5-git-send-email-ludovic.desroches@atmel.com>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:37069 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755705Ab2CUQEM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Mar 2012 12:04:12 -0400
In-Reply-To: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91sam9g25ek.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 7a13d09..960de2b 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,22 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			mmc0: mmc@f0008000 {
+				status = "okay";
+				slot@0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 15 0>;
+				};
+			};
+
+			mmc1: mmc@f000c000 {
+				status = "okay";
+				slot@0 {
+					bus-width = <4>;
+					cd-gpios = <&pioD 14 0>;
+				};
+			};
 		};
 
 		usb0: ohci@00600000 {
-- 
1.7.5.4

