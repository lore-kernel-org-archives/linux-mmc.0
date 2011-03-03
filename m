From: <subhashj@codeaurora.org>
Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage switch procedure
Date: Thu, 3 Mar 2011 18:46:09 +0530
Message-ID: <000001cbd9a5$2be1a330$83a4e990$@org>
References: <1297762510-2696-1-git-send-email-arindam.nath@amd.com> <1297762510-2696-3-git-send-email-arindam.nath@amd.com> <000301cbd82a$19ef2480$4dcd6d80$@org> <6C03668EAF45B747AF947A1603D1B300E35EF3F4@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:14593 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab1CCNQP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2011 08:16:15 -0500
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300E35EF3F4@SAUSEXMBP01.amd.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'Nath, Arindam'" <Arindam.Nath@amd.com>, cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, "'Su, Henry'" <Henry.Su@amd.com>, "'Lu, Aaron'" <Aaron.Lu@amd.com>, anath.amd@gmail.com



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Nath, Arindam
> Sent: Wednesday, March 02, 2011 1:36 PM
> To: subhashj@codeaurora.org; cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> anath.amd@gmail.com
> Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage
> switch procedure
> 
> Hi Subhash,
> 
> 
> > -----Original Message-----
> > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > Sent: Tuesday, March 01, 2011 9:33 PM
> > To: Nath, Arindam; cjb@laptop.org
> > Cc: linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron;
> > anath.amd@gmail.com
> > Subject: RE: [PATCH 02/12] mmc: sd: add support for signal voltage
> > switch procedure
> >
> >
> >
> > > -----Original Message-----
> > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > owner@vger.kernel.org] On Behalf Of Arindam Nath
> > > Sent: Tuesday, February 15, 2011 3:05 PM
> > > To: cjb@laptop.org
> > > Cc: linux-mmc@vger.kernel.org; henry.su@amd.com; aaron.lu@amd.com;
> > > anath.amd@gmail.com; Arindam Nath
> > > Subject: [PATCH 02/12] mmc: sd: add support for signal voltage
> switch
> > > procedure
> > >
> > > Host Controller v3.00 adds another Capabilities register. We can
> > > directly read this register without any version checking since the
> > > new register bits will be considred as reserved in older
> controllers,
> > > and will be read as 0. Apart from other things, this new register
> > > indicates whether the Host Controller supports SDR50, SDR104, and
> > > DDR50 UHS-I modes. So depending on the host support, we set
> > > the corresponding MMC_CAP_* flags. One more new register. Host
> > Control2
> > > is added in v3.00, which is used during Signal Voltage Switch
> > prcedure
> > > described below.
> > >
> > > Since as per v3.00 spec, UHS-I supported hosts should set S18R to
> 1,
> > > we set S18R (bit 24) of OCR before sending ACMD41. We also need to
> > set
> > > XPC (bit 28) of OCR in case the host can supply >150mA. This
> support
> > is
> > > indicated by the Maximum Current Capabilities register of the Host
> > > Controller.
> > >
> > > If the response of ACMD41 has both CCS and S18A set, we start the
> > > signal voltage switch procedure, which if successfull, will switch
> > > the card from 3.3V signalling to 1.8V signalling. Signal voltage
> > > switch procedure adds support for a new command CMD11 in the
> Physical
> > > Layer Spec v3.01. As part of this procedure, we need to set 1.8V
> > > Signalling
> > > Enable (bit 3) of Host Control2 register, which if remains set
> after
> > > 5ms,
> > > means the switch to 1.8V signalling is successfull. Otherwise, we
> > clear
> > > bit 24 of OCR and retry the initialization sequence.
> > >
> > > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > > ---
> > >  drivers/mmc/core/sd.c     |   37 ++++++++++-
> > >  drivers/mmc/core/sd_ops.c |   25 ++++++++
> > >  drivers/mmc/core/sd_ops.h |    1 +
> > >  drivers/mmc/host/sdhci.c  |  147
> > > +++++++++++++++++++++++++++++++++++++++++----
> > >  drivers/mmc/host/sdhci.h  |   18 +++++-
> > >  include/linux/mmc/host.h  |    8 +++
> > >  include/linux/mmc/sd.h    |    1 +
> > >  7 files changed, 219 insertions(+), 18 deletions(-)
> > >
> > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > index b3f8a3c..e968d5c 100644
> > > --- a/drivers/mmc/core/sd.c
> > > +++ b/drivers/mmc/core/sd.c
> > > @@ -408,6 +408,7 @@ struct device_type sd_type = {
> > >  int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> > >  {
> > >     int err;
> > > +   u32 rocr;
> > >
> > >     /*
> > >      * Since we're changing the OCR value, we seem to
> > > @@ -427,10 +428,25 @@ int mmc_sd_get_cid(struct mmc_host *host, u32
> > > ocr, u32 *cid)
> > >     if (!err)
> > >             ocr |= 1 << 30;
> > >
> > > -   err = mmc_send_app_op_cond(host, ocr, NULL);
> > > +   /* If the host can supply more than 150mA, XPC should be set to
> > > 1. */
> > > +   if (host->caps & (MMC_CAP_SET_XPC_330 | MMC_CAP_SET_XPC_300 |
> > > +       MMC_CAP_SET_XPC_180))
> > > +           ocr |= 1 << 28;
> > > +
> >
> > Why do you need MMC_CAP_SET_XPC_300 here? MMC_CAP_SET_XPC_330 &
> > MMC_CAP_SET_XPC_180 is not enough?
> 
> According to the Host Controller Spec v3.00, section 2.2.26:
> 
> "If a Host System can afford more than 150mA, Host Driver set XPC to
> 1."
> 
> Now since >150mA can be set for 1.8V, 3.0V and 3.3V, the above
> condition checks for all these cases.
> 

3.0v and 3.3v is part of High voltage range supported by card (2.7v-3.3v).
Now if host supports any voltage from this range with 150ma driver strength 
then I think only config say MMC_CAP_SET_XPC_HV (high voltage) should be set
by
host and then only one check required here. Does it make sense?


> >
> > > +   err = mmc_send_app_op_cond(host, ocr, &rocr);
> > >     if (err)
> > >             return err;
> > >
> > > +   /*
> > > +    * In case CCS and S18A in the response is set, start Signal
> > > Voltage
> > > +    * Switch procedure. SPI mode doesn't support CMD11.
> > > +    */
> > > +   if (!mmc_host_is_spi(host) && (rocr & 0x41000000)) {
> > > +           err = mmc_start_voltage_switch(host);
> > > +           if (err)
> > > +                   return err;
> > > +   }
> > > +
> >
> > Looks good.
> >
> > >     if (mmc_host_is_spi(host))
> > >             err = mmc_send_cid(host, cid);
> > >     else
> > > @@ -827,11 +843,26 @@ int mmc_attach_sd(struct mmc_host *host)
> > >     }
> > >
> > >     /*
> > > +    * If the host supports one of UHS-I modes, request the card
> > > +    * to switch to 1.8V signaling level.
> > > +    */
> > > +   if (host->caps & (MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
> > > +       MMC_CAP_UHS_DDR50))
> > > +           host->ocr |= (1 << 24);
> >
> > What about SDR12 and SDR25 modes? Are we ignoring them?
> 
> Yes, point noted. I will fix this in V2. Thanks.
> 
> >
> > > +
> > > +   /*
> > >      * Detect and init the card.
> > >      */
> > >     err = mmc_sd_init_card(host, host->ocr, NULL);
> > > -   if (err)
> > > -           goto err;
> > > +   if (err == -EAGAIN) {
> > > +           /*
> > > +            * Retry initialization with S18R set to 0.
> > > +            */
> > > +           host->ocr &= ~(1 << 24);
> > > +           err = mmc_sd_init_card(host, host->ocr, NULL);
> > > +           if (err)
> > > +                   goto err;
> > > +   }
> > >
> > >     mmc_release_host(host);
> > >     err = mmc_add_card(host->card);
> > > diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> > > index 797cdb5..a0f97c9 100644
> > > --- a/drivers/mmc/core/sd_ops.c
> > > +++ b/drivers/mmc/core/sd_ops.c
> > > @@ -146,6 +146,31 @@ int mmc_app_set_bus_width(struct mmc_card
> *card,
> > > int width)
> > >     return 0;
> > >  }
> > >
> > > +int mmc_start_voltage_switch(struct mmc_host *host)
> > > +{
> > > +   struct mmc_command cmd;
> > > +   int err;
> > > +
> > > +   BUG_ON(!host);
> > > +
> > > +   memset(&cmd, 0, sizeof(struct mmc_command));
> > > +
> > > +   cmd.opcode = SD_SWITCH_VOLTAGE;
> > > +   cmd.arg = 0;
> > > +   cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
> > > +
> > > +   err = mmc_wait_for_cmd(host, &cmd, 0);
> > > +   if (err)
> > > +           return err;
> > > +
> > > +   if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
> > > +           return -EIO;
> > > +
> > > +   err = host->ops->start_signal_voltage_switch(host);
> >
> > No Null check for start_signal_voltage_switch ops?
> 
> Will fix this in V2.
> 
> >
> > > +
> > > +   return err;
> > > +}
> > > +
> > >  int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32
> *rocr)
> > >  {
> > >     struct mmc_command cmd;
> > > diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> > > index ffc2305..3cfba59 100644
> > > --- a/drivers/mmc/core/sd_ops.h
> > > +++ b/drivers/mmc/core/sd_ops.h
> > > @@ -20,6 +20,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32
> > > *scr);
> > >  int mmc_sd_switch(struct mmc_card *card, int mode, int group,
> > >     u8 value, u8 *resp);
> > >  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
> > > +int mmc_start_voltage_switch(struct mmc_host *host);
> > >
> > >  #endif
> > >
> > > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > > index 0b537cf..6d7a276 100644
> > > --- a/drivers/mmc/host/sdhci.c
> > > +++ b/drivers/mmc/host/sdhci.c
> > > @@ -87,6 +87,8 @@ static void sdhci_dumpregs(struct sdhci_host
> *host)
> > >     printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr:
> > > 0x%08x\n",
> > >             sdhci_readw(host, SDHCI_COMMAND),
> > >             sdhci_readl(host, SDHCI_MAX_CURRENT));
> > > +   printk(KERN_DEBUG DRIVER_NAME ": Host ctl2: 0x%08x\n",
> > > +           sdhci_readw(host, SDHCI_HOST_CONTROL2));
> > >
> > >     if (host->flags & SDHCI_USE_ADMA)
> > >             printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x |
> ADMA
> > > Ptr: 0x%08x\n",
> > > @@ -1340,11 +1342,76 @@ out:
> > >     spin_unlock_irqrestore(&host->lock, flags);
> > >  }
> > >
> > > +static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc)
> > > +{
> > > +   struct sdhci_host *host;
> > > +   u8 pwr;
> > > +   u16 clk, ctrl;
> > > +   u32 present_state;
> > > +   unsigned long flags;
> > > +
> > > +   host = mmc_priv(mmc);
> > > +
> > > +   spin_lock_irqsave(&host->lock, flags);
> > > +
> > > +   /* Stop SDCLK */
> > > +   host = mmc_priv(mmc);
> > > +   clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > +   clk &= ~SDHCI_CLOCK_CARD_EN;
> > > +   sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > +
> > > +   /* Check whether DAT[3:0] is 0000 */
> > > +   present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
> > > +   if (!((present_state & SDHCI_DATA_LVL_MASK) >>
> > > SDHCI_DATA_LVL_SHIFT)) {
> > > +           /* Enable 1.8V Signal Enable in the Host Control2
> register
> > > */
> > > +           ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +           ctrl |= SDHCI_CTRL_VDD_180;
> > > +           sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
> > > +
> > > +           /* Wait for 5ms */
> > > +           mdelay(5);
> >
> > msleep would be more appropriate here.
> 
> Nicolas already commented on this one. I will take care of it in V2.
> 
> >
> > > +
> > > +           ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > +           if (ctrl & SDHCI_CTRL_VDD_180) {
> > > +                   /* Provide SDCLK again and wait for 1ms*/
> > > +                   clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > > +                   clk |= SDHCI_CLOCK_CARD_EN;
> > > +                   sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > +                   mdelay(1);
> > > +
> > > +                   /*
> > > +                    * If DAT[3:0] level is 1111b, then the card
> was
> > > +                    * successfully switched to 1.8V signaling.
> > > +                    */
> > > +                   present_state = sdhci_readl(host,
> > > SDHCI_PRESENT_STATE);
> > > +                   if ((present_state & SDHCI_DATA_LVL_MASK) ==
> > > +                        SDHCI_DATA_LVL_MASK) {
> > > +                           spin_unlock_irqrestore(&host->lock,
> flags);
> > > +                           return 0;
> > > +                   }
> >
> > Sequence looks fine according to spec.
> >
> >
> > > +           }
> > > +   }
> > > +
> > > +   /*
> > > +    * If we are here, that means the switch to 1.8V signaling
> > > failed. Stop
> > > +    * power to the card, and retry initialization sequence by
> > > setting S18R
> > > +    * to 0.
> > > +    */
> > > +   pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
> > > +   pwr &= ~SDHCI_POWER_ON;
> > > +   sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> > > +
> > > +   spin_unlock_irqrestore(&host->lock, flags);
> > > +
> > > +   return -EAGAIN;
> > > +}
> > > +
> > >  static const struct mmc_host_ops sdhci_ops = {
> > >     .request        = sdhci_request,
> > >     .set_ios        = sdhci_set_ios,
> > >     .get_ro         = sdhci_get_ro,
> > >     .enable_sdio_irq = sdhci_enable_sdio_irq,
> > > +   .start_signal_voltage_switch    =
> > > sdhci_start_signal_voltage_switch,
> > >  };
> >
> > If possible can you shorthand ops name "start_signal_voltage_switch"?
> 
> I wanted the name to be descriptive, so couldn't think of anything
> else. Can you suggest something?

