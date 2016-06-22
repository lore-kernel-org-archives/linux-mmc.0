From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/3] mmc: dw_mmc: prevent to set the wrong value
Date: Wed, 22 Jun 2016 13:15:37 +0900
Message-ID: <576A10E9.30101@samsung.com>
References: <1466487339-13211-1-git-send-email-jh80.chung@samsung.com>
 <1466487339-13211-3-git-send-email-jh80.chung@samsung.com>
 <CGME20160621081340epcas1p1c3ae89bbfc82f21649b9e496e615f563@epcas1p1.samsung.com>
 <ab1a9cae-b841-4ec2-8382-7f355b352382@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:56054 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750777AbcFVEPk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Jun 2016 00:15:40 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0O9502XP9NU19P90@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 22 Jun 2016 13:15:37 +0900 (KST)
In-reply-to: <ab1a9cae-b841-4ec2-8382-7f355b352382@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

On 06/21/2016 05:13 PM, Shawn Lin wrote:
> On 2016/6/21 13:35, Jaehoon Chung wrote:
>> If there ins no vqmmc, voltage should not be changed.
>> Then it nees to maintain the previous status for USH_REG register.
>> To use the standard spec, it should be returned error when voltage
>> can't switch.
>>
>> Note:
>> Dwmmc controller will not make any exception case.(like exynos.)
>> If card isn't working well after appling this patch, it needs to check
>> the regulator side.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>> Changelog V2:
>>     -Fix the typo
>>
>>  drivers/mmc/host/dw_mmc.c | 40 ++++++++++++++++++++++------------------
>>  1 file changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index ec3f0a8..56c48fb 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1404,33 +1404,37 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>>      struct dw_mci_slot *slot = mmc_priv(mmc);
>>      struct dw_mci *host = slot->host;
>>      const struct dw_mci_drv_data *drv_data = host->drv_data;
>> -    u32 uhs;
>> +    u32 uhs = 0;
>>      u32 v18 = SDMMC_UHS_18V << slot->id;
>>      int ret;
>>
>>      if (drv_data && drv_data->switch_voltage)
>>          return drv_data->switch_voltage(mmc, ios);
>>
>> -    /*
>> -     * Program the voltage.  Note that some instances of dw_mmc may use
>> -     * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
>> -     * does no harm but you need to set the regulator directly.  Try both.
>> -     */
>> +    if (IS_ERR(mmc->supply.vqmmc)) {
>> +        dev_dbg(&mmc->class_dev,
>> +            "vqmmc not available.(Skip the switching voltage)\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    ret = mmc_regulator_set_vqmmc(mmc, ios);
>> +    if (ret) {
>> +        dev_err(&mmc->class_dev,
>> +                 "Regulator set error %d - %s V\n",
>> +                 ret, uhs & v18 ? "1.8" : "3.3");
>> +        return ret;
>> +    }
>> +
>>      uhs = mci_readl(host, UHS_REG);
>> -    if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> 
> uhs is still zero now, so maybe we can remove this switch branch and
> only need a simple checking like this:
> 
> if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
>     uhs |= v18;

It's not enough to set the correct value.
So i will maintain this patch..

In future, i will add the MMC_SIGNAL_VOLTAGE_120 for USH_REG_EXT register.
At that time, switch statement should be better than "if" statement.. :)

Anyway, I applied this patch on my repository. If you have any objection, i will accept your opinion. :)

Best Regards,
Jaehoon Chung

> 
> otherwise, it looks good to me.
> 
>> +    switch (ios->signal_voltage) {
>> +    case MMC_SIGNAL_VOLTAGE_330:
>>          uhs &= ~v18;
>> -    else
>> +        break;
>> +    case MMC_SIGNAL_VOLTAGE_180:
>>          uhs |= v18;
>> -
>> -    if (!IS_ERR(mmc->supply.vqmmc)) {
>> -        ret = mmc_regulator_set_vqmmc(mmc, ios);
>> -
>> -        if (ret) {
>> -            dev_dbg(&mmc->class_dev,
>> -                     "Regulator set error %d - %s V\n",
>> -                     ret, uhs & v18 ? "1.8" : "3.3");
>> -            return ret;
>> -        }
>> +        break;
>> +    default:
>> +        uhs &= ~v18;
>>      }
>>      mci_writel(host, UHS_REG, uhs);
>>
>>
> 
> 

