From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4, 5/6] mmc: kconfig: select FSL_GUTS for MMC_SDHCI_OF_ESDHC
Date: Mon, 14 Dec 2015 12:04:13 -0600
Message-ID: <1450116253.15946.353.camel@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-6-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bn0107.outbound.protection.outlook.com ([157.56.110.107]:44056
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752685AbbLNSEW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Dec 2015 13:04:22 -0500
In-Reply-To: <CAPDyKFo1g5_4bpYnTO96tGfVGStysN0FnmbSx-Se4tOa7f3rZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On Mon, 2015-12-14 at 14:08 +0100, Ulf Hansson wrote:
> On 14 December 2015 at 05:24, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> > The sdhci-of-esdhc driver needs the GUTS driver support
> > to access the global utilities registers for SVR value.
> > So we select FSL_GUTS for MMC_SDHCI_OF_ESDHC here.
> > 
> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > ---
> > Changes for v2:
> >         - None
> > Changes for v3:
> >         - None
> > Changes for v4:
> >         - Added this patch
> > ---
> >  drivers/mmc/host/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 1526b8a..df57c14 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -142,6 +142,8 @@ config MMC_SDHCI_OF_ESDHC
> >         depends on MMC_SDHCI_PLTFM
> >         depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
> >         select MMC_SDHCI_IO_ACCESSORS
> > +       select SOC_FSL
> > +       select FSL_GUTS
> 
> This is weird.
> 
> First, perhaps it would make sense to have stub functions for those
> the FSL_GUTS driver provides via its API, thus the above wouldn't be
> required at all. Of course this makes only sense if you think there
> are/could be configurations for a cross SOC driver which don't need
> the GUTS driver.
> 
> Second, even if you think the stubs above is a bad idea, I would from
> the top-level Kconfig for your platform, add the needed "selects" as I
> think it's where it belongs and then change this to "depends on"
> instead.

Why is it weird for a driver to select another driver that it makes calls to? 
 Much easier to do it here than in all the platforms that use this driver.

And I think stubs for reading SVR is quite a bad idea.  It'll make the driver
build but it will silently not be able to apply SVR-based workarounds.

-Scott

