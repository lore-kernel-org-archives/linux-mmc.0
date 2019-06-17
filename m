From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: mediatek: fix SDIO IRQ interrupt handle flow
Date: Mon, 17 Jun 2019 09:47:07 +0200
Message-ID: <CAPDyKFqs2ngPfR_SM2MEssFVDDw=S7G_Oy7V7x-bP9_aFm5XDQ@mail.gmail.com>
References: <1560489970-30467-1-git-send-email-jjian.zhou@mediatek.com>
 <CAPDyKFrXU4bpKeB7Aa15j2nHqUCn-bk+YKn9_vkznmi+PS8H7A@mail.gmail.com> <1560751020.3103.25.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560751020.3103.25.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
To: jjian zhou <jjian.zhou@mediatek.com>
Cc: =?UTF-8?B?Q2hhb3RpYW4gSmluZyAo5LqV5pyd5aSpKQ==?= <Chaotian.Jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, =?UTF-8?B?WW9uZyBNYW8gKOavm+WLhyk=?= <yong.mao@mediatek.com>, srv_heupstream <srv_heupstream@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 17 Jun 2019 at 07:57, jjian zhou <jjian.zhou@mediatek.com> wrote:
>
> On Fri, 2019-06-14 at 17:46 +0800, Ulf Hansson wrote:
> > On Fri, 14 Jun 2019 at 07:26, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
> > >
> > > From: jjian zhou <jjian.zhou@mediatek.com>
> > >
> > > SDIO IRQ is triggered by low level. It need disable SDIO IRQ
> > > detected function. Otherwise the interrupt register can't be cleared.
> > > It will process the interrupt more.
> > >
> > > Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> > > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > > ---
> > >  drivers/mmc/host/mtk-sd.c | 13 +++++++------
> > >  1 file changed, 7 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > > index c518cc2..29992ae 100644
> > > --- a/drivers/mmc/host/mtk-sd.c
> > > +++ b/drivers/mmc/host/mtk-sd.c
> > > @@ -1389,10 +1389,12 @@ static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> > >         struct msdc_host *host = mmc_priv(mmc);
> > >
> > >         spin_lock_irqsave(&host->lock, flags);
> > > -       if (enb)
> > > +       if (enb) {
> > >                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > > -       else
> > > +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > > +       } else {
> > >                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> >
> > Rather than clearing SDC_CFG_SDIOIDE in the irq handler, you need to
> > do it here. As otherwise when the mmc core calls
> > host->ops->enable_sdio_irq() to disable the SDIO IRQ, it may stay
> > enabled.
> >
>
> Thank you for your review.
>
> I remove the spin lock in "__msdc_enable_sdio_irq" and add
> spin lock in "msdc_enable_sdio_irq". The modification of
> "__msdc_enable_sdio_irq" and "msdc_enable_sdio_irq" is as following.
>
> static void __msdc_enable_sdio_irq(struct msdc_host *host, int enb)
> {
>         if (enb) {
>                 sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
>                 sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>         } else {
>                 sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
>                 sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>         }
> }
>
> static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> {
>         unsigned long flags;
>         struct msdc_host *host = mmc_priv(mmc);
>         spin_lock_irqsave(&host->lock, flags);;
>         __msdc_enable_sdio_irq(host, enb);
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if (enb)
>                 pm_runtime_get_noresume(host->dev);
>         else
>                 pm_runtime_get_noidle(host->dev);
> }
>
> > > +       }
> > >         spin_unlock_irqrestore(&host->lock, flags);
> > >  }
> > >
> > > @@ -1422,6 +1424,8 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> > >                 spin_lock_irqsave(&host->lock, flags);
> > >                 events = readl(host->base + MSDC_INT);
> > >                 event_mask = readl(host->base + MSDC_INTEN);
> > > +               if ((events & event_mask) & MSDC_INT_SDIOIRQ)
> > > +                       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> >
> > As stated above, I suggest you move this into __msdc_enable_sdio_irq()
> > and thus call that function from here instead. Well, that doesn't work
> > as is, because of the spin lock, so you rather need to make a
> > sub-function of __msdc_enable_sdio_irq, that don't take/releases the
> > lock.
> >
> > I hope that was clear. If not, I can post a patch to show you what I mean.
> >
>
> I also modify this part handler in msdc_irq.
>
>         spin_lock_irqsave(&host->lock, flags);
>         events = readl(host->base + MSDC_INT);
>         event_mask = readl(host->base + MSDC_INTEN);
>         if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                 __msdc_enable_sdio_irq(host, 0);
>         /* clear interrupts */
>         writel(events & event_mask, host->base + MSDC_INT);
>
>         mrq = host->mrq;
>         cmd = host->cmd;
>         data = host->data;
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if ((events & event_mask) & MSDC_INT_SDIOIRQ)
>                 sdio_signal_irq(host->mmc);
>
> I also will add spin lock in the "msdc_ack_sdio_irq".
>
> Looking forward to your suggestions.

Seems reasonable, please post a new version, then I will review again.

[...]

Kind regards
Uffe
