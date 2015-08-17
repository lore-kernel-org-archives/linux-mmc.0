From: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/4] mmc: mediatek: Add online-tuning support of EMMC/SD
Date: Mon, 17 Aug 2015 20:01:28 +0800
Message-ID: <1439812888.5627.9.camel@mhfsdcap03>
References: <1439367845-5891-1-git-send-email-chaotian.jing@mediatek.com>
 <1439367845-5891-2-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFpX4Pp1+U9eNBuGd83sBeBgLU17qysAJ-2V-ABZZHYAGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CAPDyKFpX4Pp1+U9eNBuGd83sBeBgLU17qysAJ-2V-ABZZHYAGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, James Liao <jamesjj.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Wenbin Mei <sin_wenbinmei-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "Joe.C" <yingjoe.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bin Zhang =?UTF-8?Q?=28=E7=AB=A0=E6=96=8C=29?= <bin.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Liuquan Ji <liuquan.ji-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, srv_heupstream <srv_heupstrea>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,
Thanks, please see my comment:
On Mon, 2015-08-17 at 13:31 +0200, Ulf Hansson wrote:
> On 12 August 2015 at 10:24, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > Schedule a workqueue to do tuning when CRC error
> > Call mmc_hw_reset to re-init card when data timeout
> 
> Thanks to Adrian Hunter, the mmc core already supports re-tuning for
> the above scenarios through the mmc_retune_*() APIs.
> 
> SDHCI driver has already adopted to use that feature, you should do
> that for the mtk-sd driver as well.
> 
> Kind regards
> Uffe
> 
I also noticed that the mmc core already supports re-tuning, but it is
not suitable for our host.
For EMMC, the CMD21 only support HS200/HS400 mode, for SD card, CMD19
only support SDR50/SDR104 mode, but in our host, even 50Mhz clock
frequency may also occur CRC error, Cannot find a parameter that can
cover all SD cards which running at 50Mhz, even 25Mhz, will occur CRC
error for stress test, DDR50 mode is worse.
By the way,there are too many tune parameters need try for response,
read data, write crc status CRC error, these parameters are
multidimensional, it is hard to find a best parameter, and, try
thousands of parameters will take long time.
> >
> > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/mmc/host/mtk-sd.c | 162 ++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 150 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > index 7153500..eb44fe1 100644
> > --- a/drivers/mmc/host/mtk-sd.c
> > +++ b/drivers/mmc/host/mtk-sd.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/workqueue.h>
> >
> >  #include <linux/mmc/card.h>
> >  #include <linux/mmc/core.h>
> > @@ -290,6 +291,10 @@ struct msdc_host {
> >         struct pinctrl_state *pins_default;
> >         struct pinctrl_state *pins_uhs;
> >         struct delayed_work req_timeout;
> > +       struct workqueue_struct *repeat_workqueue;
> > +       struct work_struct repeat_req;
> > +       struct mmc_request *repeat_mrq;
> > +       u32 tune_cmd_counter;
> >         int irq;                /* host interrupt */
> >
> >         struct clk *src_clk;    /* msdc source clock */
> > @@ -353,7 +358,10 @@ static void msdc_reset_hw(struct msdc_host *host)
> >  static void msdc_cmd_next(struct msdc_host *host,
> >                 struct mmc_request *mrq, struct mmc_command *cmd);
> >
> > -static u32 data_ints_mask = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO |
> > +static const u32 cmd_ints_mask = MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRCERR |
> > +                       MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
> > +                       MSDC_INTEN_ACMDCRCERR | MSDC_INTEN_ACMDTMO;
> > +static const u32 data_ints_mask = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO |
> >                         MSDC_INTEN_DATCRCERR | MSDC_INTEN_DMA_BDCSERR |
> >                         MSDC_INTEN_DMA_GPDCSERR | MSDC_INTEN_DMA_PROTECT;
> >
> > @@ -690,6 +698,18 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
> >         msdc_track_cmd_data(host, mrq->cmd, mrq->data);
> >         if (mrq->data)
> >                 msdc_unprepare_data(host, mrq);
> > +       if (host->error && host->mmc->card &&
> > +           !mmc_card_sdio(host->mmc->card)) {
> > +               if (mrq->cmd->error == (unsigned int)-EILSEQ ||
> > +                   (mrq->stop && mrq->stop->error == (unsigned int)-EILSEQ) ||
> > +                   (mrq->sbc && mrq->sbc->error == (unsigned int)-EILSEQ) ||
> > +                   (mrq->data && mrq->data->error))  {
> > +                       host->repeat_mrq = mrq;
> > +                       queue_work(host->repeat_workqueue, &host->repeat_req);
> > +                       return;
> > +               }
> > +       }
> > +       host->tune_cmd_counter = 0;
> >         mmc_request_done(host->mmc, mrq);
> >
> >         pm_runtime_mark_last_busy(host->dev);
> > @@ -725,11 +745,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
> >         if (done)
> >                 return true;
> >
> > -       sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
> > -                       MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
> > -                       MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
> > -                       MSDC_INTEN_ACMDTMO);
> > -       writel(cmd->arg, host->base + SDC_ARG);
> > +       sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> >
> >         if (cmd->flags & MMC_RSP_PRESENT) {
> >                 if (cmd->flags & MMC_RSP_136) {
> > @@ -819,10 +835,7 @@ static void msdc_start_command(struct msdc_host *host,
> >         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> >         mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> >
> > -       sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
> > -                       MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
> > -                       MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
> > -                       MSDC_INTEN_ACMDTMO);
> > +       sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> >         writel(cmd->arg, host->base + SDC_ARG);
> >         writel(rawcmd, host->base + SDC_CMD);
> >  }
> > @@ -942,6 +955,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
> >
> >                         if (events & MSDC_INT_DATTMO)
> >                                 data->error = -ETIMEDOUT;
> > +                       else if (events & MSDC_INT_DATCRCERR)
> > +                               data->error = -EILSEQ;
> >
> >                         dev_err(host->dev, "%s: cmd=%d; blocks=%d",
> >                                 __func__, mrq->cmd->opcode, data->blocks);
> > @@ -1113,8 +1128,8 @@ static void msdc_init_hw(struct msdc_host *host)
> >
> >         writel(0, host->base + MSDC_PAD_TUNE);
> >         writel(0, host->base + MSDC_IOCON);
> > -       sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 1);
> > -       writel(0x403c004f, host->base + MSDC_PATCH_BIT);
> > +       sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
> > +       writel(0x403c0046, host->base + MSDC_PATCH_BIT);
> >         sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
> >         writel(0xffff0089, host->base + MSDC_PATCH_BIT1);
> >         /* Configure to enable SDIO mode.
> > @@ -1176,6 +1191,7 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >         switch (ios->power_mode) {
> >         case MMC_POWER_UP:
> >                 if (!IS_ERR(mmc->supply.vmmc)) {
> > +                       msdc_init_hw(host);
> >                         ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> >                                         ios->vdd);
> >                         if (ret) {
> > @@ -1214,6 +1230,120 @@ end:
> >         pm_runtime_put_autosuspend(host->dev);
> >  }
> >
> > +static void msdc_reset_mrq(struct mmc_request *mrq)
> > +{
> > +       mrq->cmd->error = 0;
> > +       if (mrq->sbc)
> > +               mrq->sbc->error = 0;
> > +       if (mrq->data)
> > +               mrq->data->error = 0;
> > +       if (mrq->stop)
> > +               mrq->stop->error = 0;
> > +}
> > +
> > +/* Send CMD12 when tuning, do not check CRC error and timeout */
> > +static void msdc_send_stop(struct msdc_host *host)
> > +{
> > +       u32 opcode = MMC_STOP_TRANSMISSION;
> > +       u32 arg = 0;
> > +       u32 rawcmd = 0;
> > +       u32 intsts = 0;
> > +
> > +       /* Reset host first */
> > +       msdc_reset_hw(host);
> > +
> > +       rawcmd = (opcode & 0x3f) | (7 << 7);
> > +       rawcmd |= (1 << 14); /* stop cmd */
> > +
> > +       sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> > +       writel(arg, host->base + SDC_ARG);
> > +       writel(rawcmd, host->base + SDC_CMD);
> > +
> > +       while (1) {
> > +               intsts = readl(host->base + MSDC_INT);
> > +               if (intsts) {
> > +                       writel(intsts, host->base + MSDC_INT);
> > +                       if (intsts & cmd_ints_mask) {
> > +                               dev_dbg(host->dev, "result of cmd12: %x\n",
> > +                                               intsts);
> > +                               break;
> > +                       }
> > +               }
> > +               udelay(1);
> > +       }
> > +}
> > +
> > +/* When tuning, CMD13 may also get crc error, so use MSDC_PS to get card status */
> > +static void msdc_wait_card_not_busy(struct msdc_host *host)
> > +{
> > +       while (1) {
> > +               if ((readl(host->base + MSDC_PS) & BIT(16)) == 0) { /* check dat0 status */
> > +                       msleep_interruptible(10);
> > +                       dev_dbg(host->dev, "MSDC_PS: %08x, SDC_STS: %08x\n",
> > +                               readl(host->base + MSDC_PS), readl(host->base + SDC_STS));
> > +               } else
> > +                       break;
> > +       }
> > +}
> > +
> > +static void msdc_tune_request(struct msdc_host *host)
> > +{
> > +       u32 orig_rsmpl, orig_cksel;
> > +       u32 cur_rsmpl, cur_cksel = 0;
> > +       u32 ddr, clkmode;
> > +       struct mmc_ios ios = host->mmc->ios;
> > +
> > +       sdr_get_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL, &orig_rsmpl);
> > +       sdr_get_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL,
> > +                     &orig_cksel);
> > +       cur_rsmpl = (orig_rsmpl + 1);
> > +       sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL, cur_rsmpl % 2);
> > +
> > +       if (ios.timing != MMC_TIMING_MMC_HS400) {
> > +               sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DSPL,
> > +                             cur_rsmpl % 2);
> > +               sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_W_DSPL,
> > +                             cur_rsmpl % 2);
> > +       }
> > +
> > +       if (cur_rsmpl >= 2) {
> > +               cur_cksel = orig_cksel + 1;
> > +               sdr_set_field(host->base + MSDC_PATCH_BIT,
> > +                             MSDC_CKGEN_MSDC_DLY_SEL, cur_cksel % 16);
> > +       }
> > +
> > +       if (host->tune_cmd_counter++ >= 2 * 16) {
> > +               dev_warn(host->dev, "Tune fail at %dhz\n", host->mclk);
> > +               host->tune_cmd_counter = 0;
> > +               sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_RSPL, 0);
> > +               sdr_set_field(host->base + MSDC_PATCH_BIT,
> > +                             MSDC_CKGEN_MSDC_DLY_SEL, 0);
> > +               sdr_get_field(host->base + MSDC_CFG, MSDC_CFG_CKMOD, &clkmode);
> > +               ddr = (clkmode == 2) ? 1 : 0;
> > +               msdc_set_mclk(host, ddr, host->mclk / 2);
> > +       }
> > +}
> > +
> > +static void msdc_repeat_request(struct work_struct *work)
> > +{
> > +       struct msdc_host *host = container_of(work, struct msdc_host, repeat_req);
> > +       struct mmc_request *mrq;
> > +       unsigned long flags;
> > +
> > +       spin_lock_irqsave(&host->lock, flags);
> > +       mrq = host->repeat_mrq;
> > +       host->repeat_mrq = NULL;
> > +       spin_unlock_irqrestore(&host->lock, flags);
> > +       msdc_send_stop(host);
> > +       msdc_wait_card_not_busy(host);
> > +       if (mrq->data && mrq->data->error == -ETIMEDOUT)
> > +               mmc_hw_reset(host->mmc);
> > +       else
> > +               msdc_tune_request(host);
> > +       msdc_reset_mrq(mrq);
> > +       msdc_ops_request(host->mmc, mrq);
> > +}
> > +
> >  static struct mmc_host_ops mt_msdc_ops = {
> >         .post_req = msdc_post_req,
> >         .pre_req = msdc_pre_req,
> > @@ -1324,6 +1454,12 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >         }
> >         msdc_init_gpd_bd(host, &host->dma);
> >         INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
> > +       host->repeat_workqueue = create_singlethread_workqueue("repeat_workqueue");
> > +       if (!host->repeat_workqueue) {
> > +               ret = -ENOMEM;
> > +               goto release_mem;
> > +       }
> > +       INIT_WORK(&host->repeat_req, msdc_repeat_request);
> >         spin_lock_init(&host->lock);
> >
> >         platform_set_drvdata(pdev, mmc);
> > @@ -1348,6 +1484,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
> >  end:
> >         pm_runtime_disable(host->dev);
> >  release:
> > +       destroy_workqueue(host->repeat_workqueue);
> >         platform_set_drvdata(pdev, NULL);
> >         msdc_deinit_hw(host);
> >         msdc_gate_clock(host);
> > @@ -1383,6 +1520,7 @@ static int msdc_drv_remove(struct platform_device *pdev)
> >
> >         pm_runtime_disable(host->dev);
> >         pm_runtime_put_noidle(host->dev);
> > +       destroy_workqueue(host->repeat_workqueue);
> >         dma_free_coherent(&pdev->dev,
> >                         sizeof(struct mt_gpdma_desc),
> >                         host->dma.gpd, host->dma.gpd_addr);
> > --
> > 1.8.1.1.dirty
> >
