From: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
Date: Mon, 22 Oct 2018 16:34:55 -0700
Message-ID: <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com> <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rajat Jain <rajatxjain@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Andy,

Thanks for your review.

On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Oct 19, 2018 at 12:53 AM Rajat Jain <rajatja@google.com> wrote:
> >
> > Problem:
> >
> > The card detect IRQ does not work with modern BIOS (that want
> > to use DSD to provide the card detect GPIO to the driver).
> >
> > Details:
> >
>
> > (Discussion: https://lkml.org/lkml/2018/9/25/1113)
>
> We have a Link tag for such references.
>
> > The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> > request the gpio descriptor for the "card detect" (or carrier detect?) pin.
>
> card detect is a right term.
>
> > This pin is specified in the ACPI for the SDHC device:
> >
> >  * Either as a resource using _CRS. This is a method used by legacy BIOS.
> >    (The driver needs to tell which resource index).
> >
> >  * Or as a named property ("cd-gpio") in DSD (which may internally point
>
> cd-gpios (gpio suffix is a legacy).
>
> >    to an entry in _CRS). This way, the driver can lookup using a string.
> >    This is what modern BIOS prefer to use.
> >
> > This API finally results in a call to the following code:
> >
> > struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> > {
> > ...
> >    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> > ...
> >    if (!acpi_can_fallback_to_crs(adev, con_id))
> >           return ERR_PTR(-ENOENT);
> > ...
> >    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> > ...
> > }
> >
> > Note that this means that if the ACPI has _DSD properties, the kernel
> > will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> > will always be false for any device hat has _DSD entries).
> >
> > The SDHCI driver is thus currently broken on a modern BIOS
>
> > (even if
> > BIOS provides both _CRS and DSD entries, either of which could be used for
>
> _DSD
>
> > a successful lookup).
>
> This is incorrect. _DSD for GPIOs without any accompanying _CRS
> doesn't make any sense.
>
> > Ironically, none of these will be used for the
> > lookup currently because:
> >
> > * Since the con_id is NULL, acpi_find_gpio() does not find a matching
> >   entry in DSDT. (The DSDT entry has the property name = "cd-gpio")
>
> cd-gpios
>
> >
> > * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
> >   returns false (because device properties have been populated from
> >   DSD), thus the _CRS is never used for the lookup.
>
> _DSD
>
> >
> > Fix:
> >
> > Try "cd" for lookup in the _DSD before falling back to using NULL so
> > as to try looking up in the _CRS.
> >
> > I've tested this patch successfully with both Legacy BIOS (that
> > provide only _CRS method) as well as modern BIOS (that provide both
> > _CRS and DSD). Also the use of "cd" also appears to be farly consistent
>
> _DSD
> fairly

I can fix the commit log to take care of all your review comments.

>
> > across other users of this API (other MMC host controller drivers).
>
> >         if (slot->cd_idx >= 0) {
> > -               ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
> > +               ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
> >                                            slot->cd_override_level, 0, NULL);
>
> Yes.
>
> > +               if (ret && ret != -EPROBE_DEFER)
> > +                       ret = mmc_gpiod_request_cd(host->mmc, NULL,
> > +                                                  slot->cd_idx,
> > +                                                  slot->cd_override_level,
> > +                                                  0, NULL);
>
> And no. Instead of this part you need to provide an ACPI GPIO mapping table.

Sure, I am willing to do so, and I tried earlier too. However, certain
doubts arose in my mind when I tried that and I posted my questions
earlier (https://lkml.org/lkml/2018/9/28/507) but couldn't elicit any
response. Unfortunately I still do not have answers. My primary
questions are:

1) - It seems that 1 SDHCI device may support multiple slots (looking
at the code). It is not clear to me if they could share card detect
interrupts, or should have separate ones? Also, the driver may not
really know? So should I add 1 or two pins using the
devm_acpi_dev_add_driver_gpios(). Is some one familiar with SDHC
driver can answer these questions, it shall be great.

2) I'm not really sure what should I set "active_low" to? Isn't this
something that should be specified by platform / ACPI too, and driver
should just be able to say say choose whatever the ACPI says?

struct acpi_gpio_params {
        unsigned int crs_entry_index;
        unsigned int line_index;
        bool active_low;
};

Since I do not understand the above two issues, and thus I chose the
safest path and not disturb the current code so as not to cause any
regressions.

Please let me know, and I'm happy to re-spin my patch.

Thanks,

Rajat

>
> See examples, like
> net/rfkill/rfkill-gpio.c
>
> (look for acpi_rfkill_default_gpios)
>
> >                 if (ret == -EPROBE_DEFER)
> >                         goto remove;
>
> --
> With Best Regards,
> Andy Shevchenko
