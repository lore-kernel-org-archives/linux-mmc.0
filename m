From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 2/3 v2] dts: Add sdhci,auto-cmd12 field for p4080 device tree
Date: Tue, 3 Aug 2010 11:11:11 +0800
Message-ID: <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:18466
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753533Ab0HCDlr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Aug 2010 23:41:47 -0400
In-Reply-To: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 Documentation/powerpc/dts-bindings/fsl/esdhc.txt |    2 ++
 arch/powerpc/boot/dts/p4080ds.dts                |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
index 8a00407..64bcb8b 100644
--- a/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/esdhc.txt
@@ -14,6 +14,8 @@ Required properties:
     reports inverted write-protect state;
   - sdhci,1-bit-only : (optional) specifies that a controller can
     only handle 1-bit data transfers.
+  - sdhci,auto-cmd12: (optional) specifies that a controller can
+    only handle auto CMD12.
 
 Example:
 
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 6b29eab..efa0091 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -280,6 +280,7 @@
 			reg = <0x114000 0x1000>;
 			interrupts = <48 2>;
 			interrupt-parent = <&mpic>;
+			sdhci,auto-cmd12;
 		};
 
 		i2c@118000 {
-- 
1.5.6.5


