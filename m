From: Bing Zhao <bzhao@marvell.com>
Subject: RE: MMC runtime PM patches break libertas probe
Date: Fri, 3 Jun 2011 15:28:33 -0700
Message-ID: <477F20668A386D41ADCC57781B1F704307FD0BF3BE@SC-VEXCH1.marvell.com>
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
 <477F20668A386D41ADCC57781B1F704307FD0BF3B1@SC-VEXCH1.marvell.com>,<BANLkTi=nz8c9P2qi9FWE+QU0XzSFddUAhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:44550 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754536Ab1FCWbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Jun 2011 18:31:00 -0400
In-Reply-To: <BANLkTi=nz8c9P2qi9FWE+QU0XzSFddUAhA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Daniel Drake <dsd@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mike Rapoport <mike@compulab.co.il>, Zhangfei Gao <zgao6@marvell.com>

> On Thu, Jun 2, 2011 at 11:39 AM, Bing Zhao <bzhao@marvell.com> wrote:
>>> If we power down the sd8686, and power it up again, without toggling
>>> the reset pin at all (e.g. keep it always high), will the card work ?
>>
>> Yes. The card should work without toggling the reset pin.
> 
> Thanks.
> 
> Just for closure-sake, can you please confirm that the sd8686 requires
> sending a CMD5 arg=0 as part of the initialization sequence after
> powering it on ?

"CMD5 Arg=0" refers to the very first CMD5 sent from host during initialization sequence.
This is required because our state machine always expects two CMD5 from host (5, 5, 3, 7, ...).

Regards,
Bing

> (we'd probably add it anyway, but it'd be nice to get a confirmation
> about this from you guys)
> 
> Btw, it will be nice to allow cards to avoid sending this if not
> required; a simple card quirk will do. wl12xx will definitely use such
> a quirk.