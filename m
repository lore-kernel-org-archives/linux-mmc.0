From: Roy Zang <tie-fei.zang@freescale.com>
Subject: [PATCH 2/3] dts: Add sdhci-auto-cmd12 field for p4080 device tree
Date: Wed, 28 Jul 2010 14:04:28 +0800
Message-ID: <1280297068-25752-1-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:26000
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752012Ab0G1GSk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Jul 2010 02:18:40 -0400
Received: from mail141-va3 (localhost.localdomain [127.0.0.1])	by
 mail141-va3-R.bigfish.com (Postfix) with ESMTP id 899DB1BD822D	for
 <linux-mmc@vger.kernel.org>; Wed, 28 Jul 2010 06:18:39 +0000 (UTC)
Received: from VA3EHSMHS005.bigfish.com (unknown [10.7.14.236])	by
 mail141-va3.bigfish.com (Postfix) with ESMTP id 6CDBB71004F	for
 <linux-mmc@vger.kernel.org>; Wed, 28 Jul 2010 06:18:39 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o6S6IbJ2015424	for <linux-mmc@vger.kernel.org>; Tue, 27 Jul 2010 23:18:38
 -0700 (MST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/boot/dts/p4080ds.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 6b29eab..11c8884 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -280,6 +280,7 @@
 			reg = <0x114000 0x1000>;
 			interrupts = <48 2>;
 			interrupt-parent = <&mpic>;
+			fsl,sdhci-auto-cmd12;
 		};
 
 		i2c@118000 {
-- 
1.5.6.5


