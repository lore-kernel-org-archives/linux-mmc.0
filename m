From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH] mmc: dw_mmc: add support for use_hold_reg
Date: Fri, 14 Dec 2012 10:12:03 -0600
Message-ID: <1355501523.24619.4.camel@dinh-ubuntu>
References: <1355428991-4602-1-git-send-email-dinguyen@altera.com>
	 <50CA65B2.9040709@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe001.messaging.microsoft.com ([216.32.181.181]:29896
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756417Ab2LNQMW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Dec 2012 11:12:22 -0500
In-Reply-To: <50CA65B2.9040709@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: cjb@laptop.org, dinh.linux@gmail.com, linux-mmc@vger.kernel.org, tgih.jun@samsung.com, thomas.abraham@linaro.org, kyungmin.park@samsung.com, james.hogan@imgtec.com

On Fri, 2012-12-14 at 08:33 +0900, Jaehoon Chung wrote:
> Hi Dinh,
> 
> According to  DesignWare Spec, we need to check which bus-mode use.
> You can refer to "https://patchwork.kernel.org/patch/1379521/".
> I know that hold_reg didn't use always, although hold_reg is set.

Hi Jaehoon,

Thanks for the info. So then my question is what is the correct way to
add support for use_hold_reg?

Our implementation of the IP is using the use_hold_reg in its default
state. The driver taken as is did not work.

Should we be adding a similar file dw_mmc-exynos.c to add this?

Thanks,

Dinh
> 
> Best Regards,
> Jaehoon Chung
> 
> On 12/14/2012 05:03 AM, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add code to read value of the use_hold_reg in the cmd register so that
> > the cmdflags can be correct.
> > 
> > Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> > ---
> >  drivers/mmc/host/dw_mmc.c  |    6 ++++++
> >  drivers/mmc/host/dw_mmc.h  |    1 +
> >  include/linux/mmc/dw_mmc.h |    3 +++
> >  3 files changed, 10 insertions(+)
> > 
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > index 323c502..490490b 100644
> > --- a/drivers/mmc/host/dw_mmc.c
> > +++ b/drivers/mmc/host/dw_mmc.c
> > @@ -265,6 +265,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
> >  	if (drv_data && drv_data->prepare_command)
> >  		drv_data->prepare_command(slot->host, &cmdr);
> >  
> > +	if (slot->host->use_hold_reg)
> > +		cmdr |= SDMMC_CMD_USE_HOLD_REG;
> > +
> >  	return cmdr;
> >  }
> >  
> > @@ -2183,6 +2186,9 @@ int dw_mci_probe(struct dw_mci *host)
> >  		host->data_shift = 2;
> >  	}
> >  
> > +	/* Get the USE_HOLD_REG */
> > +	host->use_hold_reg = mci_readl(host, CMD) & SDMMC_CMD_USE_HOLD_REG;
> > +
> >  	/* Reset all blocks */
> >  	if (!mci_wait_reset(host->dev, host))
> >  		return -ENODEV;
> > diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> > index 53b8fd9..6172900 100644
> > --- a/drivers/mmc/host/dw_mmc.h
> > +++ b/drivers/mmc/host/dw_mmc.h
> > @@ -111,6 +111,7 @@
> >  #define SDMMC_INT_ERROR			0xbfc2
> >  /* Command register defines */
> >  #define SDMMC_CMD_START			BIT(31)
> > +#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
> >  #define SDMMC_CMD_CCS_EXP		BIT(23)
> >  #define SDMMC_CMD_CEATA_RD		BIT(22)
> >  #define SDMMC_CMD_UPD_CLK		BIT(21)
> > diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> > index 34be4f4..36cab8a 100644
> > --- a/include/linux/mmc/dw_mmc.h
> > +++ b/include/linux/mmc/dw_mmc.h
> > @@ -187,6 +187,9 @@ struct dw_mci {
> >  	struct regulator	*vmmc;	/* Power regulator */
> >  	unsigned long		irq_flags; /* IRQ flags */
> >  	int			irq;
> > +
> > +	/* Set to one for SDR12 and SDR25 */
> > +	unsigned int use_hold_reg;
> >  };
> >  
> >  /* DMA ops for Internal/External DMAC interface */
> > 
> 
> 



