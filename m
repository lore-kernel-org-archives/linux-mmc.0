From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH V3 1/5] mmc: Add erase, secure erase, trim and secure
 trim operations
Date: Thu, 01 Jul 2010 13:49:32 +0300
Message-ID: <4C2C72BC.1050207@nokia.com>
References: <20100624084351.25444.30143.sendpatchset@ahunter-work.research.nokia.com>	<20100624084400.25444.57158.sendpatchset@ahunter-work.research.nokia.com> <20100630152144.3822fe6b.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:62185 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab0GAKu3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jul 2010 06:50:29 -0400
In-Reply-To: <20100630152144.3822fe6b.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel Mailing List <linux-kernel@vger.kernel.org>, Kyungmin Park <kmpark@infradead.org>, Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>

Andrew Morton wrote:
> On Thu, 24 Jun 2010 11:44:00 +0300
> Adrian Hunter <adrian.hunter@nokia.com> wrote:
> 
>> SD/MMC cards tend to support an erase operation.  In addition,
>> eMMC v4.4 cards can support secure erase, trim and secure trim
>> operations that are all variants of the basic erase command.
> 
> The patch proposes a new userspace interface via sysfs, yes?
,
Just two read-only values

> 
> Please fully describe that interface and its operation in the
> changelog.  It'd also be nice to add permanent documentation for it.
> 

OK

>>From reading the code, it appears that erase_size and
> preferred_erase_size have units in bytes.  But users shouldn't need to
> read the code to find that out.  What are the alignemnt and size
> requirements on these?  What is their position in /sys?  What do they
> actually *do* and what is the difference between them?
> 
> etetera.  People want to review this code and other people actually
> want to use it.  I'm not sure that I want to try to review this code
> when nobody's told me what interface it implements and how it's
> supposed to work.  Seems that whoever implemented BLKDISCARD didn't
> want anyone to use it either.  Sigh.
> 
> 
> All of mmc core appears to use 32-bit quantities to represent sectors,
> yes?  Why didn't it use sector_t?  What are the implications of this?

SD/MMC addressing uses 32-bit values.  There is a known 2TB limit for
SD/MMC cards.  As cards are only just getting to 64GB, that limit is
some way off, and it is not clear NAND technology can get there in
a SD/MMC package anyway.

I don't know why sector_t is not used.  I guess it would complicate doing
division since it can be 64-bit.

The implications are minimal.  In the unlikely event SD/MMC cards ever
exceed 2TB some changes will be needed, but the standard would have to
change to allow that first.


