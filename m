From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Thu, 10 Mar 2011 22:54:02 +0100
Message-ID: <201103102254.02041.arnd@arndb.de>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com> <201103101705.45230.arnd@arndb.de> <AANLkTi=bUEtNKtqvHbq63q2=Jnzc2aD6nE2cgZ2F-RKY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:51785 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020Ab1CJVyG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 16:54:06 -0500
In-Reply-To: <AANLkTi=bUEtNKtqvHbq63q2=Jnzc2aD6nE2cgZ2F-RKY@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Thursday 10 March 2011 21:45:07 Andrei Warkentin wrote:
> > We can pre-initialize the page size to some common value
> > (e.g. 16 KB for 4GB or larger cards, 4 KB for smaller than
> > 4 GB), and use quirks to override it for cards where we
> > know it's different.
> >
> 
> Even better. We have the "super page size" in the EXT_CSD. For example
> for Sandisk it's 16KB, Toshiba is reporting 32KB, but we know that's
> not right...

Ok, that sounds good. I don't think we have anything like this
for SD cards though, so we'd still need to make some reasonable
assumption there.

The one thing we know is that all SD cards should support writes of
32KB alignment, because that is the largest cluster size supported
by FAT16 and FAT32. I have experimentally shown that most cards
can reasonably do 16KB, and only few modern cards can do smaller
than that.

I also don't know what the effect of setting physical_block_size
and/or io_min is, possibly it no longer works if they are larger
than the MMU page size. Need to try this.

	Arnd
