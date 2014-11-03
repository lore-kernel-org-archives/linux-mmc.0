From: =?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5rbw==?=
	<kristina.martsenko@gmail.com>
Subject: Re: [Regression Resend] mmc: mx28: sd card detection broken since
 3.18-rc1
Date: Mon, 03 Nov 2014 23:50:53 +0200
Message-ID: <5457F8BD.1040800@gmail.com>
References: <1747777414.897866.1414878004147.JavaMail.open-xchange@oxbsltgw09.schlund.de> <5456B7B3.60401@gmail.com> <8090335.0rPHov2cpK@kerker>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <8090335.0rPHov2cpK@kerker>
Sender: linux-gpio-owner@vger.kernel.org
To: Michael Heimpold <mhei@heimpold.de>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 03/11/14 22:49, Michael Heimpold wrote:
> Hi,

Hi Michael,

> Am Montag, 3. November 2014, 01:01:07 schrieben Sie:
>> On 01/11/14 23:40, Stefan Wahren wrote:
>>> Hi,
>>>
>>> i was testing Linux Kernel 3.18-rc2 with my i.MX28 board (I2SE Duckbill) and ran
>>> into the problem that the sd card isn't detected from the Kernel at booting
>>> (driver: mxs-mmc.c). That results in a endless wait for the root partition
>>
>> I ran into this issue as well. Seems that a card-detect flag 
>> (MMC_CAP2_CD_ACTIVE_HIGH) can currently be set based on an 
>> uninitialized variable, which can lead to the card being reported as 
>> not present. This patch fixes it for me:
>>
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index 03c53b72a2d6..f0e187682d3b 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -311,7 +311,7 @@ int mmc_of_parse(struct mmc_host *host)
>>  	struct device_node *np;
>>  	u32 bus_width;
>>  	int len, ret;
>> -	bool cap_invert, gpio_invert;
>> +	bool cap_invert, gpio_invert = false;
>>  
> 
> sorry, but I don't understand how your patch fixes the problem.
> 
> First use of the gpio_invert bool is in line 370/371 within mmc_gpiod_request_cd
> (re-wrapped into a single line here for better reading):
> 
> -snip-
> ret = mmc_gpiod_request_cd(host, "cd", 0, true,  0, &gpio_invert);
> -snap-
> 
> A pointer to the bool is passed, and inside mmc_gpiod_request_cd (drivers/mmc/core/slot-gpio.c,
> line 322), always a value is assigned:
> 
> -snip-
> if (gpio_invert)
>                 *gpio_invert = !gpiod_is_active_low(desc);
> -snap-
> 
> So returning to mmc_of_parse, the bool should always have an initialized value.
> Apart from some error handling, the bool is used immediately in the xor expression
> and results in setting MMC_CAP2_CD_ACTIVE_HIGH bit, or not.
> 
> I also cannot see a code path, where gpio_invert is used without a call to mmc_gpiod_request_cd.
> 
> Would be nice, if you could point me to what I'm missing.

mmc_gpiod_request_cd can return without ever reaching the line where 
the value is assigned to gpio_invert:

desc = devm_gpiod_get_index(host->parent, con_id, idx, GPIOD_IN);
if (IS_ERR(desc))
	return PTR_ERR(desc);

This can happen when the host controller doesn't use a GPIO for card 
detection (but instead uses a dedicated pin). In this case 
devm_gpiod_get_index will return -ENOENT.

>>  	if (!host->parent || !host->parent->of_node)
>>  		return 0;
>> @@ -401,6 +401,7 @@ int mmc_of_parse(struct mmc_host *host)
>>  	else
>>  		cap_invert = false;
>>  
>> +	gpio_invert = false;
>>  	ret = mmc_gpiod_request_ro(host, "wp", 0, false, 0, &gpio_invert);
> 
> Same here. The functions always assigns a value when a pointer is given.

Same thing, the function can return before gpio_invert is ever assigned 
to.

> (And this change is unrelated to the reporters problem, so should be fixed with a
> dedicated patch.)

Since both flags are set wrong for the exact same reason, and they're 
both regressions in 3.18, I thought it would make sense to fix them 
both in one patch. (Especially since I think it's cleaner to split the 
gpio_invert variable into cd_gpio_invert and ro_gpio_invert, and I was 
going to do that in the patch I'd send.) Let me know if you still think 
I should send separate patches for them.

Thanks for the review,
Kristina
