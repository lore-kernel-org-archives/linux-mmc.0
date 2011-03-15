From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Memory replacement
Date: Tue, 15 Mar 2011 09:42:04 +0100
Message-ID: <201103150942.04690.arnd@arndb.de>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com> <201103142018.29705.arnd@arndb.de> <CB07FC9E-B64C-4B59-98F7-CD1F6FFFBA7B@laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50508 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754980Ab1COImL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Mar 2011 04:42:11 -0400
In-Reply-To: <CB07FC9E-B64C-4B59-98F7-CD1F6FFFBA7B@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Watlington <wad@laptop.org>
Cc: mikus@bga.com, "Richard A. Smith" <richard@laptop.org>, devel@lists.laptop.org, linux-mmc@vger.kernel.org

On Tuesday 15 March 2011 01:29:19 John Watlington wrote:

> On Mar 14, 2011, at 3:18 PM, Arnd Bergmann wrote:
>
> > Another effect is that the page size has increased by a factor of 8,
> > from 2 or 4 KB to 16 or 32 KB. Writing data that as smaller than
> > a page is more likely to get you into the worst case mentioned
> > above. This is part of why FAT32 with 32 KB clusters still works
> > reasonably well, but ext3 with 4 KB blocks has regressed so much.
> 
> The explanation is simple: manufacturers moved to two-bit/cell (MLC) NAND Flash
> over a year ago, and six months ago moved to three-bit/cell (TLC) NAND Flash.
> Reliability went down, then went through the floor (I cannot recommend TLC for
> anything but write-once devices).   You might have noticed this as an increase in
> the size of the erase block, as it doubled or more with the change.

That, and the move to smaller structures (down to 25 nm) has of course
reduced reliablility further, down to 2000 or so erase cycles per block,
but that effect is unrelated to the file system being used.

My point was that even if the card was done perfectly for FAT32 (maybe a
write amplification of 2), the changes I described are pessimising ext3
(data from my head, easily off by an order of magnitude):

	 drive	 block	page 	erase	w-amplftn	expected life
	 size    size	size 	cycles	FAT ext3	FAT	ext3
2005 SLC 256 MB	 64 KB	1 KB	100000	2   8		13 TB	3.2 TB
2005 MLC 512 MB	 128 KB	2 KB	10000	2   16		2.5 TB	640 GB
2011 SLC 4 GB	 2 MB	8 KB	50000	2   512		100 TB	200 GB
2011 MLC 8 GB	 4 MB	16 KB	5000	2   1024	20 TB	40 GB
2011 TLC 16 GB	 4 MB	16 KB	2000	2   1024	16 TB	32 GB

The manufacturers have probably mitigated this slightly by using more
spare blocks, better ECC and better GC over the years, but essentially
your measurements are matching the theory.

	Arnd
