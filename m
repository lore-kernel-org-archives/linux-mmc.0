From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Wed, 23 Feb 2011 16:26:12 -0600
Message-ID: <AANLkTimZDDo0xa2CzgHhH1LSWJ-KT0QgOmEAKs2nJK8x@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102221800.17196.arnd@arndb.de>
	<AANLkTinfWiRaGruP8cM44c62T8svVOKsFhi4Dmg8yzEa@mail.gmail.com>
	<201102231709.05036.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og109.obsmtp.com ([64.18.0.188]:38206 "EHLO
	exprod5og109.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682Ab1BWW31 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2011 17:29:27 -0500
In-Reply-To: <201102231709.05036.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Wed, Feb 23, 2011 at 10:09 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 23 February 2011, Andrei Warkentin wrote:
>> That sounds good! In fact, for any quirks enabled for a particular
>> card, I'll expose the tuneables through sysfs attributes, something
>> like /sys/block/mmcblk0/device/quirks/quirk-name/attr-names.
>>
>> Quirks will have block intervals and access size intervals over which
>> they are valid, along with any other quirk-specific parameter.
>> Interval overlap will not be allowed for quirks in the same operation
>> type (r/w/e). The goal here is to make the changes to issue_*_rq as
>> small as possible, and not to pollute block.c at all with the quirks
>> stuff. Quirks are looked up inside issue_*_rq based on req type and
>> [start,end) interval. The resulting found quirks structure will
>> contain a callback used inside issue_*_rq to modify mmc block request
>> structures prior to generating actual MMC commands.
>>
>> Quirks consist of a callback called inside of mmc issue_*_rq,
>> configurable attributes, and the sysfs interface. Quirk groups are
>> defined per-card. At card insertion time, a matching quirk group is
>> found, and is enabled. The quirk group enable function then enables
>> the relevant quirks with the right parameters (adds them to per
>> mmc_blk_data quirk interval tree). Some sane defaults for the tunables
>> are used. If the tunables are modified through sysfs, care is taken
>> that an interval overlap never happens, otherwise the tunable is not
>> modified and a kernel error message is logged.
>>
>> I hope I explained the tentative idea clearly... Thoughts?
>

> I would hope that the quirks can be simpler than this still, without
> the need to call any function pointers while using the device, or
> quirk specific sysfs directories.
>

I'll skip the sysfs part from the first RFC patch. I think this
complicates what I'm trying to achieve and makes this whole thing look
bigger than it is.

> What I meant is to have a single function pointer that can get
> called when detecting a specific known card. All this function
> does is to set values and flags that we can export either through
> common attributes of block devices (e.g. preferred erase size),
> or attributes specific to mmc devices (e.g. the toshiba hack, as
> a bool attribute).
>
> An obvious attribute would be the minimum size of an atomic
> page update. By default this could be 32KB, because any device
> should support that (FAT32 cannot have larger clusters). A
> card specific quirk can set it to another value, like 8KB, 16KB
> or 64KB, and file systems or other tools like mkfs can optimize
> for this value.
>
> I would like the flags like "don't submit requests spanning
> this boundary" and "make all writes below this size" to be defined
> in terms of the regular sizes we already know about, like the
> page size or the erase size.
>

I agree with you on the size/align issues. These are very generic
attributes and don't need a complicated framework like I described to
be dealt with. Ultimately they are just hints to the I/O scheduler, so
they should be part of the block device.

I am more concerned with workarounds that depend on access size (like
the toshiba one) and that modify the MMC commands sent (using reliable
writes, like the Toshiba one, or putting parameters differently like
the Sandisk erase workaround). It's these kinds of workarounds that
the quirks framework is meant to address. I don't think it's a good
idea to pollute mmc_blk_issue_rw_rq and mmc_blk_issue_discard_rq with
if()-elsed workarounds, because it's going to quickly complicate the
logic, and get out of hand and unmanageable the more cards are added.
I'm trying to avoid having to make any changes to card/block.c as part
of making quirk workarounds. The only cost when compared to an if-else
will be one O(log n) quirk lookup, where n is either one or something
close that (since the search is only done for quirks per
mmc_blk_data), and one callback invoked after "brq.data.sg_len =
mmc_queue_map_sg(mq);" so it can patch up mrq as necessary.
