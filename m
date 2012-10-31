From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
Date: Wed, 31 Oct 2012 02:23:05 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C2042CA@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1351584769-16662-1-git-send-email-r66093@freescale.com>
	<1351584769-16662-2-git-send-email-r66093@freescale.com>
 <CAGxe1ZEs=3Y9+mdvt1kp2oQ4DXAdUqC0crH2oZAi-j3DKCbAPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe005.messaging.microsoft.com ([65.55.88.15]:48073 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932973Ab2JaCXM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 30 Oct 2012 22:23:12 -0400
In-Reply-To: <CAGxe1ZEs=3Y9+mdvt1kp2oQ4DXAdUqC0crH2oZAi-j3DKCbAPA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>



Best Regards
Jerry Huang


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Girish K S
> Sent: Tuesday, October 30, 2012 7:35 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Anton Vorontsov;
> Chris Ball
> Subject: Re: [PATCH 2/4 v4] MMC/SD: Add callback function to detect card
> 
> On 30 October 2012 13:42,  <r66093@freescale.com> wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > In order to check whether the card has been removed, the function
> > mmc_send_status() will send command CMD13 to card and ask the card
> > to send its status register to sdhc driver, which will generate
> > many interrupts repeatedly and make the system performance bad.
> >
> > Therefore, add callback function get_cd() to check whether
> > the card has been removed when the driver has this callback function.
> >
> > If the card is present, 1 will return, if the card is absent, 0 will
> return.
> > If the controller will not support this feature, -ENOSYS will return.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Anton Vorontsov <cbouatmailru@gmail.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---
> > changes for v2:
> >         - when controller don't support get_cd, return -ENOSYS
> >         - add the CC
> > changes for v3:
> >         - enalbe the controller clock in platform, instead of core
> > changes for v4:
> >         - move the detect code to core.c according to the new structure
> >
> >  drivers/mmc/core/core.c |   10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 9c162cd..6412355 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -2073,7 +2073,7 @@ static int mmc_rescan_try_freq(struct mmc_host
> *host, unsigned freq)
> >
> >  int _mmc_detect_card_removed(struct mmc_host *host)
> >  {
> > -       int ret;
> > +       int ret = -ENOSYS;
> >
> >         if ((host->caps & MMC_CAP_NONREMOVABLE) || !host->bus_ops-
> >alive)
> >                 return 0;
> > @@ -2081,7 +2081,13 @@ int _mmc_detect_card_removed(struct mmc_host
> *host)
> >         if (!host->card || mmc_card_removed(host->card))
> >                 return 1;
> >
> > -       ret = host->bus_ops->alive(host);
> > +       if (host->ops->get_cd) {
> > +               ret = host->ops->get_cd(host);
> > +               if (ret >= 0)
> > +                       ret = !ret;
> > +       }
> > +       if (ret < 0)
> > +               ret = host->bus_ops->alive(host);
> why should we check for negative here? can move this code into else
> path of   if (host->ops->get_cd).
> >         if (ret) {

I did this comment:
If the card is present, 1 will return, if the card is absent, 0 will return.
If the controller will not support this feature, -ENOSYS will return.

Can't move to other address, because these codes check the card present state.


