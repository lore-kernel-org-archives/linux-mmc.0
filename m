From: Rajat Jain <rajatja@google.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
Date: Wed, 26 Sep 2018 12:25:40 -0700
Message-ID: <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

Thanks Mika and Andy for your inputs.

On Wed, Sep 26, 2018 at 1:42 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Sep 26, 2018 at 10:49 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > Hi,
> >
> > On Tue, Sep 25, 2018 at 01:54:57PM -0700, Rajat Jain wrote:
> > > * Use con_id=NULL if it is dealing with a legacy BIOS (i.e. no _DSD
> > > properties in the ACPI).
> > > * Use con_id=<actual string> if it is dealing with a modern BIOS (i.e.
> > > which provides _DSD for the <string> property)
> >
> > Or you can use con_id=<actual string> everywhere and supply
> > acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
> > not provide _DSD.

This sounds like a good idea and I'd like to do this. I have some
questions though:

1) If the BIOS does provide a _DSD entry for "cd-gpio", and
additionally driver also uses devm_acpi_dev_add_driver_gpios() to add
one more entry for the same string "cd-gpio", which one will (should?)
actually be returned by the gpiolib? The one in BIOS or the one that
was added by the driver?

2) Related, I'm trying to understand how can a driver use
devm_acpi_dev_add_driver_gpios(), for *only* the case where the BIOS
does not have a _DSD (Or should it really care)? Does the driver need
to check for _DSD using some other ACPI call?

> See also Documentation/acpi/gpio-properties.txt for
> > more information.
>
> Thanks, Mika. That is exactly the way how I suggested to fix and
> actually fixed a lot of drivers already.
>
> Run `git grep -n -w devm_acpi_dev_add_driver_gpios` to find examples.
>
> > In case of SDHCI I think the correct way is to stick using _CRS lookup
> > only because there typically is just one GpioInt() and I have not seen a
> > single BIOS yet where they implement _DSD for this besides yours. If
> > there is not way to change the BIOS implementation then I guess we just
> > need to amend the driver to call acpi_dev_add_driver_gpios().

Since we shouldn't discourage a BIOS that is trying to do the right
thing by exposing the details in _DST, I think it would be preferable
if we can solve this in the kernel.

Thanks,

Rajat

>
> True.
>
> --
> With Best Regards,
> Andy Shevchenko
