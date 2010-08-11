From: akpm@linux-foundation.org
Subject: [patch 056/177] dts: add ESDHC weird voltage bits workaround
Date: Tue, 10 Aug 2010 18:02:01 -0700
Message-ID: <201008110102.o7B121wF027115@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45917 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab0HKB2g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:28:36 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, tie-fei.zang@freescale.com, Chang-Ming.Huang@freescale.com, benh@kernel.crashing.org, galak@gate.crashing.org, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org

From: Roy Zang <tie-fei.zang@freescale.com>

P4080 ESDHC controller does not support 1.8V and 3.0V voltage.  but the
host controller capabilities register wrongly set the bits.  This patch
adds the workaround to correct the weird voltage setting bits.  Only 3.3V
voltage is supported for P4080 ESDHC controller.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@gate.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/powerpc/boot/dts/p4080ds.dts |    1 +
 1 file changed, 1 insertion(+)

diff -puN arch/powerpc/boot/dts/p4080ds.dts~dts-add-esdhc-weird-voltage-bits-workaround arch/powerpc/boot/dts/p4080ds.dts
--- a/arch/powerpc/boot/dts/p4080ds.dts~dts-add-esdhc-weird-voltage-bits-workaround
+++ a/arch/powerpc/boot/dts/p4080ds.dts
@@ -280,6 +280,7 @@
 			reg = <0x114000 0x1000>;
 			interrupts = <48 2>;
 			interrupt-parent = <&mpic>;
+			voltage-ranges = <3300 3300>;
 			sdhci,auto-cmd12;
 		};
 
_
