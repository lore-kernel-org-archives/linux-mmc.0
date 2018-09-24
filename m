From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH 0/2] gpiolib: Fix issues introduced by fast bitmap
 processing path
Date: Mon, 24 Sep 2018 13:08:11 +0200
Message-ID: <CAGfqbt6H8u_dUokB-pg51kCj09G8Mh7wB0879nKMw5Dw83tcSg@mail.gmail.com>
References: <2785169.v6aIfS3K2k@z50>
 <CGME20180923235237epcas3p3aa946da71a07da1bc3cd0e8cce3473b2@epcas3p3.samsung.com>
 <20180923235336.22148-1-jmkrzyszt@gmail.com>
 <20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N@eucas1p2.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180924094339eucas1p282f2f7cb627c183fe87da044edb90fa5~XTMgQ4GFs1339913399eucas1p2N@eucas1p2.samsung.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Ulf Hansson <ulf.hansson@linaro.org>, linux-doc@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Peter Rosin <peda@axentia.se>, netdev@vger.kernel.org, linux-i2c@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, devel@driverdev.osuosl.org, Florian Fainelli <f.fainelli@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski <krzk@kernel.org>, Kishon Vijay Abraham I <kishon@ti.com>, linux-iio@vger.kernel.org, Peter Korsgaard <peter.korsgaard@barco.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Michael Hennerich <Michael.Hennerich@analog.com>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.>
List-Id: linux-mmc@vger.kernel.org

Hi Marek,

2018-09-24 11:43 GMT+02:00, Marek Szyprowski <m.szyprowski@samsung.com>:
> Hi Janusz,
>
> On 2018-09-24 01:53, Janusz Krzysztofik wrote:
>> While investigating possible reasons of GPIO fast bitmap processing
>> related boot hang on Samsung Snow Chromebook, reported by Marek
>> Szyprowski (thanks!), I've discovered one coding bug, addressed by
>> PATCH 1/2 of this series, and one potential regression introduced at
>> design level of the solution, hopefully fixed by PATCH 2/2.  See
>> commit messages for details.
>>
>> Janusz Krzysztofik (2):
>>        gpiolib: Fix missing updates of bitmap index
>>        gpiolib: Fix array members of same chip processed separately
>>
>> The fixes should resolve the boot hang observed by Marek, however the
>> second change excludes that particular case from fast bitmap processing
>> and restores the old behaviour.
>
> I confirm, that the above 2 patches fixes boot issue on Samsung Snow
> Chromebook with next-20180920.
>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>
>> Hence, it is possible still another
>> issue which have had an influence on that boot hang exists in the code.
>> In order to fully verify the fix, it would have to be tested on a
>> platform where an array of GPIO descriptors is used which starts from
>> at least two consecutive pins of one GPIO chip in hardware order,
>> starting ftom 0, followed by one or more pins belonging to other
>> chip(s).
>>
>> In order to verify if separate calls to .set() chip callback for each
>> pin instead of one call to .set_multiple() is actually the reason of
>> boot hang on Samsung Snow Chromebook, the affected driver -
>> drivers/mmc/core/pwrseq_simple.c - would have to be temporarily
>> modified for testing purposes so it calls gpiod_set_value() for each
>> pin instead of gpiod_set_array_value() for all of them.  If that would
>> also result in boot hang, we could be sure the issue was really the
>> one addressed by the second fix.  Marek, could you please try to
>> perform such test?
>
> Yes, I've just tested next-20180920 only with the first patch from this
> patchset and the mentioned change to drivers/mmc/core/pwrseq_simple.c.
> It boots fine, so indeed the issue is in handling of arrays of gpios.
>
> Just to be sure I did it right, this is my change to the mentioned file:

Yeah, that's what I had on mind.  However, I'd be more lucky if it didn't work
for you.  Setting the pins sequentially, not simultaneously as before, was
exactly what I hoped was the reason of the hang.

> diff --git a/drivers/mmc/core/pwrseq_simple.c
> b/drivers/mmc/core/pwrseq_simple.c
> index 7f882a2bb872..9397dc1f2e38 100644
> --- a/drivers/mmc/core/pwrseq_simple.c
> +++ b/drivers/mmc/core/pwrseq_simple.c
> @@ -38,16 +38,11 @@ static void mmc_pwrseq_simple_set_gpios_value(struct
> mmc_pwrseq_simple *pwrseq,
>                                                int value)
>   {
>          struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
> +       int i;
>
> -       if (!IS_ERR(reset_gpios)) {
> -               DECLARE_BITMAP(values, BITS_PER_TYPE(value));
> -               int nvalues = reset_gpios->ndescs;
> -
> -               values[0] = value;
> -
> -               gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
> -                                              reset_gpios->info, values);
> -       }
> +       if (!IS_ERR(reset_gpios))
> +               for (i = 0; i < reset_gpios->ndescs; i++)

The only difference from the behaviour when the hang was occurring is now
the order the pins are manipulated.  Maybe that matters?
Could you please retry the same with the order of pins reversed, either in
the .dts file or here inside this for loop?

Thanks,
Janusz

> + gpiod_set_value_cansleep(reset_gpios->desc[i], value);
>   }
>
>   static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
>
>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
>
