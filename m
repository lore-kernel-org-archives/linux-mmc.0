From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH v2 1/9] mmc: meson-gx: fix setting f_min
Date: Sat, 4 Feb 2017 23:12:32 +0100
Message-ID: <78e18d60-8359-df37-ebcb-34134b31f708@gmail.com>
References: <e8f1b59a-927b-b50e-4137-0b4b9e3cbc6e@gmail.com>
 <CAPDyKFq9mScEuqcmP0E3Lz0APhYbHYtyUvc6WXkGGXR1OZavgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36565 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbdBDWMs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 4 Feb 2017 17:12:48 -0500
Received: by mail-wm0-f67.google.com with SMTP id r18so13305852wmd.3
        for <linux-mmc@vger.kernel.org>; Sat, 04 Feb 2017 14:12:47 -0800 (PST)
In-Reply-To: <CAPDyKFq9mScEuqcmP0E3Lz0APhYbHYtyUvc6WXkGGXR1OZavgg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

Am 03.02.2017 um 09:29 schrieb Ulf Hansson:
> On 1 February 2017 at 07:48, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> Currently f_min is set to 4 MHz whilst the comment states 400 MHz.
>> I think the itention is to set f_min to 400 kHz.
>> Change value and comment accordingly.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> v2:
>> - added acked-by
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 5eca88bc..da3cce31 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -268,7 +268,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>         if (f_min != UINT_MAX)
>>                 f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
>>         else
>> -               f_min = 4000000;  /* default min: 400 MHz */
>> +               f_min = 400000;  /* default min: 400 kHz */
>>         host->mmc->f_min = f_min;
> 
> This hole thing looks really weird to me. Although instead of
> discussing it here, I decided to post a patch to show how I think this
> should be done. Could you please have look!?
> https://patchwork.kernel.org/patch/9553599/
> 
Thanks for the patch. Two remarks:

Member mux_parent_rate of struct meson_host is unused after this patch.
So it should be removed as part of the patch.

Requesting 100kHz resulted in f_min = 0 in my tests. Same for 200kHz
and 300 kHz. 400kHz results in f_min = 400kHz with actual rate = 380kHz.
380kHz = 24MHz / 63 is the lowest possible frequency on Meson anyway.
All requested frequencies below this value seem to be rounded down to 0.
Therefore I'd suggest to set the requested rate to 400kHz.

Rgds, Heiner

> Kind regards
> Uffe
> 

