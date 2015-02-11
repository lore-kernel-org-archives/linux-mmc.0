From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V4 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
Date: Wed, 11 Feb 2015 05:34:40 +0100
Message-ID: <CAPDyKFonXw2NDbEw9CoRj7Sncgm_FUki+cc7j3q=xVZRrJHBkg@mail.gmail.com>
References: <1421658784-11980-1-git-send-email-ulf.hansson@linaro.org>
	<1421658784-11980-5-git-send-email-ulf.hansson@linaro.org>
	<CAAVeFuJjU-fsknYdMZ1c+aOEmc2rFy=z35S584DfHBLvUm=OAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:54799 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094AbbBKEel (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 23:34:41 -0500
Received: by mail-qc0-f171.google.com with SMTP id l6so1099881qcy.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2015 20:34:41 -0800 (PST)
In-Reply-To: <CAAVeFuJjU-fsknYdMZ1c+aOEmc2rFy=z35S584DfHBLvUm=OAQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Rojhalat Ibrahim <imr@rtschenk.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Rutland <mark.rutland@arm.com>

On 10 February 2015 at 10:12, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Mon, Jan 19, 2015 at 6:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> The need for reset GPIOs has several times been pointed out from
>> erlier posted patchsets. Especially some WLAN chips which are
>> attached to an SDIO interface may use a GPIO reset.
>>
>> The reset GPIO is asserted at initialization and prior we start the
>> power up procedure. The GPIO will be de-asserted right after the power
>> has been provided to the card, from the ->post_power_on() callback.
>>
>> Note, the reset GPIO is optional. Thus we don't return an error even if
>> we can't find a GPIO for the consumer.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Excellent, with this I can probe the wifi chip on NVIDIA SHIELD which
> requires a GPIO to be high for reset to be de-asserted.
>
> The series:
>
> Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks for testing! Unfortunate, I can't add you tag since this
patchset is already in the PR for 3.20.

>
>> ---
>>
>> Changes in v4:
>>         - Fixed call to kfree().
>>
>> ---
>>  drivers/mmc/core/pwrseq_simple.c | 38 ++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>
>> diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
>> index 61c991e..0958c69 100644
>> --- a/drivers/mmc/core/pwrseq_simple.c
>> +++ b/drivers/mmc/core/pwrseq_simple.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/slab.h>
>>  #include <linux/device.h>
>>  #include <linux/err.h>
>> +#include <linux/gpio/consumer.h>
>>
>>  #include <linux/mmc/host.h>
>>
>> @@ -18,31 +19,68 @@
>>
>>  struct mmc_pwrseq_simple {
>>         struct mmc_pwrseq pwrseq;
>> +       struct gpio_desc *reset_gpio;
>>  };
>>
>> +static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>> +{
>> +       struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>> +                                       struct mmc_pwrseq_simple, pwrseq);
>> +
>> +       if (!IS_ERR(pwrseq->reset_gpio))
>> +               gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
>> +}
>> +
>> +static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
>> +{
>> +       struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>> +                                       struct mmc_pwrseq_simple, pwrseq);
>> +
>> +       if (!IS_ERR(pwrseq->reset_gpio))
>> +               gpiod_set_value_cansleep(pwrseq->reset_gpio, 0);
>> +}
>> +
>>  static void mmc_pwrseq_simple_free(struct mmc_host *host)
>>  {
>>         struct mmc_pwrseq_simple *pwrseq = container_of(host->pwrseq,
>>                                         struct mmc_pwrseq_simple, pwrseq);
>>
>> +       if (!IS_ERR(pwrseq->reset_gpio))
>> +               gpiod_put(pwrseq->reset_gpio);
>> +
>>         kfree(pwrseq);
>>         host->pwrseq = NULL;
>>  }
>>
>>  static struct mmc_pwrseq_ops mmc_pwrseq_simple_ops = {
>> +       .pre_power_on = mmc_pwrseq_simple_pre_power_on,
>> +       .post_power_on = mmc_pwrseq_simple_post_power_on,
>> +       .power_off = mmc_pwrseq_simple_pre_power_on,
>>         .free = mmc_pwrseq_simple_free,
>>  };
>>
>>  int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
>>  {
>>         struct mmc_pwrseq_simple *pwrseq;
>> +       int ret = 0;
>>
>>         pwrseq = kzalloc(sizeof(struct mmc_pwrseq_simple), GFP_KERNEL);
>>         if (!pwrseq)
>>                 return -ENOMEM;
>>
>> +       pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_HIGH);
>
> gpiod_get() will translate to exactly the same, with less characters.
>
> Actually I see that the version in -next has support for multiple
> GPIOs. You will probably want to look at Rojhalat's latest work on
> GPIO arrays:
>
> http://permalink.gmane.org/gmane.linux.kernel.gpio/6126

Cool!

>
> This code would be a great candidate to use this GPIO array API, but
> since it is not in -next yet (should happen soon though) you might
> want to consider doing it later.
>
> Btw, I wasted a considerable amount of time on one of the defunct
> previous attempts at power sequences, so I'm interested in reviewing
> future versions of this patchset if you don't mind adding me to the CC
> list. :)

:-)

I will keep you posted for future updates. Feel free to post patches
improving the mmc-pwrseq code yourself, I will happily review them.

Kind regards
Uffe
