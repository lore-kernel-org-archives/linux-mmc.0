From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Sat, 12 Feb 2011 18:05:47 +0100
Message-ID: <201102121805.47311.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102091013.56670.arnd@arndb.de> <AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:53501 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1BLRGB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Feb 2011 12:06:01 -0500
In-Reply-To: <AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Friday 11 February 2011 23:33:42 Andrei Warkentin wrote:
> On Wed, Feb 9, 2011 at 3:13 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Yes, this is a Toshiba card. I've sent the patch as a reply to Linus' email.
> 
> cid - 02010053454d3332479070cc51451d00
> csd - d00f00320f5903ffffffffff92404000
> erase_size - 524288
> fwrev - 0x0
> hwrev - 0x0
> manfid - 0x000002
> name - SEM32G
> oemid - 0x0100
> preferred_erase_size - 2097152

Very interesting. So the manfid is the same as on most Kingston cards,
but the oemid is different. Most cards have a two-letter ASCII code
in there, 0x544d ("TM") on Kingston cards, and I always assumed that
this stood for "Toshiba Memory".

What is even stranger is the size value (among other fields) in the CSD,
the card claims a size of exactly 32GB, which I find hard to believe,
given that there are always some bad and reserved blocks.

Are you sure that the card you have is authentic? I've heard a lot about
fake USB sticks advertising a size that is much larger than the actual
flash inside of them.

Also this is the first card that I see advertise an allocation unit
size of 2MB (preferred_erase_size), all other cards seem to advertise
4 MB these days, even if they actually have 2 or 8 MB.

	Arnd
