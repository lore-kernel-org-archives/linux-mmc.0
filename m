From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: Export card RCA register to sysfs.
Date: Tue, 6 Mar 2018 22:45:44 +0800
Message-ID: <5377795c-d065-99cb-195a-8ea37c8dd579@rock-chips.com>
References: <1519732580-2867-1-git-send-email-harish_kandiga@mentor.com>
 <9ed7e027-9fc0-0d29-33bc-87811b496510@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9ed7e027-9fc0-0d29-33bc-87811b496510@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: ulf.hansson@linaro.org, linus.walleij@linaro.org, adrian.hunter@intel.com, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2018/3/6 20:48, Harish Jenny K N wrote:
> 
> 
> On Tuesday 27 February 2018 05:26 PM, Harish Jenny K N wrote:
>> This patch exports RCA register to sysfs which will help in
>> reading the disk identification information.
>>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
>>   drivers/mmc/core/mmc.c | 2 ++
>>   drivers/mmc/core/sd.c  | 2 ++
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 208a762..d45a244 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -792,6 +792,7 @@ static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
>>   MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
>>   MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>>   MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>> +MMC_DEV_ATTR(rca, "0x%x\n", card->rca);
>>   MMC_DEV_ATTR(cmdq_en, "%d\n", card->ext_csd.cmdq_en);

Just a nit that I tried to find some convention here, as RCA is a 16-bit 
register, so perhaps "0x%04x\n"? Otherwise,

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>>
>>   static ssize_t mmc_fwrev_show(struct device *dev,
>> @@ -848,6 +849,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>>   	&dev_attr_raw_rpmb_size_mult.attr,
>>   	&dev_attr_rel_sectors.attr,
>>   	&dev_attr_ocr.attr,
>> +	&dev_attr_rca.attr,
>>   	&dev_attr_dsr.attr,
>>   	&dev_attr_cmdq_en.attr,
>>   	NULL,
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 62b84dd..17d9005 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -676,6 +676,7 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
>>   MMC_DEV_ATTR(oemid, "0x%04x\n", card->cid.oemid);
>>   MMC_DEV_ATTR(serial, "0x%08x\n", card->cid.serial);
>>   MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
>> +MMC_DEV_ATTR(rca, "0x%x\n", card->rca);

Ditto.

>>
>>
>>   static ssize_t mmc_dsr_show(struct device *dev,
>> @@ -709,6 +710,7 @@ static ssize_t mmc_dsr_show(struct device *dev,
>>   	&dev_attr_oemid.attr,
>>   	&dev_attr_serial.attr,
>>   	&dev_attr_ocr.attr,
>> +	&dev_attr_rca.attr,
>>   	&dev_attr_dsr.attr,
>>   	NULL,
>>   };
>> --
>> 1.9.1
>>
> 
> 
> 
> Any comments/inputs on this ?
> 
> 
> Thanks,
> Harish Jenny K N
> 
> 
> 


-- 
Best Regards
Shawn Lin
