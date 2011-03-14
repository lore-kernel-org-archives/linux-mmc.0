From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Memory replacement
Date: Mon, 14 Mar 2011 18:32:30 +0100
Message-ID: <201103141832.30718.arnd@arndb.de>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com> <201103131821.00762.arnd@arndb.de> <4D7D37C2.2030102@laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:57807 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012Ab1CNRcg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 13:32:36 -0400
In-Reply-To: <4D7D37C2.2030102@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Richard A. Smith" <richard@laptop.org>
Cc: "C. Scott Ananian" <cscott@laptop.org>, Kevin Gordon <kgordon420@gmail.com>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On Sunday 13 March 2011, Richard A. Smith wrote:
> On 03/13/2011 01:21 PM, Arnd Bergmann wrote:
> There's a 2nd round of test(s) that runs during the manufacturing and 
> burn-in phases. One is a simple firmware test to see if you can talk the 
> card at all and then one runs at burn in.  It doesn't have a minimum 
> write size criteria but during the run there must not be any bit errors.

ok.

> > It does seem a bit crude, because many cards are not really suitable
> > for this kind of file system when their wear leveling is purely optimized
> > to the accesses defined in the sd card file system specification.
> >
> > If you did this on e.g. a typical Kingston card, it can have a write
> > amplification 100 times higher than normal (FAT32, nilfs2, ...), so
> > it gets painfully slow and wears out very quickly.
> 
> Crude as they are they have been useful tests for us.  Our top criteria 
> is reliability.  We want to ship the machines with a SD card thats going 
> to last for the 5 year design life using the filesystem we ship.  We 
> tried to create an access pattern was the worst possible and the highest 
> stress on the wear leveling system.

I see. Using the 2 KB block size on ext3 as described in the Wiki should
certainly do that, even on old cards that use 4 KB pages. I typically
misalign the partition by a few sectors to get a similar effect,
doubling the amount of internal garbage collection.

I guess the real images use a higher block size, right?

> > I had hoped that someone already correlated the GC algorithms with
> > the requirements of specific file systems to allow a more systematic
> > approach.
> 
> At the time we started doing this testing none of the log structure 
> filesystems were deemed to be mature enough for us to ship. So we didn't 
> bother to try and torture test using them.
> 
> If more precision tests were created that still allowed us to make a 
> reasonable estimate of data write lifetime we would be happy to start 
> using them.

The tool that I'm working is git://git.linaro.org/people/arnd/flashbench.git
It can be used to characterize a card in terms of its erase block size,
number of open erase blocks, FAT optimized sections of the card, and
possible access patterns inside of erase blocks, all by doing raw block
I/O. Using it is currently a more manual process than I'd hope to
make it for giving it to regular users. It also needs to be correlated
to block access patterns from the file system. When you have that, it
should be possible to accurately predict the amount of write amplification,
which directly relates to how long the card ends up living.

What I cannot determine right now is whether the card does static wear
leveling. I have a Panasonic card that is advertized as doing it, but
I haven't been able to pin down when that happens using timing attacks.

Another thing you might be interested in is my other work on a block
remapper that is designed to reduce the garbage collection by writing
data in a log-structured way, similar to how some SSDs work internally.
This will also do static wear leveling, as a way to improve the expected
life by multiple orders of magnitude in some cases.
https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashDeviceMapper
lists some concepts I want to use, but I have done a lot of changes
to the design that are not yet reflected in the Wiki. I need to
talk to more people at the Embedded Linux Conference and Storage/FS summit
in San Francisco to make sure I get that right.

	Arnd
