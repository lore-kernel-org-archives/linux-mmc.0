From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
Date: Mon, 24 Jan 2011 22:10:01 -0500
Message-ID: <AANLkTimZJbO1FNGKUG2JhJZOVeM-95cc5NuvAN+oC+Vx@mail.gmail.com>
References: <1283391692-14150-1-git-send-email-bzhao@marvell.com>
	<alpine.LFD.2.00.1009021344430.19366@xanadu.home>
	<477F20668A386D41ADCC57781B1F704307D2F41B27@SC-VEXCH1.marvell.com>
	<alpine.LFD.2.00.1009021923171.19366@xanadu.home>
	<477F20668A386D41ADCC57781B1F704307D2FE4A0F@SC-VEXCH1.marvell.com>
	<alpine.LFD.2.00.1009072119210.19366@xanadu.home>
	<477F20668A386D41ADCC57781B1F704307D2FE4A52@SC-VEXCH1.marvell.com>
	<1284459351.2359.17.camel@stummala-linux.in.qualcomm.com>
	<477F20668A386D41ADCC57781B1F704307D30738F5@SC-VEXCH1.marvell.com>
	<alpine.LFD.2.00.1009152222400.19366@xanadu.home>
	<AANLkTinjpe8iGcOyru=09WrBq4f5PfBo2QcUs40OycXg@mail.gmail.com>
	<AANLkTikguM7rYuCXpom3dN4T4+9RG2=0OvV8cnL0Tz04@mail.gmail.com>
	<477F20668A386D41ADCC57781B1F704307F4EA2BA9@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:50320 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919Ab1AYDKD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 22:10:03 -0500
Received: by fxm20 with SMTP id 20so4775522fxm.19
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jan 2011 19:10:01 -0800 (PST)
In-Reply-To: <477F20668A386D41ADCC57781B1F704307F4EA2BA9@SC-VEXCH1.marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bing Zhao <bzhao@marvell.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Nicolas Pitre <nico@fluxnic.net>, Sahitya Tummala <stummala@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Michal Miroslaw <mirqus@gmail.com>, Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, Jun Nie <njun@marvell.com>

On Mon, Jan 24, 2011 at 9:17 PM, Bing Zhao <bzhao@marvell.com> wrote:
> Hi Ohad,
>
>> -----Original Message-----
>> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
>> Sent: Saturday, January 22, 2011 2:01 PM
>> To: zhangfei gao
>> Cc: Nicolas Pitre; Bing Zhao; Sahitya Tummala; linux-mmc@vger.kernel.org; Michal Miroslaw; Chris Ball;
>> Andrew Morton; Maxim Levitsky
>> Subject: Re: [PATCH v2] sdio: skip initialization on powered resume
>>
>> On Fri, Jan 21, 2011 at 11:07 AM, zhangfei gao <zhangfei.gao@gmail.com> wrote:
>> > Do you have any updated patch to skip mmc_sdio_init_card in resume back.
>> > We need such patch in enable host sleep feature for mrvl8787.
>>
>> Is mrvl8787 a removable card ?
>
> It can be either a removable or non-removable card, depending on what platform is used.
>
>>
>> I'm asking because we already skip mmc_sdio_init_card() for
>> powered-resumed nonremovable cards (check out commit 3cfc33a "mmc:
>> sdio: don't reinitialize nonremovable powered-resumed cards").
>
> Thanks for the info.
>
>>
>> I'm not familiar with marvell's cards, but I do remember a thread
>> mentioning they have dedicated reset GPIOs, and that may suggest they
>> are nonremovables. If that's the case, simply setting
>> MMC_CAP_NONREMOVABLE on the relevant slot should do the trick for you.
>
> I think this approach works for Zhangfei on his embedded platform on which the 8787 card is non-removable.

Hi, Ohad,

Thanks for your patch, it is workable on the platform where mrvl8787
is non-removable.
However, we still have platform mrvl8787 is removable,
SDHCI_PRESENT_STATE can be read out value.
Could we remove mmc_card_is_removable(host) condition, the skip is not
related with whether card is removable or not, do you think so?

Thanks a lot.

>
> Regards,
>
> Bing
>
