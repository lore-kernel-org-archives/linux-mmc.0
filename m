From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/4] mmc: slot-gpio: switch to use flags when getting
 GPIO
Date: Mon, 22 Sep 2014 11:20:16 +0300
Message-ID: <541FDBC0.4020302@intel.com>
References: <1409137253-25189-1-git-send-email-linus.walleij@linaro.org> <CAPDyKFqw2N9zg41iz=qo3kQghmdYpafYdy545NYuu-Ji6pJELQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:61925 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753387AbaIVIVk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Sep 2014 04:21:40 -0400
In-Reply-To: <CAPDyKFqw2N9zg41iz=qo3kQghmdYpafYdy545NYuu-Ji6pJELQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-gpio@vger.kernel.org

On 08/29/2014 03:16 PM, Ulf Hansson wrote:
> On 27 August 2014 13:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>> When the slot GPIO driver gets the GPIO to be used for card
>> detect, it is now possible to specify a flag to have the line
>> set up as input. Get rid of the explicit setup call for input
>> and use the flag.
>>
>> The extra argument works as there are transition varargs
>> macros in place in the <linux/gpio/consumer.h> header, in
>> the future we will make the flags argument compulsory.
>>
>> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Thanks! Applied for next.

Unfortunately it doesn't seem to work.  I needed the patch
below.


From: Adrian Hunter <adrian.hunter@intel.com>
Date: Mon, 22 Sep 2014 11:01:16 +0300
Subject: [PATCH] gpio: Fix gpio direction flags not getting set

GPIO direction flags are not getting set because
an 'if' statement is the wrong way around.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 15cc0bb..3b54edf 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1674,7 +1674,7 @@ struct gpio_desc *__must_check __gpiod_get_index(struct device *dev,
 		set_bit(FLAG_OPEN_SOURCE, &desc->flags);
 
 	/* No particular flag request, return here... */
-	if (flags & GPIOD_FLAGS_BIT_DIR_SET)
+	if (!(flags & GPIOD_FLAGS_BIT_DIR_SET))
 		return desc;
 
 	/* Process flags */
-- 
1.8.3.2



> 
> Kind regards
> Uffe
> 
>> ---
>>  drivers/mmc/core/slot-gpio.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
>> index 5f89cb83d5f0..908c2b29e79f 100644
>> --- a/drivers/mmc/core/slot-gpio.c
>> +++ b/drivers/mmc/core/slot-gpio.c
>> @@ -308,14 +308,10 @@ int mmc_gpiod_request_cd(struct mmc_host *host, const char *con_id,
>>         if (!con_id)
>>                 con_id = ctx->cd_label;
>>
>> -       desc = devm_gpiod_get_index(host->parent, con_id, idx);
>> +       desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
>>         if (IS_ERR(desc))
>>                 return PTR_ERR(desc);
>>
>> -       ret = gpiod_direction_input(desc);
>> -       if (ret < 0)
>> -               return ret;
>> -
>>         if (debounce) {
>>                 ret = gpiod_set_debounce(desc, debounce);
>>                 if (ret < 0)
>> --
>> 1.9.3
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-gpio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

