From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: MMC runtime PM patches break libertas probe
Date: Wed, 8 Jun 2011 17:34:01 +0300
Message-ID: <BANLkTimZ+Emm6GrTztEaGnjRu92Pam13mQ@mail.gmail.com>
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
 <BANLkTi=kqnnGf3ezS=cSXCcHpmK3JxwXtg@mail.gmail.com> <BANLkTi=o6Hgb=icinjmZqVx09dx+cp-enw@mail.gmail.com>
 <BANLkTimuLrCd3oHeWOC73scuQ6ydvuwpvw@mail.gmail.com> <BANLkTimmSu33PTDn9ybOSbAfObPe4C-rZA@mail.gmail.com>
 <477F20668A386D41ADCC57781B1F704307FD0BF3B1@SC-VEXCH1.marvell.com>
 <BANLkTi=nz8c9P2qi9FWE+QU0XzSFddUAhA@mail.gmail.com> <477F20668A386D41ADCC57781B1F704307FD0BF3BE@SC-VEXCH1.marvell.com>
 <BANLkTi=qR7bbsnzsCpV=b2C4Ha5Hdb94gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55737 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753628Ab1FHOeX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2011 10:34:23 -0400
Received: by wya21 with SMTP id 21so402321wya.19
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2011 07:34:22 -0700 (PDT)
In-Reply-To: <BANLkTi=qR7bbsnzsCpV=b2C4Ha5Hdb94gQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zgao6@marvell.com>

Hi Bing,

On Sat, Jun 4, 2011 at 1:52 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Sat, Jun 4, 2011 at 1:28 AM, Bing Zhao <bzhao@marvell.com> wrote:
>> "CMD5 Arg=0" refers to the very first CMD5 sent from host during initialization sequence.
>> This is required because our state machine always expects two CMD5 from host (5, 5, 3, 7, ...).
>
> Great, thanks for confirming this !

I have another question please.

Does the sd8686 require an SDIO I/O reset (CMD52 setting bit 3 of
address 0x6 of the CCCR) to it after powering it on ?

Daniel (cc'ed) is trying to power it off and back on, and it does seem
to work in the first time, without sending a reset. In the second
time, though, the card doesn't answer CMD5 anymore, unless Daniel is
sending it an SDIO I/O reset. I was wondering whether this is an
sd8686 requirement, or whether we have some other issue at hand.

Thanks,
Ohad.
