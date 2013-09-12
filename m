From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-spear: Fix NULL pointer dereference
Date: Thu, 12 Sep 2013 13:41:05 +0530
Message-ID: <CAK9yfHzpLj6ZAcqikFWkOSWCSpU_NvchETgG0_65sU1Kb_F=kA@mail.gmail.com>
References: <1378968200-16577-1-git-send-email-sachin.kamat@linaro.org>
	<CAKohponUT5hh=saFcx7riFJB-DbPwhkYz2_7Gc2i--GWC6bYCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:34203 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348Ab3ILILG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 04:11:06 -0400
Received: by mail-oa0-f53.google.com with SMTP id k18so10594524oag.12
        for <linux-mmc@vger.kernel.org>; Thu, 12 Sep 2013 01:11:05 -0700 (PDT)
In-Reply-To: <CAKohponUT5hh=saFcx7riFJB-DbPwhkYz2_7Gc2i--GWC6bYCg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, spear-devel <spear-devel@list.st.com>

On 12 September 2013 13:19, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 12 September 2013 12:13, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> pdata could be NULL if cd_gpio = -1. Hence move the NULL check
>> outside the if condition.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>> Only compile tested.
>> ---
>>  drivers/mmc/host/sdhci-spear.c |   10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
>> index 2dba9f8..4f3557a 100644
>> --- a/drivers/mmc/host/sdhci-spear.c
>> +++ b/drivers/mmc/host/sdhci-spear.c
>> @@ -82,12 +82,12 @@ static struct sdhci_plat_data *sdhci_probe_config_dt(struct platform_device *pde
>>                 cd_gpio = -1;
>>
>>         /* If pdata is required */
>> -       if (cd_gpio != -1) {
>> +       if (cd_gpio != -1)
>>                 pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> -               if (!pdata) {
>> -                       dev_err(&pdev->dev, "DT: kzalloc failed\n");
>> -                       return ERR_PTR(-ENOMEM);
>> -               }
>> +
>> +       if (!pdata) {
>> +               dev_err(&pdev->dev, "pdata is NULL\n");
>> +               return ERR_PTR(-ENOMEM);
>>         }
>>
>>         pdata->card_int_gpio = cd_gpio;
>
> Or better move above line in the if block? We are already printing
> error in probe..

Yes. That was my second option. If we do that we would get something as below:

 84         /* If pdata is required */
 85         if (cd_gpio != -1) {
 86                pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
 87                if (!pdata) {
 88                    dev_err(&pdev->dev, "DT: kzalloc failed\n");
 89                    goto out;
 90                }
 91                pdata->card_int_gpio = cd_gpio;
 92                return pdata;
 93          }
 94
 95 out:
 96      return ERR_PTR(-ENODATA);

Does this look OK?

-- 
With warm regards,
Sachin
