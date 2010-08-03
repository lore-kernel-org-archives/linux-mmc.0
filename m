From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 3/3 v2] dts: Add ESDHC weird voltage bits workaround
Date: Tue, 3 Aug 2010 11:11:12 +0800
Message-ID: <1280805072-26112-3-git-send-email-tie-fei.zang@freescale.com>
References: <1280805072-26112-1-git-send-email-tie-fei.zang@freescale.com>
 <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe003.messaging.microsoft.com ([213.199.154.141]:26624
	"EHLO DB3EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754049Ab0HCDlr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Aug 2010 23:41:47 -0400
In-Reply-To: <1280805072-26112-2-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

P4080 ESDHC controller does not support 1.8V and 3.0V voltage. but the
host controller capabilities register wrongly set the bits.
This patch adds the workaround to correct the weird voltage setting bits.
Only 3.3V voltage is supported for P4080 ESDHC controller.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p4080ds.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index efa0091..2f0de24 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -280,6 +280,7 @@
 			reg = <0x114000 0x1000>;
 			interrupts = <48 2>;
 			interrupt-parent = <&mpic>;
+			voltage-ranges = <3300 3300>;
 			sdhci,auto-cmd12;
 		};
 
-- 
1.5.6.5


