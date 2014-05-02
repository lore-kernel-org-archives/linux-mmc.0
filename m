From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] mmc: omap: Use DIV_ROUND_UP instead of open coded
Date: Fri, 2 May 2014 22:30:49 +0200
Message-ID: <CAGhQ9Vxvb-crC++ySxarjZR+0geX_UjjEUea-_Kica50nT=n7A@mail.gmail.com>
References: <1398596216.21067.1.camel@phoenix>
	<20140502153915.GA3014@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171]:51465 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbaEBUau (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 May 2014 16:30:50 -0400
In-Reply-To: <20140502153915.GA3014@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Axel Lin <axel.lin@ingics.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>

On 2 May 2014 17:39, Tony Lindgren <tony@atomide.com> wrote:
> * Axel Lin <axel.lin@ingics.com> [140427 03:58]:
>> This also makes the intention more clear.

While you are at it you may want to use some nice defines from time.h

>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>
> Added Jarkko Nikula to cc.
>
> Tony
>
>> ---
>>  drivers/mmc/host/omap.c | 10 +++++-----
>>  1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
>> index 5c2e58b..711981e 100644
>> --- a/drivers/mmc/host/omap.c
>> +++ b/drivers/mmc/host/omap.c
>> @@ -177,7 +177,7 @@ static void mmc_omap_fclk_offdelay(struct mmc_omap_slot *slot)
>>       unsigned long tick_ns;
>>
>>       if (slot != NULL && slot->host->fclk_enabled && slot->fclk_freq > 0) {
>> -             tick_ns = (1000000000 + slot->fclk_freq - 1) / slot->fclk_freq;
>> +             tick_ns = DIV_ROUND_UP(1000000000, slot->fclk_freq);

Use NSEC_PER_SEC from time.h

>>               ndelay(8 * tick_ns);
>>       }
>>  }
>> @@ -435,7 +435,7 @@ static void mmc_omap_send_stop_work(struct work_struct *work)
>>       struct mmc_data *data = host->stop_data;
>>       unsigned long tick_ns;
>>
>> -     tick_ns = (1000000000 + slot->fclk_freq - 1)/slot->fclk_freq;
>> +     tick_ns = DIV_ROUND_UP(1000000000, slot->fclk_freq);

Same here NSEC_PER_SEC.

>>       ndelay(8*tick_ns);
>>       mmc_omap_start_command(host, data->stop);
>> @@ -477,7 +477,7 @@ mmc_omap_send_abort(struct mmc_omap_host *host, int maxloops)
>>       u16 stat = 0;
>>
>>       /* Sending abort takes 80 clocks. Have some extra and round up */
>> -     timeout = (120*1000000 + slot->fclk_freq - 1)/slot->fclk_freq;
>> +     timeout = DIV_ROUND_UP(120 * 1000000, slot->fclk_freq);

USEC_PER_SEC from time.h

regards
Joachim Eastwood
