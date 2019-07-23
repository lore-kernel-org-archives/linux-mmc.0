From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v4] mmc: host: sdhci-sprd: Fix the incorrect soft reset
 operation when runtime resuming
Date: Tue, 23 Jul 2019 14:38:32 +0200
Message-ID: <CAPDyKFpy5JeGZ2w1KJN0ECB6jPG=UTZXbPRjMQQs8+NdK4rxuQ@mail.gmail.com>
References: <89c3ef495c367d58ca3abe99a1f82c48f8c08705.1563274904.git.baolin.wang@linaro.org>
 <CAPDyKFq1y6xVfA=b1ybWvA1+e9h9aSteHAHjBbXvXGVJx95FQA@mail.gmail.com> <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMz4kuKraOb_o0LFWnqkS7m0Xd3QGrw1P+md0YBNbbbp1967OA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chunyan Zhang <zhang.lyra@gmail.com>, Orson Zhai <orsonzhai@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 23 Jul 2019 at 05:05, Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Hi Ulf,
>
> On Mon, 22 Jul 2019 at 19:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 17 Jul 2019 at 04:29, Baolin Wang <baolin.wang@linaro.org> wrote:
> > >
> > > In sdhci_runtime_resume_host() function, we will always do software reset
> > > for all, which will cause Spreadtrum host controller work abnormally after
> > > resuming.
> >
> > What does "software reset for all" means?
>
> The SD host controller specification defines 3 types software reset:
> software reset for data line, software reset for command line and
> software reset for all.
> Software reset for all means this reset affects the entire Host
> controller except for the card detection circuit.

Thanks for clarifying, please update the changelog accordingly.

>
> >
> > >
> > > Thus for Spreadtrum platform that will not power down the SD/eMMC card during
> > > runtime suspend, we should not do software reset for all.
> >
> > Normally, sdhci hosts that enters runtime suspend doesn't power off
> > the card (there are some exceptions like PCI variants).
>
> Yes, same as our controller.
>
> >
> > So, what's so special here and how does the reset come into play? I
> > don't see sdhci doing a reset in sdhci_runtime_suspend|resume_host()
> > and nor doesn the callback from the sdhci-sprd.c variant doing it.
>
> In sdhci_runtime_resume_host(), it will issue sdhci_init(host, 0) to
> issue software reset for all.

Aha, I didn't read the code carefully enough. Apologize for the noise.

>
> >
> > > To fix this
> > > issue, adding a specific reset operation that adds one condition to validate
> > > the power mode to decide if we can do software reset for all or just reset
> > > command and data lines.
> > >
> > > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > > ---
> > > Changess from v3:
> > >  - Use ios.power_mode to validate if the card is power down or not.
> > >
> > > Changes from v2:
> > >  - Simplify the sdhci_sprd_reset() by issuing sdhci_reset().
> > >
> > > Changes from v1:
> > >  - Add a specific reset operation instead of changing the core to avoid
> > >  affecting other hardware.
> > > ---
> > >  drivers/mmc/host/sdhci-sprd.c |   19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
> > > index 603a5d9..94f9726 100644
> > > --- a/drivers/mmc/host/sdhci-sprd.c
> > > +++ b/drivers/mmc/host/sdhci-sprd.c
> > > @@ -373,6 +373,23 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> > >         return 1 << 31;
> > >  }
> > >
> > > +static void sdhci_sprd_reset(struct sdhci_host *host, u8 mask)
> > > +{
> > > +       struct mmc_host *mmc = host->mmc;
> > > +
> > > +       /*
> > > +        * When try to reset controller after runtime suspend, we should not
> > > +        * reset for all if the SD/eMMC card is not power down, just reset
> > > +        * command and data lines instead. Otherwise will meet some strange
> > > +        * behaviors for Spreadtrum host controller.
> > > +        */
> > > +       if (host->runtime_suspended && (mask & SDHCI_RESET_ALL) &&
> > > +           mmc->ios.power_mode == MMC_POWER_ON)
> > > +               mask = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
> >
> > Can sdhci_sprd_reset() be called when the host is runtime suspended?
>
> When host tries to runtime resume in sdhci_runtime_resume_host(), it
> will call reset operation to do software reset.

Right, I see that now, thanks for clarifying.

However, there are still some weird things going on in
sdhci_runtime_resume_host(). Like why is host->ops->enable_dma()
called first, directly from sdhci_runtime_resume_host(), then again in
sdhci_do_reset(), after host->ops->reset() has been called. Looks like
the first call to ->enable_dma() doesn't make sense?

>
> > That sounds like a bug to me, no?
>
> Since our controller will meet some strange behaviors if we do
> software reset for all in sdhci_runtime_resume_host(), and try to
> avoid changing the core logic of sdhci_runtime_resume_host() used by
> other hardware controllers, thus I introduced a specific reset ops and
> added some condition to make sure we just do software reset command
> and data lines from runtime suspend state.

I understand, but perhaps it would become more clear if
sdhci_runtime_resume_host() is re-factored a bit. Maybe the caller can
give it some new parameter to let it decide if a SDHCI_RESET_ALL shall
be done or not.

>
> >
> > > +
> > > +       sdhci_reset(host, mask);
> > > +}
> > > +
> > >  static struct sdhci_ops sdhci_sprd_ops = {
> > >         .read_l = sdhci_sprd_readl,
> > >         .write_l = sdhci_sprd_writel,
> > > @@ -381,7 +398,7 @@ static unsigned int sdhci_sprd_get_max_timeout_count(struct sdhci_host *host)
> > >         .get_max_clock = sdhci_sprd_get_max_clock,
> > >         .get_min_clock = sdhci_sprd_get_min_clock,
> > >         .set_bus_width = sdhci_set_bus_width,
> > > -       .reset = sdhci_reset,
> > > +       .reset = sdhci_sprd_reset,
> > >         .set_uhs_signaling = sdhci_sprd_set_uhs_signaling,
> > >         .hw_reset = sdhci_sprd_hw_reset,
> > >         .get_max_timeout_count = sdhci_sprd_get_max_timeout_count,
> > > --
> > > 1.7.9.5
> > >

Kind regards
Uffe
