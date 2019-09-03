From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/4] mmc: sdhci-of-aspeed: Fix link failure for SPARC
Date: Tue, 3 Sep 2019 16:48:32 +0200
Message-ID: <CAPDyKFpWJu3RH4TWoO_wcJq0LDrM_fAUfsCC==e8O_6A8dLhiA@mail.gmail.com>
References: <20190902035842.2747-1-andrew@aj.id.au> <20190902035842.2747-2-andrew@aj.id.au>
 <CACPK8XfYgEUfaK6rtr+FdEq-Vau6d4wE2Rvfp6Q4G2-kjVLT0g@mail.gmail.com> <83570e25-b20a-4a17-85ea-15a9a53289bf@www.fastmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <83570e25-b20a-4a17-85ea-15a9a53289bf@www.fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jeffery <andrew@aj.id.au>
Cc: Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, OpenBMC Maillist <openbmc@lists.ozlabs.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-aspeed <linux-aspeed@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kbuild test robot <lkp@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2 Sep 2019 at 07:26, Andrew Jeffery <andrew@aj.id.au> wrote:
>
>
>
> On Mon, 2 Sep 2019, at 13:42, Joel Stanley wrote:
> > On Mon, 2 Sep 2019 at 03:58, Andrew Jeffery <andrew@aj.id.au> wrote:
> > >
> > > Resolves the following build error reported by the 0-day bot:
> > >
> > >     ERROR: "of_platform_device_create" [drivers/mmc/host/sdhci-of-aspeed.ko] undefined!
> > >
> > > SPARC does not set CONFIG_OF_ADDRESS so the symbol is missing. Guard the
> > > callsite to maintain build coverage for the rest of the driver.
> > >
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> > > ---
> > >  drivers/mmc/host/sdhci-of-aspeed.c | 38 ++++++++++++++++++++----------
> > >  1 file changed, 25 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > > index d5acb5afc50f..96ca494752c5 100644
> > > --- a/drivers/mmc/host/sdhci-of-aspeed.c
> > > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > > @@ -224,10 +224,30 @@ static struct platform_driver aspeed_sdhci_driver = {
> > >         .remove         = aspeed_sdhci_remove,
> > >  };
> > >
> > > -static int aspeed_sdc_probe(struct platform_device *pdev)
> > > -
> > > +static int aspeed_sdc_create_sdhcis(struct platform_device *pdev)
> > >  {
> > > +#if defined(CONFIG_OF_ADDRESS)
> >
> > This is going to be untested code forever, as no one will be running
> > on a chip with this hardware present but OF_ADDRESS disabled.
> >
> > How about we make the driver depend on OF_ADDRESS instead?
>
> Testing is split into two pieces here: compile-time and run-time.
> Clearly the run-time behaviour is going to be broken on configurations
> without CONFIG_OF_ADDRESS (SPARC as mentioned), but I don't think
> that means we shouldn't allow it to be compiled in that case
> (e.g. CONFIG_COMPILE_TEST performs a similar role).
>
> With respect to compile-time it's possible to compile either path as
> demonstrated by the build failure report.
>
> Having said that there's no reason we  couldn't do what you suggest,
> just it wasn't the existing solution pattern for the problem (there are
> several other drivers that suffered the same bug that were fixed in the
> style of this patch). Either way works, it's all somewhat academic.
> Your suggestion is more obvious in terms of correctness, but this
> patch is basically just code motion (the only addition is the `#if`/
> `#endif` lines over what was already there if we disregard the
> function declaration/invocation). I'll change it if there are further
> complaints and a reason to do a v3.

I am in favor of Joel's suggestion as I don't really like having
ifdefs bloating around in the driver (unless very good reasons).
Please re-spin a v3.

Another option is to implement stub function and to deal with error
codes, but that sounds more like a long term thingy, if even
applicable here.

Kind regards
Uffe
