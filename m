From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v2] mmc: sdhci: fix wakeup configuration
Date: Thu, 26 May 2016 14:30:09 +0200
Message-ID: <20160526123009.GA6744@odux.rfo.atmel.com>
References: <1463145362-7773-1-git-send-email-ludovic.desroches@atmel.com>
 <573EF90B.7000109@intel.com>
 <CAPDyKFoqG6pYujivi6Rop4orVLViN7Feq+iB7LXkbx6zURZ=Qw@mail.gmail.com>
 <573F5768.2070708@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:5441 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753262AbcEZMaV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 08:30:21 -0400
Content-Disposition: inline
In-Reply-To: <573F5768.2070708@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ludovic Desroches <ludovic.desroches@atmel.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>

On Fri, May 20, 2016 at 09:28:56PM +0300, Adrian Hunter wrote:
> On 20/05/2016 4:39 p.m., Ulf Hansson wrote:
> > On 20 May 2016 at 13:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > On 13/05/16 16:16, Ludovic Desroches wrote:
> > > > Activating wakeup event is not enough to get a wakeup signal. The
> > > > corresponding events have to be enabled in the Interrupt Status Enable
> > > > Register too. It follows the specification and is needed at least by
> > > > sdhci-of-at91.
> > > > 
> > > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > 
> > > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> > 
> > Is this material for stable and as a fix for 4.6?
> 
> Not as far as I know.
> 

System PM code for the Atmel SDHCI has not been submitted yet so no need
to take it as a fix.

Regards

Ludovic

> > 
> > Kind regards
> > Uffe
> > 
> > > 
> > > 
> > > > ---
> > > >   drivers/mmc/host/sdhci.c | 15 ++++++++++++++-
> > > >   1 file changed, 14 insertions(+), 1 deletion(-)
> > > > 
> > > > Changes:
> > > > - v2:
> > > >    - update commit message and comments
> > > >    - do not rename val and mask variables
> > > > 
> > > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > > index e010ea4..e351859 100644
> > > > --- a/drivers/mmc/host/sdhci.c
> > > > +++ b/drivers/mmc/host/sdhci.c
> > > > @@ -2605,18 +2605,31 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> > > >   \*****************************************************************************/
> > > > 
> > > >   #ifdef CONFIG_PM
> > > > +/*
> > > > + * To enable wakeup events, the corresponding events have to be enabled in
> > > > + * the Interrupt Status Enable register too. See 'Table 1-6: Wakeup Signal
> > > > + * Table' in the SD Host Controller Standard Specification.
> > > > + * It is useless to restore SDHCI_INT_ENABLE state in
> > > > + * sdhci_disable_irq_wakeups() since it will be set by
> > > > + * sdhci_enable_card_detection() or sdhci_init().
> > > > + */
> > > >   void sdhci_enable_irq_wakeups(struct sdhci_host *host)
> > > >   {
> > > >        u8 val;
> > > >        u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
> > > >                        | SDHCI_WAKE_ON_INT;
> > > > +     u32 irq_val = SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
> > > > +                   SDHCI_INT_CARD_INT;
> > > > 
> > > >        val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
> > > >        val |= mask ;
> > > >        /* Avoid fake wake up */
> > > > -     if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> > > > +     if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
> > > >                val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
> > > > +             irq_val &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
> > > > +     }
> > > >        sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
> > > > +     sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
> > > >   }
> > > >   EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
> > > > 
> > > > 
> > > 
