From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Fri, 10 Jun 2011 10:02:31 +0800
Message-ID: <BANLkTi=KjP9sUD0+QjDrJro0JXW4A+zOKg@mail.gmail.com>
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
	<BANLkTimuLrCd3oHeWOC73scuQ6ydvuwpvw@mail.gmail.com>
	<BANLkTimmSu33PTDn9ybOSbAfObPe4C-rZA@mail.gmail.com>
	<477F20668A386D41ADCC57781B1F704307FD0BF3B1@SC-VEXCH1.marvell.com>
	<BANLkTi=nz8c9P2qi9FWE+QU0XzSFddUAhA@mail.gmail.com>
	<477F20668A386D41ADCC57781B1F704307FD0BF3BE@SC-VEXCH1.marvell.com>
	<BANLkTi=qR7bbsnzsCpV=b2C4Ha5Hdb94gQ@mail.gmail.com>
	<BANLkTimZ+Emm6GrTztEaGnjRu92Pam13mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:58099 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756527Ab1FJCCc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jun 2011 22:02:32 -0400
Received: by vxi39 with SMTP id 39so1722467vxi.19
        for <linux-mmc@vger.kernel.org>; Thu, 09 Jun 2011 19:02:32 -0700 (PDT)
In-Reply-To: <BANLkTimZ+Emm6GrTztEaGnjRu92Pam13mQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bing Zhao <bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zgao6@marvell.com>

On Wed, Jun 8, 2011 at 10:34 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Bing,
>
> On Sat, Jun 4, 2011 at 1:52 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> On Sat, Jun 4, 2011 at 1:28 AM, Bing Zhao <bzhao@marvell.com> wrote:
>>> "CMD5 Arg=0" refers to the very first CMD5 sent from host during initialization sequence.
>>> This is required because our state machine always expects two CMD5 from host (5, 5, 3, 7, ...).
>>
>> Great, thanks for confirming this !
>
> I have another question please.
>
> Does the sd8686 require an SDIO I/O reset (CMD52 setting bit 3 of
> address 0x6 of the CCCR) to it after powering it on ?
>
> Daniel (cc'ed) is trying to power it off and back on, and it does seem
> to work in the first time, without sending a reset. In the second
> time, though, the card doesn't answer CMD5 anymore, unless Daniel is
> sending it an SDIO I/O reset. I was wondering whether this is an
> sd8686 requirement, or whether we have some other issue at hand.

Hi, Ohad

Here is answer got from the sd8686 maintainer.

For 8686, the SDIO state machine can only handle init sequence (CMD5,
5, 3, 7) from host once. If host sends another init sequence, it will
not be able to handle CMD5 and causes the SDIO block to hang. Chips
that are newer than 8686 will be able to handle multiple init sequence
from host.

So yes, for 8686, an IO reset is needed before host can send a new set
of init sequence.


>
> Thanks,
> Ohad.
>
