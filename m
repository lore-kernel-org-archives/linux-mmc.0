From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Fri, 18 Feb 2011 14:44:24 +0100
Message-ID: <201102181444.24476.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com> <AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:63810 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab1BRNo0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 08:44:26 -0500
In-Reply-To: <AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrei Warkentin <andreiw@motorola.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Friday 18 February 2011, Andrei Warkentin wrote:
> On Fri, Feb 11, 2011 at 4:33 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> > Arnd,
> >
> > Yes, this is a Toshiba card. I've sent the patch as a reply to Linus' email.
> >
> > cid - 02010053454d3332479070cc51451d00
> > csd - d00f00320f5903ffffffffff92404000
> > erase_size - 524288
> > fwrev - 0x0
> > hwrev - 0x0
> > manfid - 0x000002
> > name - SEM32G
> > oemid - 0x0100
> > preferred_erase_size - 2097152
> >
> 
> Ok. Big mistake. Sorry about that. This card is Sandisk card. I got
> confused over all the manfids changing.
> 
> Here is the Toshiba card:
> 
> cid - 1101004d4d4333324703101a17746d00
> csd - 900e00320f5903ffffffffe796400000
> erase_size - 524288
> fwrev - 0x0
> hwrev - 0x0
> manfid - 0x000011
> name - MMC32G
> oemid - 0x0100
> preferred_erase_size - 4194304
> 
> I'll get you the flashbench timings for both.

I'm curious. Neither the manfid nor the oemid fields of either card
match what I have seen on SD cards, I would expect them to be

Sandisk: manfid 0x000003, oemid 0x5344
Toshiba: manfid 0x000002, oemid 0x544d

I have not actually seen any Toshiba SD cards, but I assume that they
use the same controllers as Kingston.

Does anyone know if the IDs have any correlation between MMC and SD
controllers?

	Arnd
