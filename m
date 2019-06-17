From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: sdhci: sdhci-pci-o2micro: Correctly set bus
 width when tuning
Date: Mon, 17 Jun 2019 12:26:59 +0200
Message-ID: <CAPDyKFro3vHMMPHpVOSqiyFgtJsqmyzK11hipCGpDYFARyN+hg@mail.gmail.com>
References: <20190610185354.35310-1-rrangel@chromium.org> <CAPDyKFppNgL_kZPV-QS6ZiJErde5ea8Nj-sQTy_vXhW9jfXhpg@mail.gmail.com>
 <20190612150115.GA27989@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190612150115.GA27989@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Raul Rangel <rrangel@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ernest.zhang" <ernest.zhang@bayhubtech.com>, Daniel Kurtz <djkurtz@chromium.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 12 Jun 2019 at 17:01, Raul Rangel <rrangel@chromium.org> wrote:
>
> On Wed, Jun 12, 2019 at 03:36:25PM +0200, Ulf Hansson wrote:
> > On Mon, 10 Jun 2019 at 20:54, Raul E Rangel <rrangel@chromium.org> wrote:
> > >
> > > sdhci_send_tuning uses mmc->ios.bus_width to determine the block size.
> > > Without this patch the block size would be set incorrectly when the
> > > bus_width == 8 which results in tuning failing.
> > >
> > > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > > ---
> > >
> > >  drivers/mmc/host/sdhci-pci-o2micro.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> > > index b29bf4e7dcb48..dd21315922c87 100644
> > > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> > > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> > > @@ -115,6 +115,7 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > >          */
> > >         if (mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> > >                 current_bus_width = mmc->ios.bus_width;
> > > +               mmc->ios.bus_width = MMC_BUS_WIDTH_4;
> >
> > This looks wrong.
> >
> > mmc->ios.bus_width is not supposed to be updated by a host driver, but
> I guess I left this part out: The O2Micro controller only supports
> tuning at 4-bits. So the host driver needs to change the bus width while
> tuning and then set it back when done.

Thanks for clarifying. Please add that information to the changelog
and a minor comment in the code as well.

> Ideally I would have used
> `mmc_set_bus_width()`, but that is a core only function.

Well, that function also calls mmc_set_ios(), which is not what you
want, or is it?

>
> If `sdhci_send_tuning()` didn't rely on mmc->ios.bus_width to determine
> the bus width, but instead read the HOST_CONTROL register then this
> patch wouldn't be needed.

Could you elaborate on that. Perhaps there are variants that have a
similar constraint and in such case, this solution could possibly help
them as well.

> > rather the value should only be read.
> >
> > >                 sdhci_set_bus_width(host, MMC_BUS_WIDTH_4);
> > >         }
> > >
> > > @@ -126,8 +127,10 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
> > >
> > >         sdhci_end_tuning(host);
> > >
> > > -       if (current_bus_width == MMC_BUS_WIDTH_8)
> > > +       if (current_bus_width == MMC_BUS_WIDTH_8) {
> > > +               mmc->ios.bus_width = MMC_BUS_WIDTH_8;
> >
> > Ditto.
> >
> > >                 sdhci_set_bus_width(host, current_bus_width);
> > > +       }
> > >
> > >         host->flags &= ~SDHCI_HS400_TUNING;
> > >         return 0;
> > > --
> > > 2.22.0.rc2.383.gf4fbbf30c2-goog
> > >
> >

Kind regards
Uffe
