From: Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
Date: Mon, 12 Nov 2018 17:26:27 -0800
Message-ID: <CACK8Z6F0xrC340SHmnZHEb2jYizna_ZCeK_NGGeg_7iRb7wUsw@mail.gmail.com>
References: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
 <20181029221701.51376-1-rajatja@google.com> <CAPDyKFpqzpxUzZe-ekfwg1Nqeg1RFB1bdbSNwrGPwtfNds4p0w@mail.gmail.com>
 <CAHp75VezX-agNFp2wEHorH7U9NmZgpX-PfXdBbGDETnJY2AFGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VezX-agNFp2wEHorH7U9NmZgpX-PfXdBbGDETnJY2AFGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rajat Jain <rajatxjain@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 12, 2018 at 3:26 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Nov 12, 2018 at 1:05 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On 29 October 2018 at 23:17, Rajat Jain <rajatja@google.com> wrote:
> > > Problem:
> > >
> > > The card detect IRQ does not work with modern BIOS (that want
> > > to use _DSD to provide the card detect GPIO to the driver).
> > >
> > > Details:
> > >
> > > The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
> > > request the gpio descriptor for the "card detect" pin.
> > > This pin is specified in the ACPI for the SDHC device:
> > >
> > >  * Either as a resource using _CRS. This is a method used by legacy BIOS.
> > >    (The driver needs to tell which resource index).
> > >
> > >  * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
> > >    points to an entry in _CRS). This way, the driver can lookup using a
> > >    string. This is what modern BIOS prefer to use.
> > >
> > > This API finally results in a call to the following code:
> > >
> > > struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
> > > {
> > > ...
> > >    /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
> > > ...
> > >    if (!acpi_can_fallback_to_crs(adev, con_id))
> > >           return ERR_PTR(-ENOENT);
> > > ...
> > >    /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
> > > ...
> > > }
> > >
> > > Note that this means that if the ACPI has _DSD properties, the kernel
> > > will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
> > > will always be false for any device hat has _DSD entries).
> > >
> > > The SDHCI driver is thus currently broken on a modern BIOS, even if
> > > BIOS provides both _CRS (for index based lookup) and _DSD entries (for
> > > string based lookup). Ironically, none of these will be used for the
> > > lookup currently because:
> > >
> > > * Since the con_id is NULL, acpi_find_gpio() does not find a matching
> > >   entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")
> > >
> > > * Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
> > >   returns false (because device properties have been populated from
> > >   _DSD), thus the _CRS is never used for the lookup.
> > >
> > > Fix:
> > >
> > > Try "cd" for lookup in the _DSD before falling back to using NULL so
> > > as to try looking up in the _CRS.
> > >
> > > I've tested this patch successfully with both Legacy BIOS (that
> > > provide only _CRS method) as well as modern BIOS (that provide both
> > > _CRS and _DSD). Also the use of "cd" appears to be fairly consistent
> > > across other users of this API (other MMC host controller drivers).
> > >
> > > Link: https://lkml.org/lkml/2018/9/25/1113
> > > Signed-off-by: Rajat Jain <rajatja@google.com>
> >
> > Applied for fixes, thanks!
> >
> > Should I add a stable tag to this as well?
>
> If you go with that it might make sense to have Fixes tag against
>
> commit f10e4bf6632b5be11cea875b66ba959833a69258
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Tue May 23 20:03:19 2017 +0300
>
>    gpio: acpi: Even more tighten up ACPI GPIO lookups
>

I agree.

Thanks,

Rajat


> --
> With Best Regards,
> Andy Shevchenko
