From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/11] mmc: core: Add helper function to indicate if SDIO
 IRQs is enabled
Date: Thu, 5 Sep 2019 09:28:58 +0200
Message-ID: <CAPDyKFqAiBHb3Tta3VXWbhxJkRP_KyokgkXAr+CmJxAXqE7Cvg@mail.gmail.com>
References: <20190903142207.5825-1-ulf.hansson@linaro.org> <20190903142207.5825-2-ulf.hansson@linaro.org>
 <20190904235836.GG70797@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190904235836.GG70797@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Kaehlcke <mka@chromium.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Douglas Anderson <dianders@chromium.org>, Shawn Lin <shawn.lin@rock-chips.com>, Jaehoon Chung <jh80.chung@samsung.com>, Yong Mao <yong.mao@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 5 Sep 2019 at 01:58, Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi Ulf,
>
> On Tue, Sep 03, 2019 at 04:21:57PM +0200, Ulf Hansson wrote:
> > To avoid each host driver supporting SDIO IRQs, from keeping track
> > internally about if SDIO IRQs has been enabled, let's introduce a common
> > helper function, sdio_irq_enabled().
> >
> > The function returns true if SDIO IRQs are enabled, via using the
> > information about the number of claimed irqs. This is safe, even without
> > any locks, as long as the helper function is called only from
> > runtime/system suspend callbacks of the host driver.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  include/linux/mmc/host.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 4a351cb7f20f..0c0a565c7ff1 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -493,6 +493,15 @@ void mmc_command_done(struct mmc_host *host, struct mmc_request *mrq);
> >
> >  void mmc_cqe_request_done(struct mmc_host *host, struct mmc_request *mrq);
> >
> > +/*
> > + * May be called from host driver's system/runtime suspend/resume callbacks,
> > + * to know if SDIO IRQs has been enabled.
> > +*/
> > +static inline bool sdio_irq_enabled(struct mmc_host *host)
> > +{
> > +     return host->sdio_irqs > 0;
> > +}
> > +
>
> The name of the function is a bit misleadling, since it indicates
> if SDIO IRQs should be enabled, not whether they are actually enabled
> by the host. The resulting code can look a bit confusing to the
> uninstructed reader:
>
>   if (sdio_irq_enabled(host->slot->mmc))
>     __dw_mci_enable_sdio_irq(host->slot, 1);
>
> aka 'if SDIO IRQ is enabled, enable SDIO IRQ'.
>
> sdio_irqs_claimed() could be a possible alternative.
>
> No biggie though, just something I noticed.

Thanks for the suggestions. It makes perfect sense to me, let me rename it.

Kind regards
Uffe
