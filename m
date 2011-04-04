From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: fix mmc_pm_notify bus_ops->remove deadlock.
Date: Mon, 4 Apr 2011 10:01:29 -0500
Message-ID: <BANLkTiksgpV=XX2bxSEUy9aaeyhokoXbOw@mail.gmail.com>
References: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
	<1301925644-9274-1-git-send-email-andreiw@motorola.com>
	<BANLkTikBdgt7LFW-8OFphV0r-UMu9CfKcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:38841 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab1DDPBc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 11:01:32 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34F1q1k026940
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 11:01:52 -0400 (EDT)
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com [209.85.215.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34F1WIh026723
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 11:01:52 -0400 (EDT)
Received: by mail-ey0-f170.google.com with SMTP id 5so2067181eyf.15
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 08:01:30 -0700 (PDT)
In-Reply-To: <BANLkTikBdgt7LFW-8OFphV0r-UMu9CfKcw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, frank.hofmann@tomtom.com
Cc: Andrei Warkentin <andreiw@motorola.com>, ohad@wizery.com

On Mon, Apr 4, 2011 at 8:27 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Mon, Apr 4, 2011 at 9:00 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> This resolves the deadlock issue with suspend. There is no
>> need to claim host before the remove op.
>>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>
> Frank,
>
> Can you try this out? I think this fixes it.
>
> Ohad,
>
> I think this means we can take
> 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 out (mmc: sdio: fix SDIO
> suspend/resume regression). What do you think?
>
> Thanks,
> A
>

Ohad, nevermind.

I think there is a bigger issue here at stake for removeable cards. If
you have a mounted file system,
the usage count for mmc_blk usage will never drop enough to remove the device!

I think the block.c for removal needs to change somewhat. Removed MDs
need to clear devidx and be put on an "orphan list" from where
they will remove themselves if usage count drops to zero. On re-probe,
the "orphan list" needs to be scanned for allocated devidx, and if it
is found, then that MD should be reused.
I'll see if I can put something together.

A
