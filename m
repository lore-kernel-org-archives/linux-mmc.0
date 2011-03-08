From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Tue, 8 Mar 2011 15:03:41 +0100
Message-ID: <201103081503.42297.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102111551.15508.arnd@arndb.de> <20110308065911.GC1357@ucw.cz>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64211 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1CHODx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 09:03:53 -0500
In-Reply-To: <20110308065911.GC1357@ucw.cz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-arm-kernel@lists.infradead.org, Andrei Warkentin <andreiw@motorola.com>, linux-fsdevel@vger.kernel.org, linux-mmc@vger.kernel.org

On Tuesday 08 March 2011, Pavel Machek wrote:
> > > 
> > > How big is performance difference?
> > 
> > Several orders of magnitude. It is very easy to get a card that can write
> > 12 MB/s into a case where it writes no more than 30 KB/s, doing only
> > things that happen frequently with ext3.
> 
> Ungood.
> 
> I guess we should create something like loopback device, which knows
> about flash specifics, and does the right coalescing so that card
> stays in the fast mode?

I have listed a few suggestions for areas to work in my article
at https://lwn.net/Articles/428584/. My idea was to use a device mapper
target, as described in https://wiki.linaro.org/WorkingGroups/KernelConsolidation/Projects/FlashDeviceMapper
but a loopback device might work as well.

The other area that I think will help a lot is to make the I/O
scheduler aware of the erase block size and the preferred access
patterns.
 
> ...or, do we need to create new, simple filesystem with layout similar
> to fat32, for use on mmc cards?

It doesn't need to be similar to fat32, but creating a new file system
could fix this, too. Microsoft seems to have built ExFAT around
cheap flash devices, though they don't document what that does exactly.
I think we can do better than that, and I still want to find out
how close nilfs2 and btrfs can actually get to the optimum.

Note that it's not just MMC cards though, you get the exact same
effects on some low-end SSDs (which are basically repackaged CF
cards) and most USB sticks. The best USB sticks I have seen
can hide some effects with a bit of caching, and they have a higher
number of open segments than the cheap ones, but the basic
problems are unchanged.

The requirements for a good low-end flash optimized file system
would be roughly:

1. Do all writes is chunks of 32 or 64 KB. If there is less
   data to write, fill the chunk with zeroes and clean up later,
   but don't write more data to the same chunk.
2. Start writing on a segment (e.g. 4 MB, configurable) boundary,
   then write that segment to the end using the chunks mentioned
   above.
3. Erase full segments using trim/erase/discard before writing
   to them, if supported by the drive.
4. Have a configurable number of segments open for writing, i.e.
   you have written blocks at the start of the segment but not
   filled the segment to the end. Typical hardware limitations
   are between 1 and 10 open segments.
5. Keep all metadata within a single 4 MB segment. Drives that cannot
   do random access within normal segments can do it in the area
   that holds the FAT. If 4 MB is not enough, the FAT area can be
   used as a journal or cache, for a larger metadata area that gets
   written less frequently.
6. Because of the requirement to erase 4 MB chunks at once, there
   needs to be garbage collection to free up space. The quality
   of the garbage collection algorithm directly relates to the
   performance on full file systems and/or the space overhead.
7. Some static wear levelling is required to increase the expected
   life of consumer devices that only do dynamic wear levelling,
   i.e. the segments that contain purely static data need to
   be written occasionally so they make it back into the
   wear leveling pool of the hardware.

	Arnd
