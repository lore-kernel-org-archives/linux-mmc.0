From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
Date: Fri, 19 Oct 2018 12:13:24 +0300
Message-ID: <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181018215101.169847-1-rajatja@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Rajat Jain <rajatxjain@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@google.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:
>
> Problem:
>
> The card detect IRQ does not work with modern BIOS (that want
> to use DSD to provide the card detect GPIO to the driver).
>
> Details:
>

> (Discussion: https://lkml.org/lkml/2018/9/25/1113)

We have a Link tag for such references.

> The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> request the gpio descriptor for the "card detect" (or carrier detect?) pin.

card detect is a right term.

> This pin is specified in the ACPI for the SDHC device:
>
>  * Either as a resource using _CRS. This is a method used by legacy BIOS.
>    (The driver needs to tell which resource index).
>
>  * Or as a named property ("cd-gpio") in DSD (which may internally point

cd-gpios (gpio suffix is a legacy).

>    to an entry in _CRS). This way, the driver can lookup using a string.
>    This is what modern BIOS prefer to use.
>
> This API finally results in a call to the following code:
>
> struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> {
> ...
>    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> ...
>    if (!acpi_can_fallback_to_crs(adev, con_id))
>           return ERR_PTR(-ENOENT);
> ...
>    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> ...
> }
>
> Note that this means that if the ACPI has _DSD properties, the kernel
> will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> will always be false for any device hat has _DSD entries).
>
> The SDHCI driver is thus currently broken on a modern BIOS

> (even if
> BIOS provides both _CRS and DSD entries, either of which could be used for

_DSD

> a successful lookup).

This is incorrect. _DSD for GPIOs without any accompanying _CRS
doesn't make any sense.

> Ironically, none of these will be used for the
> lookup currently because:
>
> * Since the con_id is NULL, acpi_find_gpio() does not find a matching
>   entry in DSDT. (The DSDT entry has the property name = "cd-gpio")

cd-gpios

>
> * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
>   returns false (because device properties have been populated from
>   DSD), thus the _CRS is never used for the lookup.

_DSD

>
> Fix:
>
> Try "cd" for lookup in the _DSD before falling back to using NULL so
> as to try looking up in the _CRS.
>
> I've tested this patch successfully with both Legacy BIOS (that
> provide only _CRS method) as well as modern BIOS (that provide both
> _CRS and DSD). Also the use of "cd" also appears to be farly consistent

_DSD
fairly

> across other users of this API (other MMC host controller drivers).

>         if (slot->cd_idx >= 0) {
> -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
>                                            slot->cd_override_level, 0, NULL);

Yes.

> +               if (ret && ret != -EPROBE_DEFER)
> +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> +                                                  slot->cd_idx,
> +                                                  slot->cd_override_level,
> +                                                  0, NULL);

And no. Instead of this part you need to provide an ACPI GPIO mapping table.

See examples, like
net/rfkill/rfkill-gpio.c

(look for acpi_rfkill_default_gpios)

>                 if (ret == -EPROBE_DEFER)
>                         goto remove;

-- 
With Best Regards,
Andy Shevchenko
