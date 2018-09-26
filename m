From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't
 fallback to _CRS?
Date: Wed, 26 Sep 2018 10:47:56 +0300
Message-ID: <20180926074756.GD2664@lahna.fi.intel.com>
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Rajat Jain <rajatxjain@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Sep 25, 2018 at 01:54:57PM -0700, Rajat Jain wrote:
> * Use con_id=NULL if it is dealing with a legacy BIOS (i.e. no _DSD
> properties in the ACPI).
> * Use con_id=<actual string> if it is dealing with a modern BIOS (i.e.
> which provides _DSD for the <string> property)

Or you can use con_id=<actual string> everywhere and supply
acpi_dev_add_driver_gpios() where needed to cover cases where BIOS does
not provide _DSD. See also Documentation/acpi/gpio-properties.txt for
more information.

In case of SDHCI I think the correct way is to stick using _CRS lookup
only because there typically is just one GpioInt() and I have not seen a
single BIOS yet where they implement _DSD for this besides yours. If
there is not way to change the BIOS implementation then I guess we just
need to amend the driver to call acpi_dev_add_driver_gpios().
