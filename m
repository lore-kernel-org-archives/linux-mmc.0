From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/7] mmc: core add the property for hs200
Date: Tue, 21 Jan 2014 13:12:21 +0100
Message-ID: <CAPDyKFpV4pSxQEHrvqXyQEL2Q6hB2a0ryXgL+nwU16=2Y5brLQ@mail.gmail.com>
References: <52DE4916.4090603@samsung.com>
	<3339329.LQJLrAHSHx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:40593 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbaAUMMW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jan 2014 07:12:22 -0500
Received: by mail-qe0-f54.google.com with SMTP id df13so6858903qeb.41
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jan 2014 04:12:21 -0800 (PST)
In-Reply-To: <3339329.LQJLrAHSHx@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Seungwon Jeon <tgih.jun@samsung.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On 21 January 2014 11:30, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 21 January 2014 19:16:54 Jaehoon Chung wrote:
>> caps2-mmc-hs200-1.8v and caps2-mmc-hs200-1.2v can be used to the general capability.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> ---
>>  drivers/mmc/core/host.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 49bc403..96ac4c1 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -429,6 +429,10 @@ int mmc_of_parse(struct mmc_host *host)
>>                 host->pm_caps |= MMC_PM_KEEP_POWER;
>>         if (of_find_property(np, "enable-sdio-wakeup", &len))
>>                 host->pm_caps |= MMC_PM_WAKE_SDIO_IRQ;
>> +       if (of_find_property(np, "caps2-mmc-hs200-1_8v", NULL))
>> +               host->caps2 |= MMC_CAP2_HS200_1_8V_SDR;
>> +       if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
>> +               host->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>>
>>         return 0;
>
> If we do this, the strings also need to be documented in
> bindings/mmc/mmc.txt.
>
> Unfortunately, the names are not particularly intuitive (the caps2
> part in particular), but it's probably better to stick with that
> now.

I would prefer to remove "caps2" from the property name.

Going forward and cleaning up all the non needed caps flags, could
mean we may want to move caps2 flags into caps flags, I guess. This
would not be suitable if we decide to name the property as above.

Kind regards
Uffe

>
>         Arnd
