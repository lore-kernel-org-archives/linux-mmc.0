From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
Date: Thu, 27 Sep 2018 10:26:42 +0300
Message-ID: <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com>
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dtor@google.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Rajat Jain <rajatxjain@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 26, 2018 at 10:26 PM Rajat Jain <rajatja@google.com> wrote:
> On Wed, Sep 26, 2018 at 1:42 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Sep 26, 2018 at 10:49 AM Mika Westerberg
> > <mika.westerberg@linux.intel.com> wrote:

> > > Or you can use con_id=<actual string> everywhere and supply
> > > acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
> > > not provide _DSD.
>
> This sounds like a good idea and I'd like to do this. I have some
> questions though:
>
> 1) If the BIOS does provide a _DSD entry for "cd-gpio", and
> additionally driver also uses devm_acpi_dev_add_driver_gpios() to add
> one more entry for the same string "cd-gpio", which one will (should?)
> actually be returned by the gpiolib? The one in BIOS or the one that
> was added by the driver?

Of course the one that BIOS provides. This hardcoded mapping tables is
a fallback for *old* BIOSes which do not have _DSD.

> 2) Related, I'm trying to understand how can a driver use
> devm_acpi_dev_add_driver_gpios(), for *only* the case where the BIOS
> does not have a _DSD (Or should it really care)? Does the driver need
> to check for _DSD using some other ACPI call?

The magic happens internally in ACPI core.
Whenever one calls gpiod_get() with a name on ACPI-enabled platform,
_DSD would be checked first.

> > See also Documentation/acpi/gpio-properties.txt for
> > > more information.

> > > In case of SDHCI I think the correct way is to stick using _CRS lookup
> > > only because there typically is just one GpioInt() and I have not seen a
> > > single BIOS yet where they implement _DSD for this besides yours. If
> > > there is not way to change the BIOS implementation then I guess we just
> > > need to amend the driver to call acpi_dev_add_driver_gpios().
>
> Since we shouldn't discourage a BIOS that is trying to do the right
> thing by exposing the details in _DST, I think it would be preferable
> if we can solve this in the kernel.

Patches are welcome, I think.

Btw, is there any existing hardware on the market with such BIOS?

-- 
With Best Regards,
Andy Shevchenko
