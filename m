From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 06/11] ARM: shmobile: r8a7790: Rename mmcif node to mmc
Date: Wed, 16 Jul 2014 00:45:16 +0200
Message-ID: <1405464321-4723-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:54062 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757093AbaGOWpZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jul 2014 18:45:25 -0400
In-Reply-To: <1405464321-4723-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian.molton@codethink.co.uk>, devicetree@vger.kernel.org

Node names should describe the function of the device, not its IP core
name.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 0f15f7c..4fae298 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -356,7 +356,7 @@
 		status = "disabled";
 	};
 
-	mmcif0: mmcif@ee200000 {
+	mmcif0: mmc@ee200000 {
 		compatible = "renesas,mmcif-r8a7790", "renesas,sh-mmcif";
 		reg = <0 0xee200000 0 0x80>;
 		interrupts = <0 169 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.5

