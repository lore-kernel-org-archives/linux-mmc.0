From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] mmc: mmci: augment driver to handle gpio descriptors
Date: Mon, 18 Aug 2014 16:11:51 -0500
Message-ID: <CACRpkda9VSKG4w67bDUAwg_1p1kbOcbrUR=zcXHwM6dvftaRUA@mail.gmail.com>
References: <1407864355-21545-1-git-send-email-linus.walleij@linaro.org>
	<1407864355-21545-4-git-send-email-linus.walleij@linaro.org>
	<CAAVeFuKo0DxN9Ff1G9o+ZXp8T+J-ZBE90cqcu5Pdgsq_jAZouw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <CAAVeFuKo0DxN9Ff1G9o+ZXp8T+J-ZBE90cqcu5Pdgsq_jAZouw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 14, 2014 at 9:56 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Tue, Aug 12, 2014 at 10:25 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> -       /* If DT, cd/wp gpios must be supplied through it. */
>> -       if (!np && gpio_is_valid(plat->gpio_cd)) {
>> -               ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
>> -               if (ret)
>> -                       goto clk_disable;
>> -       }
>> -       if (!np && gpio_is_valid(plat->gpio_wp)) {
>> -               ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
>> -               if (ret)
>> -                       goto clk_disable;
>> +       /*
>> +        * If:
>> +        * - not using DT but using a descriptor table, or
>> +        * - using a table of descriptors ALONGSIDE DT, or
>> +        * look up these descriptors named "cd" and "wp" right here, fail
>> +        * silently of these do not exist and proceed to try platform data
>> +        */
>> +       if (!np) {
>> +               ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0);
>
> I am not familiar with this driver, but since mmc_gpiod_request_cd()
> uses gpiod_get(), can't you call it outside of the (!np) condition?
> You should not have to do this kind of check when using the gpiod API.
(...)
> I wonder (again, without knowing better) if this gpiod/gpio fallback
> logic should not be put directly into mmc_gpio_request_ro/cd instead
> of having two functions? Couldn't other drivers also benefit from it
> that way?

So this is a side-effect of the fact that in the MMC subsystem, the
gpio descriptor is only used in the device tree parsing code.
mmc_of_parse() in drivers/mmc/core/host.c

So if you're *not* using device tree (as some of the MMCI platforms)
they need to make these calls elsewhere.

I agree that there may be a refactoring lurking here, that would
move this out of the DT parse code and into the MMC core.
It should then be called *before* parsing the DT as DT adds
additional options to the GPIO (explicit inversion).

It can be done on top of this patch set though, once these things
are in place.

Yours,
Linus Walleij
