From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 1/2] mmc: sdio: Move code to get pending SDIO IRQs to a
 function
Date: Thu, 29 Aug 2019 10:25:04 -0700
Message-ID: <20190829172504.GE70797@google.com>
References: <20190828214620.66003-1-mka@chromium.org>
 <CAPDyKFrJOXC5DaYzPrEr-ttv5Mz6NLAvVW+L4xUUaiZpqyj+Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrJOXC5DaYzPrEr-ttv5Mz6NLAvVW+L4xUUaiZpqyj+Dw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Douglas Anderson <dianders@chromium.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 29, 2019 at 10:29:26AM +0200, Ulf Hansson wrote:
> On Wed, 28 Aug 2019 at 23:46, Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > Move the code to get pending SDIO interrupts from
> > process_sdio_pending_irqs() to a dedicated function.
> >
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> >  drivers/mmc/core/sdio_irq.c | 47 ++++++++++++++++++++++++-------------
> >  include/linux/mmc/host.h    |  1 +
> >  2 files changed, 32 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> > index 0bcc5e83bd1a..fedc49901efd 100644
> > --- a/drivers/mmc/core/sdio_irq.c
> > +++ b/drivers/mmc/core/sdio_irq.c
> > @@ -27,6 +27,35 @@
> >  #include "core.h"
> >  #include "card.h"
> >
> > +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending)
> > +{
> > +       struct mmc_card *card = host->card;
> > +       int ret;
> > +
> > +       WARN_ON(!host->claimed);
> > +
> > +       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, pending);
> > +       if (ret) {
> > +               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> > +                      mmc_card_id(card), ret);
> > +               return ret;
> > +       }
> > +
> > +       if (*pending && mmc_card_broken_irq_polling(card) &&
> > +           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> > +               unsigned char dummy;
> > +
> > +               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> > +                * register with a Marvell SD8797 card. A dummy CMD52 read to
> > +                * function 0 register 0xff can avoid this.
> > +                */
> > +               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(sdio_get_pending_irqs);
> 
> I don't think you need export the sympol as this should be an internal
> function for the core module.

ok, thanks

> > +
> >  static int process_sdio_pending_irqs(struct mmc_host *host)
> >  {
> >         struct mmc_card *card = host->card;
> > @@ -49,23 +78,9 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
> >                 return 1;
> >         }
> >
> > -       ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
> > -       if (ret) {
> > -               pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
> > -                      mmc_card_id(card), ret);
> > +       ret = sdio_get_pending_irqs(host, &pending);
> > +       if (ret)
> >                 return ret;
> > -       }
> > -
> > -       if (pending && mmc_card_broken_irq_polling(card) &&
> > -           !(host->caps & MMC_CAP_SDIO_IRQ)) {
> > -               unsigned char dummy;
> > -
> > -               /* A fake interrupt could be created when we poll SDIO_CCCR_INTx
> > -                * register with a Marvell SD8797 card. A dummy CMD52 read to
> > -                * function 0 register 0xff can avoid this.
> > -                */
> > -               mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
> > -       }
> >
> >         count = 0;
> >         for (i = 1; i <= 7; i++) {
> > diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> > index 4a351cb7f20f..7ce0e98e3dbd 100644
> > --- a/include/linux/mmc/host.h
> > +++ b/include/linux/mmc/host.h
> > @@ -502,6 +502,7 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
> >  }
> >
> >  void sdio_signal_irq(struct mmc_host *host);
> > +int sdio_get_pending_irqs(struct mmc_host *host, u8 *pending);
> 
> I want to avoid to sprinkle the public mmc headers, avoiding
> interfaces to be abused outside mmc core.
> 
> That said, I think this should be internal to the mmc core, thus
> please move this to drivers/mmc/core/sdio_ops.h.

Sounds good
