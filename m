From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-at91: Fix module autoload
Date: Fri, 21 Oct 2016 10:23:29 +0300
Message-ID: <488cd9f4-1522-6346-6618-0f3168badf96@intel.com>
References: <1476720825-30442-1-git-send-email-javier@osg.samsung.com>
 <1476720825-30442-2-git-send-email-javier@osg.samsung.com>
 <20161021064819.4y5jrdetrqsvibfa@rfolt0960.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161021064819.4y5jrdetrqsvibfa@rfolt0960.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On 21/10/16 09:48, Ludovic Desroches wrote:
> On Mon, Oct 17, 2016 at 01:13:45PM -0300, Javier Martinez Canillas wrote:
>> If the driver is built as a module, autoload won't work because the module
>> alias information is not filled. So user-space can't match the registered
>> device with the corresponding module.
>>
>> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
>>
>> Before this patch:
>>
>> $ modinfo drivers/mmc/host/sdhci-of-at91.ko | grep alias
>> $
>>
>> After this patch:
>>
>> $ modinfo drivers/mmc/host/sdhci-of-at91.ko | grep alias
>> alias:          of:N*T*Catmel,sama5d2-sdhciC*
>> alias:          of:N*T*Catmel,sama5d2-sdhci
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> 
> Thanks
>> ---
>>
>>  drivers/mmc/host/sdhci-of-at91.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
>> index a9b7fc06c434..2f9ad213377a 100644
>> --- a/drivers/mmc/host/sdhci-of-at91.c
>> +++ b/drivers/mmc/host/sdhci-of-at91.c
>> @@ -100,6 +100,7 @@ static const struct of_device_id sdhci_at91_dt_match[] = {
>>  	{ .compatible = "atmel,sama5d2-sdhci", .data = &soc_data_sama5d2 },
>>  	{}
>>  };
>> +MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>>  
>>  #ifdef CONFIG_PM
>>  static int sdhci_at91_runtime_suspend(struct device *dev)
>> -- 
>> 2.7.4
>>
> 
