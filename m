From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 2/2] Powerpc: Add 3.3v voltage support for T4240QDS
Date: Tue, 23 Jul 2013 10:59:05 +0800
Message-ID: <1374548345-15017-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:53702
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559Ab3GWDug (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2013 23:50:36 -0400
In-Reply-To: <1374548345-15017-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, AFLEMING@freescale.com, r39252@freescale.com, Haijun Zhang <Haijun.Zhang@freescale.com>, Haijun Zhang <haijun.zhang@freescale.com>

Freescale T4240QDS reference board has extra voltage shifters added
to allow 3.3V operation, so add 3.3v voltage support for T4240QDS.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
Signed-off-by: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for this patch set:
	- split from patch [PATCH 1/2] Powerpc: Add
	- voltage ranges support for T4

 arch/powerpc/boot/dts/t4240qds.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/t4240qds.dts b/arch/powerpc/boot/dts/t4240qds.dts
index 0555976..5beccdd 100644
--- a/arch/powerpc/boot/dts/t4240qds.dts
+++ b/arch/powerpc/boot/dts/t4240qds.dts
@@ -148,6 +148,11 @@
 				interrupts = <0x1 0x1 0 0>;
 			};
 		};
+
+		sdhc@114000 {
+			compatible = "fsl,t4240-esdhc", "fsl,esdhc";
+			voltage-ranges = <1800 1800 3300 3300>;
+		};
 	};
 
 	pci0: pcie@ffe240000 {
-- 
1.8.0


