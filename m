From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: core: Power cycle card on voltage switch fail
Date: Tue, 25 Sep 2012 10:52:10 +0200
Message-ID: <CA+20K0AVGG7zX3H596f+iHYB_1C7Jxm+xa0eGjrNFTC9sBwn1g@mail.gmail.com>
References: <1348556654-2119-1-git-send-email-johan.rudholm@stericsson.com>
	<CAPDyKFqr9COJ0oGQE_G99zscFXpRztQ3nN8o3_Vn-sQOxegB5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44017 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105Ab2IYIwL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 04:52:11 -0400
Received: by ieak13 with SMTP id k13so13259857iea.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 01:52:10 -0700 (PDT)
In-Reply-To: <CAPDyKFqr9COJ0oGQE_G99zscFXpRztQ3nN8o3_Vn-sQOxegB5Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Johan Rudholm <johan.rudholm@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Fredrik Soderstedt <fredrik.soderstedt@stericsson.com>

Hi Ulf,

2012/9/25 Ulf Hansson <ulf.hansson@linaro.org>:
> Hi Johan,
>
> An overall comment; would it be possible to include this patch as a
> piece of patch 1/2 "mmc: core: Proper signal voltage switch".
> They seems like quite tight connected.

Sure, I can do this. Let me see what comes out of the SDIO patch first though...

>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>> index 74972c2..9a165451 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -720,6 +720,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>>          * state.  We wait 1ms to give cards time to
>>          * respond.
>>          */
>> +try_again:
>>         mmc_go_idle(host);
>>
>>         /*
>> @@ -748,7 +749,6 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid, u32 *rocr)
>>         if (max_current > 150)
>>                 ocr |= SD_OCR_XPC;
>>
>> -try_again:
>>         err = mmc_send_app_op_cond(host, ocr, rocr);
>>         if (err)
>>                 return err;
>> @@ -761,7 +761,11 @@ try_again:
>>            ((*rocr & 0x41000000) == 0x41000000)) {
>>                 err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, true);
>>                 if (err) {
>> -                       ocr &= ~SD_OCR_S18R;
>> +                       /* Power cycle card */
>> +                       pr_warning("%s: Signal voltage switch failed, "
>> +                               "power cycling card\n", mmc_hostname(host));
>> +                       mmc_power_off(host);
>> +                       mmc_power_up(host);
>
> This mean you will retry forever even if the card is not capable of
> 1.8V. I doubt this really what you want?

The card has already ACKed that it supports 1.8V, and according to the
SD spec it should be power-cycled if the voltage swich fails, but I
guess it would be more robust to bail out after a number of retries.
Our 16 GB Verbatim card that started all this has been observed to
sometimes require five power cycles until it accepts the voltage
switch, so I'll have to pick a high enough number.

Kind regards, Johan
