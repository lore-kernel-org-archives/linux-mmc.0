From: Thierry Escande <thierry.escande@collabora.com>
Subject: Re: [PATCH v3 1/1] mmc: Hynix: add QUIRK_NOTIFY_POWEROFF_ON_SLEEP
Date: Wed, 30 Nov 2016 10:10:15 +0100
Message-ID: <302c7160-bdb2-d31a-4847-5c066f43feaf@collabora.com>
References: <1480429488-22289-1-git-send-email-thierry.escande@collabora.com>
 <CGME20161129142519epcas3p17c89a8e9123e8daa7d2479cb9d107fad@epcas3p1.samsung.com>
 <1480429488-22289-2-git-send-email-thierry.escande@collabora.com>
 <89a61073-6f1e-d386-c2d1-866447bcd715@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50297 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932141AbcK3JKT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Nov 2016 04:10:19 -0500
In-Reply-To: <89a61073-6f1e-d386-c2d1-866447bcd715@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>, bhthompson@chromium.org, linux-mmc@vger.kernel.org

Hi Jaehoon,

On 30/11/2016 09:46, Jaehoon Chung wrote:
> On 11/29/2016 11:24 PM, Thierry Escande wrote:
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index df19777..774d478 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1941,8 +1941,14 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
>>  	if (mmc_can_poweroff_notify(host->card) &&
>>  		((host->caps2 & MMC_CAP2_FULL_PWR_CYCLE) || !is_suspend))
>>  		err = mmc_poweroff_notify(host->card, notify_type);
>> -	else if (mmc_can_sleep(host->card))
>> +	else if (mmc_can_sleep(host->card)) {
>> +		if (host->card->quirks & MMC_QUIRK_NOTIFY_POWEROFF_ON_SLEEP) {
>> +			err = mmc_poweroff_notify(host->card, notify_type);
>> +			if (err)
>> +				goto out;
>> +		}
>>  		err = mmc_sleep(host);
>
> After running mmc_poweroff_notify(), also doing mmc_sleep()? Is it right?

Yes, that's what the quirk is intended for. This firmware resumes from 
sleep faster if it has been notified for power-off. This is a 
recommendation from Hynix.

Regards,
  Thierry
