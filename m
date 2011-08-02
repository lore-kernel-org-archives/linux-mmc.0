From: "Subhash Jadavani" <subhashj@codeaurora.org>
Subject: RE: [PATCH] mmc: sd: UHS-I bus speed should be set last in UHS initialization
Date: Tue, 2 Aug 2011 18:10:39 +0530
Message-ID: <000601cc5111$64c0e9c0$2e42bd40$@org>
References: <1312199897-5536-1-git-send-email-subhashj@codeaurora.org> <m2d3goc2r1.fsf@bob.laptop.org> <6C03668EAF45B747AF947A1603D1B3000197C66B0B@SAUSEXMBP01.amd.com> <000001cc50f4$5a9e5530$0fdaff90$@org> <6C03668EAF45B747AF947A1603D1B3000197C66BA2@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:23414 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754388Ab1HBMko (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Aug 2011 08:40:44 -0400
In-Reply-To: <6C03668EAF45B747AF947A1603D1B3000197C66BA2@SAUSEXMBP01.amd.com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "'Nath, Arindam'" <Arindam.Nath@amd.com>, 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 'Philip Rakity' <prakity@marvell.com>, 'zhangfei gao' <zhangfei.gao@gmail.com>


> -----Original Message-----
> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
> owner@vger.kernel.org] On Behalf Of Nath, Arindam
> Sent: Tuesday, August 02, 2011 3:21 PM
> To: Subhash Jadavani; 'Chris Ball'
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; 'Philip
> Rakity'; 'zhangfei gao'
> Subject: RE: [PATCH] mmc: sd: UHS-I bus speed should be set last in UHS
> initialization
> 
> 
> 
> > -----Original Message-----
> > From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
> > Sent: Tuesday, August 02, 2011 2:43 PM
> > To: Nath, Arindam; 'Chris Ball'
> > Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; 'Philip
> > Rakity'; 'zhangfei gao'
> > Subject: RE: [PATCH] mmc: sd: UHS-I bus speed should be set last in
> UHS
> > initialization
> >
> > Hi Arindam,
> >
> > Thank you for the review. Please find few comments inline.
> >
> > > -----Original Message-----
> > > From: Nath, Arindam [mailto:Arindam.Nath@amd.com]
> > > Sent: Tuesday, August 02, 2011 12:38 PM
> > > To: Chris Ball; Subhash Jadavani
> > > Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> Philip
> > > Rakity; zhangfei gao
> > > Subject: RE: [PATCH] mmc: sd: UHS-I bus speed should be set last in
> > UHS
> > > initialization
> > >
> > > Hi Subhash,
> > >
> > >
> > > > -----Original Message-----
> > > > From: Chris Ball [mailto:cjb@laptop.org]
> > > > Sent: Tuesday, August 02, 2011 1:40 AM
> > > > To: Subhash Jadavani
> > > > Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org;
> Nath,
> > > > Arindam
> > > > Subject: Re: [PATCH] mmc: sd: UHS-I bus speed should be set last
> in
> > > UHS
> > > > initialization
> > > >
> > > > Hi Subhash, adding Arindam for review,
> > > >
> > > > On Mon, Aug 01 2011, Subhash Jadavani wrote:
> > > > > mmc_sd_init_uhs_card function sets the driver type, current
> limit
> > > > > and bus speed mode on card as well as on host controller side.
> > > > >
> > > > > Currently bus speed mode is set by sending CMD6 to card and
> > > > > immediately setting the timing mode in host controller. But
> > > > > then before initiating tuning sequence, it also tries to set
> > > > > current limit by sending CMD6 to card which results in data
> > > > > timeout errors in controller if bus speed mode is SDR50/SDR104
> > > mode.
> > > > >
> > > > > So basically bus speed mode should be set only after current
> > limit
> > > > > is set in the card and immediately after setting the bus speed
> > > mode,
> > > > > tuning sequence should be initiated.
> > > > >
> > > > > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > > > > ---
> > > > >  drivers/mmc/core/sd.c |   57 ++++++++++++++++++++++++++++++++-
> --
> > --
> > > --
> > > > ---------
> > > > >  1 files changed, 38 insertions(+), 19 deletions(-)
> > > > >
> > > > > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > > > > index ff27741..d257496 100644
> > > > > --- a/drivers/mmc/core/sd.c
> > > > > +++ b/drivers/mmc/core/sd.c
> > > > > @@ -459,10 +459,9 @@ static int sd_select_driver_type(struct
> > > mmc_card
> > > > *card, u8 *status)
> > > > >  	return 0;
> > > > >  }
> > > > >
> > > > > -static int sd_set_bus_speed_mode(struct mmc_card *card, u8
> > > *status)
> > > > > +static int sd_get_bus_speed_mode(struct mmc_card *card)
> > > > >  {
> > > > > -	unsigned int bus_speed = 0, timing = 0;
> > > > > -	int err;
> > > > > +	int bus_speed = 0;
> > > > >
> > > > >  	/*
> > > > >  	 * If the host doesn't support any of the UHS-I modes,
> > fallback
> > > > on
> > > > > @@ -470,37 +469,56 @@ static int sd_set_bus_speed_mode(struct
> > > > mmc_card *card, u8 *status)
> > > > >  	 */
> > > > >  	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 |
> > MMC_CAP_UHS_SDR25 |
> > > > >  	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
> > MMC_CAP_UHS_DDR50)))
> > > > > -		return 0;
> > > > > +		return -EINVAL;
> > >
> > > We should not return -EINVAL here, because this is not an error
> > > condition. This would simply mean that the card and host controller
> > > will fall back to using the default bus speed, and should still be
> > > operable. Check the comment below too.
> >
> > Return value of this function gets used in sd_set_bus_speed_mode()
> > function
> > and compared against all the valid bus speed modes. If we choose to
> > return 0
> > from here then '0' corresponds to valid bus speed mode
> > 'UHS_SDR12_BUS_SPEED'.
> >
> > #define UHS_SDR12_BUS_SPEED     0
> > #define UHS_SDR25_BUS_SPEED     1
> > #define UHS_SDR50_BUS_SPEED     2
> > #define UHS_SDR104_BUS_SPEED    3
> > #define UHS_DDR50_BUS_SPEED     4
> >
> > If we don't want to return the error value from this function then we
> > can
> > basically remove following check from this *get* function and move it
> > to
> > each *set* function before calling *get*. Please see more comments
> > inline in
> > *set* functions below.
> >
> > if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
> > 	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50)))
> > 		return -EINVAL;
> 
> By *Default Bus Speed*, I meant speed corresponding to SDR12. So if we
> return 0 from sd_get_bus_speed_mode(), that would make sure that your
> modified sd_set_bus_speed_mode()  correctly executes the last *else if*
> condition, and we set the default speed. So I don't think we will need
> to return -EINVAL.

