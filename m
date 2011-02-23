From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Wed, 23 Feb 2011 04:19:50 -0600
Message-ID: <AANLkTinfWiRaGruP8cM44c62T8svVOKsFhi4Dmg8yzEa@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102201539.08496.arnd@arndb.de>
	<AANLkTi=ZOUrNoT1W1n3d+9KTMewKZ3kxo71AQsas9OpD@mail.gmail.com>
	<201102221800.17196.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og114.obsmtp.com ([64.18.0.28]:59365 "EHLO
	exprod5og114.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029Ab1BWKTy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Feb 2011 05:19:54 -0500
In-Reply-To: <201102221800.17196.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Tue, Feb 22, 2011 at 11:00 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> Do you think there is any need for runtime tuning of the MMC
>> workarounds (disregarding ones that really belong in the I/O
>> scheduler)? Should the workarounds be simply platform callbacks, or
>> should they be something heftier ("policies")?
>
> The platform hook seems the wrong place, because you might use
> the same chip in multiple platforms, and a single platform might
> have a large number of different boards, all of which require
> separate workarounds.
>

That's a good point. At best it would result in massive copy-paste/

> A per-card quirk table does not seem so bad, we have that in
> other subsystems as well. I wouldn't necessarily make it
> a list of possible quirks, but rather a __devinit function that
> is called for a new card on insertion, in order to tweak various
> parameters.
>

That sounds good! In fact, for any quirks enabled for a particular
card, I'll expose the tuneables through sysfs attributes, something
like /sys/block/mmcblk0/device/quirks/quirk-name/attr-names.

Quirks will have block intervals and access size intervals over which
they are valid, along with any other quirk-specific parameter.
Interval overlap will not be allowed for quirks in the same operation
type (r/w/e). The goal here is to make the changes to issue_*_rq as
small as possible, and not to pollute block.c at all with the quirks
stuff. Quirks are looked up inside issue_*_rq based on req type and
[start,end) interval. The resulting found quirks structure will
contain a callback used inside issue_*_rq to modify mmc block request
structures prior to generating actual MMC commands.

Quirks consist of a callback called inside of mmc issue_*_rq,
configurable attributes, and the sysfs interface. Quirk groups are
defined per-card. At card insertion time, a matching quirk group is
found, and is enabled. The quirk group enable function then enables
the relevant quirks with the right parameters (adds them to per
mmc_blk_data quirk interval tree). Some sane defaults for the tunables
are used. If the tunables are modified through sysfs, care is taken
that an interval overlap never happens, otherwise the tunable is not
modified and a kernel error message is logged.

I hope I explained the tentative idea clearly... Thoughts?

A
