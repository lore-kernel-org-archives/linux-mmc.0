From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC 4/5] MMC: Adjust unaligned write accesses.
Date: Thu, 10 Mar 2011 17:05:45 +0100
Message-ID: <201103101705.45230.arnd@arndb.de>
References: <1299718449-15172-1-git-send-email-andreiw@motorola.com> <1299718449-15172-5-git-send-email-andreiw@motorola.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56204 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab1CJQFy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 11:05:54 -0500
In-Reply-To: <1299718449-15172-5-git-send-email-andreiw@motorola.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org

On Thursday 10 March 2011, Andrei Warkentin wrote:
> Adjust unaligned write accesses spanning preferred align
> size into two accesses - an unaligned and an aligned access.
> This is meant to be used for card quirks, and is off
> by default. A limiting value in transfer size
> for this adjustment is available, as on some cards there is a
> perf decrease for larger transfers.
> 
> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>

Sorry for repeating myself, but I'm not sure if you didn't understand
me or if I missed your arguments against the more generic approach.

Instead of encoding specific parameters for this quirk, I would
much prefer to have the values be meaningful, and have the
code deal with the interpretation.

> @@ -63,6 +63,8 @@ struct mmc_blk_data {
>  
>  	unsigned int	usage;
>  	unsigned int	read_only;
> +	unsigned int	write_align_size;
> +	unsigned int	write_align_limit;
>  };

These numbers are generally speaking useless, except for the
one quirk. What I was trying to suggest here is to have
a page_size field that reflects the underlying page size
of the NAND flash, and a flag that says "please split all
requests under 1.5 times the page size along page boundaries".

We can pre-initialize the page size to some common value
(e.g. 16 KB for 4GB or larger cards, 4 KB for smaller than
4 GB), and use quirks to override it for cards where we
know it's different.

There are a lot of optimizations based on the page size
(partition alignment, fs block size, readahead, ...), so it
can become a generic blockdev attribute and get used by
both kernel and user code, rather than assuming we can
do 512 byte sector accesses efficiently.

The block layer already has physical_block_size and
io_min fields in various places, so the answer may be
to simply set one of those instead of introducing another
page_size for mmc.

	Arnd
