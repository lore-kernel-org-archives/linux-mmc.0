From: John Watlington <wad@laptop.org>
Subject: Re: Memory replacement
Date: Mon, 14 Mar 2011 20:29:19 -0400
Message-ID: <CB07FC9E-B64C-4B59-98F7-CD1F6FFFBA7B@laptop.org>
References: <AANLkTikQOVa8qfU-R6uqQXKhAVxqeAmxKONjPmmqLCr8@mail.gmail.com> <4D7D4670.1050009@bga.com> <CB98789C-76FD-4C0E-B7CA-FB41A3F32757@laptop.org> <201103142018.29705.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from amoxicillin.media.mit.edu ([18.85.2.134]:48245 "EHLO
	amoxicillin.media.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756211Ab1COA31 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2011 20:29:27 -0400
In-Reply-To: <201103142018.29705.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Watlington <wad@laptop.org>, mikus@bga.com, "Richard A. Smith" <richard@laptop.org>, devel@lists.laptop.org, linux-mmc@vger.kernel.org


On Mar 14, 2011, at 3:18 PM, Arnd Bergmann wrote:

> On Monday 14 March 2011 19:50:27 John Watlington wrote:
>> Cards that are in the state you describe are most likely dead due to
>> running out of spare blocks.   There is nothing that can be done to
>> rehabilitate them, even using the manufacturer's secret code.
>> In a disturbing trend, most of the cards I've returned for failure analysis
>> in the past year have been worn out (and not just trashed meta-data
>> due to a firmware error).
> 
> Part of the explanation for this could be the fact that erase block
> sizes have rapidly increased. AFAIK, the original XO builtin flash
> had 128KB erase blocks, which is also a common size for 1GB SD and
> CF cards.

> Cards made in 2010 or later typically have erase blocks of 2 MB, and
> combine two of them into an allocation unit of 4 MB. This means that
> in the worst case (random access over the whole medium), the write
> amplification has increased by a factor of 32.
> 
> Another effect is that the page size has increased by a factor of 8,
> from 2 or 4 KB to 16 or 32 KB. Writing data that as smaller than
> a page is more likely to get you into the worst case mentioned
> above. This is part of why FAT32 with 32 KB clusters still works
> reasonably well, but ext3 with 4 KB blocks has regressed so much.

The explanation is simple: manufacturers moved to two-bit/cell (MLC) NAND Flash
over a year ago, and six months ago moved to three-bit/cell (TLC) NAND Flash.
Reliability went down, then went through the floor (I cannot recommend TLC for
anything but write-once devices).   You might have noticed this as an increase in
the size of the erase block, as it doubled or more with the change.

Cheers,
wad

