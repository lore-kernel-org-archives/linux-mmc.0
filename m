From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 3/5] mmc: kconfig: select MFD_SYSCON for MMC_SDHCI_OF_ESDHC
Date: Tue, 8 Dec 2015 11:40:16 -0600
Message-ID: <1449596416.15946.123.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-4-git-send-email-yangbo.lu@freescale.com>
	 <CAPDyKFowBMaB1YKD79wE5hr40mO8QufbEW3ZfoNcui708pX81g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0131.outbound.protection.outlook.com ([207.46.100.131]:57609
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751132AbbLHSOE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 8 Dec 2015 13:14:04 -0500
In-Reply-To: <CAPDyKFowBMaB1YKD79wE5hr40mO8QufbEW3ZfoNcui708pX81g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, X.Xie@freescale.com, Li Leo <LeoLi@freescale.com>

On Tue, 2015-12-08 at 14:49 +0100, Ulf Hansson wrote:
> On 27 November 2015 at 04:20, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> > The sdhci-of-esdhc driver needs the syscon support to do
> > regmap and access the global utilities registers. So we
> > select MFD_SYSCON for MMC_SDHCI_OF_ESDHC here.
> > 
> > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > ---
> > Changes for v2:
> >         - None
> > Changes for v3:
> >         - Added this patch
> > ---
> >  drivers/mmc/host/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 1526b8a..4fb88ba 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -142,6 +142,7 @@ config MMC_SDHCI_OF_ESDHC
> >         depends on MMC_SDHCI_PLTFM
> >         depends on PPC || ARCH_MXC || ARCH_LAYERSCAPE
> >         select MMC_SDHCI_IO_ACCESSORS
> > +       select MFD_SYSCON
> 
> Perhaps "depends on" is better to use here.

Plenty of other thing select MFD_SYSCON, and MFD_SYSCON doesn't have any
dependencies.  Why would you torment a user by making them somehow guess (or
dig around to find out) that they need to enable MFD_SYSCON before seeing a
random other driver appear?

-Scott

