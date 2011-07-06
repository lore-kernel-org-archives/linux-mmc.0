From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH v4] arm: mach-mmp: brownstone.c support multiple sd slots
Date: Wed, 6 Jul 2011 09:08:45 -0700
Message-ID: <6AAC67C8-1C8F-4F15-9CED-5BA83CA21C39@marvell.com>
References: <59C2B513-EC04-4CA2-818B-9901CAF3E554@marvell.com>
 <20110427093328.GU17290@n2100.arm.linux.org.uk>
 <161C3F6C-0986-4364-B458-DBA4D08456FD@marvell.com>
 <1F336A22-BAC3-41E3-8D4E-5DF27874D1EA@marvell.com>
 <20110428095127.GX17290@n2100.arm.linux.org.uk>
 <3BFCE791-3BAD-42ED-BC87-A27F40D6C77C@marvell.com>
 <CAMPhdO-TTRP-k7J-zrG2_rQJsmNDRhTgpqiiX2yqW+Egf8+t2A@mail.gmail.com>
 <CAMj5BkiK17RMY-vEENDqQiDOmfG0Esnp7QDooKWVrhkQL4g6Ow@mail.gmail.com>
 <CAMPhdO-b_dpC2ueexEFujr6p_NRb2JwDc0-UEx3cfOSVcZ-d6w@mail.gmail.com>
 <67F311C7-B489-41E6-BC85-C06DACC7263A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog121.obsmtp.com ([74.125.149.145]:42366 "EHLO
	na3sys009aog121.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750986Ab1GFQJy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 6 Jul 2011 12:09:54 -0400
In-Reply-To: <67F311C7-B489-41E6-BC85-C06DACC7263A@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Zhangfei Gao <zhangfei.gao@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Zhangfei Gao <zgao6@marvell.com>

Eric,

Not sure what to suggest.

If it makes more sense to take V3 which powers on the wifi card but does not do power handling per
new spec take that.  At least wifi card works and then wait for power code.  New code could delete
power code as part of the mod.

If it makes more sense to wait for power code -- take V4.

Philip




V4
==
remove code to enable power for wifi.  Coming in separate patch
(by others) that conforms to new power architecture.

V3
==
Change since V2 -- delete mmc3 since it was committed
to linux next.

enable mmc1 used for wifi (8688) and marked PERMANENT.
Wifi requires enabling of power on the device by
toggling the gpio lines for power and reset.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 arch/arm/mach-mmp/brownstone.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/brownstone.c b/arch/arm/mach-mmp/brownstone.c
index c79162a..7634b2f 100644
--- a/arch/arm/mach-mmp/brownstone.c
+++ b/arch/arm/mach-mmp/brownstone.c
@@ -180,6 +180,11 @@ static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc0 = {
 	.clk_delay_cycles = 0x1f,
 };
 
+static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc1 = {
+	.clk_delay_cycles = 0x1f,
+	.flags		= PXA_FLAG_CARD_PERMANENT,
+};
+
 static struct sdhci_pxa_platdata mmp2_sdh_platdata_mmc2 = {
 	.clk_delay_cycles = 0x1f,
 	.flags = PXA_FLAG_CARD_PERMANENT
@@ -195,8 +200,9 @@ static void __init brownstone_init(void)
 	mmp2_add_uart(1);
 	mmp2_add_uart(3);
 	mmp2_add_twsi(1, NULL, ARRAY_AND_SIZE(brownstone_twsi1_info));
-	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
 	mmp2_add_sdhost(2, &mmp2_sdh_platdata_mmc2); /* eMMC */
+	mmp2_add_sdhost(0, &mmp2_sdh_platdata_mmc0); /* SD/MMC */
+	mmp2_add_sdhost(1, &mmp2_sdh_platdata_mmc1); /* Wifi */
 
 	/* enable 5v regulator */
 	platform_device_register(&brownstone_v_5vp_device);
-- 
1.7.0.4


