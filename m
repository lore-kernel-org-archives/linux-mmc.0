From: akpm@linux-foundation.org
Subject: [patch 084/232] powerpc/85xx: add eSDHC support for MPC8536DS boards
Date: Tue, 22 Sep 2009 16:45:17 -0700
Message-ID: <200909222345.n8MNjHtJ013999@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37866 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751517AbZIWASK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:18:10 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, avorontsov@ru.mvista.com, ben@fluff.org, benh@kernel.crashing.org, david.vrabel@csr.com, galak@kernel.crashing.org, linux-mmc@vger.kernel.org, pierre@ossman.eu, s.hauer@pengutronix.de

From: Anton Vorontsov <avorontsov@ru.mvista.com>

This patch simply adds sdhci node to the device tree.

We specify clock-frequency manually, so that eSDHC will work without
upgrading U-Boot.  Though, that'll only work for default setup (1500 MHz)
on new board revisions.  For non-default setups, it's recommended to
upgrade U-Boot, since it will fixup clock-frequency automatically.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Pierre Ossman <pierre@ossman.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: Ben Dooks <ben@fluff.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/boot/dts/mpc8536ds.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff -puN arch/powerpc/boot/dts/mpc8536ds.dts~powerpc-85xx-add-esdhc-support-for-mpc8536ds-boards arch/powerpc/boot/dts/mpc8536ds.dts
--- a/arch/powerpc/boot/dts/mpc8536ds.dts~powerpc-85xx-add-esdhc-support-for-mpc8536ds-boards
+++ a/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -258,6 +258,14 @@
 			clock-frequency = <250000000>;
 		};
 
+		sdhci@2e000 {
+			compatible = "fsl,mpc8536-esdhc", "fsl,esdhc";
+			reg = <0x2e000 0x1000>;
+			interrupts = <72 0x2>;
+			interrupt-parent = <&mpic>;
+			clock-frequency = <250000000>;
+		};
+
 		serial0: serial@4500 {
 			cell-index = <0>;
 			device_type = "serial";
_
