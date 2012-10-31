From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
Date: Wed, 31 Oct 2012 02:23:45 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C2042D8@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
 <CAPDyKFqM0cUkDDadm8MBK=+wHHYOSH3CVEHyiY1ybLkmPqSX7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:14963
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753797Ab2JaCXy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Oct 2012 22:23:54 -0400
In-Reply-To: <CAPDyKFqM0cUkDDadm8MBK=+wHHYOSH3CVEHyiY1ybLkmPqSX7w@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>



Best Regards
Jerry Huang


> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Wednesday, October 31, 2012 7:09 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Anton Vorontsov;
> Chris Ball
> Subject: Re: [PATCH 1/4 v3] MMC/core: Add f_min to mmc_power_on()
> 
> On 30 October 2012 09:12,  <r66093@freescale.com> wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > When f_init is zero, the SDHC can't work correctly. So f_min will
> replace
> > f_init, when f_init is zero.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Anton Vorontsov <cbouatmailru@gmail.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---
> > changes for v2:
> >         - add the CC
> > changes for v3:
> >         - enalbe the controller clock in platform, instead of core
> >
> >  drivers/mmc/core/core.c |    5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 06c42cf..9c162cd 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -1319,7 +1319,10 @@ static void mmc_power_up(struct mmc_host *host)
> >          */
> >         mmc_delay(10);
> >
> > -       host->ios.clock = host->f_init;
> > +       if (host->f_init)
> > +               host->ios.clock = host->f_init;
> > +       else
> > +               host->ios.clock = host->f_min;
> 
> This should not be needed. host->f_init should never become zero, I
> believe.
> 
Uh, this patch can be removed.

