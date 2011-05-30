From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Mon, 30 May 2011 10:32:12 +0300
Message-ID: <BANLkTi=o6Hgb=icinjmZqVx09dx+cp-enw@mail.gmail.com>
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
 <BANLkTikpciJnTudOeSLM_O7AAD4GGkbbOw@mail.gmail.com> <BANLkTikQC+u5yyU+YBAZ5JpFDRFHrHNOoA@mail.gmail.com>
 <BANLkTi=kqnnGf3ezS=cSXCcHpmK3JxwXtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42540 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878Ab1E3Hcd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 03:32:33 -0400
Received: by wwa36 with SMTP id 36so3630305wwa.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 00:32:32 -0700 (PDT)
In-Reply-To: <BANLkTi=kqnnGf3ezS=cSXCcHpmK3JxwXtg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zhangfei.gao@marvell.com>

On Mon, May 30, 2011 at 10:01 AM, Daniel Drake <dsd@laptop.org> wrote:
> On 30 May 2011 07:52, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Last we talked, we found out runtime PM didn't work because the sd8686
>> required an additional manipulation of an external reset gpio line,
>> and that the only reason OLPC could power it down/up was this patch:
>>
>> http://dev.laptop.org/git/olpc-2.6/commit/?h=olpc-2.6.35&id=e9bee721fb0cc303286d1fe5df4930ce79b0b1e0
>
> My further investigation here suggests that this change is not
> necessary. It was added in response to a separate (hard-to-reproduce)
> issue and it was never known if it would actually fix that issue, it
> was more of a guess. We don't have any convincing evidence that it
> helps, so it will be dropped in future.
>
> Anyway, just to be sure, I tried combining this hack with runtime PM,
> and also as a regulator, and it didn't help anything. runtime PM still
> fails to power up the card.
>
> Sorry for leading you down the wrong path there.
...
>> does mmc_stop_host+mmc_start_host
>> work for you without manipulating that reset gpio ?
>
> Yes.

Hm. I still don't entirely get it, because we had others (Mike, cc'd)
saying too that the sd8686 requires manipulating an external reset
gpio after bringing the power back up.

Maybe someone from Marvell can comment on this (cc'ing Zhangfei Gao) ?

> You didn't comment on the added mmc_select_voltage() call. Is that one
> also sensible?

I guess. if we're reading the I/O OCR, might as well use it. This way
our runtime PM power up path will also be identical to the one induced
by mmc_attach_sdio.
