From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [PATCH] mmc: moxart: fix
 wait_for_completion_interruptible_timeout return variable type
Date: Mon, 25 Jul 2016 13:20:55 +0000
Message-ID: <20160725132055.GA26009@osadl.at>
References: <1469377937-14360-1-git-send-email-hofrat@osadl.org>
 <CAPDyKFpTcG8vrqTYiJqGnD9MYAJ9SQy_0fZiiO0UF-E5qX0Crg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpTcG8vrqTYiJqGnD9MYAJ9SQy_0fZiiO0UF-E5qX0Crg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Luis de Bethencourt <luis@debethencourt.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jul 25, 2016 at 10:29:46AM +0200, Ulf Hansson wrote:
> On 24 July 2016 at 18:32, Nicholas Mc Guire <hofrat@osadl.org> wrote:
> > wait_for_completion_timeout_interruptible returns long not unsigned long
> > so dma_time, which is used exclusively here, is changed to long.
> >
> > Fixes: 1b66e94e6b99 ("mmc: moxart: Add MOXA ART SD/MMC driver")
> >
> > Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> > ---
> >
> > API non-compliance was located by coccinelle
> >
> > This is mostly cosmetic since dma_time is not actually used for anything
> > at present, however if it ever were, then a signal received would be
> > interpreted as a large remaining jiffies left, which would be wrong.
> >
> > Compile tested with: moxart_defconfig + ARCH_MULTI_V4=y,
> > CONFIG_ARCH_MOXART=y, CONFIG_MMC_MOXART=y
> >
> > Patch is against 4.7.0-rc7 (localversion-next -next-20160724)
> >
> >  drivers/mmc/host/moxart-mmc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> > index 79905ce..2e5c25f 100644
> > --- a/drivers/mmc/host/moxart-mmc.c
> > +++ b/drivers/mmc/host/moxart-mmc.c
> > @@ -257,7 +257,7 @@ static void moxart_dma_complete(void *param)
> >  static void moxart_transfer_dma(struct mmc_data *data, struct moxart_host *host)
> >  {
> >         u32 len, dir_data, dir_slave;
> > -       unsigned long dma_time;
> > +       long dma_time;
> >         struct dma_async_tx_descriptor *desc = NULL;
> >         struct dma_chan *dma_chan;
> >
> > @@ -397,7 +397,7 @@ static void moxart_prepare_data(struct moxart_host *host)
> >  static void moxart_request(struct mmc_host *mmc, struct mmc_request *mrq)
> >  {
> >         struct moxart_host *host = mmc_priv(mmc);
> > -       unsigned long pio_time, flags;
> > +       long pio_time, flags;
> 
> This changes "flags" too. I don't think that is what you really want, right!?
> 
oops - sorry - my bad - looks like I first added the problem
and then "found it" - will fix this up.

thx!
hofrat
