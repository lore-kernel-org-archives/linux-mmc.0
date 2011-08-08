From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v1 1/1] mmc: sd: UHS-I bus speed should be set last in
 UHS initialization
Date: Mon, 8 Aug 2011 08:19:05 -0700
Message-ID: <7929E625-7C46-4CFF-BBB7-ADF19AF6A892@marvell.com>
References: <1312454295-10609-1-git-send-email-subhashj@codeaurora.org>
 <000001cc538c$40e3a790$c2aaf6b0$@org>
 <6C03668EAF45B747AF947A1603D1B3000197DD0F56@SAUSEXMBP01.amd.com>
 <000301cc5595$ed63a3c0$c82aeb40$@org>
 <6C03668EAF45B747AF947A1603D1B3000197E84BBD@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <6C03668EAF45B747AF947A1603D1B3000197E84BBD@SAUSEXMBP01.amd.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: Subhash Jadavani <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org


On Aug 7, 2011, at 11:46 PM, Nath, Arindam wrote:

> Hi Subhash,
> 
> 
>> -----Original Message-----
>> From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
>> Sent: Monday, August 08, 2011 12:09 PM
>> To: Nath, Arindam; linux-mmc@vger.kernel.org; 'Philip Rakity'
>> Cc: linux-arm-msm@vger.kernel.org
>> Subject: RE: [PATCH v1 1/1] mmc: sd: UHS-I bus speed should be set last
>> in UHS initialization
>> 
>> Hi Arindam,
>> 
>>> -----Original Message-----
>>> From: Nath, Arindam [mailto:Arindam.Nath@amd.com]
>>> Sent: Friday, August 05, 2011 10:54 PM
>>> To: Subhash Jadavani; linux-mmc@vger.kernel.org; 'Philip Rakity'
>>> Cc: linux-arm-msm@vger.kernel.org
>>> Subject: RE: [PATCH v1 1/1] mmc: sd: UHS-I bus speed should be set
>> last
>>> in UHS initialization
>>> 
>>> Hi Subhash,
>>> 
>>> The patch in general looks good to me, I have one comment below.
>>> 
>>>> -----Original Message-----
>>>> From: Subhash Jadavani [mailto:subhashj@codeaurora.org]
>>>> Sent: Friday, August 05, 2011 9:55 PM
>>>> To: linux-mmc@vger.kernel.org; Nath, Arindam; 'Philip Rakity'
>>>> Cc: linux-arm-msm@vger.kernel.org
>>>> Subject: RE: [PATCH v1 1/1] mmc: sd: UHS-I bus speed should be set
>>> last
>>>> in UHS initialization
>>>> 
>>>> Chris, Arindam, Philip,
>>>> 
>>>> Please let me know you comments on this reworked patch.
>>>> 
>>>> Regards,
>>>> Subhash
>>>> 
>>>>> -----Original Message-----
>>>>> From: linux-arm-msm-owner@vger.kernel.org [mailto:linux-arm-msm-
>>>>> owner@vger.kernel.org] On Behalf Of Subhash Jadavani
>>>>> Sent: Thursday, August 04, 2011 4:08 PM
>>>>> To: linux-mmc@vger.kernel.org
>>>>> Cc: linux-arm-msm@vger.kernel.org; Subhash Jadavani
>>>>> Subject: [PATCH v1 1/1] mmc: sd: UHS-I bus speed should be set
>> last
>>>> in
>>>>> UHS initialization
>>>>> 
>>>>> mmc_sd_init_uhs_card function sets the driver type, current limit
>>>>> and bus speed mode on card as well as on host controller side.
>>>>> 
>>>>> Currently bus speed mode is set by sending CMD6 to card and
>>>>> immediately setting the timing mode in host controller. But
>>>>> then before initiating tuning sequence, it also tries to set
>>>>> current limit by sending CMD6 to card which results in data
>>>>> timeout errors in controller if bus speed mode is SDR50/SDR104
>>> mode.
>>>>> 
>>>>> So basically bus speed mode should be set only after current
>> limit
>>>>> is set in the card and immediately after setting the bus speed
>>> mode,
>>>>> tuning sequence should be initiated.
>>>>> 
>>>>> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
>>>>> ---
>>>>> drivers/mmc/core/sd.c |   65 ++++++++++++++++++++++++++++++++++-
>> --
>>> --
>>>> --
>>>>> --------
>>>>> 1 files changed, 45 insertions(+), 20 deletions(-)
>>>>> 
>>>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>>>> index ff27741..769e587 100644
>>>>> --- a/drivers/mmc/core/sd.c
>>>>> +++ b/drivers/mmc/core/sd.c
>>>>> @@ -459,10 +459,9 @@ static int sd_select_driver_type(struct
>>> mmc_card
>>>>> *card, u8 *status)
>>>>> 	return 0;
>>>>> }
>>>>> 
>>>>> -static int sd_set_bus_speed_mode(struct mmc_card *card, u8
>>> *status)
>>>>> +static int sd_get_bus_speed_mode(struct mmc_card *card)
>>>>> {
>>>>> -	unsigned int bus_speed = 0, timing = 0;
>>>>> -	int err;
>>>>> +	int bus_speed = 0;
>>>>> 
>>>>> 	/*
>>>>> 	 * If the host doesn't support any of the UHS-I modes,
>> fallback
>>>>> on
>>>>> @@ -475,32 +474,57 @@ static int sd_set_bus_speed_mode(struct
>>>> mmc_card
>>>>> *card, u8 *status)
>>>>> 	if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
>>>>> 	    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)) {
>>>>> 			bus_speed = UHS_SDR104_BUS_SPEED;
>>>>> -			timing = MMC_TIMING_UHS_SDR104;
>>>>> -			card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
>>>>> 	} else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
>>>>> 		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50))
>> {
>>>>> 			bus_speed = UHS_DDR50_BUS_SPEED;
>>>>> -			timing = MMC_TIMING_UHS_DDR50;
>>>>> -			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
>>>>> 	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>>>>> 		    MMC_CAP_UHS_SDR50)) && (card-
>>> sw_caps.sd3_bus_mode &
>>>>> 		    SD_MODE_UHS_SDR50)) {
>>>>> 			bus_speed = UHS_SDR50_BUS_SPEED;
>>>>> -			timing = MMC_TIMING_UHS_SDR50;
>>>>> -			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
>>>>> 	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>>>>> 		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
>>>>> 		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25))
>> {
>>>>> 			bus_speed = UHS_SDR25_BUS_SPEED;
>>>>> -			timing = MMC_TIMING_UHS_SDR25;
>>>>> -			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
>>>>> 	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
>>>>> 		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
>>>>> 		    MMC_CAP_UHS_SDR12)) && (card-
>>> sw_caps.sd3_bus_mode &
>>>>> 		    SD_MODE_UHS_SDR12)) {
>>>>> 			bus_speed = UHS_SDR12_BUS_SPEED;
>>>>> -			timing = MMC_TIMING_UHS_SDR12;
>>>>> -			card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
>>>>> +	}
>>>>> +
>>>>> +	return bus_speed;
>>>>> +}
>>>>> +
>>>>> +static int sd_set_bus_speed_mode(struct mmc_card *card, u8
>>> *status)
>>>>> +{
>>>>> +	int err, bus_speed;
>>>>> +	unsigned int timing = 0;
>>>>> +
>>>>> +	bus_speed = sd_get_bus_speed_mode(card);
>>>>> +
>>>>> +	switch (bus_speed) {
>>>>> +	case UHS_SDR104_BUS_SPEED:
>>>>> +		timing = MMC_TIMING_UHS_SDR104;
>>>>> +		card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
>>>>> +		break;
>>>>> +	case UHS_DDR50_BUS_SPEED:
>>>>> +		timing = MMC_TIMING_UHS_DDR50;
>>>>> +		card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
>>>>> +		break;
>>>>> +	case UHS_SDR50_BUS_SPEED:
>>>>> +		timing = MMC_TIMING_UHS_SDR50;
>>>>> +		card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
>>>>> +		break;
>>>>> +	case UHS_SDR25_BUS_SPEED:
>>>>> +		timing = MMC_TIMING_UHS_SDR25;
>>>>> +		card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
>>>>> +		break;
>>>>> +	case UHS_SDR12_BUS_SPEED:
>>>>> +		timing = MMC_TIMING_UHS_SDR12;
>>>>> +		card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
>>>>> +		break;
>>>>> +	default:
>>>>> +		return 0;
>>>>> 	}
>>>>> 
>>>>> 	card->sd_bus_speed = bus_speed;
>>> 
>>> There is redundancy in the use of a variable here. We have
>> *bus_speed*,
>>> and we have *card->sd_bus_speed* which will eventually have the same
>>> value. The point to consider is this, if you use
>>> sd_get_bus_speed_mode() to return the current bus speed, then there
>> is
>>> a function call overhead, may be minor, associated with the call.
>> Right
>>> now we only use the return value from this function in
>>> sd_set_current_limit(), but in future there might be multiple calls
>>> from other functions. So rather than returning the *bus_speed* from
>>> sd_get_bus_speed() everytime, IMO it's better to have it stored in
>>> mmc_card structure, which can be used anytime later without any
>>> overhead. I would like to have another opinion on this.
>>> 
>> 
>> Yes, that is also fine. then I can do something like this: Rename
>> sd_get_bus_speed_mode to sd_update_bus_speed_mode() and this function
>> will
>> just set the "card->sd_bus_speed" mode depending on card and host
>> capability. Then call sd_update_bus_speed_mode() in
>> mmc_sd_init_uhs_card()
>> before calling
>> sd_select_driver_type(),sd_set_current_limit(),sd_set_bus_speed_mode()
>> functions and in all of these *set* functions, directly use
>> "card->sd_bus_speed".
>> 
>> Is this fine? if yes, then I can post the new patch with these changes.
> 
> I am OK with your suggestion.
> 
> Philip, do you want to add anything?

I am okay with this.  I need to see the final patch since I have code for sdio cards ready
that I will submit and would like to check things with the change.  Might be a case to
refactor the code to a one common routine and specific code for sd/sdio.


Philip
> 
>> 
>> Regards,
>> Subhash
>> 
>> 
>>> Thanks,
>>> Arindam
>>> 
>>>>> @@ -522,6 +546,7 @@ static int sd_set_bus_speed_mode(struct
>>> mmc_card
>>>>> *card, u8 *status)
>>>>> static int sd_set_current_limit(struct mmc_card *card, u8
>> *status)
>>>>> {
>>>>> 	int current_limit = 0;
>>>>> +	unsigned int bus_speed = sd_get_bus_speed_mode(card);
>>>>> 	int err;
>>>>> 
>>>>> 	/*
>>>>> @@ -529,9 +554,9 @@ static int sd_set_current_limit(struct
>> mmc_card
>>>>> *card, u8 *status)
>>>>> 	 * bus speed modes. For other bus speed modes, we set the
>> default
>>>>> 	 * current limit of 200mA.
>>>>> 	 */
>>>>> -	if ((card->sd_bus_speed == UHS_SDR50_BUS_SPEED) ||
>>>>> -	    (card->sd_bus_speed == UHS_SDR104_BUS_SPEED) ||
>>>>> -	    (card->sd_bus_speed == UHS_DDR50_BUS_SPEED)) {
>>>>> +	if ((bus_speed == UHS_SDR50_BUS_SPEED) ||
>>>>> +	    (bus_speed == UHS_SDR104_BUS_SPEED) ||
>>>>> +	    (bus_speed == UHS_DDR50_BUS_SPEED)) {
>>>>> 		if (card->host->caps & MMC_CAP_MAX_CURRENT_800) {
>>>>> 			if (card->sw_caps.sd3_curr_limit &
>>>>> SD_MAX_CURRENT_800)
>>>>> 				current_limit = SD_SET_CURRENT_LIMIT_800;
>>>>> @@ -613,13 +638,13 @@ static int mmc_sd_init_uhs_card(struct
>>> mmc_card
>>>>> *card)
>>>>> 	if (err)
>>>>> 		goto out;
>>>>> 
>>>>> -	/* Set bus speed mode of the card */
>>>>> -	err = sd_set_bus_speed_mode(card, status);
>>>>> +	/* Set current limit for the card */
>>>>> +	err = sd_set_current_limit(card, status);
>>>>> 	if (err)
>>>>> 		goto out;
>>>>> 
>>>>> -	/* Set current limit for the card */
>>>>> -	err = sd_set_current_limit(card, status);
>>>>> +	/* Set bus speed mode of the card */
>>>>> +	err = sd_set_bus_speed_mode(card, status);
>>>>> 	if (err)
>>>>> 		goto out;
>>>>> 
>>>>> --
>>>>> 1.7.1.1
>>>>> 
>>>>> --
>>>>> Sent by a consultant of the Qualcomm Innovation Center, Inc.
>>>>> The Qualcomm Innovation Center, Inc. is a member of the Code
>> Aurora
>>>>> Forum.
>>>>> 
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe linux-
>>> arm-
>>>>> msm" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-
>> info.html
>>>> 
>>> 
>> 
>> 
> 
> 
