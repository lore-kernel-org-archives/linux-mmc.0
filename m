From: =?ISO-8859-1?Q?Kevyn=2DAlexandre_Par=E9?=
	<kevyn.alexandre.pare@gmail.com>
Subject: OMAP35x MMC Host Controller compatibility with SDXC?
Date: Tue, 17 Sep 2013 17:02:38 -0400
Message-ID: <CAL1yNcLxUnDCfZJxLVUjSDLtgvuBYEjL-pw_aZ8dA1rVu5o=4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ve0-f170.google.com ([209.85.128.170]:52125 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753316Ab3IQVCj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 17:02:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: x0khasim@ti.com, madhu.cr@ti.com, mjalori@ti.com

Hi,

My question is related to the drivers/mmc/host/omap_hsmmc.c host
controller compatibility with SDXC for the OMAP35x?

Reading the TRM for OMAP35x:
http://www.ti.com/lit/ug/spruf98x/spruf98x.pdf

It's said that:
- Full compliance with SD command/response sets as defined in the SD
Memory Card Specifications, v2.0 including high-capacity SDHC cards up
to 32GB.

- Full compliance with sets as defined in the SD Card Specification,
Part A2, SD Host Controller Standard Specification, v2.00

It doesn't mention the SDXC?
I'm trying to found my way through all the spec of sdcard.org.

I'm still wondering why using SDXC of 64GB is working and doesn't pop
a WARNING message and if it's safe??

My test shows that I'm having some timeout in some cases (v3.4.60):
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req done (CMD52): -110: 00000000 00000000 00000000 00000000
mmc0: starting CMD52 arg 80000c08 flags 00000195

omap_hsmmc omap_hsmmc.0: mmc0: CMD5, argument 0x00000000
omap_hsmmc omap_hsmmc.0: IRQ Status is 18000
omap_hsmmc omap_hsmmc.0: MMC IRQ 0x18000 : ERRI CTO
mmc0: req failed (CMD5): -110, retrying...

mmc1: starting CMD8 arg 000001aa flags 000002f5
omap_hsmmc omap_hsmmc.1: mmc1: CMD8, argument 0x000001aa
mmc0: starting CMD18 arg 00020000 flags 000000b5
omap_hsmmc omap_hsmmc.1: IRQ Status is 18000
omap_hsmmc omap_hsmmc.1: MMC IRQ 0x18000 : ERRI CTO
mmc1: req done (CMD8): -110: 00000000 00000000 00000000 00000000

So CMD 52,5 and 8 gives me timeout...

Looking at the 3.11.1 there is 2 more validation for UHS that are not in 3.4.60:
omap_hsmmc_set_clock  // Enable High-Speed Support
omap_set_bus_width

Is it safe to use SDXC with OMAP35x or not? Should this pop a error message?

Best Regards,

-KA