Ok. Got your points. Will address this in next rev. for this patch.

Thanks,
Subhash

> 
> >
> > >
> > > > >
> > > > >  	if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
> > > > >  	    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)) {
> > > > >  			bus_speed = UHS_SDR104_BUS_SPEED;
> > > > > -			timing = MMC_TIMING_UHS_SDR104;
> > > > > -			card->sw_caps.uhs_max_dtr =
UHS_SDR104_MAX_DTR;
> > > > >  	} else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
> > > > >  		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50))
> > {
> > > > >  			bus_speed = UHS_DDR50_BUS_SPEED;
> > > > > -			timing = MMC_TIMING_UHS_DDR50;
> > > > > -			card->sw_caps.uhs_max_dtr =
UHS_DDR50_MAX_DTR;
> > > > >  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> > > > >  		    MMC_CAP_UHS_SDR50)) && (card-
> > >sw_caps.sd3_bus_mode &
> > > > >  		    SD_MODE_UHS_SDR50)) {
> > > > >  			bus_speed = UHS_SDR50_BUS_SPEED;
> > > > > -			timing = MMC_TIMING_UHS_SDR50;
> > > > > -			card->sw_caps.uhs_max_dtr =
UHS_SDR50_MAX_DTR;
> > > > >  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> > > > >  		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
> > > > >  		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25))
> > {
> > > > >  			bus_speed = UHS_SDR25_BUS_SPEED;
> > > > > -			timing = MMC_TIMING_UHS_SDR25;
> > > > > -			card->sw_caps.uhs_max_dtr =
UHS_SDR25_MAX_DTR;
> > > > >  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> > > > >  		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
> > > > >  		    MMC_CAP_UHS_SDR12)) && (card-
> > >sw_caps.sd3_bus_mode &
> > > > >  		    SD_MODE_UHS_SDR12)) {
> > > > >  			bus_speed = UHS_SDR12_BUS_SPEED;
> > > > > +	}
> > > > > +
> > > > > +	return bus_speed;
> > > > > +}
> > > > > +
> > > > > +static int sd_set_bus_speed_mode(struct mmc_card *card, u8
> > > *status)
> > > > > +{
> > > > > +	int err, bus_speed;
> > > > > +	unsigned int timing = 0;
> > > > > +
> >
> > We need add this check here.
> >
> > 	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
> >   		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
> > MMC_CAP_UHS_DDR50)))
> > 			return 0;
> 
> Actually my very first patches returned directly from this function for
> the above condition. But if I remember correctly, Philip suggested that
> we should set the default speed too, so the *else if* clause below
> would take care of that.
> 
> >
> >
> > > > > +	bus_speed = sd_get_bus_speed_mode(card);
> > > > > +
> > > > > +	if (bus_speed == UHS_SDR104_BUS_SPEED) {
> > > > > +			timing = MMC_TIMING_UHS_SDR104;
> > > > > +			card->sw_caps.uhs_max_dtr =
UHS_SDR104_MAX_DTR;
> > > > > +	} else if (bus_speed == UHS_DDR50_BUS_SPEED) {
> > > > > +			timing = MMC_TIMING_UHS_DDR50;
> > > > > +			card->sw_caps.uhs_max_dtr =
UHS_DDR50_MAX_DTR;
> > > > > +	} else if (bus_speed == UHS_SDR50_BUS_SPEED) {
> > > > > +			timing = MMC_TIMING_UHS_SDR50;
> > > > > +			card->sw_caps.uhs_max_dtr =
UHS_SDR50_MAX_DTR;
> > > > > +	} else if (bus_speed == UHS_SDR25_BUS_SPEED) {
> > > > > +			timing = MMC_TIMING_UHS_SDR25;
> > > > > +			card->sw_caps.uhs_max_dtr =
UHS_SDR25_MAX_DTR;
> > > > > +	} else if (bus_speed == UHS_SDR12_BUS_SPEED) {
> > > > >  			timing = MMC_TIMING_UHS_SDR12;
> > > > >  			card->sw_caps.uhs_max_dtr =
UHS_SDR12_MAX_DTR;
> > > > > +	} else {
> > > > > +		return -EINVAL;
> > > > >  	}
> > > >
> > > > Minor change: I think "switch (sd_get_bus_speed_mode(card))"
> would
> > be
> > > > cleaner.
> >
> > Yes, we can replace it with switch. I will do it next patch rev.
> >
> > > >
> > > > >
> > > > >  	card->sd_bus_speed = bus_speed;
> > > > > @@ -522,6 +540,7 @@ static int sd_set_bus_speed_mode(struct
> > > mmc_card
> > > > *card, u8 *status)
> > > > >  static int sd_set_current_limit(struct mmc_card *card, u8
> > *status)
> > > > >  {
> > > > >  	int current_limit = 0;
> > > > > +	unsigned int bus_speed = sd_get_bus_speed_mode(card);
> > > > >  	int err;
> >
> > We need add this check here.
> >
> > 	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
> >   		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 |
> > MMC_CAP_UHS_DDR50)))
> > 			return 0;
> 
> Setting current limit is little different. As per section 4.3.10.3 of
> the Physical Layer Spec v3.01, Current Limit is only set for SDR50,
> SDR104, and DDR50 modes. For SDR12 and SDR25, we need to set the
> current limit of 200mA. So I don't think we should directly return from
> here.
> 
> >
> > > > >
> > > > >  	/*
> > > > > @@ -529,9 +548,9 @@ static int sd_set_current_limit(struct
> > mmc_card
> > > > *card, u8 *status)
> > > > >  	 * bus speed modes. For other bus speed modes, we set the
> > default
> > > > >  	 * current limit of 200mA.
> > > > >  	 */
> > > > > -	if ((card->sd_bus_speed == UHS_SDR50_BUS_SPEED) ||
> > > > > -	    (card->sd_bus_speed == UHS_SDR104_BUS_SPEED) ||
> > > > > -	    (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
> > > > > +	if ((bus_speed == UHS_SDR50_BUS_SPEED) ||
> > > > > +	    (bus_speed == UHS_SDR104_BUS_SPEED) ||
> > > > > +	    (bus_speed == UHS_DDR50_BUS_SPEED)) {
> > > > >  		if (card->host->caps & MMC_CAP_MAX_CURRENT_800) {
> > > > >  			if (card->sw_caps.sd3_curr_limit &
> > > > SD_MAX_CURRENT_800)
> > > > >  				current_limit =
SD_SET_CURRENT_LIMIT_800;
> > > > > @@ -613,13 +632,13 @@ static int mmc_sd_init_uhs_card(struct
> > > mmc_card
> > > > *card)
> > > > >  	if (err)
> > > > >  		goto out;
> > > > >
> > > > > -	/* Set bus speed mode of the card */
> > > > > -	err = sd_set_bus_speed_mode(card, status);
> > > > > +	/* Set current limit for the card */
> > > > > +	err = sd_set_current_limit(card, status);
> > > > >  	if (err)
> > > > >  		goto out;
> > > > >
> > > > > -	/* Set current limit for the card */
> > > > > -	err = sd_set_current_limit(card, status);
> > > > > +	/* Set bus speed mode of the card */
> > > > > +	err = sd_set_bus_speed_mode(card, status);
> > >
> > > Now supposing that we return -EINVAL here, then that would imply
> that
> > > mmc_sd_init_uhs_card() failed, but that should not be the case.
> Like
> > I
> > > mentioned before, the card should still be operable using default
> > speed
> > > mode.
> >
> > When you say Default speed mode, does it mean SDR12 mode?
> 
> Yes.
> 
> >
> > Thanks,
> > Subhash
> >
> > >
> > > Thanks,
> > > Arindam
> > >
> > > > >  	if (err)
> > > > >  		goto out;
> > > > >
> > > >
> > > > Thanks,
> > > >
> > > > - Chris.
> > > > --
> > > > Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> > > > One Laptop Per Child
> > >
> >
> >
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-
> msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

