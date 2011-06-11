From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Sat, 11 Jun 2011 10:33:37 +0800
Message-ID: <BANLkTinyU5x5QFbDs2bqbZ0ebpRhe+aSSw@mail.gmail.com>
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
	<BANLkTi=KjP9sUD0+QjDrJro0JXW4A+zOKg@mail.gmail.com>
	<BANLkTinDe6fOavZZ+1c1OKS7XMf_J5YhaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38153 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758509Ab1FKCdi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Jun 2011 22:33:38 -0400
Received: by vxi39 with SMTP id 39so2628636vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 10 Jun 2011 19:33:37 -0700 (PDT)
In-Reply-To: <BANLkTinDe6fOavZZ+1c1OKS7XMf_J5YhaA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Bing Zhao <bzhao@marvell.com>, Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zgao6@marvell.com>, Benson Chau <bchau@marvell.com>

On Fri, Jun 10, 2011 at 12:28 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> Hi Zhangfei,
>
> On Fri, Jun 10, 2011 at 5:02 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> Here is answer got from the sd8686 maintainer.
>>
>> For 8686, the SDIO state machine can only handle init sequence (CMD5,
>> 5, 3, 7) from host once. If host sends another init sequence, it will
>> not be able to handle CMD5 and causes the SDIO block to hang. Chips
>> that are newer than 8686 will be able to handle multiple init sequence
>> from host.
>
> Thanks for the reply !
>
>> So yes, for 8686, an IO reset is needed before host can send a new set
>> of init sequence.
>
> But if we're powering down and up the device first, then the init
> sequence is considered the first one, and then we don't need an IO
> reset, right ? That was what we wondered about.

Hi Ohad,

If you power down and up the device, then IO reset is not needed and
8686 can process host init sequence correctly.

CC Benson.

>
> Thanks,
> Ohad.
>
