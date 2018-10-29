From: Rajat Jain <rajatxjain@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
Date: Mon, 29 Oct 2018 12:43:24 -0700
Message-ID: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
 <20181018215101.169847-1-rajatja@google.com> <CAHp75Vd_r4QGR5xw2cJigM2J3WStg_0PdynBXMZOyZh+t1znKg@mail.gmail.com>
 <CACK8Z6HOsUcPFyf-GguxPxh_Zdj6gCXP=FpGw-vQXJfnM=cquw@mail.gmail.com>
 <20181024100230.GQ10650@smile.fi.intel.com> <CAE_wzQ-80NCNbzbFx1eEDwEEOEAbv-5u+W171iUagY2pOahbmw@mail.gmail.com>
 <CAHp75VfMHqT+aAGVaXzXGbzF2=VEABOOaGhkjfV-D0NPbBM+Rw@mail.gmail.com>
 <CACK8Z6GMsfVEpefzwvVgS44Eg=PQzcNOaC3GA9F2OzrBxvpchw@mail.gmail.com> <20181029174356.GR10650@smile.fi.intel.com>
Reply-To: rajatxjain@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181029174356.GR10650@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rajat Jain <rajatja@google.com>, Dmitry Torokhov <dtor@google.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Oct 29, 2018 at 10:44 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Mon, Oct 29, 2018 at 10:22:02AM -0700, Rajat Jain wrote:
> > On Mon, Oct 29, 2018 at 8:23 AM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Oct 24, 2018 at 9:03 PM Dmitry Torokhov <dtor@google.com> wrote:
> > > > On Wed, Oct 24, 2018 at 3:02 AM Andy Shevchenko
> > > > <andy.shevchenko@gmail.com> wrote:
> > > > > On Mon, Oct 22, 2018 at 04:34:55PM -0700, Rajat Jain wrote:
> > > > > > On Fri, Oct 19, 2018 at 2:13 AM Andy Shevchenko
> > > > > > <andy.shevchenko@gmail.com> wrote:
>
> > > > > > Also, the driver may not
> > > > > > really know?
> > > > >
> > > > > I think in such case the bug in HW design and / or driver.
> > > >
> > > > Why? You can have a shared or dedicated interrupt and the driver does
> > > > not really need to know if it can poll the status.
> > >
> > > Yes, that's my point either we get 1:1 mapping between slot and GPIOs
> > > or have a possibility to read back from some register(s) the actual
> > > status of all of them, otherwise it's a bad design.
> >
> > No, AFAIU, the driver only should only be able to read the status of
> > *the* interrupt that was fired? (as opposite to the ability to read
> > *all of them* when an interrupt fires).
>
> I can't be sure in the details of this (sdhci) driver, I'm not a maintainer of
> that one. So, my above conclusions are purely generic.
>
> > > > > > 2) I'm not really sure what should I set "active_low" to? Isn't this
> > > > > > something that should be specified by platform / ACPI too, and driver
> > > > > > should just be able to say say choose whatever the ACPI says?
> > > > > >
> > > > > > struct acpi_gpio_params {
> > > > > >         unsigned int crs_entry_index;
> > > > > >         unsigned int line_index;
> > > > > >         bool active_low;
> > > > > > };
>
>
> > > > > ACPI specification misses this property, that's why we have it in the
> > > > > structure. In your case it should be provided by _DSD and thus be consistent
> > > > > with the hardcoded values.
> > > >
> > > > Again, you think as if the driver was platform specific; it is not. I
> > > > have 1000s of systems with different ACPI tables. Let's say half of
> > > > them use one polarity, and half another. Which polarity do you propose
> > > > to use?
> > >
> > > Use one table for one half and another for the rest.
> >
> > But how does driver determine which table to use for which platform?
> > (Currently the driver is platform independent).
>
> Based on vendor and device IDs in any form of it.

The vendor ID and device ID here would mean building a table of
platforms ids in this (currently platform independent) driver. I'm not
sure if my original patch introduces any problems that are worth
solving using such a table.

I would thus prefer to solve it using my original patch, I would
respin it taking care of your other review comments.

Thanks and best regards,

Rajat

>
> --
> With Best Regards,
> Andy Shevchenko
>
>
