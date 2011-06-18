From: Philip Rakity <prakity@marvell.com>
Subject: RE: SD8686 fast power-cycle problems
Date: Sat, 18 Jun 2011 08:36:05 -0700
Message-ID: <43E4817426ED174AA81263BCECB4351D134B85BBCB@sc-vexch3.marvell.com>
References: <BANLkTimsjb_cvcDKQpuqN_GxNWnyA0ebRg@mail.gmail.com>
	<1E37377F-AC54-43BC-AF01-53CA9FDE3A10@marvell.com>,<BANLkTiko7eZDhhyk_BxGN8haS37yCxihZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:51409 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755985Ab1FRPnC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 18 Jun 2011 11:43:02 -0400
In-Reply-To: <BANLkTiko7eZDhhyk_BxGN8haS37yCxihZQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Zhangfei Gao <zgao6@marvell.com>, Bing Zhao <bzhao@marvell.com>, Benson Chau <bchau@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


________________________________________
From: dsd.olpc@gmail.com [dsd.olpc@gmail.com] On Behalf Of Daniel Drake [dsd@laptop.org]
Sent: Saturday, June 18, 2011 2:33 AM
To: Philip Rakity
Cc: Zhangfei Gao; Bing Zhao; Benson Chau; linux-mmc@vger.kernel.org
Subject: Re: SD8686 fast power-cycle problems

On 17 June 2011 19:49, Philip Rakity <prakity@marvell.com> wrote:
>
> sdio_reset is harmless to non-sdio devices.  Especially since it is in the main power up path.
>
> I see no reason this should be done.  Can you prepare a patch ?

A patch to remove the sdio_reset() call from mmc_rescan_try_freq()? If
my understanding is correct, that one is needed, as you will need to
do a reset after failing to probe at one freq and then trying another
one.

Or do you mean a patch to add sdio_reset() into the runtime PM powerup
path? That would be harmless, would increase consistency between the
codepaths, and would solve this issue, so naturally has my vote :)


Add sdio_reset() !!  To the code path
Thanks
Daniel
