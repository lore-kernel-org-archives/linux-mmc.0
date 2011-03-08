From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/3] mmc: skip detection of nonremovable cards on
 rescan - card removal detection regression
Date: Tue, 08 Mar 2011 19:02:15 +0200
Message-ID: <1299603735.3100.0.camel@maxim-laptop>
References: <1290921690-6133-1-git-send-email-ohad@wizery.com>
	 <1290921690-6133-2-git-send-email-ohad@wizery.com>
	 <20101217005123.GD17239@void.printf.net>
	 <AANLkTi=ff=kkaRHOrDyoxOgw_Bt7raiPf3T=ed1=EveZ@mail.gmail.com>
	 <1299205366.4999.3.camel@maxim-laptop>
	 <AANLkTi=8Qi=-Ff1SQwBaxC5xxijMKPKAgFR17UGGTAvS@mail.gmail.com>
	 <AANLkTi=tgV0Qqs+GuLVvF6fcVB2tL1e5aWZsMggTQGfX@mail.gmail.com>
	 <AANLkTin2Ky4sqJCqSePCWBP27Gfo4SdNmr0u16zskPMo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55810 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173Ab1CHRCW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 12:02:22 -0500
Received: by fxm17 with SMTP id 17so5304444fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 09:02:21 -0800 (PST)
In-Reply-To: <AANLkTin2Ky4sqJCqSePCWBP27Gfo4SdNmr0u16zskPMo@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Dmitry Shmidt <dimitrysh@google.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tue, 2011-03-08 at 18:44 +0200, Ohad Ben-Cohen wrote:
> On Mon, Mar 7, 2011 at 9:01 PM, Dmitry Shmidt <dimitrysh@google.com> wrote:
> > On Sat, Mar 5, 2011 at 7:03 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> >> On Fri, Mar 4, 2011 at 4:22 AM, Maxim Levitsky <maximlevitsky@gmail.com> wrote:
> >>> This patch breaks the CONFIG_MMC_UNSAFE_RESUME
> >>
> >> Does the below work for you (untested) ?
> >>
> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> >> index 6625c05..150b5f3 100644
> >> --- a/drivers/mmc/core/core.c
> >> +++ b/drivers/mmc/core/core.c
> >> @@ -1529,7 +1529,7 @@ void mmc_rescan(struct work_struct *work)
> >>         * still present
> >>         */
> >>        if (host->bus_ops && host->bus_ops->detect && !host->bus_dead
> >> -           && mmc_card_is_removable(host))
> >> +           && !(host->caps & MMC_CAP_NONREMOVABLE))
> >>                host->bus_ops->detect(host);
> >>
> >>        /*
> >>
> > This works for me,
> 
> Thanks.
> 
> Maxim, does this work for you too ?

Yep, just tested.

Best regards,
	Maxim Levitsky

