From: <subhashj@codeaurora.org>
Subject: RE: [PATCH v2 04/12] mmc: sd: add support for driver type selection
Date: Thu, 10 Mar 2011 16:55:36 +0530
Message-ID: <001501cbdf15$e3673450$aa359cf0$@org>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com> <1299238369-1768-5-git-send-email-arindam.nath@amd.com> <000301cbdef0$652b87a0$2f8296e0$@org> <6C03668EAF45B747AF947A1603D1B300E3AA281A@SAUSEXMBP01.amd.com> <001201cbdf0d$de50d780$9af28680$@org> <6C03668EAF45B747AF947A1603D1B300E3AA287F@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:11475 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750769Ab1CJLZm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Mar 2011 06:25:42 -0500
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300E3AA287F@SAUSEXMBP01.amd.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'Nath, Arindam'" <Arindam.Nath@amd.com>, cjb@laptop.org
Cc: zhangfei.gao@gmail.com, prakity@marvell.com, linux-mmc@vger.kernel.org, "'Su, Henry'" <Henry.Su@amd.com>, "'Lu, Aaron'" <Aaron.Lu@amd.com>, anath.amd@gmail.com



> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Nath, Arindam
> Sent: Thursday, March 10, 2011 4:15 PM
> To: subhashj@codeaurora.org; cjb@laptop.org
> Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: RE: [PATCH v2 04/12] mmc: sd: add support for driver type
> selection
> 
> Hi Subhash,
> 
> 
> > -----Original Message-----
> > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > Sent: Thursday, March 10, 2011 3:58 PM
> > To: Nath, Arindam; cjb@laptop.org
> > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > Subject: RE: [PATCH v2 04/12] mmc: sd: add support for driver type
> > selection
> >
> >
> >
> > > -----Original Message-----
> > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > owner@vger.kernel.org] On Behalf Of Nath, Arindam
> > > Sent: Thursday, March 10, 2011 2:02 PM
> > > To: subhashj@codeaurora.org; cjb@laptop.org
> > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > > Subject: RE: [PATCH v2 04/12] mmc: sd: add support for driver type
> > > selection
> > >
> > > Hi Subhash,
> > >
> > >
> > > > -----Original Message-----
> > > > From: subhashj@codeaurora.org [mailto:subhashj@codeaurora.org]
> > > > Sent: Thursday, March 10, 2011 12:27 PM
> > > > To: Nath, Arindam; cjb@laptop.org
> > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com; linux-
> > > > mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> > > > Subject: RE: [PATCH v2 04/12] mmc: sd: add support for driver
> type
> > > > selection
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> > > > > owner@vger.kernel.org] On Behalf Of Arindam Nath
> > > > > Sent: Friday, March 04, 2011 5:03 PM
> > > > > To: cjb@laptop.org
> > > > > Cc: zhangfei.gao@gmail.com; prakity@marvell.com;
> > > > > subhashj@codeaurora.org; linux-mmc@vger.kernel.org;
> > > henry.su@amd.com;
> > > > > aaron.lu@amd.com; anath.amd@gmail.com; Arindam Nath
> > > > > Subject: [PATCH v2 04/12] mmc: sd: add support for driver type
> > > > > selection
> > > > >
> > > > > This patch adds support for setting driver strength during UHS-
> I
> > > > > initialization prcedure. Since UHS-I cards set S18A (bit 24) in
> > > > > response to ACMD41, we use this as a base for UHS-I
> > initialization.
> > > > > We modify the parameter list of mmc_sd_get_cid() so that we can
> > > > > save the ROCR from ACMD41 to check whether bit 24 is set.
> > > > >
> > > > > We decide whether the Host Controller supports A, C, or D
> driver
> > > > > type depending on the Capabilities register. We then set the
> > > > > appropriate driver type for the card using CMD6 mode 1. As per
> > > > > Host Controller spec v3.00, we set driver type for the host
> only
> > > > > if Preset Value Enable in the Host Control2 register is not
> set.
> > > > > SDHCI_HOST_CONTROL has been renamed to SDHCI_HOST_CONTROL1 to
> > > > > conform to the spec.
> > > > >
> > > > > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > > > > ---
> > > > >  drivers/mmc/core/core.c  |    9 +++
> > > > >  drivers/mmc/core/core.h  |    1 +
> > > > >  drivers/mmc/core/sd.c    |  140
> > > > +++++++++++++++++++++++++++++++++++++-
> > > > > --------
> > > > >  drivers/mmc/core/sd.h    |    3 +-
> > > > >  drivers/mmc/core/sdio.c  |    3 +-
> > > > >  drivers/mmc/host/sdhci.c |   48 ++++++++++++----
> > > > >  drivers/mmc/host/sdhci.h |   10 +++-
> > > > >  include/linux/mmc/card.h |    4 +
> > > > >  include/linux/mmc/host.h |    8 +++
> > > > >  9 files changed, 186 insertions(+), 40 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> > > > > index 6625c05..daa535a 100644
> > > > > --- a/drivers/mmc/core/core.c
> > > > > +++ b/drivers/mmc/core/core.c
> > > > > @@ -947,6 +947,15 @@ void mmc_set_timing(struct mmc_host *host,
> > > > > unsigned int timing)
> > > > >  }
> > > > >
> > > > >  /*
> > > > > + * Select appropriate driver type for host.
> > > > > + */
> > > > > +void mmc_set_driver_type(struct mmc_host *host, unsigned int
> > > > drv_type)
> > > > > +{
> > > > > +   host->ios.drv_type = drv_type;
> > > > > +   mmc_set_ios(host);
> > > > > +}
> > > > > +
> > > > > +/*
> > > > >   * Apply power to the MMC stack.  This is a two-stage process.
> > > > >   * First, we enable power to the card without the clock
> running.
> > > > >   * We then wait a bit for the power to stabilise.  Finally,
> > > > > diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> > > > > index ca1fdde..6114ca5 100644
> > > > > --- a/drivers/mmc/core/core.h
> > > > > +++ b/drivers/mmc/core/core.h
> > > > > @@ -42,6 +42,7 @@ void mmc_set_bus_width_ddr(struct mmc_host
> > *host,
> > > > > unsigned int width,
> > > > >                        unsigned int ddr);
> > > > >  u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> > > > >  void mmc_set_timing(struct mmc_host *host, unsigned int
> timing);
> > > > > +void mmc_set_driver_type(struct mmc_host *host, unsigned int
> > > > > drv_type);
> > > > >
> > > > >  static inline void mmc_delay(unsigned int ms)
> > > > >  {
> > > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > > > index a63956b..f6a4fab 100644
> > > > > --- a/drivers/mmc/core/sd.c
> > > > > +++ b/drivers/mmc/core/sd.c
> > > > > @@ -426,6 +426,86 @@ out:
> > > > >     return err;
> > > > >  }
> > > > >
> > > > > +static int sd_select_driver_type(struct mmc_card *card, u8
> > > *status)
> > > > > +{
> > > > > +   int host_set_drv_type, card_set_drv_type;
> > > >
> > > > Why you need to use *set* in name? Just host_drv_type &
> > card_drv_type
> > > > is not
> > > > enough?
> > >
> > > I wanted to emphasize on the fact that we are setting the values
> for
> > > host and card both. I don't have issues removing the *set* part.
> >
> > I don't think you need to use *set*.
> 
> Okay with me. I will remove *set*.
> 
> >
> > >
> > > >
> > > > > +   int err;
> > > > > +
> > > > > +   /*
> > > > > +    * If the host doesn't support any of the Driver Types A,C
> or
> > > D,
> > > > > +    * default Driver Type B is used.
> > > > > +    */
> > > > > +   if (!(card->host->caps & (MMC_CAP_DRIVER_TYPE_A |
> > > > > MMC_CAP_DRIVER_TYPE_C
> > > > > +       | MMC_CAP_DRIVER_TYPE_D)))
> > > > > +           return 0;
> > > > > +
> > > > > +   if (card->host->caps & MMC_CAP_DRIVER_TYPE_A) {
> > > > > +           host_set_drv_type = MMC_SET_DRIVER_TYPE_A;
> > > > > +           if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_A)
> > > > > +                   card_set_drv_type = MMC_SET_DRIVER_TYPE_A;
> > > > > +           else if (card->sw_caps.uhs_drv_type &
> > SD_DRIVER_TYPE_C)
> > > > > +                   card_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > > >
> > > > Why you are combining TYPE_C under CAP_*_TYPE_A?
> > >
> > > Both the host and card can support multiple driver types, so we
> need
> > to
> > > decide the appropriate setting for them based on their
> capabilities.
> >
> > Agreed but here you are first checking that host is capable of TYPE_A
> > or
> > not. Then if it's capable of TYPE_A that doesn't guarantee that host
> is
> > capable of TYPE_C as well even if card supports both TYPE_A and
> TYPE_C.
> 
> Please refer to section 6.7.1.2 of the Physical Layer spec v3.01. As
> per the description, it seemed to me like, since Driver Type C is
> weaker than Driver Type A, a host with Type A can still drive a card of
> Type C. I might have misunderstood the spec, so please correct me if
> wrong.

