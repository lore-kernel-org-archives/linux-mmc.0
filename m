From: akpm@linux-foundation.org
Subject: [patch 055/177] dts: add sdhci,auto-cmd12 field for p4080 device tree
Date: Tue, 10 Aug 2010 18:02:00 -0700
Message-ID: <201008110102.o7B120qr027112@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59507 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753282Ab0HKB2j (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Aug 2010 21:28:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, tie-fei.zang@freescale.com, Chang-Ming.Huang@freescale.com, benh@kernel.crashing.org, galak@gate.crashing.org, grant.likely@secretlab.ca, linux-mmc@vger.kernel.org

From: Roy Zang <tie-fei.zang@freescale.com>

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kumar Gala <galak@gate.crashing.org>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    2 ++
 arch/powerpc/boot/dts/p4080ds.dts                |    1 +
 2 files changed, 3 insertions(+)

diff -puN Documentation/powerpc/dts-bindings/fsl/esdhc.txt~dts-add-sdhciauto-cmd12-field-for-p4080-device-tree Documentation/powerpc/dts-bindings/fsl/esdhc.txt
--- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt~dts-add-sdhciauto-cmd12-field-for-p4080-device-tree
+++ a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
@@ -14,6 +14,8 @@ Required properties:
     reports inverted write-protect state;
   - sdhci,1-bit-only : (optional) specifies that a controller can
     only handle 1-bit data transfers.
+  - sdhci,auto-cmd12: (optional) specifies that a controller can
+    only handle auto CMD12.
 
 Example:
 
diff -puN arch/powerpc/boot/dts/p4080ds.dts~dts-add-sdhciauto-cmd12-field-for-p4080-device-tree arch/powerpc/boot/dts/p4080ds.dts
--- a/arch/powerpc/boot/dts/p4080ds.dts~dts-add-sdhciauto-cmd12-field-for-p4080-device-tree
+++ a/arch/powerpc/boot/dts/p4080ds.dts
@@ -280,6 +280,7 @@
 			reg = <0x114000 0x1000>;
 			interrupts = <48 2>;
 			interrupt-parent = <&mpic>;
+			sdhci,auto-cmd12;
 		};
 
 		i2c@118000 {
_
