From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 5/5] mmc: cavium: Fix probing race with regulator
Date: Wed, 17 May 2017 15:41:12 +0200
Message-ID: <20170517134112.GA6216@hc>
References: <20170516093655.17746-1-jglauber@cavium.com>
 <20170516093655.17746-6-jglauber@cavium.com>
 <CAL_Jsq+wMnNH0oOy7qpycm+4tTu=zYCVzDSuSTSpkfQY85kDEQ@mail.gmail.com>
 <20170516133838.GA20659@hc>
 <CAL_Jsq+p8c-9Sypr6_fAsU2y=uakVhNENJ8XPS0j06Zo=a3caw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam01on0059.outbound.protection.outlook.com ([104.47.32.59]:9202
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750969AbdEQNl2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 17 May 2017 09:41:28 -0400
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+p8c-9Sypr6_fAsU2y=uakVhNENJ8XPS0j06Zo=a3caw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, May 16, 2017 at 09:37:48AM -0500, Rob Herring wrote:
> On Tue, May 16, 2017 at 8:38 AM, Jan Glauber
> <jan.glauber@caviumnetworks.com> wrote:
> > On Tue, May 16, 2017 at 08:07:50AM -0500, Rob Herring wrote:
> >> On Tue, May 16, 2017 at 4:36 AM, Jan Glauber <jglauber@cavium.com> wrote:
> >> > If the regulator probing is not yet finished this driver
> >> > might catch a -EPROBE_DEFER. Returning after this condition
> >> > did not remove the created platform device. On a repeated
> >> > call to the probe function the of_platform_device_create
> >> > fails.
> >> >
> >> > Calling of_platform_device_destroy after EPROBE_DEFER resolves
> >> > this bug.
> >> >
> >> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> >> > ---
> >> >  drivers/mmc/host/cavium-thunderx.c | 4 +++-
> >> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >> >
> >> > diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> >> > index fe3d772..257535e 100644
> >> > --- a/drivers/mmc/host/cavium-thunderx.c
> >> > +++ b/drivers/mmc/host/cavium-thunderx.c
> >> > @@ -137,8 +137,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
> >> >                                 continue;
> >> >
> >> >                         ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
> >> > -                       if (ret)
> >> > +                       if (ret) {
> >> > +                               of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
> >>
> >> What if this fails after the 1st iteration of the loop. It's only
> >> cleaning up the current device.
> >
> > The platform device is just a dummy device created directly before
> > cvm_mmc_of_slot_probe(). So there is no need to cleanup anything else.
> 
> So if you have 2 slots, the first slot probes successfully and the 2nd
> slot defers, then you only need to clean-up the 2nd device/slot? Looks
> to me like you are leaking the 1st device you alloc.

OK, got it now. My assumption was that your scenario can't happen in
reality with EPROBE_DEFER.

> >
> > As far as I've seen it the platform code 'tags' the nodes it already
> > used, but I need the same node to be parsed again on -EPROBE_DEFER.
> >
> >> Use devm_of_platform_populate or
> >> of_platform_populate/of_platform_depopulate instead.
> >
> > I'm not sure one of these will work here.
> 
> Those functions loop over child nodes and create devices. You are
> doing the same thing. You'd just need to create all the devices first
> and then probe them all.

I'll take a look at devm_of_platform_populate then. If I can use it it
will solve the leak issue.

thanks,
Jan

> The whole structure here with the dummy devices and how you are
> initializing things is screwy. IMO, you should be creating actual
> drivers for the dummy devices.
> 
> Rob
