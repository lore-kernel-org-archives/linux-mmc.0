From: Daniel Drake <dsd@laptop.org>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sat, 6 Nov 2010 21:19:49 +0000
Message-ID: <AANLkTi=GjQUOBBWe96ubtxN+ndQLcOFjebrDkM_1hSSb@mail.gmail.com>
References: <AANLkTim+Ez8FonyZDu42u4NX-KKV0YS_J-Ya-zT-Gf9q@mail.gmail.com>
	<AANLkTinEes6Er6-WW_t8esjazrLWZ0Z7jvYJDSZL9PNG@mail.gmail.com>
	<AANLkTinJ2K2cz9PSdyNoNGUS8GWfLpqRBH2C3XjO5vjO@mail.gmail.com>
	<AANLkTi=VAU=9Q+Ga7yQyu3aL7gV0vbzymQ-2uJAg1jf8@mail.gmail.com>
	<AANLkTi=QT6_zyddRz=3f6GDx-RVoiROOumhegm8pFuHU@mail.gmail.com>
	<AANLkTimfp0pPqpO03-R4yBsADQ27RLQ_PxLTfBAMfPGk@mail.gmail.com>
	<AANLkTi=gFmq47Xq+CxnU18aHyhcaF78WrWYDhga4Xf2X@mail.gmail.com>
	<AANLkTimqFBBsDCCDNOq22fuqjw7pezizZ9At+1ucGZ-j@mail.gmail.com>
	<AANLkTi=RP0i5cWO4AogGJx-sQ+17YKuiptQWi0ypYVnA@mail.gmail.com>
	<AANLkTiktD13-UC8=gwWhp9oR9_vGcM98VpRQ9i0CQg_-@mail.gmail.com>
	<AANLkTi=8Xd1xTfFvAJkicR_89JOu4P2uwyoMHvXCBKv8@mail.gmail.com>
	<AANLkTi=cPURFAitedD=mjkNiD_=ZCjakkMN6z7ecqv6k@mail.gmail.com>
	<AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:50423 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747Ab0KFVTv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 6 Nov 2010 17:19:51 -0400
Received: by ywc21 with SMTP id 21so2765970ywc.19
        for <linux-mmc@vger.kernel.org>; Sat, 06 Nov 2010 14:19:51 -0700 (PDT)
In-Reply-To: <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On 1 November 2010 08:27, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> On such boards, the right thing to do would be to disable runtime PM altogether.
>
> The patch below (/attached) should trivially fix the problem - can you
> please check it out ?

Thanks.
It solves the problem.

But, what you point out is quite interesting.
We currently have a (not-yet-upstream) rfkill driver for the XO-1.5,
which we also put in place for power saving reasons. It operates by
calling mmc_stop_host(). In light of your work, I guess that wasn't
really turning off the card.

So, it would be great if you could get runtime PM working on this
combo, and then later we could make a real rfkill driver.

I guess you have an XO-1.5 now. I'm happy to help you get started, I
guess this is your first time working with an XO. Drop by irc.oftc.net
#olpc-devel and I'll happily help you get started booting your own
kernel etc.

Thanks!
Daniel
