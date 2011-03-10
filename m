From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 10/12] mmc: sdhci: enable preset value after uhs
 initialization
Date: Thu, 10 Mar 2011 08:07:54 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300E3AA2935@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-11-git-send-email-arindam.nath@amd.com>
 <001b01cbdf26$6b865c70$42931550$@org>
 <6C03668EAF45B747AF947A1603D1B300E3AA28F7@SAUSEXMBP01.amd.com>
 <002101cbdf29$6268ce40$273a6ac0$@org>
 <6C03668EAF45B747AF947A1603D1B300E3AA2914@SAUSEXMBP01.amd.com>
 <002701cbdf2b$fba51940$f2ef4bc0$@org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.182]:26545
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751655Ab1CJOIE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 10 Mar 2011 09:08:04 -0500
In-Reply-To: <002701cbdf2b$fba51940$f2ef4bc0$@org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "prakity@marvell.com" <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

> -----Original Message-----
> From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> Sent: Thursday, March 10, 2011 7:34 PM
> To: Nath, Arindam; cjb@laptop.org
> Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: RE: [PATCH v2 10/12] mmc: sdhci: enable preset value after uhs
> initialization
> 
> 
> 
> > -----Original Message-----
> > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > owner@vger.kernel.org] On Behalf Of Nath, Arindam
> > Sent: Thursday, March 10, 2011 7:20 PM
> > To: subhashj@codeaurora.org; cjb@laptop.org
> > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > Subject: RE: [PATCH v2 10/12] mmc: sdhci: enable preset value after
> uhs
> > initialization
> >
> > > -----Original Message-----
> > > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > > Sent: Thursday, March 10, 2011 7:15 PM
> > > To: Nath, Arindam; cjb@laptop.org
> > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > > Subject: RE: [PATCH v2 10/12] mmc: sdhci: enable preset value after
> > uhs
> > > initialization
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > > owner@vger.kernel.org] On Behalf Of Nath, Arindam
> > > > Sent: Thursday, March 10, 2011 7:01 PM
> > > > To: subhashj@codeaurora.org; cjb@laptop.org
> > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > > > Subject: RE: [PATCH v2 10/12] mmc: sdhci: enable preset value
> after
> > > uhs
> > > > initialization
> > > >
> > > > Hi Subhash,
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > > > > Sent: Thursday, March 10, 2011 6:54 PM
> > > > > To: Nath, Arindam; cjb@laptop.org
> > > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > > > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > > > > Subject: RE: [PATCH v2 10/12] mmc: sdhci: enable preset value
> > after
> > > > uhs
> > > > > initialization
> > > > >
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > > > > owner@vger.kernel.org] On Behalf Of Arindam Nath
> > > > > > Sent: Friday, March 04, 2011 5:03 PM
> > > > > > To: cjb@laptop.org
> > > > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
> > > > > > subhashj@codeaurora.org; linux-mmc@vger.kernel.org;
> > > > henry.su@amd.com;
> > > > > > aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> > > > > > Subject: [PATCH v2 10/12] mmc: sdhci: enable preset value
> after
> > > uhs
> > > > > > initialization
> > > > > >
> > > > > > According to the Host Controller spec v3.00, setting Preset
> > Value
> > > > > > Enable
> > > > > > in the Host Control2 register lets SDCLK Frequency Select,
> > Clock
> > > > > > Generator
> > > > > > Select and Driver Strength Select to be set automatically by
> > the
> > > > Host
> > > > > > Controller based on the UHS-I mode set. This patch enables
> this
> > > > > > feature.
> > > > > > We also reset Preset Value Enable when the card is removed
> from
> > > the
> > > > > > slot.
> > > > >
> > > > > What does this preset_value means? Is this defined in SD3.01
> > spec?
> > > I
> > > > > think
> > > > > it looks like specific to your controller (sdhci). If it's
> > specific
> > > > to
> > > > > your
> > > > > controller then this new mmc_ops should not be added.
> > > >
> > > > Preset Value Enable is very much part of the standard SD Host
> > > > Controller spec v3.00. Please refer to Host Control 2 register.
> > >
> > > I don't think all controllers should be compliant to SD host
> > controller
> > > spec. I don't think controller on our chips has something like
> this.
> >
> > But from the spec it looks as if controllers conforming to v3.00
> should
> > provide this feature. There is no other bit anywhere else in the spec
> > which can indicate support for Preset Value Enable except for the
> > controller version number.
> 
> Actually, I am not aware about this controller spec v3.00. can you
> please
> point me to the link for this spec (if it's available)?

The spec is named "SD Host Controller Standard Specification Ver3.00". I think it can be downloaded from sdcard.org, but you will need to pay for the license.

Thanks,
Arindam

> 
> 
> >
> > Thanks,
> > Arindam
> >
> > >
> > > >
> > > > Thanks,
> > > > Arindam
> > > >
> > > > >
> > > > >
> > > > > >
> > > > > > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > > > > > ---
> > > > > >  drivers/mmc/core/sd.c    |    7 +++++++
> > > > > >  drivers/mmc/host/sdhci.c |   36
> > > > ++++++++++++++++++++++++++++++++++++
> > > > > >  include/linux/mmc/host.h |    1 +
> > > > > >  3 files changed, 44 insertions(+), 0 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > > > > index 1e2d157..ae7a771 100644
> > > > > > --- a/drivers/mmc/core/sd.c
> > > > > > +++ b/drivers/mmc/core/sd.c
> > > > > > @@ -962,6 +962,13 @@ static int mmc_sd_init_card(struct
> > mmc_host
> > > > > *host,
> > > > > > u32 ocr,
> > > > > >  		}
> > > > > >  	}
> > > > > >
> > > > > > +	/*
> > > > > > +	 * Since initialization is now complete, enable preset
> > > > > > +	 * value registers.
> > > > > > +	 */
> > > > > > +	if (host->ops->enable_preset_value)
> > > > > > +		host->ops->enable_preset_value(host);
> > > > > > +
> > > > > >  	host->card = card;
> > > > > >  	return 0;
> > > > > >
> > > > > > diff --git a/drivers/mmc/host/sdhci.c
> > b/drivers/mmc/host/sdhci.c
> > > > > > index 8f4f102..1f6e4ad 100644
> > > > > > --- a/drivers/mmc/host/sdhci.c
> > > > > > +++ b/drivers/mmc/host/sdhci.c
> > > > > > @@ -1602,6 +1602,40 @@ out:
> > > > > >  	spin_unlock_irqrestore(&host->lock, flags);
> > > > > >  }
> > > > > >
> > > > > > +static void sdhci_enable_preset_value(struct mmc_host *mmc)
> > > > > > +{
> > > > > > +	struct sdhci_host *host;
> > > > > > +	u16 ctrl;
> > > > > > +	unsigned long flags;
> > > > > > +
> > > > > > +	host = mmc_priv(mmc);
> > > > > > +
> > > > > > +	/* Host Controller v3.00 defines preset value registers */
> > > > > > +	if (host->version < SDHCI_SPEC_300)
> > > > > > +		return;
> > > > > > +
> > > > > > +	spin_lock_irqsave(&host->lock, flags);
> > > > > > +
> > > > > > +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > > > > +	ctrl |= SDHCI_CTRL_PRESET_VAL_ENABLE;
> > > > > > +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > > > > > +
> > > > > > +	spin_unlock_irqrestore(&host->lock, flags);
> > > > > > +}
> > > > > > +
> > > > > > +static void sdhci_disable_preset_value(struct sdhci_host
> > *host)
> > > > > > +{
> > > > > > +	u16 ctrl;
> > > > > > +
> > > > > > +	/* Only for Host Controller version >= v3.00 */
> > > > > > +	if (host->version < SDHCI_SPEC_300)
> > > > > > +		return;
> > > > > > +
> > > > > > +	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > > > > +	ctrl &= ~SDHCI_CTRL_PRESET_VAL_ENABLE;
> > > > > > +	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > > > > > +}
> > > > > > +
> > > > > >  static const struct mmc_host_ops sdhci_ops = {
> > > > > >  	.request	= sdhci_request,
> > > > > >  	.set_ios	= sdhci_set_ios,
> > > > > > @@ -1610,6 +1644,7 @@ static const struct mmc_host_ops
> > sdhci_ops
> > > =
> > > > {
> > > > > >  	.start_signal_voltage_switch	=
> > > > > > sdhci_start_signal_voltage_switch,
> > > > > >  	.get_max_current_180		= sdhci_get_max_current_180,
> > > > > >  	.execute_tuning			= sdhci_execute_tuning,
> > > > > > +	.enable_preset_value		= sdhci_enable_preset_value,
> > > > > >  };
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > >
> > >
> >
> /**********************************************************************
> > > > > > *******\
> > > > > > @@ -1920,6 +1955,7 @@ static irqreturn_t sdhci_irq(int irq,
> > void
> > > > > > *dev_id)
> > > > > >  		sdhci_writel(host, intmask & (SDHCI_INT_CARD_INSERT
> |
> > > > > >  			SDHCI_INT_CARD_REMOVE), SDHCI_INT_STATUS);
> > > > > >  		tasklet_schedule(&host->card_tasklet);
> > > > > > +		sdhci_disable_preset_value(host);
> > > > > >  	}
> > > > > >
> > > > > >  	intmask &= ~(SDHCI_INT_CARD_INSERT |
> > > SDHCI_INT_CARD_REMOVE);
> > > > > > diff --git a/include/linux/mmc/host.h
> > b/include/linux/mmc/host.h
> > > > > > index 651e40b..e63e063 100644
> > > > > > --- a/include/linux/mmc/host.h
> > > > > > +++ b/include/linux/mmc/host.h
> > > > > > @@ -130,6 +130,7 @@ struct mmc_host_ops {
> > > > > >  	int	(*start_signal_voltage_switch)(struct mmc_host
> > > *host);
> > > > > >  	int	(*get_max_current_180)(struct mmc_host *mmc);
> > > > > >  	void	(*execute_tuning)(struct mmc_host *host);
> > > > > > +	void	(*enable_preset_value)(struct mmc_host *host);
> > > > > >  };
> > > > > >
> > > > > >  struct mmc_card;
> > > > > > --
> > > > > > 1.7.1
> > > > > >
> > > > > > --
> > > > > > To unsubscribe from this list: send the line "unsubscribe
> > linux-
> > > > mmc"
> > > > > in
> > > > > > the body of a message to majordomo@vger.kernel.org
> > > > > > More majordomo info at  http://vger.kernel.org/majordomo-
> > > info.html
> > > > >
> > > >
> > > >
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-
> > mmc"
> > > in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-
> info.html
> > >
> >
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


