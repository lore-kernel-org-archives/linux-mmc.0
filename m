From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Mon, 30 May 2011 07:04:20 -0400
Message-ID: <BANLkTimuLrCd3oHeWOC73scuQ6ydvuwpvw@mail.gmail.com>
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
	<BANLkTikpciJnTudOeSLM_O7AAD4GGkbbOw@mail.gmail.com>
	<BANLkTikQC+u5yyU+YBAZ5JpFDRFHrHNOoA@mail.gmail.com>
	<BANLkTi=kqnnGf3ezS=cSXCcHpmK3JxwXtg@mail.gmail.com>
	<BANLkTi=o6Hgb=icinjmZqVx09dx+cp-enw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:61164 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705Ab1E3LEU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 May 2011 07:04:20 -0400
Received: by vws1 with SMTP id 1so2562394vws.19
        for <linux-mmc@vger.kernel.org>; Mon, 30 May 2011 04:04:20 -0700 (PDT)
In-Reply-To: <BANLkTi=o6Hgb=icinjmZqVx09dx+cp-enw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Daniel Drake <dsd@laptop.org>, linux-mmc@vger.kernel.org, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zhangfei.gao@marvell.com>, Bing Zhao <bzhao@marvell.com>

On Mon, May 30, 2011 at 3:32 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> On Mon, May 30, 2011 at 10:01 AM, Daniel Drake <dsd@laptop.org> wrote=
:
>> On 30 May 2011 07:52, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>>> Last we talked, we found out runtime PM didn't work because the sd8=
686
>>> required an additional manipulation of an external reset gpio line,
>>> and that the only reason OLPC could power it down/up was this patch=
:
>>>
>>> http://dev.laptop.org/git/olpc-2.6/commit/?h=3Dolpc-2.6.35&id=3De9b=
ee721fb0cc303286d1fe5df4930ce79b0b1e0
>>
>> My further investigation here suggests that this change is not
>> necessary. It was added in response to a separate (hard-to-reproduce=
)
>> issue and it was never known if it would actually fix that issue, it
>> was more of a guess. We don't have any convincing evidence that it
>> helps, so it will be dropped in future.
>>
>> Anyway, just to be sure, I tried combining this hack with runtime PM=
,
>> and also as a regulator, and it didn't help anything. runtime PM sti=
ll
>> fails to power up the card.
>>
>> Sorry for leading you down the wrong path there.
> ...
>>> does mmc_stop_host+mmc_start_host
>>> work for you without manipulating that reset gpio ?
>>
>> Yes.
>
> Hm. I still don't entirely get it, because we had others (Mike, cc'd)
> saying too that the sd8686 requires manipulating an external reset
> gpio after bringing the power back up.

sd8686 requires two pins to control power, PDn and RESETn.
To enable sd8686, PDn and RESETn should both set high.
To disable sd8686, PDn should be set low.
We also have plans to use runtime PM to optimize these two pins,
suggested by Ohad before.
However currently we still use rfkill method to control the two pins.
In the stress test, we found wlan card may not be probed successfully
even the two pins are set correctly, so we manually detect whether
mmc->card is allocated or not, not sure whether runtime PM to handle
this case.

>
> Maybe someone from Marvell can comment on this (cc'ing Zhangfei Gao) =
?
>
>> You didn't comment on the added mmc_select_voltage() call. Is that o=
ne
>> also sensible?
>
> I guess. if we're reading the I/O OCR, might as well use it. This way
> our runtime PM power up path will also be identical to the one induce=
d
> by mmc_attach_sdio.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
