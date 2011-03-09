From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 04/12] mmc: sd: add support for driver type selection
Date: Wed, 9 Mar 2011 02:11:23 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300E3A04ECA@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-5-git-send-email-arindam.nath@amd.com>
 <0B2CFFEC-2419-43DF-BC94-C5E343BA23F0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:19713
	"EHLO DB3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752478Ab1CIILr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Mar 2011 03:11:47 -0500
In-Reply-To: <0B2CFFEC-2419-43DF-BC94-C5E343BA23F0@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Wednesday, March 09, 2011 11:04 AM
> To: Nath, Arindam
> Cc: cjb@laptop.org; zhangfei.gao@gmail.com; subhashj@codeaurora.org;
> linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH v2 04/12] mmc: sd: add support for driver type
> selection
> 
> 
> On Mar 4, 2011, at 3:32 AM, Arindam Nath wrote:
> 
> > This patch adds support for setting driver strength during UHS-I
> > initialization prcedure. Since UHS-I cards set S18A (bit 24) in
> > response to ACMD41, we use this as a base for UHS-I initialization.
> > We modify the parameter list of mmc_sd_get_cid() so that we can
> > save the ROCR from ACMD41 to check whether bit 24 is set.
> >
> > We decide whether the Host Controller supports A, C, or D driver
> > type depending on the Capabilities register. We then set the
> > appropriate driver type for the card using CMD6 mode 1. As per
> > Host Controller spec v3.00, we set driver type for the host only
> > if Preset Value Enable in the Host Control2 register is not set.
> > SDHCI_HOST_CONTROL has been renamed to SDHCI_HOST_CONTROL1 to
> > conform to the spec.
> >
> > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > ---
> > drivers/mmc/core/core.c  |    9 +++
> > drivers/mmc/core/core.h  |    1 +
> > drivers/mmc/core/sd.c    |  140
> +++++++++++++++++++++++++++++++++++++---------
> > drivers/mmc/core/sd.h    |    3 +-
> > drivers/mmc/core/sdio.c  |    3 +-
> > drivers/mmc/host/sdhci.c |   48 ++++++++++++----
> > drivers/mmc/host/sdhci.h |   10 +++-
> > include/linux/mmc/card.h |    4 +
> > include/linux/mmc/host.h |    8 +++
> > 9 files changed, 186 insertions(+), 40 deletions(-)
> >
> > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > index 6625c05..daa535a 100644
> > --- a/drivers/mmc/core/core.c
> > +++ b/drivers/mmc/core/core.c
> > @@ -947,6 +947,15 @@ void mmc_set_timing(struct mmc_host *host,
> unsigned int timing)
> > }
> >
> > /*
> > + * Select appropriate driver type for host.
> > + */
> > +void mmc_set_driver_type(struct mmc_host *host, unsigned int
> drv_type)
> > +{
> > +       host->ios.drv_type = drv_type;
> > +       mmc_set_ios(host);
> > +}
> > +
> > +/*
> >  * Apply power to the MMC stack.  This is a two-stage process.
> >  * First, we enable power to the card without the clock running.
> >  * We then wait a bit for the power to stabilise.  Finally,
> > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > index ca1fdde..6114ca5 100644
> > --- a/drivers/mmc/core/core.h
> > +++ b/drivers/mmc/core/core.h
> > @@ -42,6 +42,7 @@ void mmc_set_bus_width_ddr(struct mmc_host *host,
> unsigned int width,
> >                           unsigned int ddr);
> > u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> > void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> > +void mmc_set_driver_type(struct mmc_host *host, unsigned int
> drv_type);
> >
> > static inline void mmc_delay(unsigned int ms)
> > {
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index a63956b..f6a4fab 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -426,6 +426,86 @@ out:
> >        return err;
> > }
> >
> > +static int sd_select_driver_type(struct mmc_card *card, u8 *status)
> > +{
> > +       int host_set_drv_type, card_set_drv_type;
> > +       int err;
> > +
> > +       /*
> > +        * If the host doesn't support any of the Driver Types A,C or
> D,
> > +        * default Driver Type B is used.
> > +        */
> > +       if (!(card->host->caps & (MMC_CAP_DRIVER_TYPE_A |
> MMC_CAP_DRIVER_TYPE_C
> > +           | MMC_CAP_DRIVER_TYPE_D)))
> > +               return 0;
> > +
> > +       if (card->host->caps & MMC_CAP_DRIVER_TYPE_A) {
> > +               host_set_drv_type = MMC_SET_DRIVER_TYPE_A;
> > +               if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_A)
> > +                       card_set_drv_type = MMC_SET_DRIVER_TYPE_A;
> > +               else if (card->sw_caps.uhs_drv_type &
> SD_DRIVER_TYPE_C)
> > +                       card_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > +       } else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
> > +               host_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > +               if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_C)
> > +                       card_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > +       }
> > +
> > +       err = mmc_sd_switch(card, 1, 2, card_set_drv_type, status);
> > +       if (err)
> > +               return err;
> > +
> > +       if ((status[15] & 0xF) != card_set_drv_type)
> > +               printk(KERN_WARNING "%s: Problem setting driver
> strength!\n",
> > +                       mmc_hostname(card->host));
> > +       else
> > +               mmc_set_driver_type(card->host, host_set_drv_type);
> > +
> > +       return 0;
> > +}
> 
> warning when compiling above routine for possible uninitialized
> variables
> > ost_set_drv_type, card_set_drv_type;

Yes, Chris already mentioned about these warnings. These will be fixed in next version of patchset.

> 
> 
> do you want to change the code to add a else ?
> eg
> > +       } else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
> > +               host_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > +               if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_C)
> > +                       card_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > +       }
> 
> 	else {
>                        card_set_drv_type = MMC_SET_DRIVER_TYPE_D;
> 	               host_set_drv_type = MMC_SET_DRIVER_TYPE_D;
> 	}

If none of the if and else-if conditions are met, the controller falls back on default driver type B, so we don't need an else block here.

Thanks,
Arindam