So this is what you are assuming: A > B > C > D. with above check you are
ignoring TYPE_B then. Let's say you check host CAP TYPE_A and if it supports
then you check if card supports TYPE_A or not. If it's not then you are
directly jumping to TYPE_C. but according to spec TYPE_B is stronger than
TYPE_C. Please check the section: 6.7.1.5 in spec. it says this: "whenever a
stronger driver than type B is needed, driver type A can be selected and
whenever a weaker driver than type B is needed, driver type C can be
selected "

> 
> >
> > >
> > > >
> > > > > +   } else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
> > > > > +           host_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > > > > +           if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_C)
> > > > > +                   card_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> > > > > +   }
> > > >
> > > > Again TYPE_C checking here? Also why are you skiping TYPE_D here?
> > >
> > > TYPE_C checking for the same reason as above. I could not find a
> > > scenario where I can put TYPE_D into, so there is not checking.
> > > Probably you can suggest something?
> >
> > Will following simple check is not enough?
> >
> >         if (card->host->caps & MMC_CAP_DRIVER_TYPE_A) {
> >                 host_set_drv_type = MMC_SET_DRIVER_TYPE_A;
> >                 if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_A)
> >                         card_set_drv_type = MMC_SET_DRIVER_TYPE_A;
> >         } else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
> >                 host_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> >                 if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_C)
> >                         card_set_drv_type = MMC_SET_DRIVER_TYPE_C;
> >         } else if (card->host->caps & MMC_CAP_DRIVER_TYPE_D) {
> >                 host_set_drv_type = MMC_SET_DRIVER_TYPE_D;
> >                 if (card->sw_caps.uhs_drv_type & SD_DRIVER_TYPE_D)
> >                         card_set_drv_type = MMC_SET_DRIVER_TYPE_D;
> >         } else {
> >                       return 0; /* default = TYPE_B */
> >         }
> >
> >
> >
> > >
> > > >
> > > > > +
> > > > > +   err = mmc_sd_switch(card, 1, 2, card_set_drv_type, status);
> > > > > +   if (err)
> > > > > +           return err;
> > > > > +
> > > > > +   if ((status[15] & 0xF) != card_set_drv_type)
> > > > > +           printk(KERN_WARNING "%s: Problem setting driver
> > > > > strength!\n",
> > > > > +                   mmc_hostname(card->host));
> > > > > +   else
> > > > > +           mmc_set_driver_type(card->host, host_set_drv_type);
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +/*
> > > > > + * UHS-I specific initialization procedure
> > > > > + */
> > > > > +static int mmc_sd_init_uhs_card(struct mmc_card *card)
> > > > > +{
> > > > > +   int err;
> > > > > +   u8 *status;
> > > > > +
> > > > > +   if (!card->scr.sda_spec3)
> > > > > +           return 0;
> > > > > +
> > > > > +   if (!(card->csd.cmdclass & CCC_SWITCH))
> > > > > +           return 0;
> > > >
> > > > We can combine both these check under single "if" checking.
> > >
> > > The code snippet is a replica of the code already present in
> > > mmc_sd_switch_hs() and mmc_read_switch(), so I too followed the
> same
> > > checking. I can combine them into a single condition if you want.
> >
> > Ok. it's  up to you in this case. If it looks by having 2 different
> > statements then it's fine.
> >
> > >
> > > >
> > > > > +
> > > > > +   err = -EIO;
> > > >
> > > > Is this really required? I don't think initializing "err" is
> needed
> > > > here.
> > >
> > > Again a replica of the functions mentioned above. Let me know if
> you
> > > want this removed.
> >
> > This is not needed here. You can remove it.
> 
> Will remove it then. Thanks.
> 
> >
> > >
> > > >
> > > > > +
> > > > > +   status = kmalloc(64, GFP_KERNEL);
> > > > > +   if (!status) {
> > > > > +           printk(KERN_ERR "%s: could not allocate a buffer
> for
> > "
> > > > > +                   "switch capabilities.\n",
> mmc_hostname(card-
> > > >host));
> > > > > +           return -ENOMEM;
> > > > > +   }
> > > >
> > > > You may want to allocate memory only after bus width setting is
> > > > successful.
> > >
> > > Yes, good suggestion. I will incorporate this change.
> > >
> > > >
> > > > > +
> > > > > +   /* Set 4-bit bus width */
> > > > > +   if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
> > > > > +       (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
> > > > > +           err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
> > > > > +           if (err)
> > > > > +                   goto out;
> > > > > +
> > > > > +           mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
> > > > > +   }
> > > > > +
> > > > > +   /* Set the driver strength for the card */
> > > > > +   err = sd_select_driver_type(card, status);
> > > >
> > > > Actually why are you allocating memory for "status" response in
> > > > mmc_sd_init_uhs_card() function. You need "status" only in
> > > > sd_select_driver_type() function. So you should be allocating
> > memory
> > > in
> > > > sd_select_driver_type() function only. here you just say "
> > > > sd_select_driver_type(card);"
> > >
> > > Please check the later patches. "status" is used to store return
> > > statuses from *bus_speed_mode() and *current_limit() as well. So I
> > > think it makes sense to allocate memory for "status" at the
> beginning
> > > of the function, and use it later.
> >
> > Sorry. I had not checked the later patches. Yes, allocating here is
> > proper.
> > As same status is being used for other switch settings as well.
> >
> >
> > >
> > > >
> > > > > +
> > > > > +out:
> > > > > +   kfree(status);
> > > > > +
> > > > > +   return err;
> > > > > +}
> > > > > +
> > > > >  MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0],
> card-
> > > > > >raw_cid[1],
> > > > >     card->raw_cid[2], card->raw_cid[3]);
> > > > >  MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0],
> card-
> > > > > >raw_csd[1],
> > > > > @@ -474,10 +554,10 @@ struct device_type sd_type = {
> > > > >  /*
> > > > >   * Fetch CID from card.
> > > > >   */
> > > > > -int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
> > > > > +int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
> > > > > +   u32 *rocr)
> > > > >  {
> > > > >     int err;
> > > > > -   u32 rocr;
> > > > >
> > > > >     /*
> > > > >      * Since we're changing the OCR value, we seem to
> > > > > @@ -502,7 +582,7 @@ int mmc_sd_get_cid(struct mmc_host *host,
> u32
> > > > ocr,
> > > > > u32 *cid)
> > > > >         MMC_CAP_SET_XPC_180))
> > > > >             ocr |= 1 << 28;
> > > > >
> > > > > -   err = mmc_send_app_op_cond(host, ocr, &rocr);
> > > > > +   err = mmc_send_app_op_cond(host, ocr, rocr);
> > > > >     if (err)
> > > > >             return err;
> > > > >
> > > > > @@ -510,7 +590,7 @@ int mmc_sd_get_cid(struct mmc_host *host,
> u32
> > > > ocr,
> > > > > u32 *cid)
> > > > >      * In case CCS and S18A in the response is set, start
> Signal
> > > > > Voltage
> > > > >      * Switch procedure. SPI mode doesn't support CMD11.
> > > > >      */
> > > > > -   if (!mmc_host_is_spi(host) && (rocr & 0x41000000)) {
> > > > > +   if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x41000000))
> {
> > > >
> > > > You are not doing NULL check for "rocr" in mmc_send_app_op_cond()
> > but
> > > > you
> > > > are doing it here. Is it needed? If "rocr" is NULL then
> > > > mmc_send_app_op_cond() itself will fail.
> > >
> > > I am actually checking rocr for NULL before returning from
> > > mmc_send_app_op_cond(). Can you please check the function again to
> > make
> > > sure?
> > Yes. It's fine. ignore this.
> >
> >
> > >
> > > > Also, you may need to check b31 (busy bit) of rocr because spec
> > says
> > > > this:
> > > > "Section:4.2.3.1 CCS (Bit 30) and S18A (Bit 24) are valid when
> Busy
> > > > (Bit 31)
> > > > is set to 1."
> > >
> > > The busy bit (bit 31) checking is already performed inside
> > > mmc_send_app_op_cond(), cmd.resp[0] & MMC_CARD_BUSY.
> >
> > Ok. fine.
> >
> > >
> > > >
> > > > >             err = mmc_start_voltage_switch(host);
> > > > >             if (err)
> > > > >                     return err;
> > > > > @@ -643,11 +723,12 @@ static int mmc_sd_init_card(struct
> mmc_host
> > > > > *host, u32 ocr,
> > > > >     struct mmc_card *card;
> > > > >     int err;
> > > > >     u32 cid[4];
> > > > > +   u32 rocr;
> > > > >
> > > > >     BUG_ON(!host);
> > > > >     WARN_ON(!host->claimed);
> > > > >
> > > > > -   err = mmc_sd_get_cid(host, ocr, cid);
> > > > > +   err = mmc_sd_get_cid(host, ocr, cid, &rocr);
> > > > >     if (err)
> > > > >             return err;
> > > > >
> > > > > @@ -700,30 +781,37 @@ static int mmc_sd_init_card(struct
> mmc_host
> > > > > *host, u32 ocr,
> > > > >     if (err)
> > > > >             goto free_card;
> > > > >
> > > > > -   /*
> > > > > -    * Attempt to change to high-speed (if supported)
> > > > > -    */
> > > > > -   err = mmc_sd_switch_hs(card);
> > > > > -   if (err > 0)
> > > > > -           mmc_sd_go_highspeed(card);
> > > > > -   else if (err)
> > > > > -           goto free_card;
> > > > > -
> > > > > -   /*
> > > > > -    * Set bus speed.
> > > > > -    */
> > > > > -   mmc_set_clock(host, mmc_sd_get_max_clock(card));
> > > > > -
> > > > > -   /*
> > > > > -    * Switch to wider bus (if supported).
> > > > > -    */
> > > > > -   if ((host->caps & MMC_CAP_4_BIT_DATA) &&
> > > > > -           (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
> > > > > -           err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
> > > > > +   /* Initialization sequence for UHS-I cards */
> > > > > +   if (rocr & 0x01000000) {
> > > >
> > > > Instead of 0x01000000, you can use (1 << 24) to be more readable.
> > >
> > > I am okay with your suggestion. Will change it.
> > >
> > > Thanks,
> > > Arindam
> > >
> > > >
> > > > > +           err = mmc_sd_init_uhs_card(card);
> > > > >             if (err)
> > > > >                     goto free_card;
> > > > > +   } else {
> > > > > +           /*
> > > > > +            * Attempt to change to high-speed (if supported)
> > > > > +            */
> > > > > +           err = mmc_sd_switch_hs(card);
> > > > > +           if (err > 0)
> > > > > +                   mmc_sd_go_highspeed(card);
> > > > > +           else if (err)
> > > > > +                   goto free_card;
> > > > > +
> > > > > +           /*
> > > > > +            * Set bus speed.
> > > > > +            */
> > > > > +           mmc_set_clock(host, mmc_sd_get_max_clock(card));
> > > > >
> > > > > -           mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
> > > > > +           /*
> > > > > +            * Switch to wider bus (if supported).
> > > > > +            */
> > > > > +           if ((host->caps & MMC_CAP_4_BIT_DATA) &&
> > > > > +                   (card->scr.bus_widths &
> SD_SCR_BUS_WIDTH_4))
> > {
> > > > > +                   err = mmc_app_set_bus_width(card,
> > > MMC_BUS_WIDTH_4);
> > > > > +                   if (err)
> > > > > +                           goto free_card;
> > > > > +
> > > > > +                   mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
> > > > > +           }
> > > > >     }
> > > > >
> > > > >     host->card = card;
> > > > > diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
> > > > > index 3d8800f..5106b44 100644
> > > > > --- a/drivers/mmc/core/sd.h
> > > > > +++ b/drivers/mmc/core/sd.h
> > > > > @@ -5,7 +5,8 @@
> > > > >
> > > > >  extern struct device_type sd_type;
> > > > >
> > > > > -int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid);
> > > > > +int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
> > > > > +   u32 *rocr);
> > > > >  int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card
> > *card);
> > > > >  void mmc_decode_cid(struct mmc_card *card);
> > > > >  int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card
> > > *card,
> > > > > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > > > > index 5c4a54d..6d16684 100644
> > > > > --- a/drivers/mmc/core/sdio.c
> > > > > +++ b/drivers/mmc/core/sdio.c
> > > > > @@ -364,7 +364,8 @@ static int mmc_sdio_init_card(struct
> mmc_host
> > > > > *host, u32 ocr,
> > > > >     }
> > > > >
> > > > >     if (ocr & R4_MEMORY_PRESENT
> > > > > -       && mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid)
> > ==
> > > 0)
> > > > > {
> > > > > +       && mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid,
> > > > > +       NULL) == 0) {
> > > > >             card->type = MMC_TYPE_SD_COMBO;
> > > > >
> > > > >             if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO
> ||
> > > > > diff --git a/drivers/mmc/host/sdhci.c
> b/drivers/mmc/host/sdhci.c
> > > > > index 5487a0b..1645687 100644
> > > > > --- a/drivers/mmc/host/sdhci.c
> > > > > +++ b/drivers/mmc/host/sdhci.c
> > > > > @@ -63,7 +63,7 @@ static void sdhci_dumpregs(struct sdhci_host
> > > *host)
> > > > >             sdhci_readw(host, SDHCI_TRANSFER_MODE));
> > > > >     printk(KERN_DEBUG DRIVER_NAME ": Present:  0x%08x | Host
> ctl:
> > > > > 0x%08x\n",
> > > > >             sdhci_readl(host, SDHCI_PRESENT_STATE),
> > > > > -           sdhci_readb(host, SDHCI_HOST_CONTROL));
> > > > > +           sdhci_readb(host, SDHCI_HOST_CONTROL1));
> > > > >     printk(KERN_DEBUG DRIVER_NAME ": Power:    0x%08x | Blk
> gap:
> > > > > 0x%08x\n",
> > > > >             sdhci_readb(host, SDHCI_POWER_CONTROL),
> > > > >             sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
> > > > > @@ -216,18 +216,18 @@ static void sdhci_activate_led(struct
> > > > sdhci_host
> > > > > *host)
> > > > >  {
> > > > >     u8 ctrl;
> > > > >
> > > > > -   ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > > > > +   ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
> > > > >     ctrl |= SDHCI_CTRL_LED;
> > > > > -   sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > > > +   sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > > > >  }
> > > > >
> > > > >  static void sdhci_deactivate_led(struct sdhci_host *host)
> > > > >  {
> > > > >     u8 ctrl;
> > > > >
> > > > > -   ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > > > > +   ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
> > > > >     ctrl &= ~SDHCI_CTRL_LED;
> > > > > -   sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > > > +   sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > > > >  }
> > > > >
> > > > >  #ifdef SDHCI_USE_LEDS_CLASS
> > > > > @@ -786,14 +786,14 @@ static void sdhci_prepare_data(struct
> > > > sdhci_host
> > > > > *host, struct mmc_data *data)
> > > > >      * is ADMA.
> > > > >      */
> > > > >     if (host->version >= SDHCI_SPEC_200) {
> > > > > -           ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > > > > +           ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
> > > > >             ctrl &= ~SDHCI_CTRL_DMA_MASK;
> > > > >             if ((host->flags & SDHCI_REQ_USE_DMA) &&
> > > > >                     (host->flags & SDHCI_USE_ADMA))
> > > > >                     ctrl |= SDHCI_CTRL_ADMA32;
> > > > >             else
> > > > >                     ctrl |= SDHCI_CTRL_SDMA;
> > > > > -           sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > > > +           sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > > > >     }
> > > > >
> > > > >     if (!(host->flags & SDHCI_REQ_USE_DMA)) {
> > > > > @@ -1252,7 +1252,7 @@ static void sdhci_set_ios(struct mmc_host
> > > *mmc,
> > > > > struct mmc_ios *ios)
> > > > >     if (host->ops->platform_8bit_width)
> > > > >             host->ops->platform_8bit_width(host, ios-
> >bus_width);
> > > > >     else {
> > > > > -           ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > > > > +           ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
> > > > >             if (ios->bus_width == MMC_BUS_WIDTH_8) {
> > > > >                     ctrl &= ~SDHCI_CTRL_4BITBUS;
> > > > >                     if (host->version >= SDHCI_SPEC_300)
> > > > > @@ -1265,10 +1265,10 @@ static void sdhci_set_ios(struct
> mmc_host
> > > > *mmc,
> > > > > struct mmc_ios *ios)
> > > > >                     else
> > > > >                             ctrl &= ~SDHCI_CTRL_4BITBUS;
> > > > >             }
> > > > > -           sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > > > +           sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > > > >     }
> > > > >
> > > > > -   ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > > > > +   ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
> > > > >
> > > > >     if ((ios->timing == MMC_TIMING_SD_HS ||
> > > > >          ios->timing == MMC_TIMING_MMC_HS)
> > > > > @@ -1277,7 +1277,25 @@ static void sdhci_set_ios(struct
> mmc_host
> > > > *mmc,
> > > > > struct mmc_ios *ios)
> > > > >     else
> > > > >             ctrl &= ~SDHCI_CTRL_HISPD;
> > > > >
> > > > > -   sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > > > > +   sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > > > > +
> > > > > +   if (host->version >= SDHCI_SPEC_300) {
> > > > > +           u16 ctrl_2;
> > > > > +
> > > > > +           ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > > > > +           if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
> > > > > +                   /*
> > > > > +                    * We only need to set Driver Strength if
> the
> > > > > +                    * preset value enable is not set.
> > > > > +                    */
> > > > > +                   if (ios->drv_type == MMC_SET_DRIVER_TYPE_A)
> > > > > +                           ctrl_2 |= SDHCI_CTRL_DRV_TYPE_A;
> > > > > +                   else if (ios->drv_type ==
> > > MMC_SET_DRIVER_TYPE_C)
> > > > > +                           ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
> > > > > +
> > > > > +                   sdhci_writew(host, ctrl_2,
> > > SDHCI_HOST_CONTROL2);
> > > > > +           }
> > > > > +   }
> > > > >
> > > > >     /*
> > > > >      * Some (ENE) controllers go apeshit on some ios operation,
> > > > > @@ -2037,6 +2055,14 @@ int sdhci_add_host(struct sdhci_host
> > *host)
> > > > >     if (caps[1] & SDHCI_SUPPORT_DDR50)
> > > > >             mmc->caps |= MMC_CAP_UHS_DDR50;
> > > > >
> > > > > +   /* Driver Type(s) (A, C, D) supported by the host */
> > > > > +   if (caps[1] & SDHCI_DRIVER_TYPE_A)
> > > > > +           mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
> > > > > +   if (caps[1] & SDHCI_DRIVER_TYPE_C)
> > > > > +           mmc->caps |= MMC_CAP_DRIVER_TYPE_C;
> > > > > +   if (caps[1] & SDHCI_DRIVER_TYPE_D)
> > > > > +           mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
> > > > > +
> > > > >     ocr_avail = 0;
> > > > >     /*
> > > > >      * According to SD Host Controller spec v3.00, if the Host
> > > System
> > > > > diff --git a/drivers/mmc/host/sdhci.h
> b/drivers/mmc/host/sdhci.h
> > > > > index 95d70e6..a407b5b 100644
> > > > > --- a/drivers/mmc/host/sdhci.h
> > > > > +++ b/drivers/mmc/host/sdhci.h
> > > > > @@ -72,7 +72,7 @@
> > > > >  #define  SDHCI_DATA_LVL_MASK       0x00F00000
> > > > >  #define   SDHCI_DATA_LVL_SHIFT     20
> > > > >
> > > > > -#define SDHCI_HOST_CONTROL         0x28
> > > > > +#define SDHCI_HOST_CONTROL1        0x28
> > > > >  #define  SDHCI_CTRL_LED            0x01
> > > > >  #define  SDHCI_CTRL_4BITBUS        0x02
> > > > >  #define  SDHCI_CTRL_HISPD  0x04
> > > > > @@ -151,6 +151,11 @@
> > > > >
> > > > >  #define SDHCI_HOST_CONTROL2                0x3E
> > > > >  #define  SDHCI_CTRL_VDD_180                0x0008
> > > > > +#define  SDHCI_CTRL_DRV_TYPE_B             0x0000
> > > > > +#define  SDHCI_CTRL_DRV_TYPE_A             0x0010
> > > > > +#define  SDHCI_CTRL_DRV_TYPE_C             0x0020
> > > > > +#define  SDHCI_CTRL_DRV_TYPE_D             0x0030
> > > > > +#define  SDHCI_CTRL_PRESET_VAL_ENABLE      0x8000
> > > > >
> > > > >  #define SDHCI_CAPABILITIES 0x40
> > > > >  #define  SDHCI_TIMEOUT_CLK_MASK    0x0000003F
> > > > > @@ -174,6 +179,9 @@
> > > > >  #define  SDHCI_SUPPORT_SDR50       0x00000001
> > > > >  #define  SDHCI_SUPPORT_SDR104      0x00000002
> > > > >  #define  SDHCI_SUPPORT_DDR50       0x00000004
> > > > > +#define  SDHCI_DRIVER_TYPE_A       0x00000010
> > > > > +#define  SDHCI_DRIVER_TYPE_C       0x00000020
> > > > > +#define  SDHCI_DRIVER_TYPE_D       0x00000040
> > > > >
> > > > >  #define SDHCI_CAPABILITIES_1       0x44
> > > > >
> > > > > diff --git a/include/linux/mmc/card.h
> b/include/linux/mmc/card.h
> > > > > index 7080f22..2d7f7a3 100644
> > > > > --- a/include/linux/mmc/card.h
> > > > > +++ b/include/linux/mmc/card.h
> > > > > @@ -77,6 +77,10 @@ struct sd_switch_caps {
> > > > >     unsigned int            hs_max_dtr;
> > > > >     unsigned int            uhs_bus_mode;
> > > > >     unsigned int            uhs_drv_type;
> > > > > +#define SD_DRIVER_TYPE_B   0x01
> > > > > +#define SD_DRIVER_TYPE_A   0x02
> > > > > +#define SD_DRIVER_TYPE_C   0x04
> > > > > +#define SD_DRIVER_TYPE_D   0x08
> > > > >     unsigned int            uhs_curr_limit;
> > > > >  };
> > > > >
> > > > > diff --git a/include/linux/mmc/host.h
> b/include/linux/mmc/host.h
> > > > > index ad7daa3..bc2121e 100644
> > > > > --- a/include/linux/mmc/host.h
> > > > > +++ b/include/linux/mmc/host.h
> > > > > @@ -56,6 +56,11 @@ struct mmc_ios {
> > > > >  #define MMC_SDR_MODE               0
> > > > >  #define MMC_1_2V_DDR_MODE  1
> > > > >  #define MMC_1_8V_DDR_MODE  2
> > > > > +
> > > > > +   unsigned char   drv_type;               /* driver type (A,
> C,
> > > D) */
> > > > > +
> > > > > +#define MMC_SET_DRIVER_TYPE_A      1
> > > > > +#define MMC_SET_DRIVER_TYPE_C      2
> > > >
> > > > *SET* is not required in name. again why are we ignoring TYPE D
> > here?
> > > >
> > > > >  };
> > > > >
> > > > >  struct mmc_host_ops {
> > > > > @@ -183,6 +188,9 @@ struct mmc_host {
> > > > >  #define MMC_CAP_SET_XPC_330        (1 << 20)       /* Host
> > > supports >150mA
> > > > > current at 3.3V */
> > > > >  #define MMC_CAP_SET_XPC_300        (1 << 21)       /* Host
> > > supports >150mA
> > > > > current at 3.0V */
> > > > >  #define MMC_CAP_SET_XPC_180        (1 << 22)       /* Host
> > > supports >150mA
> > > > > current at 1.8V */
> > > > > +#define MMC_CAP_DRIVER_TYPE_A      (1 << 23)       /* Host
> > > supports
> > > > Driver
> > > > > Type A */
> > > > > +#define MMC_CAP_DRIVER_TYPE_C      (1 << 24)       /* Host
> > > supports
> > > > Driver
> > > > > Type C */
> > > > > +#define MMC_CAP_DRIVER_TYPE_D      (1 << 25)       /* Host
> > > supports
> > > > Driver
> > > > > Type D */
> > > > >
> > > > >     mmc_pm_flag_t           pm_caps;        /* supported pm
> > > features */
> > > > >
> > > > > --
> > > > > 1.7.1
> > > > >
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe
> linux-
> > > mmc"
> > > > in
> > > > > the body of a message to majordomo@vger.kernel.org
> > > > > More majordomo info at  http://vger.kernel.org/majordomo-
> > info.html
> > > >
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-
> mmc"
> > in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

