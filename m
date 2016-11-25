From: Joonyoung Shim <jy0922.shim@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: add missing codes for runtime resume
Date: Fri, 25 Nov 2016 11:55:09 +0900
Message-ID: <5837A80D.3020902@samsung.com>
References: <CGME20161123094435epcas1p358457576f3e08aa57b19012efc8c7ad1@epcas1p3.samsung.com>
 <1479893632-1742-1-git-send-email-jy0922.shim@samsung.com>
 <4478096a-4d57-f739-d746-17c506548981@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55003 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750935AbcKYCya (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Nov 2016 21:54:30 -0500
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OH6016ETG2O0860@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Nov 2016 11:54:25 +0900 (KST)
In-reply-to: <4478096a-4d57-f739-d746-17c506548981@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, shawn.lin@rock-chips.com, "jy0922.shim@samsung.com >> Joonyoung Shim" <jy0922.shim@samsung.com>

Hi jaehoon,

On 11/25/2016 11:37 AM, Jaehoon Chung wrote:
> Hi Joonyoung,
> 
> On 11/23/2016 06:33 PM, Joonyoung Shim wrote:
>> The commit 64997de4fd17 ("mmc: dw_mmc: remove system PM callback") is
>> missing to call dw_mci_ctrl_reset(). This adds to call
>> dw_mci_ctrl_reset() and to handle error of clocks.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> 
> Applied on my dwmmc repository. Thanks!
> 

Thanks, but i found one more issue.

> Best Regards,
> Jaehoon Chung
> 
>> ---
>>  drivers/mmc/host/dw_mmc.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index d426fa41bcce..25e21a20ee04 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -3303,6 +3303,17 @@ int dw_mci_runtime_resume(struct device *dev)
>>  	if (ret)
>>  		return ret;

Here, error handling about biu_clk should be consider.

>>  
>> +	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS)) {
>> +		clk_disable_unprepare(host->ciu_clk);
>> +
>> +		if (host->cur_slot &&
>> +		    (mmc_can_gpio_cd(host->cur_slot->mmc) ||
>> +		     !mmc_card_is_removable(host->cur_slot->mmc)))
>> +			clk_disable_unprepare(host->biu_clk);
>> +
>> +		return -ENODEV;
>> +	}
>> +
>>  	if (host->use_dma && host->dma_ops->init)
>>  		host->dma_ops->init(host);
>>  
>>

I will send patch v2, could you review and apply patch v2 instead of v1?

Thanks.

