From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/8] mmc: tmio: Keep host active while SDIO irq is enabled
Date: Mon, 11 Nov 2013 10:07:57 +0100
Message-ID: <CAPDyKFoP8mALf6P1hVy0A3iGNf2=gRgdavFBO4=Q-cj=KMi-tA@mail.gmail.com>
References: <1383890776-6912-1-git-send-email-ulf.hansson@linaro.org>
	<1383890776-6912-5-git-send-email-ulf.hansson@linaro.org>
	<Pine.LNX.4.64.1311080737410.22449@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:47947 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab3KKJH6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Nov 2013 04:07:58 -0500
Received: by mail-qc0-f178.google.com with SMTP id x19so3893023qcw.9
        for <linux-mmc@vger.kernel.org>; Mon, 11 Nov 2013 01:07:58 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.1311080737410.22449@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 8 November 2013 07:56, Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> Hi Ulf,
>
> On Fri, 8 Nov 2013, Ulf Hansson wrote:
>
>> The host must be kept active to be able to serve with SDIO irqs. We
>> prevent it from being put into in-active while the SDIO irq is enabled
>> by simply adding balanced calls to pm_runtime_get|put.
>>
>> Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  drivers/mmc/host/tmio_mmc.h     |    1 +
>>  drivers/mmc/host/tmio_mmc_pio.c |   19 +++++++++++++++----
>>  2 files changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
>> index 6c5b45a..c2c9546 100644
>> --- a/drivers/mmc/host/tmio_mmc.h
>> +++ b/drivers/mmc/host/tmio_mmc.h
>> @@ -102,6 +102,7 @@ struct tmio_mmc_host {
>>       struct mutex            ios_lock;       /* protect set_ios() context */
>>       bool                    native_hotplug;
>>       bool                    resuming;
>> +     bool                    sdio_irq_enabled;
>>  };
>>
>>  int tmio_mmc_host_probe(struct tmio_mmc_host **host,
>> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
>> index 472e803..377157e 100644
>> --- a/drivers/mmc/host/tmio_mmc_pio.c
>> +++ b/drivers/mmc/host/tmio_mmc_pio.c
>> @@ -129,15 +129,22 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>>  {
>>       struct tmio_mmc_host *host = mmc_priv(mmc);
>>
>> -     if (enable) {
>> +     if (enable && !host->sdio_irq_enabled) {
>> +             /* Keep device active while SDIO irq is enabled */
>> +             pm_runtime_get_sync(mmc_dev(mmc));
>> +             host->sdio_irq_enabled = true;
>> +
>>               host->sdio_irq_mask = TMIO_SDIO_MASK_ALL &
>>                                       ~TMIO_SDIO_STAT_IOIRQ;
>>               sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0001);
>>               sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
>> -     } else {
>> +     } else if (!enable && host->sdio_irq_enabled) {
>>               host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
>>               sd_ctrl_write16(host, CTL_SDIO_IRQ_MASK, host->sdio_irq_mask);
>>               sd_ctrl_write16(host, CTL_TRANSACTION_CTL, 0x0000);
>> +
>> +             host->sdio_irq_enabled = false;
>> +             pm_runtime_put(mmc_dev(mmc));
>>       }
>>  }
>>
>> @@ -1072,8 +1079,12 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
>>
>>       _host->sdcard_irq_mask &= ~irq_mask;
>>
>> -     if (pdata->flags & TMIO_MMC_SDIO_IRQ)
>> -             tmio_mmc_enable_sdio_irq(mmc, 0);
>> +     _host->sdio_irq_enabled = false;
>
> This by itself is unneeded as the data is allocated per kzalloc(). It can
> be argued, that such explicit assignments make code better readable, but
> we also don't initialise other boolean variables in struct tmio_mmc_host
> during probe(): force_pio and resuming, so, to stay consistent it could be
> better to preserve that pattern.

Sure, makes sense!

>
>> +     if (pdata->flags & TMIO_MMC_SDIO_IRQ) {
>> +             _host->sdio_irq_mask = TMIO_SDIO_MASK_ALL;
>> +             sd_ctrl_write16(_host, CTL_SDIO_IRQ_MASK, _host->sdio_irq_mask);
>> +             sd_ctrl_write16(_host, CTL_TRANSACTION_CTL, 0x0000);
>> +     }
>
> I don't think I like this open-coding a lot. I think, in
> tmio_mmc_enable_sdio_irq() above it would be better to only balance calls
> to pm_runtime_enable/disable() by checking and setting the
> .sdio_irq_enabled flag. Then we wouldn't have to modify this location.

I can rework like you proposed, but do note that since calls to
tmio_mmc_enable_sdio_irq are not to be considered balanced, we might
end up in re-writing the CTL_SDIO_IRQ_MASK and CTL_TRANSACTION_CTL
with the same values they already have. Is this really wanted? That
was the reason to why I moved out the initial pieces to probe.

Kind regards
Uffe

>
> Thanks
> Guennadi
>
>>
>>       spin_lock_init(&_host->lock);
>>       mutex_init(&_host->ios_lock);
>> --
>> 1.7.9.5
>>
>
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
