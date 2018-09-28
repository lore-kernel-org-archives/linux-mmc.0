From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
Date: Fri, 28 Sep 2018 15:13:31 +0200
Message-ID: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
 <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com>
 <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com>
 <CACRpkdZZW_HK8uFA=iQQ88DnoR7KX2mYTbO3HMtNBLd-3GpiWQ@mail.gmail.com> <CAA93t1qYN8BAZjOY+osHzTjYthYo+HY10zvfgQ-Z8+AQ2HdFZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA93t1qYN8BAZjOY+osHzTjYthYo+HY10zvfgQ-Z8+AQ2HdFZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rajatxjain@gmail.com
Cc: Rajat Jain <rajatja@google.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@google.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 28, 2018 at 2:34 PM Rajat Jain <rajatxjain@gmail.com> wrote:

> > This is not looking good at all.
> >
> > Andy should we revert the patch or do you have some other
> > quick fix in mind we could do? It seems reverting the patch
> > could be bad for the mctrl patches IIUC, but this regression
> > seems even more serious.
>
> Sorry, I may have made it sound like more serious than it is. Yes,
> what I said is true, but we (Google) does not plan to update those
> devices to the latest kernel. That regression will only be seen by any
> developers who try to do it on their own.

Given the number of core kernel developers using chromebooks
and relying on them to be working as expected, these are the
users I am most worried about, really.

If only 3 users in the world can't read photos from their SD-cards
that may sound like a small problem, but if those 3 users are
core kernel developers reporting bugs, I as maintainer have a
big problem. So not all users are equal, or how should I put it.

> Also, the commit I mentioned above was put in long time back, and I
> think it is more reasonable to put a fix in the sdhci driver instead.

OK cool.

>  - It seems that 1 SDHCI device may support multiple slots. It was not
> clear to me if they could share card detect interrupts, or should have
> separate ones? Also, the driver may not really know? So should I add 1
> or two pins using the devm_acpi_dev_add_driver_gpios().
>
> - I was unsure what should I set the active_low to.
>
> Given these concerns, it seemed the easiest fix to me, if we can call
> mmc_gpiod_request_cd() twice, once with "cd" and then with NULL as a
> fallback.

That sounds like a resonable fix to me.

Yours,
Linus Walleij
