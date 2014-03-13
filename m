From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 2/5] mmc: identify available device type to select
Date: Thu, 13 Mar 2014 18:51:14 +0900
Message-ID: <53217F92.20606@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006901cf2a58$d844f440$88cedcc0$%jun@samsung.com>
 <003c01cf3a12$9b58e3b0$d20aab10$%jun@samsung.com>
 <531D908E.1070504@samsung.com>
 <001f01cf3c58$425f1570$c71d4050$%jun@samsung.com>
 <53214437.6010009@samsung.com>
 <000c01cf3e97$7cd177c0$76746740$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:35366 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494AbaCMJvS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Mar 2014 05:51:18 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2D00JQMCP90410@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 13 Mar 2014 18:51:10 +0900 (KST)
In-reply-to: <000c01cf3e97$7cd177c0$76746740$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

On 03/13/2014 05:37 PM, Seungwon Jeon wrote:
> On Thu, March 13, 2014, Jaehoon Chung wrote:
>> Dear, Seungwon.
>>
>> On 03/10/2014 08:59 PM, Seungwon Jeon wrote:
>>> On Mon, March 10, 2014, Jaehoon Chung wrote:
>>>> On 03/07/2014 11:36 PM, Seungwon Jeon wrote:
>>>>> Device types which are supported by both host and device
>>>>> can be identified when EXT_CSD is read. There is no need to
>>>>> check host's capability anymore.
>>>>>
>>>>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> 	Just rebased with latest one.
>>>>>
>>>>>  drivers/mmc/core/mmc.c   |   77 ++++++++++++++++++++++++++-------------------
>>>>>  include/linux/mmc/card.h |    6 ++-
>>>>>  include/linux/mmc/host.h |    6 ---
>>>>>  include/linux/mmc/mmc.h  |   12 +++++--
>>>>>  4 files changed, 56 insertions(+), 45 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>> index db9655f..0abece0 100644
>>>>> --- a/drivers/mmc/core/mmc.c
>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>> @@ -243,28 +243,46 @@ static void mmc_select_card_type(struct mmc_card *card)
>>>>>  	u8 card_type = card->ext_csd.raw_card_type & EXT_CSD_CARD_TYPE_MASK;
>>>>>  	u32 caps = host->caps, caps2 = host->caps2;
>>>>>  	unsigned int hs_max_dtr = 0;
>>>>> +	unsigned int avail_type = 0;
>>>>>
>>>>> -	if (card_type & EXT_CSD_CARD_TYPE_26)
>>>>> +	if (caps & MMC_CAP_MMC_HIGHSPEED &&
>>>>> +	    card_type & EXT_CSD_CARD_TYPE_HS_26) {
>>>>>  		hs_max_dtr = MMC_HIGH_26_MAX_DTR;
>>>>> +		avail_type |= EXT_CSD_CARD_TYPE_HS_26;
>>>>> +	}
>>>>>
>>>>>  	if (caps & MMC_CAP_MMC_HIGHSPEED &&
>>>>> -			card_type & EXT_CSD_CARD_TYPE_52)
>>>>> +	    card_type & EXT_CSD_CARD_TYPE_HS_52) {
>>>>>  		hs_max_dtr = MMC_HIGH_52_MAX_DTR;
>>>>> +		avail_type |= EXT_CSD_CARD_TYPE_HS_52;
>>>>> +	}
>>>> Can it bind with "caps & MMC_CAP_MMC_HIGHSPEED"?
>>> Yes, 'nested if' may be possible here.
>>> I just think current style is more harmonious though.
>> Don't mind. it's ok. :)
>>
>>>
>>>> if (caps & MMC_CAP_MMC_HIGH_SPEED) {
>>>> 	if (card_type & EXT_CSD_CARD_TYPE_HS_26) {
>>>> 		...
>>>> 	}
>>>> 	if (card_type & EXT_CSD_CARD_TYPE_HS_52) {
>>>> 		...
>>>> 	}
>>>> }
>>>>>
>>>>> -	if ((caps & MMC_CAP_1_8V_DDR &&
>>>>> -			card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) ||
>>>>> -	    (caps & MMC_CAP_1_2V_DDR &&
>>>>> -			card_type & EXT_CSD_CARD_TYPE_DDR_1_2V))
>>>>> +	if (caps & MMC_CAP_1_8V_DDR &&
>>>>> +	    card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
>>>>>  		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>>>>> +		avail_type |= EXT_CSD_CARD_TYPE_DDR_1_8V;
>>>>> +	}
>>>>>
>>>>> -	if ((caps2 & MMC_CAP2_HS200_1_8V_SDR &&
>>>>> -			card_type & EXT_CSD_CARD_TYPE_SDR_1_8V) ||
>>>>> -	    (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
>>>>> -			card_type & EXT_CSD_CARD_TYPE_SDR_1_2V))
>>>>> +	if (caps & MMC_CAP_1_2V_DDR &&
>>>>> +	    card_type & EXT_CSD_CARD_TYPE_DDR_1_2V) {
>>>>> +		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>>>>> +		avail_type |= EXT_CSD_CARD_TYPE_DDR_1_2V;
>>>>> +	}
>>>>> +
>>>>> +	if (caps2 & MMC_CAP2_HS200_1_8V_SDR &&
>>>>> +	    card_type & EXT_CSD_CARD_TYPE_HS200_1_8V) {
>>>>>  		hs_max_dtr = MMC_HS200_MAX_DTR;
>>>>> +		avail_type |= EXT_CSD_CARD_TYPE_HS200_1_8V;
>>>>> +	}
>>>>> +
>>>>> +	if (caps2 & MMC_CAP2_HS200_1_2V_SDR &&
>>>>> +	    card_type & EXT_CSD_CARD_TYPE_HS200_1_2V) {
>>>>> +		hs_max_dtr = MMC_HS200_MAX_DTR;
>>>>> +		avail_type |= EXT_CSD_CARD_TYPE_HS200_1_2V;
>>>>> +	}
>>>>>
>>>>>  	card->ext_csd.hs_max_dtr = hs_max_dtr;
>>>>> -	card->ext_csd.card_type = card_type;
>>>>> +	card->mmc_avail_type = avail_type;
>>>>>  }
>>>>>
>>>>>  /*
>>>>> @@ -708,6 +726,11 @@ static struct device_type mmc_type = {
>>>>>  	.groups = mmc_attr_groups,
>>>>>  };
>>>>>
>>>>> +static inline unsigned int mmc_snoop_ddr(struct mmc_card *card)
>>>>> +{
>>>>> +	return card->mmc_avail_type & EXT_CSD_CARD_TYPE_DDR_52;
>>>>> +}
>>>>> +
>>>>>  /*
>>>>>   * Select the PowerClass for the current bus width
>>>>>   * If power class is defined for 4/8 bit bus in the
>>>>> @@ -808,12 +831,10 @@ static int mmc_select_hs200(struct mmc_card *card)
>>>>>
>>>>>  	host = card->host;
>>>>>
>>>>> -	if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V &&
>>>>> -			host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
>>>>> +	if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_2V)
>>>>>  		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120);
>>>>>
>>>>> -	if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
>>>>> -			host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
>>>>> +	if (err && card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200_1_8V)
>>>>>  		err = __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
>>>>>
>>>>>  	/* If fails try again during next card power cycle */
>>>>> @@ -1072,10 +1093,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>>>>  	 */
>>>>>  	if (card->ext_csd.hs_max_dtr != 0) {
>>>>>  		err = 0;
>>>>> -		if (card->ext_csd.hs_max_dtr > 52000000 &&
>>>>> -		    host->caps2 & MMC_CAP2_HS200)
>>>> MMC_CAP2_HS200 need no more, doesn't?
>>> If you mean to remove 'MMC_CAP2_HS200' definition, it is currently used in sdhci.c
>> I have also checked that it is used in sdhci.c.
>> but I think that capability like MMC_CAP2_HS200 was defined to use for core, not controller.
>> It can be changed other quirks instead of MMC_CAP2_HS200 into sdhci.c
>> how about?
> Hmm.
> I feel like current way is not bad in sdhci.c, but if you have an idea, it would be different patch.
Sure..Then when your patch-set is merged, i will send the other patch.

Best Regards,
Jaehoon Chung
> 
> Thanks,
> Seungwon Jeon 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

