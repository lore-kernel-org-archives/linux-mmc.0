From: "C. Scott Ananian" <cscott@laptop.org>
Subject: Re: Memory replacement
Date: Sat, 12 Mar 2011 20:01:22 -0500
Message-ID: <AANLkTinkAN9Y8wmwt5kzeozYESB7xJD7GvV3Nu6s5wPG@mail.gmail.com>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com>
	<201103111135.01394.arnd@arndb.de>
	<320717C0-7117-462E-9227-7966EE6941D7@laptop.org>
	<201103122351.07697.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39523 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab1CMBBY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Mar 2011 20:01:24 -0500
Received: by iwn34 with SMTP id 34so3827502iwn.19
        for <linux-mmc@vger.kernel.org>; Sat, 12 Mar 2011 17:01:23 -0800 (PST)
In-Reply-To: <201103122351.07697.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Watlington <wad@laptop.org>, Kevin Gordon <kgordon420@gmail.com>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On Sat, Mar 12, 2011 at 5:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I've had four cards with a Sandisk label that had unusual characteris=
tics
> and manufacturer/OEM IDs that refer to other companies, three Samsung=
 ("SM")
> and one unknown ("BE", possibly lexar). In all cases, the Sandisk sup=
port
> has confirmed from photos that the cards are definitely fake. They al=
so

Please see the blog post I cited in the email immediately prior to
yours, which discusses this situation precisely.  Often the cards are
not actually "fake" -- they may even be produced on the exact same
equipment as the usual cards, but "off the books" during hours when
the factory is officially closed.  This sort of thing is very very
widespread, and fakes can come even via official distribution
channels.  (Discussed in bunnie's post.)

> However, they have apparently managed to make them work well
> for random access by using some erase blocks as SLC (writing only
> the pages that carry the most significant bit in each cell) and
> by doing log structured writes in there, something that apparently
> others have not figured out yet. Also, as I mentioned, they
> consistenly use a relatively large number of open erase blocks.
> I've measured both effects on SD cards and USB sticks.

You've been lucky.

> I believe you can get this level of sophistication only from
> companies that make the nand flash, the controller and the card:
> Sandisk, Samsung and Toshiba.
> Other brands that just get the controllers and the flash chips
> from whoever sells them cheaply (kingston, adata, panasonic,
> transcend, ...) apparently don't get the really good stuff.

You're giving the OEMs too much credit.  As John says, unless you
arrange for a special SKU, even the "first source" companies will give
you whatever they've got cheap that day.

>> How we deal with this is constant testing and getting notification f=
rom
>> the manufacturer that they are changing the internals (unfortunately=
,
>> we aren't willing to pay the premium to have a special SKU).
>
> Do you have test results somewhere publically available? We are curre=
ntly
> discussing adding some tweaks to the linux mmc drivers to detect card=
s
> with certain features, and to do some optimizations in the block laye=
r
> for common ones.

http://wiki.laptop.org/go/NAND_Testing

But the testing wad is talking about is really *on the factory floor*:
 Regular sampling of chips as they come into the factory to ensure
that the chips *you are actually about to put into the XOs* are
consistent.  Relying on manufacturing data reported by the chips is
not reliable.
  --scott

--=20
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=A0 ( http://cscott.net/=
 )
