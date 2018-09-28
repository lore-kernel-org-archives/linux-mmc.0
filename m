From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: sdhci driver card-detect is broken because gpiolib can't fallback
 to _CRS?
Date: Fri, 28 Sep 2018 10:42:07 +0200
Message-ID: <CACRpkdZZW_HK8uFA=iQQ88DnoR7KX2mYTbO3HMtNBLd-3GpiWQ@mail.gmail.com>
References: <CACK8Z6Ebo0giDifRHBg13pe_mO18vb1n0+LGMoMjkLai6X9MNg@mail.gmail.com>
 <20180926074756.GD2664@lahna.fi.intel.com> <CAHp75Vdf7NxFtgZx+hqsA1YZY4szD5Ba9jbyo4CeeDHeaU3YAQ@mail.gmail.com>
 <CACK8Z6F1jkSN3KXiv+0X2uh61pBkpSMpHrdMHwLarbSAFoHMUA@mail.gmail.com>
 <CAHp75VcQ0SviZ6vsn_5inn5oZxxj-5ZQq5bC+bXPxuF8KOa_Rg@mail.gmail.com> <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACK8Z6HjFy_5sv_ZRRyfRgCYMYPpuoFqmKekyi7fSLk14YpN6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rajat Jain <rajatja@google.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Dmitry Torokhov <dtor@google.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, rajatxjain@gmail.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 27, 2018 at 7:57 PM Rajat Jain <rajatja@google.com> wrote:

> > Patches are welcome, I think.
> >
> > Btw, is there any existing hardware on the market with such BIOS?
>
> Yes, all the chrome books available in the market (at least the ones
> released in last 3 years) have same ACPI layout (provide _DSD for
> card-detect). They are all working fine today because they use an
> older kernel, but if we update them to the latest kernel, this part
> will be broken.

This is not looking good at all.

Andy should we revert the patch or do you have some other
quick fix in mind we could do? It seems reverting the patch
could be bad for the mctrl patches IIUC, but this regression
seems even more serious.

Yours,
Linus Walleij
