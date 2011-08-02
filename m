From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] mmc: sd: UHS-I bus speed should be set last in UHS
 initialization
Date: Tue, 2 Aug 2011 02:08:23 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B3000197C66B0B@SAUSEXMBP01.amd.com>
References: <1312199897-5536-1-git-send-email-subhashj@codeaurora.org>
 <m2d3goc2r1.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <m2d3goc2r1.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Subhash Jadavani <subhashj@codeaurora.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Subhash,


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, August 02, 2011 1:40 AM
> To: Subhash Jadavani
> Cc: linux-mmc@vger.kernel.org; linux-arm-msm@vger.kernel.org; Nath,
> Arindam
> Subject: Re: [PATCH] mmc: sd: UHS-I bus speed should be set last in UHS
> initialization
> 
> Hi Subhash, adding Arindam for review,
> 
> On Mon, Aug 01 2011, Subhash Jadavani wrote:
> > mmc_sd_init_uhs_card function sets the driver type, current limit
> > and bus speed mode on card as well as on host controller side.
> >
> > Currently bus speed mode is set by sending CMD6 to card and
> > immediately setting the timing mode in host controller. But
> > then before initiating tuning sequence, it also tries to set
> > current limit by sending CMD6 to card which results in data
> > timeout errors in controller if bus speed mode is SDR50/SDR104 mode.
> >
> > So basically bus speed mode should be set only after current limit
> > is set in the card and immediately after setting the bus speed mode,
> > tuning sequence should be initiated.
> >
> > Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> > ---
> >  drivers/mmc/core/sd.c |   57 ++++++++++++++++++++++++++++++++-------
> ---------
> >  1 files changed, 38 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> > index ff27741..d257496 100644
> > --- a/drivers/mmc/core/sd.c
> > +++ b/drivers/mmc/core/sd.c
> > @@ -459,10 +459,9 @@ static int sd_select_driver_type(struct mmc_card
> *card, u8 *status)
> >  	return 0;
> >  }
> >
> > -static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
> > +static int sd_get_bus_speed_mode(struct mmc_card *card)
> >  {
> > -	unsigned int bus_speed = 0, timing = 0;
> > -	int err;
> > +	int bus_speed = 0;
> >
> >  	/*
> >  	 * If the host doesn't support any of the UHS-I modes, fallback
> on
> > @@ -470,37 +469,56 @@ static int sd_set_bus_speed_mode(struct
> mmc_card *card, u8 *status)
> >  	 */
> >  	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
> >  	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50)))
> > -		return 0;
> > +		return -EINVAL;

We should not return -EINVAL here, because this is not an error condition. This would simply mean that the card and host controller will fall back to using the default bus speed, and should still be operable. Check the comment below too.

> >
> >  	if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
> >  	    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)) {
> >  			bus_speed = UHS_SDR104_BUS_SPEED;
> > -			timing = MMC_TIMING_UHS_SDR104;
> > -			card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
> >  	} else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
> >  		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50)) {
> >  			bus_speed = UHS_DDR50_BUS_SPEED;
> > -			timing = MMC_TIMING_UHS_DDR50;
> > -			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> >  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> >  		    MMC_CAP_UHS_SDR50)) && (card->sw_caps.sd3_bus_mode &
> >  		    SD_MODE_UHS_SDR50)) {
> >  			bus_speed = UHS_SDR50_BUS_SPEED;
> > -			timing = MMC_TIMING_UHS_SDR50;
> > -			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
> >  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> >  		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
> >  		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
> >  			bus_speed = UHS_SDR25_BUS_SPEED;
> > -			timing = MMC_TIMING_UHS_SDR25;
> > -			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> >  	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
> >  		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
> >  		    MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode &
> >  		    SD_MODE_UHS_SDR12)) {
> >  			bus_speed = UHS_SDR12_BUS_SPEED;
> > +	}
> > +
> > +	return bus_speed;
> > +}
> > +
> > +static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
> > +{
> > +	int err, bus_speed;
> > +	unsigned int timing = 0;
> > +
> > +	bus_speed = sd_get_bus_speed_mode(card);
> > +
> > +	if (bus_speed == UHS_SDR104_BUS_SPEED) {
> > +			timing = MMC_TIMING_UHS_SDR104;
> > +			card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
> > +	} else if (bus_speed == UHS_DDR50_BUS_SPEED) {
> > +			timing = MMC_TIMING_UHS_DDR50;
> > +			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
> > +	} else if (bus_speed == UHS_SDR50_BUS_SPEED) {
> > +			timing = MMC_TIMING_UHS_SDR50;
> > +			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
> > +	} else if (bus_speed == UHS_SDR25_BUS_SPEED) {
> > +			timing = MMC_TIMING_UHS_SDR25;
> > +			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
> > +	} else if (bus_speed == UHS_SDR12_BUS_SPEED) {
> >  			timing = MMC_TIMING_UHS_SDR12;
> >  			card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
> > +	} else {
> > +		return -EINVAL;
> >  	}
> 
> Minor change: I think "switch (sd_get_bus_speed_mode(card))" would be
> cleaner.
> 
> >
> >  	card->sd_bus_speed = bus_speed;
> > @@ -522,6 +540,7 @@ static int sd_set_bus_speed_mode(struct mmc_card
> *card, u8 *status)
> >  static int sd_set_current_limit(struct mmc_card *card, u8 *status)
> >  {
> >  	int current_limit = 0;
> > +	unsigned int bus_speed = sd_get_bus_speed_mode(card);
> >  	int err;
> >
> >  	/*
> > @@ -529,9 +548,9 @@ static int sd_set_current_limit(struct mmc_card
> *card, u8 *status)
> >  	 * bus speed modes. For other bus speed modes, we set the default
> >  	 * current limit of 200mA.
> >  	 */
> > -	if ((card->sd_bus_speed == UHS_SDR50_BUS_SPEED) ||
> > -	    (card->sd_bus_speed == UHS_SDR104_BUS_SPEED) ||
> > -	    (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
> > +	if ((bus_speed == UHS_SDR50_BUS_SPEED) ||
> > +	    (bus_speed == UHS_SDR104_BUS_SPEED) ||
> > +	    (bus_speed == UHS_DDR50_BUS_SPEED)) {
> >  		if (card->host->caps & MMC_CAP_MAX_CURRENT_800) {
> >  			if (card->sw_caps.sd3_curr_limit &
> SD_MAX_CURRENT_800)
> >  				current_limit = SD_SET_CURRENT_LIMIT_800;
> > @@ -613,13 +632,13 @@ static int mmc_sd_init_uhs_card(struct mmc_card
> *card)
> >  	if (err)
> >  		goto out;
> >
> > -	/* Set bus speed mode of the card */
> > -	err = sd_set_bus_speed_mode(card, status);
> > +	/* Set current limit for the card */
> > +	err = sd_set_current_limit(card, status);
> >  	if (err)
> >  		goto out;
> >
> > -	/* Set current limit for the card */
> > -	err = sd_set_current_limit(card, status);
> > +	/* Set bus speed mode of the card */
> > +	err = sd_set_bus_speed_mode(card, status);

Now supposing that we return -EINVAL here, then that would imply that mmc_sd_init_uhs_card() failed, but that should not be the case. Like I mentioned before, the card should still be operable using default speed mode.

Thanks,
Arindam

> >  	if (err)
> >  		goto out;
> >
> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
