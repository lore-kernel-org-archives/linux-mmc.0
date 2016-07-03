From: Hans de Goede <hdegoede@redhat.com>
Subject: sunxi mmc on A10 / A13 does not have a sample clock, cannot do ddr ?
Date: Sun, 3 Jul 2016 17:20:43 +0200
Message-ID: <de974dc5-2192-a87f-d727-a8e9e9f4b079@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60249 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752646AbcGCPUr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 3 Jul 2016 11:20:47 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org

Hi Chen-Yu,

While working on some dts cleanups I tested
the latest sunxi-next kernel code on my A13
Utoo P66 tablet and the emmc no longer works.

The kernel tries to enable DDR52 mode on it,
since it apparently can do that and after that
the kernel can no longer talk to it.

Removing MMC_CAP_1_8V_DDR from sunxi-mmc.c
fixes this.

Part of the problem likely is that it seems
that the mmc clock on sun4i / sun5i do
not have sample / output phase clks.

It does not matter what one writes to
0x1c20088 / 0x1c20090, bits 8-10 and
20-22 are always 0.

I've observed this on both sun4i and sun5i,
and the sun4i / sun5i datasheets
also do not mention the phase bits
for register 0x1c20088 / 0x1c20090.

As such I'm thinking that the best way to fix
this is:

1) In sunxi-mmc.c make the sample clocks
optional; and if not present then do not
set MMC_CAP_1_8V_DDR (and do not try to
set sample clks)

2) Remove the sample clks from the base
sun4i / sun5i dtsi files

Regards,

Hans
