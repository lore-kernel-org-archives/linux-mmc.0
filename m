From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from
 sdhci_add_host() fn
Date: Wed, 2 Sep 2015 18:37:35 +0530
Message-ID: <55E6F497.8080300@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
 <1441139838.12163.5.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441139838.12163.5.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Wednesday 02 September 2015 02:07 AM, Joe Perches wrote:
> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>> Return value would give clear information about the actual root-cause
>> of the failure.
>> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
>> @@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>
>>   	ret = sdhci_add_host(host);
>>   	if (ret) {
>> -		dev_err(&pdev->dev, "failed to add host\n");
>> +		dev_err(&pdev->dev, "failed to add host ret - %d\n", ret);
>>   		goto err_add_host;
>>   	}
>>
>
> If this is really desirable, there are many other callers of
> sdhci_add_host with error messages just like this one.
>

How about this? If you are ok, I can change it and submit the patch
again.


diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d2caa60..3a4902c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3176,8 +3176,11 @@ int sdhci_add_host(struct sdhci_host *host)
                 mmc->caps |= MMC_CAP_NEEDS_POLL;

         /* If there are external regulators, get them */
-       if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER)
+       if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER) {
+               pr_err("%s: regulator supply unavailable, deferring 
probe. \n",
+                               mmc_hostname(mmc));
                 return -EPROBE_DEFER;
+       }

         /* If vqmmc regulator and no 1.8V signalling, then there's no 
UHS */
         if (!IS_ERR(mmc->supply.vqmmc)) {


Thanks,
Vaibhav
