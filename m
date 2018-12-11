From: Jjian Zhou <jjian.zhou@mediatek.com>
Subject: Re: [PATCH v3] mmc: mediatek: Add MMC_CAP_SDIO_IRQ support
Date: Tue, 11 Dec 2018 20:11:33 +0800
Message-ID: <1544530293.29734.30.camel@mhfsdcap03>
References: <1544442233-20303-1-git-send-email-jjian.zhou@mediatek.com>
         <CAPDyKFq2xH2m4JTbOwbh38mqjbwLRNewuYEVyOKCsBAPrUm9Dg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq2xH2m4JTbOwbh38mqjbwLRNewuYEVyOKCsBAPrUm9Dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing =?UTF-8?Q?=28=E4=BA=95=E6=9C=9D=E5=A4=A9=29?= <Chaotian.Jing@mediatek.com>, Ryder Lee =?UTF-8?Q?=28=E6=9D=8E=E5=BA=9A=E8=AB=BA=29?= <Ryder.Lee@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, srv_heupstream <srv_heupstream@mediatek.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yong Mao =?UTF-8?Q?=28=E6=AF=9B=E5=8B=87=29?= <yong.mao@mediatek.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2018-12-11 at 17:29 +0800, Ulf Hansson wrote:
> On Mon, 10 Dec 2018 at 12:44, Jjian Zhou <jjian.zhou@mediatek.com> wrote:
> >
> > From: jjian zhou <jjian.zhou@mediatek.com>
> >
> > This patch enables support SDIO IRQs. It enables
> > MMC_CAP_SDIO_IRQ & MMC_CAP2_SDIO_IRQ_NOTHREAD
> > and implement the ->ack_sdio_irq callback.
> >
> > Signed-off-by: Jjian Zhou <jjian.zhou@mediatek.com>
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 49 ++++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 46 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 6334cc7..40a1848 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -1114,6 +1114,7 @@ static void msdc_start_command(struct msdc_host *host,
> >                 struct mmc_request *mrq, struct mmc_command *cmd)
> >  {
> >         u32 rawcmd;
> > +       unsigned long flags;
> >
> >         WARN_ON(host->cmd);
> >         host->cmd = cmd;
> > @@ -1131,7 +1132,10 @@ static void msdc_start_command(struct msdc_host *host,
> >         cmd->error = 0;
> >         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> >
> > +       spin_lock_irqsave(&host->lock, flags);
> >         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +
> 
> The above looks like a reasonable change, however does it really
> belong in $subject patch. If so, can you explain why?
> 
> Maybe you should move this into a standalone separate patch?
> 

Thanks for your suggestion.

The modification of MSDC_INTEN is non-atomic operation. If it enanbles
MMC_CAP_SDIO_IRQ, there is a race condition of access MSDC_INTEN in irq
and thread context. So need make modification of MSDC_INTEN by atomic.

> >         writel(cmd->arg, host->base + SDC_ARG);
> >         writel(rawcmd, host->base + SDC_CMD);
> >  }
> > @@ -1351,6 +1355,27 @@ static void msdc_request_timeout(struct work_struct *work)
> >         }
> >  }
> >
> > +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> > +{
> > +       unsigned long flags;
> > +       struct msdc_host *host = mmc_priv(mmc);
> > +
> > +       if (enb)
> > +               pm_runtime_get_sync(host->dev);
> 
> I would convert to pm_runtime_get_noresume() as the host is already
> been runtime resumed by the mmc core.

will do it in next version.

> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +       if (enb)
> > +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > +       else
> > +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> > +       spin_unlock_irqrestore(&host->lock, flags);
> 
> You should move the code above into a separate function. Along the lines of:
> 
> static void __msdc_enable_sdio_irq(struct mmc_host *mmc, int enb)
> 
> You need this, because you will otherwise mess up the runtime PM usage
> count when acking the SDIO irq. More comments about that below.

will do it in next version.

> > +
> > +       if (!enb) {
> > +               pm_runtime_mark_lastwill do it in next version._busy(host->dev);
> > +               pm_runtime_put_autosuspend(host->dev);
> 
> Convert to pm_runtime_put_noidle(), as the above is already managed by
> the mmc core.
> 

will do it in next version.

> > +       }
> > +}
> > +
> >  static irqreturn_t msdc_irq(int irq, void *dev_id)
> >  {
> >         struct msdc_host *host = (struct msdc_host *) dev_id;
> > @@ -1373,7 +1398,12 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
> >                 data = host->data;
> >                 spin_unlock_irqrestore(&host->lock, flags);
> >
> > -               if (!(events & event_mask))
> > +               if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> > +                       msdc_enable_sdio_irq(host->mmc, 0);
> 
> To not mess up the runtime PM reference count and to avoid invoking
> runtime PM callbacks from atomic context, I suggest you call
> __msdc_enable_sdio_irq(host->mmc, 0) (new proposed function according
> to earlier comment).

will do it in next version.

> 
> > +                       sdio_signal_irq(host->mmc);
> > +               }
> > +
> > +               if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
> >                         break;
> >
> >                 if (!mrq) {
> > @@ -1493,8 +1523,11 @@ static void msdc_init_hw(struct msdc_host *host)
> >          */
> >         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
> >
> > -       /* disable detect SDIO device interrupt function */
> > -       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       /* Config SDIO device detect interrupt function */
> > +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> > +       else
> > +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> >
> >         /* Configure to default data timeout */
> >         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
> > @@ -2013,6 +2046,11 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> >         sdr_clr_bits(host->base + EMMC_IOCON, 1);
> >  }
> >
> > +static void msdc_ack_sdio_irq(struct mmc_host *mmc)
> > +{
> > +       msdc_enable_sdio_irq(mmc, 1);
> 
> To not mess up the runtime PM reference count, I suggest you call
> __msdc_enable_sdio_irq(host->mmc, 1) (new proposed function according
> to earlier comment).
> 

will do it in next version.

> > +}
> > +
> >  static const struct mmc_host_ops mt_msdc_ops = {
> >         .post_req = msdc_post_req,
> >         .pre_req = msdc_pre_req,
> > @@ -2020,6 +2058,8 @@ static void msdc_hw_reset(struct mmc_host *mmc)
> >         .set_ios = msdc_ops_set_ios,
> >         .get_ro = mmc_gpio_get_ro,
> >         .get_cd = mmc_gpio_get_cd,
> > +       .enable_sdio_irq = msdc_enable_sdio_irq,
> > +       .ack_sdio_irq = msdc_ack_sdio_irq,
> >         .start_signal_voltage_switch = msdc_ops_switch_volt,
> >         .card_busy = msdc_card_busy,
> >         .execute_tuning = msdc_execute_tuning,
> > @@ -2147,6 +2187,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >         else
> >                 mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
> >
> > +       if (mmc->caps & MMC_CAP_SDIO_IRQ)
> > +               mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> > +
> >         mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> >         /* MMC core transfer sizes tunable parameters */
> >         mmc->max_segs = MAX_BD_NUM;
> > --
> > 1.9.1
> >
> 
> Kind regards
> Uffe