I cannot think of other name. you can keep this name unless someone suggest
Better name.


> 
> >
> >
> > >
> > >
> > >
> >
> /**********************************************************************
> > > *******\
> > > @@ -1802,7 +1869,9 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> > >  int sdhci_add_host(struct sdhci_host *host)
> > >  {
> > >     struct mmc_host *mmc;
> > > -   unsigned int caps, ocr_avail;
> > > +   u32 caps[2];
> > > +   u32 max_current_caps;
> > > +   unsigned int ocr_avail;
> > >     int ret;
> > >
> > >     WARN_ON(host == NULL);
> > > @@ -1825,12 +1894,13 @@ int sdhci_add_host(struct sdhci_host *host)
> > >                     host->version);
> > >     }
> > >
> > > -   caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
> > > +   caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host-
> >caps
> > > :
> > >             sdhci_readl(host, SDHCI_CAPABILITIES);
> > > +   caps[1] = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> > >
> > >     if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> > >             host->flags |= SDHCI_USE_SDMA;
> > > -   else if (!(caps & SDHCI_CAN_DO_SDMA))
> > > +   else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
> > >             DBG("Controller doesn't have SDMA capability\n");
> > >     else
> > >             host->flags |= SDHCI_USE_SDMA;
> > > @@ -1841,7 +1911,8 @@ int sdhci_add_host(struct sdhci_host *host)
> > >             host->flags &= ~SDHCI_USE_SDMA;
> > >     }
> > >
> > > -   if ((host->version >= SDHCI_SPEC_200) && (caps &
> > > SDHCI_CAN_DO_ADMA2)) {
> > > +   if ((host->version >= SDHCI_SPEC_200) &&
> > > +           (caps[0] & SDHCI_CAN_DO_ADMA2)) {
> > >             host->flags &= ~SDHCI_USE_SDMA;
> > >             host->flags |= SDHCI_USE_ADMA;
> > >     }
> > > @@ -1893,10 +1964,10 @@ int sdhci_add_host(struct sdhci_host *host)
> > >     }
> > >
> > >     if (host->version >= SDHCI_SPEC_300)
> > > -           host->max_clk = (caps & SDHCI_CLOCK_V3_BASE_MASK)
> > > +           host->max_clk = (caps[0] & SDHCI_CLOCK_V3_BASE_MASK)
> > >                     >> SDHCI_CLOCK_BASE_SHIFT;
> > >     else
> > > -           host->max_clk = (caps & SDHCI_CLOCK_BASE_MASK)
> > > +           host->max_clk = (caps[0] & SDHCI_CLOCK_BASE_MASK)
> > >                     >> SDHCI_CLOCK_BASE_SHIFT;
> > >
> > >     host->max_clk *= 1000000;
> > > @@ -1912,7 +1983,7 @@ int sdhci_add_host(struct sdhci_host *host)
> > >     }
> > >
> > >     host->timeout_clk =
> > > -           (caps & SDHCI_TIMEOUT_CLK_MASK) >>
> SDHCI_TIMEOUT_CLK_SHIFT;
> > > +           (caps[0] & SDHCI_TIMEOUT_CLK_MASK) >>
> > > SDHCI_TIMEOUT_CLK_SHIFT;
> > >     if (host->timeout_clk == 0) {
> > >             if (host->ops->get_timeout_clock) {
> > >                     host->timeout_clk = host->ops-
> > > >get_timeout_clock(host);
> > > @@ -1924,7 +1995,7 @@ int sdhci_add_host(struct sdhci_host *host)
> > >                     return -ENODEV;
> > >             }
> > >     }
> > > -   if (caps & SDHCI_TIMEOUT_CLK_UNIT)
> > > +   if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
> > >             host->timeout_clk *= 1000;
> > >
> > >     /*
> > > @@ -1951,21 +2022,71 @@ int sdhci_add_host(struct sdhci_host *host)
> > >     if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> > >             mmc->caps |= MMC_CAP_4_BIT_DATA;
> > >
> > > -   if (caps & SDHCI_CAN_DO_HISPD)
> > > +   if (caps[0] & SDHCI_CAN_DO_HISPD)
> > >             mmc->caps |= MMC_CAP_SD_HIGHSPEED |
> MMC_CAP_MMC_HIGHSPEED;
> > >
> > >     if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> > >         mmc_card_is_removable(mmc))
> > >             mmc->caps |= MMC_CAP_NEEDS_POLL;
> > >
> > > +   /* UHS-I mode(s) supported by the host controller. */
> > > +   if (caps[1] & SDHCI_SUPPORT_SDR50)
> > > +           mmc->caps |= MMC_CAP_UHS_SDR50;
> > > +   if (caps[1] & SDHCI_SUPPORT_SDR104)
> > > +           mmc->caps |= MMC_CAP_UHS_SDR104;
> >
> > If SDR104 is supported then that SDR50 is by default supported. You
> may
> > want
> > to take care of that.
> 
> As per the spec, for SDR50 support:
> 
> "If SDR104 is supported, this bit shall be set to 1."
> 
> Since the spec uses the word _shall_, I thought it is more of a
> suggestion than a requirement. Please correct me if wrong.

