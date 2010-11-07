From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sun, 7 Nov 2010 12:42:23 +0200
Message-ID: <AANLkTinXyW-iymJUeXGODLLBOevTwyUOcROg-B1wwJcA@mail.gmail.com>
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
 <AANLkTi=EaZbdnJzJWGH2fUadvNkUhdQgTU1rAoS5wMAs@mail.gmail.com> <AANLkTi=GjQUOBBWe96ubtxN+ndQLcOFjebrDkM_1hSSb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59493 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251Ab0KGKmp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 7 Nov 2010 05:42:45 -0500
Received: by iwn41 with SMTP id 41so2763122iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 07 Nov 2010 02:42:45 -0800 (PST)
In-Reply-To: <AANLkTi=GjQUOBBWe96ubtxN+ndQLcOFjebrDkM_1hSSb@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Sat, Nov 6, 2010 at 11:19 PM, Daniel Drake <dsd@laptop.org> wrote:
> Thanks.
> It solves the problem.

Good. Did it also solve the 1st issue you had ?

Anyway I'm still interested to reproduce that crash. No reason to get
a kernel panic whatsoever.

>
> But, what you point out is quite interesting.
> We currently have a (not-yet-upstream) rfkill driver for the XO-1.5,
> which we also put in place for power saving reasons.

Can you please elaborate ? What power saving ? How do you exactly plan
to use it ? Do you plan to power off the card without taking the wlan
interface down first ?

> It operates by
> calling mmc_stop_host(). In light of your work, I guess that wasn't
> really turning off the card.

Sounds like it.

Chris and I briefly discussed this in LPC, and he mentioned that you
might have an external power source to that card, that is not
controlled by the mmc regulator, and which you disable/enable from
user space just before suspending the host ?

>
> So, it would be great if you could get runtime PM working on this
> combo, and then later we could make a real rfkill driver.

The XO-1.5 problem is orthogonal to runtime PM. If your regulator
really powered down your card, then everything would just have worked.

>
> I guess you have an XO-1.5 now. I'm happy to help you get started, I
> guess this is your first time working with an XO. Drop by irc.oftc.net
> #olpc-devel and I'll happily help you get started booting your own
> kernel etc.

Thanks. This would allow me to test generic core code on a platform
which is completely different from those I have.

Thanks,
Ohad.

>
> Thanks!
> Daniel
>
