From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] mmc: core: add new cap for 3.3V only DDR MMCs
Date: Sun, 7 Aug 2016 10:07:00 +0800
Message-ID: <7284d9a4-164d-dd2d-b9a0-dd1de6c76274@rock-chips.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
 <1470488140-10104-3-git-send-email-stefan.wahren@i2se.com>
 <0e38d62a-b3d0-30ca-fca9-bb740ae54d0a@denx.de>
 <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <16443443.114784.752d0f22-93a7-46e8-bb14-c884787aaea3.open-xchange-7tX72C7vayboQLBSYMtkGA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Otavio Salvador <otavio-fKevB0iiKLMBZ+LybsDmbA@public.gmane.org>, Holger Schurig <holgerschurig-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

在 2016/8/6 22:18, Stefan Wahren 写道:
> Hi Marek,
>
>> Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> hat am 6. August 2016 um 15:14 geschrieben:
>>
>>
>> On 08/06/2016 02:55 PM, Stefan Wahren wrote:
>>> This patch based on the work of Fabio Estevam:
>>> "[PATCH v2] mmc: core: Do not set mmc voltage to 1.8V when
>>> 'no-1-8-v' is present"
>>>
>>> It adds the support for 3.3V only DDR MMC hosts.
>>
>> Do such cards even exist ? Do you have a link where I can find some ?
>
> i never said anything about SD cards. I mean eMMC modules which usually have 8
> data pins like this one [1].
>
> Please don't blame me if it's not compatible to i.MX28. It's only an example.
>
> [1] -
> http://datasheet.octopart.com/THGBM3G4D1FBAIGH2H-Toshiba-datasheet-20748880.pdf


I download the datasheet you mentioned, and I explicitly see it
describe 1V8 everywhere, especially for the section of "ELECTRICAL
CHARACTERISTICS".

I never see one eMMC claiming DDR52 capability but doesn't support 1V8
so far. Could you kindly share me the part number of the eMMC you are
using? :)

>
>>
>>> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
>>> ---
>>>  drivers/mmc/core/host.c  |    2 ++
>>>  drivers/mmc/core/mmc.c   |    6 ++++++
>>>  include/linux/mmc/host.h |    1 +
>>>  3 files changed, 9 insertions(+)
>>>
>>> Changes to Fabio's patch:
>>> - rebase to current linux-next
>>> - rename DT property to mmc-ddr-3_3v
>>> - use EXT_CSD_CARD_TYPE_DDR_52 instead of new define
>>>
>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>> index 98f25ff..4c971de 100644
>>> --- a/drivers/mmc/core/host.c
>>> +++ b/drivers/mmc/core/host.c
>>> @@ -301,6 +301,8 @@ int mmc_of_parse(struct mmc_host *host)
>>>  	if (of_property_read_bool(np, "wakeup-source") ||
>>>  	    of_property_read_bool(np, "enable-sdio-wakeup")) /* legacy */
>>>  		host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>>> +	if (of_property_read_bool(np, "mmc-ddr-3_3v"))
>>> +		host->caps2 |= MMC_CAP2_3_3V_ONLY_DDR;
>>>  	if (of_property_read_bool(np, "mmc-ddr-1_8v"))
>>>  		host->caps |= MMC_CAP_1_8V_DDR;
>>>  	if (of_property_read_bool(np, "mmc-ddr-1_2v"))
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index f2d185c..8a933d5 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -210,6 +210,12 @@ static void mmc_select_card_type(struct mmc_card *card)
>>>  		avail_type |= EXT_CSD_CARD_TYPE_HS_52;
>>>  	}
>>>
>>> +	if (caps2 & MMC_CAP2_3_3V_ONLY_DDR &&
>>> +	    card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
>>> +		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>>> +		avail_type |= EXT_CSD_CARD_TYPE_DDR_52;
>>> +	}
>>> +
>>>  	if (caps & MMC_CAP_1_8V_DDR &&
>>>  	    card_type & EXT_CSD_CARD_TYPE_DDR_1_8V) {
>>>  		hs_max_dtr = MMC_HIGH_DDR_MAX_DTR;
>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>> index aa4bfbf..db0775d 100644
>>> --- a/include/linux/mmc/host.h
>>> +++ b/include/linux/mmc/host.h
>>> @@ -311,6 +311,7 @@ struct mmc_host {
>>>  #define MMC_CAP2_HS400_ES	(1 << 20)	/* Host supports enhanced strobe */
>>>  #define MMC_CAP2_NO_SD		(1 << 21)	/* Do not send SD commands during
>>> initialization */
>>>  #define MMC_CAP2_NO_MMC		(1 << 22)	/* Do not send (e)MMC commands during
>>> initialization */
>>> +#define MMC_CAP2_3_3V_ONLY_DDR	(1 << 23)	/* Only supports 3.3V DDR */
>>>
>>>  	mmc_pm_flag_t		pm_caps;	/* supported pm features */
>>>
>>>
>>
>>
>> --
>> Best regards,
>> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
