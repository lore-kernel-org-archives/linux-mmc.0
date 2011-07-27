From: Philip Rakity <prakity@marvell.com>
Subject: RE: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in
 sdhci_tasklet_finish
Date: Wed, 27 Jul 2011 07:56:53 -0700
Message-ID: <43E4817426ED174AA81263BCECB4351D134D9ED97E@sc-vexch3.marvell.com>
References: <1310362031-8186-1-git-send-email-Aaron.Lu@amd.com>
 <6C03668EAF45B747AF947A1603D1B300018F85B9E0@SAUSEXMBP01.amd.com>
 <20110721052358.GA31584@lovegaga>
 <CAMj5BkhT2-mybTHTVxXm1TG0w=Ap34etwKgxg3QVVzohaZWupA@mail.gmail.com>
 <20110721100351.GA31886@lovegaga>
 <CAMj5BkjnskRO=HwmbPgjuOZ2VWyoVp=8ViWw8j22Y7M8oC8Kig@mail.gmail.com>,<20110727091549.GC3340@lovegaga>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:41159 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751491Ab1G0O7I convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jul 2011 10:59:08 -0400
In-Reply-To: <20110727091549.GC3340@lovegaga>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>, zhangfei gao <zhangfei.gao@gmail.com>
Cc: "Nath, Arindam" <Arindam.Nath@amd.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Reviewed-by: Philip Rakity  <prakity@marvell.com>
________________________________________
From: Aaron Lu [aaron.lu@amd.com]
Sent: Wednesday, July 27, 2011 2:15 AM
To: zhangfei gao; Philip Rakity
Cc: Nath, Arindam; Chris Ball; linux-mmc@vger.kernel.org
Subject: Re: [PATCH] mmc: sdhci: fix retuning timer wrongly deleted in sdhci_tasklet_finish

On Fri, Jul 22, 2011 at 06:21:11PM +0800, zhangfei gao wrote:
>
> Thanks for explanation, looks good to me.
>

Hi Philip & Zhangfei,

Can I have your reviewed-by tag in the patch?

Thanks,
Aaron

> >> >> >
> >> >> > Signed-off-by: Aaron Lu <Aaron.Lu@amd.com>
> >> >> > ---
> >> >> >  drivers/mmc/host/sdhci.c |    3 ---
> >> >> >  1 files changed, 0 insertions(+), 3 deletions(-)
> >> >> >
> >> >> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> >> > index 91d9892..6250bac 100644
> >> >> > --- a/drivers/mmc/host/sdhci.c
> >> >> > +++ b/drivers/mmc/host/sdhci.c
> >> >> > @@ -1863,9 +1863,6 @@ static void sdhci_tasklet_finish(unsigned long
> >> >> > param)
> >> >> >
> >> >> >     del_timer(&host->timer);
> >> >> >
> >> >> > -   if (host->version >= SDHCI_SPEC_300)
> >> >> > -           del_timer(&host->tuning_timer);
> >> >> > -
> >> >> >     mrq = host->mrq;
> >> >> >
> >> >> >     /*
> >> >> > --
> >> >> > 1.7.1
> >> >>
> >> >>
> >> >
> >> >
> >>
> >
> >
>

