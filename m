From: "Tardy, Pierre" <pierre.tardy@intel.com>
Subject: RE: [[RFC] 2/5] MMC: Add block quirks support.
Date: Tue, 8 Mar 2011 10:37:39 +0000
Message-ID: <8250E4885F9967469CAC3FB5CBA2CE699352219A3C@irsmsx501.ger.corp.intel.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
	<AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
	<AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
	<AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
 <AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57667 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751683Ab1CHKiY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 05:38:24 -0500
In-Reply-To: <AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, "tardyp@gmail.com" <tardyp@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


> I took a look at quirks.c in linux-next. It's a bit sdio-specific... I
> would extend mmc_fixup to contain card type (to know if cis
> vendor/device should be checked) as well as name/manfid/oemid and rev
> id (which is just a combination of hwrev, fwrev and date).
Feel free to change mmc_fixup. The quirk.c is made to be extended.

> 
> Vendor_fixup would be the top-level card fixup.
> I would add blk_fixup (so block specific information like desired
> write align size can be kept inside mmc_blk_data instead of polluting
> mmc_card).
> 
> ...and to support part reliability workarounds for Toshiba cards, will
> add a blk_adjust method to be invoked inside blk req handling.
> 
> Arnd, what do you think?
> 
> Pierre, what do you think about my above ideas of extending the
> current quirks.c? Please see the following patches, which were my
> original submissions...
I think your work sounds promising.
Look at pci/quirk.c it's 3k loc, with very various things.
IMHO, we should just list cards, and set quirk flags, and quirk parameters in quirk.c.
And put nice generic card independent quirk code in block.c.

How is it possible to say generically: "avoid writes < 12K that are 8K unaligned and cross an 8K barrier"?

Pierre
---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, 
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

