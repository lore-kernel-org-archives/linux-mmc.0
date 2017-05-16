From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH 5/5] mmc: cavium: Fix probing race with regulator
Date: Tue, 16 May 2017 15:38:38 +0200
Message-ID: <20170516133838.GA20659@hc>
References: <20170516093655.17746-1-jglauber@cavium.com>
 <20170516093655.17746-6-jglauber@cavium.com>
 <CAL_Jsq+wMnNH0oOy7qpycm+4tTu=zYCVzDSuSTSpkfQY85kDEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-sn1nam02on0088.outbound.protection.outlook.com ([104.47.36.88]:44913
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbdEPNi4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 16 May 2017 09:38:56 -0400
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+wMnNH0oOy7qpycm+4tTu=zYCVzDSuSTSpkfQY85kDEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, David Daney <david.daney@cavium.com>, Frank Rowand <frowand.list@gmail.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, May 16, 2017 at 08:07:50AM -0500, Rob Herring wrote:
> On Tue, May 16, 2017 at 4:36 AM, Jan Glauber <jglauber@cavium.com> wrote:
> > If the regulator probing is not yet finished this driver
> > might catch a -EPROBE_DEFER. Returning after this condition
> > did not remove the created platform device. On a repeated
> > call to the probe function the of_platform_device_create
> > fails.
> >
> > Calling of_platform_device_destroy after EPROBE_DEFER resolves
> > this bug.
> >
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  drivers/mmc/host/cavium-thunderx.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/cavium-thunderx.c b/drivers/mmc/host/cavium-thunderx.c
> > index fe3d772..257535e 100644
> > --- a/drivers/mmc/host/cavium-thunderx.c
> > +++ b/drivers/mmc/host/cavium-thunderx.c
> > @@ -137,8 +137,10 @@ static int thunder_mmc_probe(struct pci_dev *pdev,
> >                                 continue;
> >
> >                         ret = cvm_mmc_of_slot_probe(&host->slot_pdev[i]->dev, host);
> > -                       if (ret)
> > +                       if (ret) {
> > +                               of_platform_device_destroy(&host->slot_pdev[i]->dev, NULL);
> 
> What if this fails after the 1st iteration of the loop. It's only
> cleaning up the current device.

The platform device is just a dummy device created directly before
cvm_mmc_of_slot_probe(). So there is no need to cleanup anything else.

As far as I've seen it the platform code 'tags' the nodes it already
used, but I need the same node to be parsed again on -EPROBE_DEFER.

> Use devm_of_platform_populate or
> of_platform_populate/of_platform_depopulate instead.

I'm not sure one of these will work here.

--Jan

> Rob
