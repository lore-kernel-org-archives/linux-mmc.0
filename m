From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 3/3] mmc: sdio: mediatek: Support SDIO feature
Date: Thu, 20 Apr 2017 15:50:52 +0200
Message-ID: <CAPDyKFr38YYmzSAoRK=0YjP=9B3d4o1uDZLTCGSn_Vr4mt9rrw@mail.gmail.com>
References: <1492510391-704-1-git-send-email-yong.mao@mediatek.com> <1492510391-704-4-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1492510391-704-4-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Rob Herring <robh@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Kurtz <djkurtz@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, srv_heupstream <srv_heupstream@mediatek.com>, linux-mediatek@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 18 April 2017 at 12:13, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> 1. Add irqlock to protect accessing the shared register
> 2. Implement enable_sdio_irq interface
> 3. Add msdc_recheck_sdio_irq mechanism to make sure all interrupts
>    can be processed immediately

I think this should be split up in more pieces. Perhaps three as the
changelog describes.

Moreover I would appreciate some more information about why/how.

>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c |  182 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 143 insertions(+), 39 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 07f3236..fdae197 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -118,6 +118,7 @@
>  #define MSDC_PS_CDSTS           (0x1 << 1)     /* R  */
>  #define MSDC_PS_CDDEBOUNCE      (0xf << 12)    /* RW */
>  #define MSDC_PS_DAT             (0xff << 16)   /* R  */
> +#define MSDC_PS_DATA1           (0x1 << 17)    /* R  */
>  #define MSDC_PS_CMD             (0x1 << 24)    /* R  */
>  #define MSDC_PS_WP              (0x1 << 31)    /* R  */
>
> @@ -312,6 +313,7 @@ struct msdc_host {
>         int cmd_rsp;
>
>         spinlock_t lock;
> +       spinlock_t irqlock;    /* irq lock */
>         struct mmc_request *mrq;
>         struct mmc_command *cmd;
>         struct mmc_data *data;
> @@ -330,12 +332,14 @@ struct msdc_host {
>         struct pinctrl_state *pins_uhs;
>         struct delayed_work req_timeout;
>         int irq;                /* host interrupt */
> +       bool irq_thread_alive;
>
>         struct clk *src_clk;    /* msdc source clock */
>         struct clk *h_clk;      /* msdc h_clk */
>         u32 mclk;               /* mmc subsystem clock frequency */
>         u32 src_clk_freq;       /* source clock frequency */
>         u32 sclk;               /* SD/MS bus clock frequency */
> +       bool clock_on;
>         unsigned char timing;
>         bool vqmmc_enabled;
>         u32 hs400_ds_delay;
> @@ -343,6 +347,7 @@ struct msdc_host {
>         u32 hs400_cmd_int_delay; /* cmd internal delay for HS400 */
>         bool hs400_cmd_resp_sel_rising;
>                                  /* cmd response sample selection for HS400 */
> +       u32 clk_pad_delay;

Parsing and using of pad_delay seems like it also should be a separate change.

>         bool hs400_mode;        /* current eMMC will run at hs400 mode */
>         struct msdc_save_para save_para; /* used when gate HCLK */
>         struct msdc_tune_para def_tune_para; /* default tune setting */
> @@ -399,6 +404,7 @@ static void msdc_reset_hw(struct msdc_host *host)
>
>  static void msdc_cmd_next(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd);
> +static void msdc_recheck_sdio_irq(struct msdc_host *host);
>
>  static const u32 cmd_ints_mask = MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRCERR |
>                         MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
> @@ -525,6 +531,7 @@ static void msdc_gate_clock(struct msdc_host *host)
>  {
>         clk_disable_unprepare(host->src_clk);
>         clk_disable_unprepare(host->h_clk);
> +       host->clock_on = false;

This looks weird. Why do you need to keep track of this?

>  }
>
>  static void msdc_ungate_clock(struct msdc_host *host)
> @@ -533,6 +540,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
>         clk_prepare_enable(host->src_clk);
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> +       host->clock_on = true;

Ditto.

>  }
>
>  static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
> @@ -541,6 +549,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>         u32 flags;
>         u32 div;
>         u32 sclk;
> +       unsigned long irq_flags;
>
>         if (!hz) {
>                 dev_dbg(host->dev, "set mclk to 0\n");
> @@ -549,8 +558,11 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>                 return;
>         }
>
> +       spin_lock_irqsave(&host->irqlock, irq_flags);

Why is the spin_lock needed now, and not before. Could you elaborate on that?

No matter what, seems like it should be separate change.

>         flags = readl(host->base + MSDC_INTEN);
>         sdr_clr_bits(host->base + MSDC_INTEN, flags);
> +       spin_unlock_irqrestore(&host->irqlock, irq_flags);
> +
>         sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
>         if (timing == MMC_TIMING_UHS_DDR50 ||
>             timing == MMC_TIMING_MMC_DDR52 ||
> @@ -600,7 +612,10 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>         host->timing = timing;
>         /* need because clk changed. */
>         msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
> +
> +       spin_lock_irqsave(&host->irqlock, irq_flags);
>         sdr_set_bits(host->base + MSDC_INTEN, flags);
> +       spin_unlock_irqrestore(&host->irqlock, irq_flags);
>
>         /*
>          * mmc_select_hs400() will drop to 50Mhz and High speed mode,
> @@ -708,6 +723,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
>  static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
>                             struct mmc_command *cmd, struct mmc_data *data)
>  {
> +       unsigned long flags;
>         bool read;
>
>         WARN_ON(host->data);
> @@ -716,8 +732,12 @@ static void msdc_start_data(struct msdc_host *host, struct mmc_request *mrq,
>
>         mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
>         msdc_dma_setup(host, &host->dma, data);
> +
> +       spin_lock_irqsave(&host->irqlock, flags);
>         sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
>         sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
> +
>         dev_dbg(host->dev, "DMA start\n");
>         dev_dbg(host->dev, "%s: cmd=%d DMA data: %d blocks; read=%d\n",
>                         __func__, cmd->opcode, data->blocks, read);
> @@ -774,6 +794,8 @@ static void msdc_request_done(struct msdc_host *host, struct mmc_request *mrq)
>         if (mrq->data)
>                 msdc_unprepare_data(host, mrq);
>         mmc_request_done(host->mmc, mrq);
> +
> +       msdc_recheck_sdio_irq(host);

This I don't get. Why checking for SDIO IRQ here? Is it like an
optimization thing or?

>  }
>
>  /* returns true if command is fully handled; returns false otherwise */
> @@ -797,15 +819,17 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>                                         | MSDC_INT_CMDTMO)))
>                 return done;
>
> -       spin_lock_irqsave(&host->lock, flags);
>         done = !host->cmd;
> +       spin_lock_irqsave(&host->lock, flags);
>         host->cmd = NULL;
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         if (done)
>                 return true;
>
> +       spin_lock_irqsave(&host->irqlock, flags);
>         sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
>
>         if (cmd->flags & MMC_RSP_PRESENT) {
>                 if (cmd->flags & MMC_RSP_136) {
> @@ -883,6 +907,7 @@ static inline bool msdc_cmd_is_ready(struct msdc_host *host,
>  static void msdc_start_command(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd)
>  {
> +       unsigned long flags;
>         u32 rawcmd;
>
>         WARN_ON(host->cmd);
> @@ -901,7 +926,10 @@ static void msdc_start_command(struct msdc_host *host,
>         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
>         mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
>
> +       spin_lock_irqsave(&host->irqlock, flags);
>         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
> +
>         writel(cmd->arg, host->base + SDC_ARG);
>         writel(rawcmd, host->base + SDC_CMD);
>  }
> @@ -993,8 +1021,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>              | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
>              | MSDC_INT_DMA_PROTECT);
>
> -       spin_lock_irqsave(&host->lock, flags);
>         done = !host->data;
> +       spin_lock_irqsave(&host->lock, flags);
>         if (check_data)
>                 host->data = NULL;
>         spin_unlock_irqrestore(&host->lock, flags);
> @@ -1009,7 +1037,11 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
>                                 1);
>                 while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
>                         cpu_relax();
> +
> +               spin_lock_irqsave(&host->irqlock, flags);
>                 sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
> +               spin_unlock_irqrestore(&host->irqlock, flags);
> +
>                 dev_dbg(host->dev, "DMA stop\n");
>
>                 if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->error)) {
> @@ -1123,44 +1155,47 @@ static void msdc_request_timeout(struct work_struct *work)
>
>  static irqreturn_t msdc_irq(int irq, void *dev_id)
>  {
> +       unsigned long flags;
>         struct msdc_host *host = (struct msdc_host *) dev_id;
> +       struct mmc_request *mrq;
> +       struct mmc_command *cmd;
> +       struct mmc_data *data;
> +       u32 events, event_mask;
> +
> +       spin_lock_irqsave(&host->irqlock, flags);
> +       events = readl(host->base + MSDC_INT);
> +       event_mask = readl(host->base + MSDC_INTEN);
> +       /* clear interrupts */
> +       writel(events & event_mask, host->base + MSDC_INT);
> +
> +       mrq = host->mrq;
> +       cmd = host->cmd;
> +       data = host->data;
> +       spin_unlock_irqrestore(&host->irqlock, flags);
> +
> +       if ((events & event_mask) & MSDC_INT_SDIOIRQ) {
> +               mmc_signal_sdio_irq(host->mmc);
> +               if (!mrq)
> +                       return IRQ_HANDLED;
> +       }
>
> -       while (true) {
> -               unsigned long flags;
> -               struct mmc_request *mrq;
> -               struct mmc_command *cmd;
> -               struct mmc_data *data;
> -               u32 events, event_mask;
> -
> -               spin_lock_irqsave(&host->lock, flags);
> -               events = readl(host->base + MSDC_INT);
> -               event_mask = readl(host->base + MSDC_INTEN);
> -               /* clear interrupts */
> -               writel(events & event_mask, host->base + MSDC_INT);
> -
> -               mrq = host->mrq;
> -               cmd = host->cmd;
> -               data = host->data;
> -               spin_unlock_irqrestore(&host->lock, flags);
> -
> -               if (!(events & event_mask))
> -                       break;
> +       if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
> +               return IRQ_HANDLED;
>
> -               if (!mrq) {
> -                       dev_err(host->dev,
> -                               "%s: MRQ=NULL; events=%08X; event_mask=%08X\n",
> -                               __func__, events, event_mask);
> -                       WARN_ON(1);
> -                       break;
> -               }
> +       if (!mrq) {
> +               dev_err(host->dev,
> +                       "%s: MRQ=NULL; events=%08X; event_mask=%08X\n",
> +                       __func__, events, event_mask);
> +               WARN_ON(1);
> +               return IRQ_HANDLED;
> +       }
>
> -               dev_dbg(host->dev, "%s: events=%08X\n", __func__, events);
> +       dev_dbg(host->dev, "%s: events=%08X\n", __func__, events);
>
> -               if (cmd)
> -                       msdc_cmd_done(host, events, mrq, cmd);
> -               else if (data)
> -                       msdc_data_xfer_done(host, events, mrq, data);
> -       }
> +       if (cmd)
> +               msdc_cmd_done(host, events, mrq, cmd);
> +       else if (data)
> +               msdc_data_xfer_done(host, events, mrq, data);
>
>         return IRQ_HANDLED;
>  }
> @@ -1168,6 +1203,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>  static void msdc_init_hw(struct msdc_host *host)
>  {
>         u32 val;
> +       unsigned long flags;
>
>         /* Configure to MMC/SD mode, clock free running */
>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPDN);
> @@ -1179,11 +1215,14 @@ static void msdc_init_hw(struct msdc_host *host)
>         sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
>
>         /* Disable and clear all interrupts */
> +       spin_lock_irqsave(&host->irqlock, flags);
>         writel(0, host->base + MSDC_INTEN);
>         val = readl(host->base + MSDC_INT);
>         writel(val, host->base + MSDC_INT);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
>
> -       writel(0, host->base + MSDC_PAD_TUNE);
> +       sdr_set_field(host->base + MSDC_PAD_TUNE,
> +                     MSDC_PAD_TUNE_CLKTDLY, host->clk_pad_delay);
>         writel(0, host->base + MSDC_IOCON);
>         sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
>         writel(0x403c0046, host->base + MSDC_PATCH_BIT);
> @@ -1196,9 +1235,11 @@ static void msdc_init_hw(struct msdc_host *host)
>          */
>         sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIO);
>
> -       /* disable detect SDIO device interrupt function */
> -       sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> -
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +       else
> +               /* disable detect SDIO device interrupt function */
> +               sdr_clr_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
>         /* Configure to default data timeout */
>         sdr_set_field(host->base + SDC_CFG, SDC_CFG_DTOC, 3);
>
> @@ -1210,11 +1251,15 @@ static void msdc_init_hw(struct msdc_host *host)
>  static void msdc_deinit_hw(struct msdc_host *host)
>  {
>         u32 val;
> +       unsigned long flags;
> +
>         /* Disable and clear all interrupts */
> +       spin_lock_irqsave(&host->irqlock, flags);
>         writel(0, host->base + MSDC_INTEN);
>
>         val = readl(host->base + MSDC_INT);
>         writel(val, host->base + MSDC_INT);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
>  }
>
>  /* init gpd and bd list in msdc_drv_probe */
> @@ -1582,6 +1627,48 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         sdr_clr_bits(host->base + EMMC_IOCON, 1);
>  }
>
> +/**
> + * msdc_recheck_sdio_irq - recheck whether the SDIO IRQ is lost
> + * @host: The host to check.
> + *
> + * Host controller may lost interrupt in some special case.
> + * Add sdio IRQ recheck mechanism to make sure all interrupts
> + * can be processed immediately
> + */
> +static void msdc_recheck_sdio_irq(struct msdc_host *host)
> +{
> +       u32 reg_int, reg_ps;
> +
> +       if (host->clock_on && (host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
> +           host->irq_thread_alive) {
> +               reg_int = readl(host->base + MSDC_INT);
> +               reg_ps  = readl(host->base + MSDC_PS);
> +               if (!((reg_int & MSDC_INT_SDIOIRQ) ||
> +                     (reg_ps & MSDC_PS_DATA1)))
> +                       mmc_signal_sdio_irq(host->mmc);
> +       }
> +}
> +
> +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       unsigned long flags;
> +       struct msdc_host *host = mmc_priv(mmc);
> +
> +       host->irq_thread_alive = true;
> +       if (enable) {
> +               msdc_recheck_sdio_irq(host);
> +
> +               spin_lock_irqsave(&host->irqlock, flags);
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +               spin_unlock_irqrestore(&host->irqlock, flags);
> +       } else {
> +               spin_lock_irqsave(&host->irqlock, flags);
> +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ);
> +               spin_unlock_irqrestore(&host->irqlock, flags);
> +       }
> +}
> +
>  static struct mmc_host_ops mt_msdc_ops = {
>         .post_req = msdc_post_req,
>         .pre_req = msdc_pre_req,
> @@ -1593,6 +1680,7 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         .execute_tuning = msdc_execute_tuning,
>         .prepare_hs400_tuning = msdc_prepare_hs400_tuning,
>         .hw_reset = msdc_hw_reset,
> +       .enable_sdio_irq = msdc_enable_sdio_irq,
>  };
>
>  static void msdc_of_property_parse(struct platform_device *pdev,
> @@ -1612,6 +1700,9 @@ static void msdc_of_property_parse(struct platform_device *pdev,
>                 host->hs400_cmd_resp_sel_rising = true;
>         else
>                 host->hs400_cmd_resp_sel_rising = false;
> +
> +       of_property_read_u32(pdev->dev.of_node, "mediatek,clk-pad-delay",
> +                            &host->clk_pad_delay);
>  }
>
>  static int msdc_drv_probe(struct platform_device *pdev)
> @@ -1705,6 +1796,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         mmc_dev(mmc)->dma_mask = &host->dma_mask;
>
>         host->timeout_clks = 3 * 1048576;
> +       host->irq_thread_alive = false;
>         host->dma.gpd = dma_alloc_coherent(&pdev->dev,
>                                 2 * sizeof(struct mt_gpdma_desc),
>                                 &host->dma.gpd_addr, GFP_KERNEL);
> @@ -1718,6 +1810,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         msdc_init_gpd_bd(host, &host->dma);
>         INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
>         spin_lock_init(&host->lock);
> +       spin_lock_init(&host->irqlock);

I don't get why the host->lock can't be used here? Why do you need a new one?

>
>         platform_set_drvdata(pdev, mmc);
>         msdc_ungate_clock(host);
> @@ -1732,6 +1825,10 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         pm_runtime_set_autosuspend_delay(host->dev, MTK_MMC_AUTOSUSPEND_DELAY);
>         pm_runtime_use_autosuspend(host->dev);
>         pm_runtime_enable(host->dev);
> +
> +       /* In SDIO irq mode, DATA1 slways need to be detected */
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               pm_runtime_get_sync(host->dev);

This seems reasonable, however I think we can make this more fine grained.

It is actually not until there is a SDIO func driver that has claimed
an SDIO IRQ, to when you need to make sure to keep the host runtime PM
resumed.

Please look into the following series [1], which I recently posted and
try to see if using MMC_CAP2_SDIO_IRQ_NOTHREAD can suite you. In
principle I think $subject patch can be greatly simplified if you
convert to MMC_CAP2_SDIO_IRQ_NOTHREAD.

>         ret = mmc_add_host(mmc);
>
>         if (ret)
> @@ -1821,6 +1918,10 @@ static int msdc_runtime_suspend(struct device *dev)
>
>         msdc_save_reg(host);
>         msdc_gate_clock(host);
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ) {
> +               pm_runtime_mark_last_busy(dev);
> +               pm_runtime_put_autosuspend(dev);
> +       }
>         return 0;
>  }
>
> @@ -1829,6 +1930,9 @@ static int msdc_runtime_resume(struct device *dev)
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct msdc_host *host = mmc_priv(mmc);
>
> +       /* In SDIO irq mode, DATA1 slways need to be detected */
> +       if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +               pm_runtime_get_sync(host->dev);
>         msdc_ungate_clock(host);
>         msdc_restore_reg(host);
>         return 0;
> --
> 1.7.9.5
>

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-mmc/msg43763.html
