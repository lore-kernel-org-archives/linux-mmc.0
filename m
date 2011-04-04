From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: fix mmc_pm_notify bus_ops->remove deadlock.
Date: Mon, 4 Apr 2011 11:08:25 -0500
Message-ID: <BANLkTikMmf-d1BVG6ZMUV-L-nB05ytQVYw@mail.gmail.com>
References: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
	<1301925644-9274-1-git-send-email-andreiw@motorola.com>
	<BANLkTikBdgt7LFW-8OFphV0r-UMu9CfKcw@mail.gmail.com>
	<BANLkTiksgpV=XX2bxSEUy9aaeyhokoXbOw@mail.gmail.com>
	<alpine.DEB.2.00.1104041624310.690@localhost6.localdomain6>
	<BANLkTikmNZnFOfEaCm4RdNs5p6b-L5rY8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:39224 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1DDQI2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 12:08:28 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34G8lcu029543
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 12:08:47 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34FkvuB018672
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 12:08:47 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so6663499wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 09:08:25 -0700 (PDT)
In-Reply-To: <BANLkTikmNZnFOfEaCm4RdNs5p6b-L5rY8w@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: frank.hofmann@tomtom.com, linux-mmc@vger.kernel.org

On Mon, Apr 4, 2011 at 10:47 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Mon, Apr 4, 2011 at 10:26 AM, Frank Hofmann <frank.hofmann@tomtom.com> wrote:
>>
>>
>> On Mon, 4 Apr 2011, Andrei Warkentin wrote:
>>
>>> On Mon, Apr 4, 2011 at 8:27 AM, Andrei Warkentin <andreiw@motorola.com>
>>> wrote:
>>>>
>>>> On Mon, Apr 4, 2011 at 9:00 AM, Andrei Warkentin <andreiw@motorola.com>
>>>> wrote:
>>>>>
>>>>> This resolves the deadlock issue with suspend. There is no
>>>>> need to claim host before the remove op.
>>>>>
>>>>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>>>>
>>>> Frank,
>>>>
>>>> Can you try this out? I think this fixes it.
>>>>
>>>> Ohad,
>>>>
>>>> I think this means we can take
>>>> 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 out (mmc: sdio: fix SDIO
>>>> suspend/resume regression). What do you think?
>>>>
>>>> Thanks,
>>>> A
>>>>
>>>
>>> Ohad, nevermind.
>>>
>>> I think there is a bigger issue here at stake for removeable cards. If
>>> you have a mounted file system,
>>> the usage count for mmc_blk usage will never drop enough to remove the
>>> device!
>>>
>>> I think the block.c for removal needs to change somewhat. Removed MDs
>>> need to clear devidx and be put on an "orphan list" from where
>>> they will remove themselves if usage count drops to zero. On re-probe,
>>> the "orphan list" needs to be scanned for allocated devidx, and if it
>>> is found, then that MD should be reused.
>>> I'll see if I can put something together.
>>>
>>> A
>>>
>>
>> Just to clarify, do you want a test result without
>> 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 or better wait for now ?
>>
>> FrankH.
>>
>
> I don't think there is a point. For example, for mounted media, if the
> userspace unmounts the filesystem on suspend, then the device will
> successfully remove.
> For root fs on a removeable card, it will never tear down the mmcblk
> MD, because mmc_blk_release will never be called enough times (fs is
> mounted).
>
> Is the card actually an external card for you or an eMMC? You could
> just get away with unsafe resume, I suppose...
>
> A
>

I don't think there is a good fix. Suspend with a removable card is
equivalent to pulling out the card with a file system mounted after
manually mounting the fs,
with the exception that all outstanding I/O is flushed. You could play
games with caching removed MDs if the use count doesn't drop to zero
and reusing them, but
the best you can achieve is a successful resume after a suspend as
long as the hardware configuration didn't change (no other cards
added).

A
