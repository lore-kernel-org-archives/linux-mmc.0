From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/4] mmc: core: add high-capacity erase size capability
 flag
Date: Thu, 09 Feb 2012 09:12:22 +0200
Message-ID: <4F3371D6.4060907@intel.com>
References: <1328618935-25175-1-git-send-email-adrian.hunter@intel.com> <1328618935-25175-2-git-send-email-adrian.hunter@intel.com> <4F32A399.4050609@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:36736 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751002Ab2BIHMT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Feb 2012 02:12:19 -0500
In-Reply-To: <4F32A399.4050609@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 08/02/12 18:32, Ulf Hansson wrote:
> On 02/07/2012 01:48 PM, Adrian Hunter wrote:
>> Let drivers specify the use of high-capacity erase size.
>>
>> Signed-off-by: Adrian Hunter<adrian.hunter@intel.com>
>> ---
>>   drivers/mmc/core/mmc.c   |    3 ++-
>>   include/linux/mmc/host.h |    1 +
>>   2 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 6b13776..bd2f71f 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -949,7 +949,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>        * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
>>        * bit.  This bit will be lost every time after a reset or power off.
>>        */
>> -    if (card->ext_csd.enhanced_area_en) {
>> +    if (card->ext_csd.enhanced_area_en ||
>> +        (card->ext_csd.rev>= 3&&  (host->caps2&  MMC_CAP2_HC_ERASE_SZ))) {
> 
> This will default disable this feature. Is that what we want?
> Why the need to disable this at all?

It will change the erase group size and the write protect group size.
That will cause breakage for anyone using write protect groups of
a smaller size.

> 
>>           err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>                    EXT_CSD_ERASE_GROUP_DEF, 1,
>>                    card->ext_csd.generic_cmd6_time);
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 20d7c82..c7ce9d2 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -258,6 +258,7 @@ struct mmc_host {
>>   #define MMC_CAP2_HS200        (MMC_CAP2_HS200_1_8V_SDR | \
>>                    MMC_CAP2_HS200_1_2V_SDR)
>>   #define MMC_CAP2_BROKEN_VOLTAGE    (1<<  7)    /* Use the broken voltage */
>> +#define MMC_CAP2_HC_ERASE_SZ    (1<<  8)    /* High-capacity erase size */
>>
>>       mmc_pm_flag_t        pm_caps;    /* supported pm features */
>>       unsigned int        power_notify_type;
> 
> Br
> Ulf Hansson
> 

