From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v2 04/16] mmc: meson-gx: use _irqsave variant of spinlock
Date: Tue, 22 Aug 2017 13:41:31 +0200
Message-ID: <1503402091.7032.9.camel@baylibre.com>
References: <20170821160301.21899-1-jbrunet@baylibre.com>
         <20170821160301.21899-5-jbrunet@baylibre.com>
         <CAPDyKFpoOc+1WMqLMOwhGkifP-Zp3GS7wTSkHmBUk4Pf0Dh+DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpoOc+1WMqLMOwhGkifP-Zp3GS7wTSkHmBUk4Pf0Dh+DQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2017-08-22 at 13:08 +0200, Ulf Hansson wrote:
> On 21 August 2017 at 18:02, Jerome Brunet <jbrunet@baylibre.com> wrote:
> > spinlock used in interrupt handler should use the _irqsave variant
> 
> Exactly why is that needed?

That's a mistake left over from a debugging session. Thx for pointing it out.
I'll respin w/o it 

> 
> > 
> > Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  drivers/mmc/host/meson-gx-mmc.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-
> > mmc.c
> > index 8a74a048db88..a399fbd415f4 100644
> > --- a/drivers/mmc/host/meson-gx-mmc.c
> > +++ b/drivers/mmc/host/meson-gx-mmc.c
> > @@ -727,6 +727,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
> >         struct mmc_command *cmd;
> >         struct mmc_data *data;
> >         u32 irq_en, status, raw_status;
> > +       unsigned long flag;
> >         irqreturn_t ret = IRQ_HANDLED;
> > 
> >         if (WARN_ON(!host))
> > @@ -739,7 +740,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
> > 
> >         data = cmd->data;
> > 
> > -       spin_lock(&host->lock);
> > +       spin_lock_irqsave(&host->lock, flag);
> >         irq_en = readl(host->regs + SD_EMMC_IRQ_EN);
> >         raw_status = readl(host->regs + SD_EMMC_STATUS);
> >         status = raw_status & irq_en;
> > @@ -806,7 +807,7 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
> >         if (ret == IRQ_HANDLED)
> >                 meson_mmc_request_done(host->mmc, cmd->mrq);
> > 
> > -       spin_unlock(&host->lock);
> > +       spin_unlock_irqrestore(&host->lock, flag);
> >         return ret;
> >  }
> > 
> > --
> > 2.9.5
> > 
> 
> Kind regards
> Uffe
