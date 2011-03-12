From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Memory replacement
Date: Sat, 12 Mar 2011 23:51:07 +0100
Message-ID: <201103122351.07697.arnd@arndb.de>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com> <201103111135.01394.arnd@arndb.de> <320717C0-7117-462E-9227-7966EE6941D7@laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:52596 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756148Ab1CLWvP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Mar 2011 17:51:15 -0500
In-Reply-To: <320717C0-7117-462E-9227-7966EE6941D7@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Watlington <wad@laptop.org>
Cc: devel@lists.laptop.org, Kevin Gordon <kgordon420@gmail.com>, linux-mmc@vger.kernel.org

On Friday 11 March 2011 18:28:49 John Watlington wrote:
> 
> On Mar 11, 2011, at 5:35 AM, Arnd Bergmann wrote:
> 
> > I've tested around a dozen media from them, and while you are true
> > that they use rather different algorithms and NAND chips inside, all
> > of them can write to at least 5 erase blocks before getting into
> > garbage collection, which is really needed for ext3 file systems.
> > 
> > Contrast this with Kingston cards, which all use the same algorithm
> > and can only write data linearly to one erase block at a time, resulting
> > in one or two orders of magnitude higher internal write amplification.
> > 
> > Most other vendors are somewhere inbetween, and you sometimes get
> > fake cards that don't do what you expect, such a a bunch of Samsung
> > microSDHC cards thaI have I which are labeled Sandisk on the outside.
> 
> Those aren't fakes.   That is what I'm trying to get across.

I've had four cards with a Sandisk label that had unusual characteristics
and manufacturer/OEM IDs that refer to other companies, three Samsung ("SM")
and one unknown ("BE", possibly lexar). In all cases, the Sandisk support
has confirmed from photos that the cards are definitely fake. They also
explained that all authentic cards (possibly fake ones as well, but I have
not seen them) will be labeled "Made in China", not "Made in Korea" or
"Made in Taiwan" as my fake ones, and that the authentic microSD cards have
the serial number on the front side, not on the back.

> > I've also seen some really cheap noname cards outperform similar-spec'd
> > sandisk card, both regarding maximum throughput and the garbage collection
> > algorithms, but you can't rely on that.
> 
> 
> My point is that you can't rely on Sandisk either.
> 
> I've been in discussion with both Sandisk and Adata about these issues,
> as well as constantly testing batches of new SD cards from all major
> vendors.
>
> Unless you pay a lot extra and order at least 100K, you have no
> control over what they give you.   They don't just change NAND chips,
> they change the controller chip and its firmware.  Frequently.
> And they don't update either the SKU number, part marking or the
> identification fields available to software.    The manufacturing batch
> number printed on the outside is the only thing that changes.

I agree that you cannot rely on specific behavior to stay the 
same with any vendor. One thing I noticed for instance is that
many new Sandisk cards are using TLC (three level cell) NAND,
which is inherently slower and cheaper than the regular two-level
MLC used in older cards or those from other vendors.

However, they have apparently managed to make them work well
for random access by using some erase blocks as SLC (writing only
the pages that carry the most significant bit in each cell) and
by doing log structured writes in there, something that apparently
others have not figured out yet. Also, as I mentioned, they
consistenly use a relatively large number of open erase blocks.
I've measured both effects on SD cards and USB sticks.

I believe you can get this level of sophistication only from
companies that make the nand flash, the controller and the card:
Sandisk, Samsung and Toshiba.

Other brands that just get the controllers and the flash chips
from whoever sells them cheaply (kingston, adata, panasonic,
transcend, ...) apparently don't get the really good stuff.
 
> How we deal with this is constant testing and getting notification from
> the manufacturer that they are changing the internals (unfortunately,
> we aren't willing to pay the premium to have a special SKU).

Do you have test results somewhere publically available? We are currently
discussing adding some tweaks to the linux mmc drivers to detect cards
with certain features, and to do some optimizations in the block layer
for common ones.

	Arnd