Ok.

> 
> >
> > > +   if (caps[1] & SDHCI_SUPPORT_DDR50)
> > > +           mmc->caps |= MMC_CAP_UHS_DDR50;
> > > +
> > >     ocr_avail = 0;
> > > -   if (caps & SDHCI_CAN_VDD_330)
> > > +   /*
> > > +    * According to SD Host Controller spec v3.00, if the Host
> System
> > > +    * can afford more than 150mA, Host Driver should set XPC to 1.
> > > Also
> > > +    * the value is meaningful only if Voltage Support in the
> > > Capabilities
> > > +    * register is set. The actual current value is 4 times the
> > > register
> > > +    * value.
> > > +    */
> > > +   max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
> > > +
> > > +   if (caps[0] & SDHCI_CAN_VDD_330) {
> > > +           int max_current_330;
> > > +
> > >             ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
> > > -   if (caps & SDHCI_CAN_VDD_300)
> > > +
> > > +           max_current_330 = ((max_current_caps &
> > > +                              SDHCI_MAX_CURRENT_330_MASK) >>
> > > +                              SDHCI_MAX_CURRENT_330_SHIFT) *
> > > +                              SDHCI_MAX_CURRENT_MULTIPLIER;
> > > +
> > > +           if (max_current_330 > 150)
> > > +                   mmc->caps |= MMC_CAP_SET_XPC_330;
> > > +   }
> > > +   if (caps[0] & SDHCI_CAN_VDD_300) {
> > > +           int max_current_300;
> > > +
> > >             ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
> > > -   if (caps & SDHCI_CAN_VDD_180)
> > > +
> > > +           max_current_300 = ((max_current_caps &
> > > +                              SDHCI_MAX_CURRENT_300_MASK) >>
> > > +                              SDHCI_MAX_CURRENT_300_SHIFT) *
> > > +                              SDHCI_MAX_CURRENT_MULTIPLIER;
> > > +
> > > +           if (max_current_300 > 150)
> > > +                   mmc->caps |= MMC_CAP_SET_XPC_300;
> > > +   }
> > > +   if (caps[0] & SDHCI_CAN_VDD_180) {
> > > +           int max_current_180;
> > > +
> > >             ocr_avail |= MMC_VDD_165_195;
> > >
> > > +           max_current_180 = ((max_current_caps &
> > > +                              SDHCI_MAX_CURRENT_180_MASK) >>
> > > +                              SDHCI_MAX_CURRENT_180_SHIFT) *
> > > +                              SDHCI_MAX_CURRENT_MULTIPLIER;
> > > +
> > > +           if (max_current_180 > 150)
> > > +                   mmc->caps |= MMC_CAP_SET_XPC_180;
> > > +   }
> > > +
> > >     mmc->ocr_avail = ocr_avail;
> > >     mmc->ocr_avail_sdio = ocr_avail;
> > >     if (host->ocr_avail_sdio)
> > > @@ -2025,7 +2146,7 @@ int sdhci_add_host(struct sdhci_host *host)
> > >     if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> > >             mmc->max_blk_size = 2;
> > >     } else {
> > > -           mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
> > > +           mmc->max_blk_size = (caps[0] & SDHCI_MAX_BLOCK_MASK) >>
> > >                             SDHCI_MAX_BLOCK_SHIFT;
> > >             if (mmc->max_blk_size >= 3) {
> > >                     printk(KERN_WARNING "%s: Invalid maximum block
> size,
> > > "
> > > diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> > > index 223762c..95d70e6 100644
> > > --- a/drivers/mmc/host/sdhci.h
> > > +++ b/drivers/mmc/host/sdhci.h
> > > @@ -69,6 +69,8 @@
> > >  #define  SDHCI_DATA_AVAILABLE      0x00000800
> > >  #define  SDHCI_CARD_PRESENT        0x00010000
> > >  #define  SDHCI_WRITE_PROTECT       0x00080000
> > > +#define  SDHCI_DATA_LVL_MASK       0x00F00000
> > > +#define   SDHCI_DATA_LVL_SHIFT     20
> > >
> > >  #define SDHCI_HOST_CONTROL         0x28
> > >  #define  SDHCI_CTRL_LED            0x01
> > > @@ -147,7 +149,8 @@
> > >
> > >  #define SDHCI_ACMD12_ERR   0x3C
> > >
> > > -/* 3E-3F reserved */
> > > +#define SDHCI_HOST_CONTROL2                0x3E
> > > +#define  SDHCI_CTRL_VDD_180                0x0008
> > >
> > >  #define SDHCI_CAPABILITIES 0x40
> > >  #define  SDHCI_TIMEOUT_CLK_MASK    0x0000003F
> > > @@ -168,9 +171,20 @@
> > >  #define  SDHCI_CAN_VDD_180 0x04000000
> > >  #define  SDHCI_CAN_64BIT   0x10000000
> > >
> > > +#define  SDHCI_SUPPORT_SDR50       0x00000001
> > > +#define  SDHCI_SUPPORT_SDR104      0x00000002
> > > +#define  SDHCI_SUPPORT_DDR50       0x00000004
> > > +
> > >  #define SDHCI_CAPABILITIES_1       0x44
> > >
> > > -#define SDHCI_MAX_CURRENT  0x48
> > > +#define SDHCI_MAX_CURRENT          0x48
> > > +#define  SDHCI_MAX_CURRENT_330_MASK        0x0000FF
> > > +#define  SDHCI_MAX_CURRENT_330_SHIFT       0
> > > +#define  SDHCI_MAX_CURRENT_300_MASK        0x00FF00
> > > +#define  SDHCI_MAX_CURRENT_300_SHIFT       8
> > > +#define  SDHCI_MAX_CURRENT_180_MASK        0xFF0000
> > > +#define  SDHCI_MAX_CURRENT_180_SHIFT       16
> > > +#define   SDHCI_MAX_CURRENT_MULTIPLIER     4
> > >
> > >  /* 4C-4F reserved for more max current */
> > >
> > > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > > index bcb793e..ec09b32 100644
> > > --- a/include/linux/mmc/host.h
> > > +++ b/include/linux/mmc/host.h
> > > @@ -117,6 +117,8 @@ struct mmc_host_ops {
> > >
> > >     /* optional callback for HC quirks */
> > >     void    (*init_card)(struct mmc_host *host, struct mmc_card
> *card);
> > > +
> > > +   int     (*start_signal_voltage_switch)(struct mmc_host *host);
> > >  };
> > >
> > >  struct mmc_card;
> > > @@ -173,6 +175,12 @@ struct mmc_host {
> > >                                             /* DDR mode at 1.2V */
> > >  #define MMC_CAP_POWER_OFF_CARD     (1 << 13)       /* Can power
> off
> > after
> > > boot */
> > >  #define MMC_CAP_BUS_WIDTH_TEST     (1 << 14)       /* CMD14/CMD19
> bus
> > > width ok */
> > > +#define MMC_CAP_UHS_SDR50  (1 << 15)       /* Host supports UHS
> SDR50
> > > mode */
> > > +#define MMC_CAP_UHS_SDR104 (1 << 16)       /* Host supports UHS
> SDR104
> > > mode */
> > > +#define MMC_CAP_UHS_DDR50  (1 << 17)       /* Host supports UHS
> DDR50
> > > mode */
> > > +#define MMC_CAP_SET_XPC_330        (1 << 18)       /* Host
> supports >150mA
> > > current at 3.3V */
> > > +#define MMC_CAP_SET_XPC_300        (1 << 19)       /* Host
> supports >150mA
> > > current at 3.0V */
> > > +#define MMC_CAP_SET_XPC_180        (1 << 20)       /* Host
> supports >150mA
> > > current at 1.8V */
> > >
> > >     mmc_pm_flag_t           pm_caps;        /* supported pm
> features */
> > >
> > > diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> > > index 178363b..3ba5aa6 100644
> > > --- a/include/linux/mmc/sd.h
> > > +++ b/include/linux/mmc/sd.h
> > > @@ -17,6 +17,7 @@
> > >  /* This is basically the same command as for MMC with some quirks.
> > */
> > >  #define SD_SEND_RELATIVE_ADDR     3   /* bcr
> R6
> > > */
> > >  #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below
> R7
> > > */
> > > +#define SD_SWITCH_VOLTAGE         11  /* ac
> R1
> > > */
> > >
> > >    /* class 10 */
> > >  #define SD_SWITCH                 6   /* adtc [31:0] See below
> R1
> > > */
> > > --
> > > 1.7.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> mmc"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> Thanks,
> Arindam
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

