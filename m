From: Alexandre Courbot <gnurou@gmail.com>
Subject: Re: [PATCH] mmc: core: Add DT bindings for card detect debounce time
Date: Sat, 21 Jun 2014 16:22:12 +0900
Message-ID: <CAAVeFu+CW0DSbqc6k145APao2r907sAyMw0+W=hQXxO6LoQx-g@mail.gmail.com>
References: <1399649837-27286-1-git-send-email-balajitk@ti.com> <CAPDyKFoZ=zjKg5bUMnK_X2XOatT=XSAnBDpYqu0Q2VOkM7hOOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFoZ=zjKg5bUMnK_X2XOatT=XSAnBDpYqu0Q2VOkM7hOOA@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Balaji T K <balajitk@ti.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 18, 2014 at 10:47 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 9 May 2014 17:37, Balaji T K <balajitk@ti.com> wrote:
>> Provide an option to get CD debounce time from DT
>>
>> Signed-off-by: Balaji T K <balajitk@ti.com>
>> ---
>>  Documentation/devicetree/bindings/mmc/mmc.txt |    1 +
>>  drivers/mmc/core/host.c                       |    6 +++++-
>>  2 files changed, 6 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
>> index 9dce540..fae590b 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc.txt
>> @@ -17,6 +17,7 @@ Optional properties:
>>  - bus-width: Number of data lines, can be <1>, <4>, or <8>.  The default
>>    will be <1> if the property is absent.
>>  - wp-gpios: Specify GPIOs for write protection, see gpio binding
>> +- cd-debounce-us: debounce time in microseconds for card detect gpio.
>>  - cd-inverted: when present, polarity on the CD line is inverted. See the note
>>    below for the case, when a GPIO is used for the CD line
>>  - wp-inverted: when present, polarity on the WP line is inverted. See the note
>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>> index fdea825..59cd3a0 100644
>> --- a/drivers/mmc/core/host.c
>> +++ b/drivers/mmc/core/host.c
>> @@ -313,6 +313,7 @@ int mmc_of_parse(struct mmc_host *host)
>>         bool explicit_inv_wp, gpio_inv_wp = false;
>>         enum of_gpio_flags flags;
>>         int len, ret, gpio;
>> +       unsigned int debounce;
>>
>>         if (!host->parent || !host->parent->of_node)
>>                 return 0;
>> @@ -367,6 +368,9 @@ int mmc_of_parse(struct mmc_host *host)
>>                 if (of_find_property(np, "broken-cd", &len))
>>                         host->caps |= MMC_CAP_NEEDS_POLL;
>>
>> +               if (of_property_read_u32(np, "cd-debounce-us", &debounce) < 0)
>> +                       debounce = 0;
>> +
>
> Hi Balaji,
>
> Sorry for a late reply.
>
> I am wondering whether this should be a generic gpio of property,
> instead of a mmc specific thing.
>
> I have added Linus Walleij and Alexandre Courbot, the maintainers of
> gpio. Let's see if they can point us in a direction.

I agree it would be nice if the debounce value could be handled by the
GPIO framework. I just wonder what would be the correct way of doing
it? Contrary to ACTIVE_LOW and other flags which can be specified with
the GPIO phandle, debounce is a numeric value. Maybe using a different
property, e.g.:

cd-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
cd-gpios-debounce = <10>;

When looking up a GPIO through gpiod_get(), the GPIO framework could
then check for -debounce property and set the debounce time
accordingly. At first sight I'd say that would work and could be used
for MMC and all other subsystems that need something similar.

Alex.
