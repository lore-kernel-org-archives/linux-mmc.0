From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Wed, 16 Dec 2015 16:48:19 -0600
Message-ID: <1450306099.15946.469.camel@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
	 <1450116253.15946.353.camel@freescale.com>
	 <CAPDyKFrKSMC0uo8re3CxjNCUsVnEMau=GTKq=v_3ooNnQxw2Eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0126.outbound.protection.outlook.com ([207.46.100.126]:4192
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751972AbbLPWs2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 16 Dec 2015 17:48:28 -0500
In-Reply-To: <CAPDyKFrKSMC0uo8re3CxjNCUsVnEMau=GTKq=v_3ooNnQxw2Eg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On Tue, 2015-12-15 at 10:46 +0100, Ulf Hansson wrote:
> [...]
> > > > --- a/drivers/mmc/host/Kconfig
> > > > +++ b/drivers/mmc/host/Kconfig
> > > > @@ -142,6 +142,8 @@ config MMC_SDHCI_OF_ESDHC
> > > >         depends on MMC_SDHCI_PLTFM
> > > >         depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
> > > >         select MMC_SDHCI_IO_ACCESSORS
> > > > +       select SOC_FSL
> > > > +       select FSL_GUTS
> > > 
> > > This is weird.
> > > 
> > > First, perhaps it would make sense to have stub functions for those
> > > the FSL_GUTS driver provides via its API, thus the above wouldn't be
> > > required at all. Of course this makes only sense if you think there
> > > are/could be configurations for a cross SOC driver which don't need
> > > the GUTS driver.
> > > 
> > > Second, even if you think the stubs above is a bad idea, I would from
> > > the top-level Kconfig for your platform, add the needed "selects" as I
> > > think it's where it belongs and then change this to "depends on"
> > > instead.
> > 
> > Why is it weird for a driver to select another driver that it makes calls
> > to?
> >  Much easier to do it here than in all the platforms that use this driver.
> 
> Because using "select" will not consider the dependencies for the new
> selected Kconfig option. I can imagine that it might become a problem,
> sooner or later.

It's not a problem as long as the selected option's dependencies (if any) are
selected, or depended on by the selecting driver.  I wouldn't expect the
FSL_GUTS driver to depend on anything other than basic OF support.

> So, "select" shall be used by care and in this case I think we can
> cope fine with using "depends on".

What does select exist for if not situations like this?  What "care" is
missing?

-Scott

