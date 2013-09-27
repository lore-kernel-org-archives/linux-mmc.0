From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v2 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Fri, 27 Sep 2013 15:11:41 +0530
Message-ID: <CAK9yfHxNtcNu39oKB58ceSaVUJXd3QB=1zAZS4tHc92dY_oGYA@mail.gmail.com>
References: <1378976643-26717-1-git-send-email-sachin.kamat@linaro.org>
	<CAKohpok10OndjAULMBk7M+j1v1Tzsa2N7n71SOKqLiQXiAHJUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:59734 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab3I0Jlm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2013 05:41:42 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so3011203obc.28
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2013 02:41:42 -0700 (PDT)
In-Reply-To: <CAKohpok10OndjAULMBk7M+j1v1Tzsa2N7n71SOKqLiQXiAHJUQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 12 September 2013 14:54, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12 September 2013 14:34, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> pdata could be NULL if cd_gpio = -1. Dereference pdata only
>> if it is not NULL.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> Compile tested.
>> Changes since v1:
>> * Moved the pdata assignment inside if condition.
>> ---
>>  drivers/mmc/host/sdhci-spear.c |    8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
>> index 2dba9f8..76ddd89 100644
>> --- a/drivers/mmc/host/sdhci-spear.c
>> +++ b/drivers/mmc/host/sdhci-spear.c
>> @@ -84,14 +84,12 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
>>         /* If pdata is required */
>>         if (cd_gpio != -1) {
>>                 pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> -               if (!pdata) {
>> +               if (!pdata)
>>                         dev_err(&pdev->dev, "DT: kzalloc failed\n");
>> -                       return ERR_PTR(-ENOMEM);
>> -               }
>> +               else
>> +                       pdata->card_int_gpio = cd_gpio;
>>         }
>>
>> -       pdata->card_int_gpio = cd_gpio;
>> -
>>         return pdata;
>>  }
>>  #else
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>


Ping Chris.

-- 
With warm regards,
Sachin
