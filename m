From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc-rockchip: remove dw_mci_rockchip_pmops
Date: Fri, 12 Feb 2016 19:42:31 +0800
Message-ID: <56BDC527.9090002@rock-chips.com>
References: <1454470004-21408-1-git-send-email-shawn.lin@rock-chips.com>
 <56B2EC67.4010909@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56B2EC67.4010909@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 2016/2/4 14:15, Jaehoon Chung wrote:
> Hi, Shawn.
>
> On 02/03/2016 12:26 PM, Shawn Lin wrote:
>> dw_mci_rockchip_pmops just copy-paste what dw_mci_pltfm_pmops
>> have done. Let's remove it.
>
> Yep, it's possible to remove.
> I'm not sure but i want to know there is no plan to add the specific code of rockchip in suspend/resume.
> Could you check this?

Jaehoon,

:) I can't say "never plan to add anything" in case of some broken Socs
need something special to do in the future. But I will that would not 
happen, and personally we not going to add specific code here.

Thanks for sharing your thought.

>
> Best Regards,
> Jaehoon Chung
>
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>   drivers/mmc/host/dw_mmc-rockchip.c | 22 +---------------------
>>   1 file changed, 1 insertion(+), 21 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
>> index d9c92f3..3438ab3 100644
>> --- a/drivers/mmc/host/dw_mmc-rockchip.c
>> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
>> @@ -276,33 +276,13 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
>>   	return dw_mci_pltfm_register(pdev, drv_data);
>>   }
>>
>> -#ifdef CONFIG_PM_SLEEP
>> -static int dw_mci_rockchip_suspend(struct device *dev)
>> -{
>> -	struct dw_mci *host = dev_get_drvdata(dev);
>> -
>> -	return dw_mci_suspend(host);
>> -}
>> -
>> -static int dw_mci_rockchip_resume(struct device *dev)
>> -{
>> -	struct dw_mci *host = dev_get_drvdata(dev);
>> -
>> -	return dw_mci_resume(host);
>> -}
>> -#endif /* CONFIG_PM_SLEEP */
>> -
>> -static SIMPLE_DEV_PM_OPS(dw_mci_rockchip_pmops,
>> -			 dw_mci_rockchip_suspend,
>> -			 dw_mci_rockchip_resume);
>> -
>>   static struct platform_driver dw_mci_rockchip_pltfm_driver = {
>>   	.probe		= dw_mci_rockchip_probe,
>>   	.remove		= dw_mci_pltfm_remove,
>>   	.driver		= {
>>   		.name		= "dwmmc_rockchip",
>>   		.of_match_table	= dw_mci_rockchip_match,
>> -		.pm		= &dw_mci_rockchip_pmops,
>> +		.pm		= &dw_mci_pltfm_pmops,
>>   	},
>>   };
>>
>>
>
>
>
>


-- 
Best Regards
Shawn Lin
