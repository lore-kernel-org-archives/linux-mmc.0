From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [RESEND PATCH] mmc: sdhci: fix wakeup configuration
Date: Fri, 13 May 2016 14:19:32 +0200
Message-ID: <20160513121932.GS27024@odux.rfo.atmel.com>
References: <1463131622-6380-1-git-send-email-ludovic.desroches@atmel.com>
 <5735BC71.4020500@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:9283 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbcEMMTc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2016 08:19:32 -0400
Content-Disposition: inline
In-Reply-To: <5735BC71.4020500@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, Kevin Liu <kliu5@marvell.com>, Jialing Fu <jlfu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>

On Fri, May 13, 2016 at 02:37:21PM +0300, Adrian Hunter wrote:
> + cc some Marvell people because they added this code
> 
> On 13/05/16 12:27, Ludovic Desroches wrote:
> > Activating wakeup event is not enough to get a wakeup signal. The
> > corresponding events have to be enabled in the Interrupt Status Enable
> > Register too.
> 
> That seems to follow the specification.  Did you find that you actually
> needed this change to get it to work?
> 

Yes, I din't wake up on card event without this patch.

> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > ---
> > Hi,
> > 
> > I just updated sdhci_enable_irq_wakeups() not sdhci_disable_irq_wakeups()
> > because I don't think it is necessary to configure SDHCI_INT_ENABLE at this
> > step, it will be done with sdhci_init() or sdhci_enable_card_detection().
> 
> OK, but that should be in the commit message and commented in the code too.

I'll add it.

> 
> > 
> > While I was writing this patch, several questions came to my mind:
> > - Is the naming correct? wakeup signal is not an irq. 'enable_irq_wakeups' can
> >   be a bit confusing.
> 
> I don't support renaming things unless the names are really really bad.
> These names are OK.
> 
> > - If we want to wakeup from irq, we may have to set SDHCI_INT_ENABLE and
> >   SDHCI_SIGNAL_ENABLE and not rely on a previous configuration, isn't it?
> 
> I imagine the card interrupt will occur when it is enabled.  I don't know
> about card insert / remove.
> 
> What works for you?
> 

I only use wakeup events and not irqs in system PM (patches for
sdhci-of-at91 are not sent yet, I am waiting for the inclusion of other
patches).

What I mean is that if we want to wake up from irqs, it could be safer and
clearer to set explicitely SDHCI_INT_ENABLE and SDHCI_SIGNAL_ENABLE in
sdhci_enable_irq_wakeups(). It is just a thought and not needed for this
patch.

> > 
> > Regards
> > 
> > Ludovic
> > 
> >  drivers/mmc/host/sdhci.c | 26 ++++++++++++++++++--------
> >  1 file changed, 18 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index b284924..6fc69ed 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -2638,18 +2638,28 @@ static irqreturn_t sdhci_thread_irq(int irq, void *dev_id)
> >  \*****************************************************************************/
> >  
> >  #ifdef CONFIG_PM
> > +/*
> > + * To enable wakeup events, the corresponding events have to be enabled in
> > + * the Interrupt Status Enable register too. See 'Table 1-6: Wakeup Signal
> > + * Table' in the SD Host Controller Standard Specification.
> > + */
> >  void sdhci_enable_irq_wakeups(struct sdhci_host *host)
> >  {
> > -	u8 val;
> > -	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
> > -			| SDHCI_WAKE_ON_INT;
> > +	u8 wakeup_val;
> > +	u8 wakeup_mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE |
> > +			 SDHCI_WAKE_ON_INT;
> 
> Please don't rename variables, or tidy-up code that you are not changing.
> 

I thought it will be better to have wakeup_val and irq_val instead of
val and irq_val. That's why I renamed it while introducing irq_val.

> > +	u32 irq_val = SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE |
> > +		      SDHCI_INT_CARD_INT;
> >  
> > -	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
> > -	val |= mask ;
> 
> These 2 line are actually unchanged.
> 
> > +	wakeup_val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
> > +	wakeup_val |= wakeup_mask;
> >  	/* Avoid fake wake up */
> > -	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> > -		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
> > -	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
> > +	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) {
> > +		wakeup_val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
> > +		irq_val &= ~(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
> > +	}
> > +	sdhci_writeb(host, wakeup_val, SDHCI_WAKE_UP_CONTROL);
> > +	sdhci_writel(host, irq_val, SDHCI_INT_ENABLE);
> >  }
> >  EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
> >  
> > 
> 
