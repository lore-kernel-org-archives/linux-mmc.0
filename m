From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Tue, 8 Mar 2011 17:21:58 +0100
Message-ID: <201103081721.58633.arnd@arndb.de>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com> <AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com> <AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49983 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755927Ab1CHQWF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 11:22:05 -0500
In-Reply-To: <AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, tardyp@gmail.com, linux-mmc@vger.kernel.org

On Monday 07 March 2011, Andrei Warkentin wrote:
> 
> I took a look at quirks.c in linux-next. It's a bit sdio-specific... I
> would extend mmc_fixup to contain card type (to know if cis
> vendor/device should be checked) as well as name/manfid/oemid and rev
> id (which is just a combination of hwrev, fwrev and date).

Makes sense.
 
> Vendor_fixup would be the top-level card fixup.
> I would add blk_fixup (so block specific information like desired
> write align size can be kept inside mmc_blk_data instead of polluting
> mmc_card).
> 
> ...and to support part reliability workarounds for Toshiba cards, will
> add a blk_adjust method to be invoked inside blk req handling.
> 
> Arnd, what do you think?

I'm still not comfortable with having the blk_adjust method. I think it
would be much better to encode that behavior in an abstract way in
the block driver and set a flag to enable it in the quirks file.

	Arnd
