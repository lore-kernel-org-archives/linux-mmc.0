From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card
	detection on Dove
Date: Fri, 23 Nov 2012 08:57:26 +0000
Message-ID: <20121123085726.GK5764@n2100.arm.linux.org.uk>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk> <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk> <20121123083117.GA25754@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49457 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467Ab2KWJCx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Nov 2012 04:02:53 -0500
Content-Disposition: inline
In-Reply-To: <20121123083117.GA25754@S2100-06.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Nov 23, 2012 at 04:31:20PM +0800, Shawn Guo wrote:
> On Thu, Nov 22, 2012 at 11:55:51PM +0000, Russell King wrote:
> > This commit taken from Rabeeh's Cubox kernel and re-worked for DT;
> > Sebastian Hasselbrath is believed to be the original author.
> > 
> > Some Cuboxes require a GPIO for card detection; this implements the
> > optional GPIO support for card detection.  This GPIO is logic 0 for
> > card inserted.
> > 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  drivers/mmc/host/sdhci-dove.c |   73 +++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 67 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> > index 4af64f3..e621448 100644
> > --- a/drivers/mmc/host/sdhci-dove.c
> > +++ b/drivers/mmc/host/sdhci-dove.c
> > @@ -19,20 +19,30 @@
> >   * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> >   */
> >  
> > -#include <linux/err.h>
> > -#include <linux/io.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > -#include <linux/module.h>
> > +#include <linux/gpio.h>
> > +#include <linux/io.h>
> >  #include <linux/mmc/host.h>
> > +#include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_gpio.h>
> >  
> >  #include "sdhci-pltfm.h"
> >  
> >  struct sdhci_dove_priv {
> >  	struct clk *clk;
> > +	int gpio_cd;
> >  };
> >  
> > +static irqreturn_t sdhci_dove_carddetect_irq(int irq, void *data)
> > +{
> > +	struct sdhci_host *host = data;
> > +
> > +	tasklet_schedule(&host->card_tasklet);
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static u16 sdhci_dove_readw(struct sdhci_host *host, int reg)
> >  {
> >  	u16 ret;
> > @@ -50,16 +60,25 @@ static u16 sdhci_dove_readw(struct sdhci_host *host, int reg)
> >  
> >  static u32 sdhci_dove_readl(struct sdhci_host *host, int reg)
> >  {
> > +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> > +	struct sdhci_dove_priv *priv = pltfm_host->priv;
> >  	u32 ret;
> >  
> > +	ret = readl(host->ioaddr + reg);
> > +
> >  	switch (reg) {
> >  	case SDHCI_CAPABILITIES:
> > -		ret = readl(host->ioaddr + reg);
> >  		/* Mask the support for 3.0V */
> >  		ret &= ~SDHCI_CAN_VDD_300;
> >  		break;
> > -	default:
> > -		ret = readl(host->ioaddr + reg);
> > +	case SDHCI_PRESENT_STATE:
> > +		if (gpio_is_valid(priv->gpio_cd)) {
> > +			if (gpio_get_value(priv->gpio_cd) == 0)
> > +				ret |= SDHCI_CARD_PRESENT;
> > +			else
> > +				ret &= ~SDHCI_CARD_PRESENT;
> > +		}
> > +		break;
> 
> It seems that the helpers in drivers/mmc/core/slot-gpio.c can help to
> simplify the patch a lot.  With sdhci core code being calling
> mmc_gpio_get_cd() to query card present, the fake SDHCI_PRESENT_STATE
> implementation above can be totally saved.

Does this work with the sdhci stuff?  I notice that sdhci does some
special additional resetting of the host when it detects that a card
is removed; this would be lost if that were to be used because the
tasklet in sdhci.c would be bypassed.

So no, I don't think slot-gpio.c can be used here.
