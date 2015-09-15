From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from
 sdhci_add_host() fn
Date: Tue, 15 Sep 2015 13:53:59 +0200
Message-ID: <CAPDyKFpteaVH16QG0OMYK2G8=nezQF9jdJgAS8sWAY_oDcqCiQ@mail.gmail.com>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
	<1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
	<1441139838.12163.5.camel@perches.com>
	<55E6F497.8080300@linaro.org>
	<1441206476.12163.44.camel@perches.com>
	<55E712E4.7080608@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55E712E4.7080608@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Cc: Joe Perches <joe@perches.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On 2 September 2015 at 17:16, Vaibhav Hiremath
<vaibhav.hiremath@linaro.org> wrote:
>
>
> On Wednesday 02 September 2015 08:37 PM, Joe Perches wrote:
>>
>> On Wed, 2015-09-02 at 18:37 +0530, Vaibhav Hiremath wrote:
>>>
>>> On Wednesday 02 September 2015 02:07 AM, Joe Perches wrote:
>>>>
>>>> On Wed, 2015-09-02 at 00:54 +0530, Vaibhav Hiremath wrote:
>>>>>
>>>>> Return value would give clear information about the actual root-cause
>>>>> of the failure.
>>>>> diff --git a/drivers/mmc/host/sdhci-pxav3.c
>>>>> b/drivers/mmc/host/sdhci-pxav3.c
>>>>> @@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device
>>>>> *pdev)
>>>>>
>>>>>         ret = sdhci_add_host(host);
>>>>>         if (ret) {
>>>>> -               dev_err(&pdev->dev, "failed to add host\n");
>>>>> +               dev_err(&pdev->dev, "failed to add host ret - %d\n",
>>>>> ret);
>>>>>                 goto err_add_host;
>>>>>         }
>>>>
>>>>
>>>> If this is really desirable, there are many other callers of
>>>> sdhci_add_host with error messages just like this one.
>>>>
>>> How about this? If you are ok, I can change it and submit the patch
>>> again.
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>
>> []
>>>
>>> @@ -3176,8 +3176,11 @@ int sdhci_add_host(struct sdhci_host *host)
>>>                   mmc->caps |= MMC_CAP_NEEDS_POLL;
>>>
>>>           /* If there are external regulators, get them */
>>> -       if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER)
>>> +       if (mmc_regulator_get_supply(mmc) == -EPROBE_DEFER) {
>>> +               pr_err("%s: regulator supply unavailable, deferring
>>> probe. \n",
>>> +                               mmc_hostname(mmc));
>>>                   return -EPROBE_DEFER;
>>> +       }
>>
>>
>> (your email client has inappropriate line wrapping)
>>
>> The KERN_<LEVEL> here probably isn't right.
>>
>> Deferring isn't an error, at best it's a notification
>
>
> I would consider it as an ERROR if it gets deferred
> continuously/multiple times due to same reason.
>
>> and perhaps should be at pr_notice/KERN_NOTICE
>>
>
> Yeah, KERN_NOTICE looks right here.
>
>> I don't know how often or how many times this deferral
>> can occur.  Do you?
>>
>
> -EDEFER_PROBE usually means that driver has some dependency,
> for which it has to wait.
> In my case, during every boot, I pxav3_sdhci_probe gets deferred once
> due to regulator unavailability.

The driver core already prints a message on the debug level for
-EDEFER_PROBE. Please don't do that in the driver as well.

Kind regards
Uffe
