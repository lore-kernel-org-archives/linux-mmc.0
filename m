From: Wei-Ning Huang <wnhuang@google.com>
Subject: Re: [PATCH 2/4] sdio: mediatek: Support sdio feature
Date: Mon, 23 Jan 2017 19:24:11 +0800
Message-ID: <CABicQ-W103YX8OR+20Kjjg1yKFzw1Bu1aZuQNAsd3DSVVHcxJQ@mail.gmail.com>
References: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com> <1478585341-6749-3-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:38889 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAWLYX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2017 06:24:23 -0500
Received: by mail-it0-f53.google.com with SMTP id c7so63333558itd.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2017 03:24:18 -0800 (PST)
In-Reply-To: <1478585341-6749-3-git-send-email-yong.mao@mediatek.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, YH Huang <yh.huang@mediatek.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>, Chaotian Jing <chaotian.jing@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Douglas Anderson <dianders@chromium.org>, Geert Uytterhoeven <geert@linux-m68k.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, linux-mediatek@lists.infrad

On Tue, Nov 8, 2016 at 2:08 PM, Yong Mao <yong.mao@mediatek.com> wrote:
> From: yong mao <yong.mao@mediatek.com>
>
> 1. Add irqlock to protect accessing the shared register
> 2. Modify the implementation of msdc_card_busy due to SDIO
> 3. Implement enable_sdio_irq
> 4. Add msdc_recheck_sdio_irq mechanism to make sure all
>    interrupts can be processed immediately
>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c |  167 ++++++++++++++++++++++++++++++++++-----=
------
>  1 file changed, 129 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b29683b..37edf30 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -117,6 +117,7 @@
>  #define MSDC_PS_CDSTS           (0x1 << 1)     /* R  */
>  #define MSDC_PS_CDDEBOUNCE      (0xf << 12)    /* RW */
>  #define MSDC_PS_DAT             (0xff << 16)   /* R  */
> +#define MSDC_PS_DATA1           (0x1 << 17)    /* R  */
>  #define MSDC_PS_CMD             (0x1 << 24)    /* R  */
>  #define MSDC_PS_WP              (0x1 << 31)    /* R  */
>
> @@ -304,6 +305,7 @@ struct msdc_host {
>         int cmd_rsp;
>
>         spinlock_t lock;
> +       spinlock_t irqlock;     /* sdio irq lock */
>         struct mmc_request *mrq;
>         struct mmc_command *cmd;
>         struct mmc_data *data;
> @@ -322,12 +324,14 @@ struct msdc_host {
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
> @@ -387,6 +391,7 @@ static void msdc_reset_hw(struct msdc_host *host)
>
>  static void msdc_cmd_next(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd);
> +static void msdc_recheck_sdio_irq(struct msdc_host *host);
>
>  static const u32 cmd_ints_mask =3D MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRC=
ERR |
>                         MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
> @@ -513,6 +518,7 @@ static void msdc_gate_clock(struct msdc_host *host)
>  {
>         clk_disable_unprepare(host->src_clk);
>         clk_disable_unprepare(host->h_clk);
> +       host->clock_on =3D false;
>  }
>
>  static void msdc_ungate_clock(struct msdc_host *host)
> @@ -521,6 +527,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
>         clk_prepare_enable(host->src_clk);
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
> +       host->clock_on =3D true;
>  }
>
>  static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, =
u32 hz)
> @@ -529,6 +536,7 @@ static void msdc_set_mclk(struct msdc_host *host, uns=
igned char timing, u32 hz)
>         u32 flags;
>         u32 div;
>         u32 sclk;
> +       unsigned long irq_flags;
>
>         if (!hz) {
>                 dev_dbg(host->dev, "set mclk to 0\n");
> @@ -537,8 +545,11 @@ static void msdc_set_mclk(struct msdc_host *host, un=
signed char timing, u32 hz)
>                 return;
>         }
>
> +       spin_lock_irqsave(&host->irqlock, irq_flags);
>         flags =3D readl(host->base + MSDC_INTEN);
>         sdr_clr_bits(host->base + MSDC_INTEN, flags);
> +       spin_unlock_irqrestore(&host->irqlock, irq_flags);
> +
>         sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
>         if (timing =3D=3D MMC_TIMING_UHS_DDR50 ||
>             timing =3D=3D MMC_TIMING_MMC_DDR52 ||
> @@ -588,7 +599,10 @@ static void msdc_set_mclk(struct msdc_host *host, un=
signed char timing, u32 hz)
>         host->timing =3D timing;
>         /* need because clk changed. */
>         msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
> +
> +       spin_lock_irqsave(&host->irqlock, irq_flags);
>         sdr_set_bits(host->base + MSDC_INTEN, flags);
> +       spin_unlock_irqrestore(&host->irqlock, irq_flags);
>
>         /*
>          * mmc_select_hs400() will drop to 50Mhz and High speed mode,
> @@ -690,6 +704,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msd=
c_host *host,
>  static void msdc_start_data(struct msdc_host *host, struct mmc_request *=
mrq,
>                             struct mmc_command *cmd, struct mmc_data *dat=
a)
>  {
> +       unsigned long flags;
>         bool read;
>
>         WARN_ON(host->data);
> @@ -698,8 +713,12 @@ static void msdc_start_data(struct msdc_host *host, =
struct mmc_request *mrq,
>
>         mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
>         msdc_dma_setup(host, &host->dma, data);
> +
> +       spin_lock_irqsave(&host->irqlock, flags);
>         sdr_set_bits(host->base + MSDC_INTEN, data_ints_mask);
>         sdr_set_field(host->base + MSDC_DMA_CTRL, MSDC_DMA_CTRL_START, 1)=
;
> +       spin_unlock_irqrestore(&host->irqlock, flags);
> +
>         dev_dbg(host->dev, "DMA start\n");
>         dev_dbg(host->dev, "%s: cmd=3D%d DMA data: %d blocks; read=3D%d\n=
",
>                         __func__, cmd->opcode, data->blocks, read);
> @@ -756,6 +775,7 @@ static void msdc_request_done(struct msdc_host *host,=
 struct mmc_request *mrq)
>         if (mrq->data)
>                 msdc_unprepare_data(host, mrq);
>         mmc_request_done(host->mmc, mrq);
> +       msdc_recheck_sdio_irq(host);
>  }
>
>  /* returns true if command is fully handled; returns false otherwise */
> @@ -779,15 +799,17 @@ static bool msdc_cmd_done(struct msdc_host *host, i=
nt events,
>                                         | MSDC_INT_CMDTMO)))
>                 return done;
>
> -       spin_lock_irqsave(&host->lock, flags);
>         done =3D !host->cmd;
> +       spin_lock_irqsave(&host->lock, flags);
>         host->cmd =3D NULL;
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
> @@ -902,6 +924,7 @@ static inline bool msdc_cmd_is_ready(struct msdc_host=
 *host,
>  static void msdc_start_command(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd)
>  {
> +       unsigned long flags;
>         u32 rawcmd;
>
>         WARN_ON(host->cmd);
> @@ -920,7 +943,10 @@ static void msdc_start_command(struct msdc_host *hos=
t,
>         rawcmd =3D msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
>         mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
>
> +       spin_lock_irqsave(&host->irqlock, flags);
>         sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
> +
>         writel(cmd->arg, host->base + SDC_ARG);
>         writel(rawcmd, host->base + SDC_CMD);
>  }
> @@ -1013,8 +1039,8 @@ static bool msdc_data_xfer_done(struct msdc_host *h=
ost, u32 events,
>              | MSDC_INT_DMA_BDCSERR | MSDC_INT_DMA_GPDCSERR
>              | MSDC_INT_DMA_PROTECT);
>
> -       spin_lock_irqsave(&host->lock, flags);
>         done =3D !host->data;
> +       spin_lock_irqsave(&host->lock, flags);
>         if (check_data)
>                 host->data =3D NULL;
>         spin_unlock_irqrestore(&host->lock, flags);
> @@ -1029,7 +1055,11 @@ static bool msdc_data_xfer_done(struct msdc_host *=
host, u32 events,
>                                 1);
>                 while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_ST=
S)
>                         cpu_relax();
> +
> +               spin_lock_irqsave(&host->irqlock, flags);
>                 sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
> +               spin_unlock_irqrestore(&host->irqlock, flags);
> +
>                 dev_dbg(host->dev, "DMA stop\n");
>
>                 if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->er=
ror)) {
> @@ -1134,44 +1164,47 @@ static void msdc_request_timeout(struct work_stru=
ct *work)
>
>  static irqreturn_t msdc_irq(int irq, void *dev_id)
>  {
> +       unsigned long flags;
>         struct msdc_host *host =3D (struct msdc_host *) dev_id;
> +       struct mmc_request *mrq;
> +       struct mmc_command *cmd;
> +       struct mmc_data *data;
> +       u32 events, event_mask;
> +
> +       spin_lock_irqsave(&host->irqlock, flags);
> +       events =3D readl(host->base + MSDC_INT);
> +       event_mask =3D readl(host->base + MSDC_INTEN);
> +       /* clear interrupts */
> +       writel(events & event_mask, host->base + MSDC_INT);
> +
> +       mrq =3D host->mrq;
> +       cmd =3D host->cmd;
> +       data =3D host->data;
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
> -               events =3D readl(host->base + MSDC_INT);
> -               event_mask =3D readl(host->base + MSDC_INTEN);
> -               /* clear interrupts */
> -               writel(events & event_mask, host->base + MSDC_INT);
> -
> -               mrq =3D host->mrq;
> -               cmd =3D host->cmd;
> -               data =3D host->data;
> -               spin_unlock_irqrestore(&host->lock, flags);
> -
> -               if (!(events & event_mask))
> -                       break;
> +       if (!(events & (event_mask & ~MSDC_INT_SDIOIRQ)))
> +               return IRQ_HANDLED;
>
> -               if (!mrq) {
> -                       dev_err(host->dev,
> -                               "%s: MRQ=3DNULL; events=3D%08X; event_mas=
k=3D%08X\n",
> -                               __func__, events, event_mask);
> -                       WARN_ON(1);
> -                       break;
> -               }
> +       if (!mrq) {
> +               dev_err(host->dev,
> +                       "%s: MRQ=3DNULL; events=3D%08X; event_mask=3D%08X=
\n",
> +                       __func__, events, event_mask);
> +               WARN_ON(1);
> +               return IRQ_HANDLED;
> +       }
>
> -               dev_dbg(host->dev, "%s: events=3D%08X\n", __func__, event=
s);
> +       dev_dbg(host->dev, "%s: events=3D%08X\n", __func__, events);
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
> @@ -1179,6 +1212,7 @@ static irqreturn_t msdc_irq(int irq, void *dev_id)
>  static void msdc_init_hw(struct msdc_host *host)
>  {
>         u32 val;
> +       unsigned long flags;
>
>         /* Configure to MMC/SD mode, clock free running */
>         sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_MODE | MSDC_CFG_CKPD=
N);
> @@ -1190,9 +1224,11 @@ static void msdc_init_hw(struct msdc_host *host)
>         sdr_clr_bits(host->base + MSDC_PS, MSDC_PS_CDEN);
>
>         /* Disable and clear all interrupts */
> +       spin_lock_irqsave(&host->irqlock, flags);
>         writel(0, host->base + MSDC_INTEN);
>         val =3D readl(host->base + MSDC_INT);
>         writel(val, host->base + MSDC_INT);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
>
>         writel(0, host->base + MSDC_PAD_TUNE);
>         writel(0, host->base + MSDC_IOCON);
> @@ -1207,9 +1243,11 @@ static void msdc_init_hw(struct msdc_host *host)
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
> @@ -1221,11 +1259,15 @@ static void msdc_init_hw(struct msdc_host *host)
>  static void msdc_deinit_hw(struct msdc_host *host)
>  {
>         u32 val;
> +       unsigned long flags;
> +
>         /* Disable and clear all interrupts */
> +       spin_lock_irqsave(&host->irqlock, flags);
>         writel(0, host->base + MSDC_INTEN);
>
>         val =3D readl(host->base + MSDC_INT);
>         writel(val, host->base + MSDC_INT);
> +       spin_unlock_irqrestore(&host->irqlock, flags);
>  }
>
>  /* init gpd and bd list in msdc_drv_probe */
> @@ -1493,6 +1535,52 @@ static void msdc_hw_reset(struct mmc_host *mmc)
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
> + *
> + */
> +static void msdc_recheck_sdio_irq(struct msdc_host *host)
> +{
> +       u32 reg_int, reg_ps;
> +
> +       if (host->clock_on &&
> +           (host->mmc->caps & MMC_CAP_SDIO_IRQ) &&
> +           host->irq_thread_alive) {
> +               reg_int =3D readl(host->base + MSDC_INT);
> +               reg_ps  =3D readl(host->base + MSDC_PS);
> +               if (!((reg_int & MSDC_INT_SDIOIRQ) ||
> +                     (reg_ps & MSDC_PS_DATA1))) {
> +                       mmc_signal_sdio_irq(host->mmc);
> +               }
> +       }
> +}
> +
> +static void msdc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +       unsigned long flags;
> +       struct msdc_host *host =3D mmc_priv(mmc);
> +
> +       host->irq_thread_alive =3D true;
> +       if (enable) {
> +               pm_runtime_get_sync(host->dev);\
This cause problems in kernel >=3D 3.19. Since pm_runtime_get_sync calls
__might_sleep, and you are not suppose to sleep in a IRQ handler.

2017-01-20T00:32:49.855603-08:00 WARNING kernel: [   11.068860] do not
call blocking ops when !TASK_RUNNING; state=3D1 set at
[<ffffffc0007a350c>] sdio_irq_thread+0x11c/0x1dc
...
2017-01-20T00:32:49.856042-08:00 EMERG kernel: [   12.136156] Call
trace:
2017-01-20T00:32:49.856044-08:00 WARNING kernel: [   12.138584]
[<ffffffc000249d84>] __might_sleep+0x64/0x90
2017-01-20T00:32:49.856047-08:00 WARNING kernel: [   12.143855]
[<ffffffc000630f54>] __pm_runtime_resume+0x40/0x9c
2017-01-20T00:32:49.856049-08:00 WARNING kernel: [   12.149644]
[<ffffffc0007ae994>] msdc_enable_sdio_irq+0x44/0xd0
2017-01-20T00:32:49.856051-08:00 WARNING kernel: [   12.155516]
[<ffffffc0007a3544>] sdio_irq_thread+0x154/0x1dc
2017-01-20T00:32:49.856053-08:00 WARNING kernel: [   12.161131]
[<ffffffc00023f30c>] kthread+0x10c/0x114
2017-01-20T00:32:49.856055-08:00 WARNING kernel: [   12.166056]
[<ffffffc000203dd0>] ret_from_fork+0x10/0x40
2017-01-20T00:32:49.856057-08:00 WARNING kernel: [   12.171368] sched:
RT throttling activated for rt_rq ffffffc0fff5a5c0 (cpu 1)
2017-01-20T00:32:49.856059-08:00 WARNING kernel: [   12.171368]
potential CPU hogs:
2017-01-20T00:32:49.856061-08:00 WARNING kernel: [   12.171368]
 ksdioirqd/mmc2 (1772)

dw_mmc also enables autosuspend but it didn't call any pm_runtime_get*
function in it's enable_sdio_irq function, I don't really know how it
worked around this.
Ulf, any suggestions on how we can do this?

Wei-Ning

> +               msdc_recheck_sdio_irq(host);
> +
> +               spin_lock_irqsave(&host->irqlock, flags);
> +               sdr_set_bits(host->base + SDC_CFG, SDC_CFG_SDIOIDE);
> +               sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ)=
;
> +               spin_unlock_irqrestore(&host->irqlock, flags);
> +       } else {
> +               spin_lock_irqsave(&host->irqlock, flags);
> +               sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_SDIOIRQ)=
;
> +               spin_unlock_irqrestore(&host->irqlock, flags);
> +       }
> +}
> +
>  static struct mmc_host_ops mt_msdc_ops =3D {
>         .post_req =3D msdc_post_req,
>         .pre_req =3D msdc_pre_req,
> @@ -1504,6 +1592,7 @@ static void msdc_hw_reset(struct mmc_host *mmc)
>         .execute_tuning =3D msdc_execute_tuning,
>         .prepare_hs400_tuning =3D msdc_prepare_hs400_tuning,
>         .hw_reset =3D msdc_hw_reset,
> +       .enable_sdio_irq =3D msdc_enable_sdio_irq,
>  };
>
>  static int msdc_drv_probe(struct platform_device *pdev)
> @@ -1600,6 +1689,7 @@ static int msdc_drv_probe(struct platform_device *p=
dev)
>         mmc_dev(mmc)->dma_mask =3D &host->dma_mask;
>
>         host->timeout_clks =3D 3 * 1048576;
> +       host->irq_thread_alive =3D false;
>         host->dma.gpd =3D dma_alloc_coherent(&pdev->dev,
>                                 2 * sizeof(struct mt_gpdma_desc),
>                                 &host->dma.gpd_addr, GFP_KERNEL);
> @@ -1613,6 +1703,7 @@ static int msdc_drv_probe(struct platform_device *p=
dev)
>         msdc_init_gpd_bd(host, &host->dma);
>         INIT_DELAYED_WORK(&host->req_timeout, msdc_request_timeout);
>         spin_lock_init(&host->lock);
> +       spin_lock_init(&host->irqlock);
>
>         platform_set_drvdata(pdev, mmc);
>         msdc_ungate_clock(host);
> --
> 1.7.9.5
>



--=20
Wei-Ning Huang, =E9=BB=83=E5=81=89=E5=AF=A7 | Software Engineer, Google Inc=
., Taiwan |
wnhuang@google.com | Cell: +886 910-380678
