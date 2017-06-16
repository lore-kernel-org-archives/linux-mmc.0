From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 2/5] mmc: tmio: add complete to DMA ops
Date: Fri, 16 Jun 2017 08:06:08 +0200
Message-ID: <20170616060602.GA16534@verge.net.au>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
 <1496927368-18897-4-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUkhkDEqsDZUQ94dFnLU+dFcZ+ed=qHokH3sEWGFdkkuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUkhkDEqsDZUQ94dFnLU+dFcZ+ed=qHokH3sEWGFdkkuw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 09, 2017 at 09:35:20AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Jun 8, 2017 at 3:09 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > Add complete to DMA ops to allow DMAC implementation dependent
> > handling of DMA completion.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/mmc/host/tmio_mmc.h      |  1 +
> >  drivers/mmc/host/tmio_mmc_core.c | 10 ++++++++--
> >  2 files changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> > index 9c94b6eb9b49..82725f9de359 100644
> > --- a/drivers/mmc/host/tmio_mmc.h
> > +++ b/drivers/mmc/host/tmio_mmc.h
> > @@ -121,6 +121,7 @@ struct tmio_mmc_dma_ops {
> >                         struct tmio_mmc_data *pdata);
> >         void (*release)(struct tmio_mmc_host *host);
> >         void (*abort)(struct tmio_mmc_host *host);
> > +       void (*complete)(struct tmio_mmc_host *host);
> >  };
> >
> >  struct tmio_mmc_host {
> > diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> > index 0e76e099dc7f..26fe9bb64849 100644
> > --- a/drivers/mmc/host/tmio_mmc_core.c
> > +++ b/drivers/mmc/host/tmio_mmc_core.c
> > @@ -86,6 +86,12 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
> >                 host->dma_ops->abort(host);
> >  }
> >
> > +static inline void tmio_mmc_complete_dma(struct tmio_mmc_host *host)
> > +{
> > +       if (host->dma_ops)
> > +               host->dma_ops->complete(host);
> 
> I believe this will cause a crash and thus break bisection, as no driver
> fills in the complete pointer yet.

Indeed. And it seems to cause a panic on non-Gen3 users of the driver.

I think the fix should be:

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 26fe9bb64849..9ec2e933b6f0 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -88,7 +88,7 @@ static inline void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
 
 static inline void tmio_mmc_complete_dma(struct tmio_mmc_host *host)
 {
-	if (host->dma_ops)
+	if (host->dma_ops && host->dma_ops->complete)
 		host->dma_ops->complete(host);
 }
 

> 
> > +}
> > +
> >  void tmio_mmc_enable_mmc_irqs(struct tmio_mmc_host *host, u32 i)
> >  {
> >         host->sdcard_irq_mask &= ~(i & TMIO_MASK_IRQ);
> > @@ -604,11 +610,11 @@ static void tmio_mmc_data_irq(struct tmio_mmc_host *host, unsigned int stat)
> >
> >                 if (done) {
> >                         tmio_mmc_disable_mmc_irqs(host, TMIO_STAT_DATAEND);
> > -                       complete(&host->dma_dataend);
> > +                       tmio_mmc_complete_dma(host);
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
