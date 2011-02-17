From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Thu, 17 Feb 2011 16:47:46 +0100
Message-ID: <201102171647.46190.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com> <201102151816.57104.arnd@arndb.de> <AANLkTimoqCtWMmBJ40v+1UjR0U2Sdh9pp+2fwYpi3fUx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49322 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755534Ab1BQPry (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2011 10:47:54 -0500
In-Reply-To: <AANLkTimoqCtWMmBJ40v+1UjR0U2Sdh9pp+2fwYpi3fUx@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Thursday 17 February 2011, Andrei Warkentin wrote:
> Ext4.

Ok, I see. I haven't really done this kind of tests before, but my
feeling is that ext3/ext4 may be much worse than the alternatives
at the moment. It would certainly be worthwhile to do tests using
nilfs2 and btrfs, whose default behaviour matches the requirements
of your eMMC flash much better, and see how they perform with and
without your patch.

> I agree, which is why all of this is controlled now through sysfs, and
> there are no more hard-coded checks for manfid, mmc versus sd or any
> other magic. There is a page_size_secs attribute, through which you
> can notify of the page size for the device.

How about making that just page_size in bytes? sectors don't always
mean 512 bytes, so this would be both shorter and less anbiguous.

> The workaround for small
> writes crossing the page boundary (and winding up in Buffer B, instead
> of A) is turned on by setting split_tlow and split_thigh, which
> provided a threshold range in sectors over which the the writes will
> be split/aligned. The second workaround for splitting larger requests
> and writing them with reliable write (to avoid getting coalesced and
> winding up in Buffer B again) is controlled through split_relw_tlow
> and split_relw_thigh. Do you think there is a better way? Or is this
> good enough?

I think I'd try to reduce the number of sysfs files needed for this.
What are the values you would typically set here?

My feeling is that separating unaligned page writes from full pages
or multiples of pages could always be benefitial for all cards, or at
least harmless, but that will require more measurements.
Whether to do the reliable write or not could be a simple flag
if the numbers are the same.

> So, as I mentioned before, T had done some tests given data provided
> by M, and then T verified that this fix was good. I need to do my own
> tests on the patch after I rewrite it. Is iozone the best tool I can
> use? So far I have a MMC logging facility through connector that I use
> to collect stats (useful for seeing how fs traffic translates to
> actual mmc commands...once I clean it up I'll push here for RFC). What
> about the tool you're writing? Any way I can use it?

It's now available in a an early almost-usable version at
git://git.linaro.org/people/arnd/flashbench.git

I don't have a test for the second buffer yet, but it would be
good to know some of the other characteristics of your eMMC drive.

Please try some of these commands:

flashbench -a /dev/mmcblk0  --blocksize=1024
flashbench --open-au --open-au-nr=1 /dev/mmcblk0 --blocksize=512
flashbench --open-au --open-au-nr=1 /dev/mmcblk0 --blocksize=512 --random
flashbench --open-au --open-au-nr=2 /dev/mmcblk0 --blocksize=512
flashbench --open-au --open-au-nr=2 /dev/mmcblk0 --blocksize=512 --random
flashbench --open-au --open-au-nr=3 /dev/mmcblk0 --blocksize=512
flashbench --open-au --open-au-nr=3 /dev/mmcblk0 --blocksize=512 --random

Note that the --open-au test will overwrite your data. You can do it on a
partition you don't use, but it needs to be aligned to 4 MB.

	Arnd
