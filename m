From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: mediatek: Add tune support
Date: Thu, 15 Oct 2015 08:39:16 +0200
Message-ID: <20151015063916.GT7858@pengutronix.de>
References: <1444729078-26585-1-git-send-email-chaotian.jing@mediatek.com>
 <1444729078-26585-4-git-send-email-chaotian.jing@mediatek.com>
 <CAPDyKFqUFRZF2M4ichgqM2SeRQbh52e5U1oFG9AExsq0SkFj9w@mail.gmail.com>
 <1444877180.8751.15.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444877180.8751.15.camel@mhfsdcap03>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Howard Chen <ibanezchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Kristina Martsenko <kristina.martsenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kerne>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 15, 2015 at 10:46:20AM +0800, Chaotian Jing wrote:
> On Wed, 2015-10-14 at 12:05 +0200, Ulf Hansson wrote:
> > On 13 October 2015 at 11:37, Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org> wrote:
> > > Add CMD19/CMD21 support for EMMC/SD/SDIO tuning
> > > Add HS400 mode support
> > >
> > > Signed-off-by: Chaotian Jing <chaotian.jing-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > > ---
> > >  drivers/mmc/host/mtk-sd.c | 359 ++++++++++++++++++++++++++++++++++++++++++----
> > >  1 file changed, 332 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> > > index b2e89d3..f12a50a 100644
> > > --- a/drivers/mmc/host/mtk-sd.c
> > > +++ b/drivers/mmc/host/mtk-sd.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/pm.h>
> > >  #include <linux/pm_runtime.h>
> > >  #include <linux/regulator/consumer.h>
> > > +#include <linux/slab.h>
> > >  #include <linux/spinlock.h>
> > >
> > >  #include <linux/mmc/card.h>
> > > @@ -64,6 +65,7 @@
> > >  #define SDC_RESP2        0x48
> > >  #define SDC_RESP3        0x4c
> > >  #define SDC_BLK_NUM      0x50
> > > +#define EMMC_IOCON       0x7c
> > >  #define SDC_ACMD_RESP    0x80
> > >  #define MSDC_DMA_SA      0x90
> > >  #define MSDC_DMA_CTRL    0x98
> > > @@ -71,6 +73,8 @@
> > >  #define MSDC_PATCH_BIT   0xb0
> > >  #define MSDC_PATCH_BIT1  0xb4
> > >  #define MSDC_PAD_TUNE    0xec
> > > +#define PAD_DS_TUNE      0x188
> > > +#define EMMC50_CFG0      0x208
> > >
> > >  /*--------------------------------------------------------------------------*/
> > >  /* Register Mask                                                            */
> > > @@ -87,6 +91,7 @@
> > >  #define MSDC_CFG_CKSTB          (0x1 << 7)     /* R  */
> > >  #define MSDC_CFG_CKDIV          (0xff << 8)    /* RW */
> > >  #define MSDC_CFG_CKMOD          (0x3 << 16)    /* RW */
> > > +#define MSDC_CFG_HS400_CK_MODE  (0x1 << 18)    /* RW */
> > >
> > >  /* MSDC_IOCON mask */
> > >  #define MSDC_IOCON_SDR104CKS    (0x1 << 0)     /* RW */
> > > @@ -204,6 +209,17 @@
> > >  #define MSDC_PATCH_BIT_SPCPUSH    (0x1 << 29)  /* RW */
> > >  #define MSDC_PATCH_BIT_DECRCTMO   (0x1 << 30)  /* RW */
> > >
> > > +#define MSDC_PAD_TUNE_DATRRDLY   (0x1f <<  8)  /* RW */
> > > +#define MSDC_PAD_TUNE_CMDRDLY    (0x1f << 16)  /* RW */
> > > +
> > > +#define PAD_DS_TUNE_DLY1         (0x1f << 2)   /* RW */
> > > +#define PAD_DS_TUNE_DLY2         (0x1f << 7)   /* RW */
> > > +#define PAD_DS_TUNE_DLY3         (0x1f << 12)  /* RW */
> > > +
> > > +#define EMMC50_CFG_PADCMD_LATCHCK (0x1 << 0)   /* RW */
> > > +#define EMMC50_CFG_CRCSTS_EDGE    (0x1 << 3)   /* RW */
> > > +#define EMMC50_CFG_CFCSTS_SEL     (0x1 << 4)   /* RW */
> > > +
> > >  #define REQ_CMD_EIO  (0x1 << 0)
> > >  #define REQ_CMD_TMO  (0x1 << 1)
> > >  #define REQ_DAT_ERR  (0x1 << 2)
> > > @@ -219,6 +235,7 @@
> > >  #define CMD_TIMEOUT         (HZ/10 * 5)        /* 100ms x5 */
> > >  #define DAT_TIMEOUT         (HZ    * 5)        /* 1000ms x5 */
> > >
> > > +#define DELAY_MAX      32 /* PAD dalay cells */
> > 
> > /s/dalay/delay
> > 
> > Can we have some more explaination around this define. Perhaps a more
> > self-explaining name would be enough.-
> 
> This is the max step of the pad delay cells, our hardware use 5bits to
> describe the pad delay.
> will change it to
> #define PAD_DELAY_MAX	32
> > >  /*--------------------------------------------------------------------------*/
> > >  /* Descriptor Structure                                                     */
> > >  /*--------------------------------------------------------------------------*/
> > > @@ -265,6 +282,14 @@ struct msdc_save_para {
> > >         u32 pad_tune;
> > >         u32 patch_bit0;
> > >         u32 patch_bit1;
> > > +       u32 pad_ds_tune;
> > > +       u32 emmc50_cfg0;
> > > +};
> > > +
> > > +struct msdc_delay_phase {
> > > +       u8 maxlen;
> > > +       u8 start;
> > > +       u8 final_phase;
> > >  };
> > >
> > >  struct msdc_host {
> > > @@ -293,12 +318,15 @@ struct msdc_host {
> > >         int irq;                /* host interrupt */
> > >
> > >         struct clk *src_clk;    /* msdc source clock */
> > > +       struct clk *src_clk_parent; /* src_clk's parent */
> > > +       struct clk *hs400_src;  /* 400Mhz source clock */
> > 
> > Hmm, so you need to control the upper level clocks. Can you elaborate
> > on why this is needed?
> > 
> hs400 is DDR200, in our host design, if the mode is DDR(HS400), if want
> to get 200Mhz mmc bus clock frequency, the minimum source clock is
> double of the mmc bus clock, So, we need it for HS400 mode with 200Mhz
> bus clock.
> > >         struct clk *h_clk;      /* msdc h_clk */
> > >         u32 mclk;               /* mmc subsystem clock frequency */
> > >         u32 src_clk_freq;       /* source clock frequency */
> > >         u32 sclk;               /* SD/MS bus clock frequency */
> > > -       bool ddr;
> > > +       unsigned char timing;
> > >         bool vqmmc_enabled;
> > > +       u32 hs400_ds_delay;
> > >         struct msdc_save_para save_para; /* used when gate HCLK */
> > >  };
> > >
> > > @@ -353,7 +381,10 @@ static void msdc_reset_hw(struct msdc_host *host)
> > >  static void msdc_cmd_next(struct msdc_host *host,
> > >                 struct mmc_request *mrq, struct mmc_command *cmd);
> > >
> > > -static u32 data_ints_mask = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO |
> > > +static const u32 cmd_ints_mask = MSDC_INTEN_CMDRDY | MSDC_INTEN_RSPCRCERR |
> > > +                       MSDC_INTEN_CMDTMO | MSDC_INTEN_ACMDRDY |
> > > +                       MSDC_INTEN_ACMDCRCERR | MSDC_INTEN_ACMDTMO;
> > 
> > This belongs to separate code improvement patch.
> > 
> OK, will separate it.
> > > +static const u32 data_ints_mask = MSDC_INTEN_XFER_COMPL | MSDC_INTEN_DATTMO |
> > >                         MSDC_INTEN_DATCRCERR | MSDC_INTEN_DMA_BDCSERR |
> > >                         MSDC_INTEN_DMA_GPDCSERR | MSDC_INTEN_DMA_PROTECT;
> > >
> > > @@ -485,7 +516,7 @@ static void msdc_ungate_clock(struct msdc_host *host)
> > >                 cpu_relax();
> > >  }
> > >
> > > -static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
> > > +static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
> > 
> > Perhaps this change could be split into two changes.
> > 
> > One that breaks out code from ->set_ios() and let msdc_set_mclk() also
> > deals with DDR timings.
> > 
> > Second you add the HS400 specific parts.
> > 
> OK, will split it.
> > >  {
> > >         u32 mode;
> > >         u32 flags;
> > > @@ -501,8 +532,15 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
> > >
> > >         flags = readl(host->base + MSDC_INTEN);
> > >         sdr_clr_bits(host->base + MSDC_INTEN, flags);
> > > -       if (ddr) { /* may need to modify later */
> > > -               mode = 0x2; /* ddr mode and use divisor */
> > > +       sdr_clr_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
> > > +       if (timing == MMC_TIMING_UHS_DDR50 ||
> > > +           timing == MMC_TIMING_MMC_DDR52 ||
> > 
> > So, no support for HS200?
> > 
> HS200 is the same with other SDR modes, so it will be handled at else..
> > > +           timing == MMC_TIMING_MMC_HS400) {
> > > +               if (timing == MMC_TIMING_MMC_HS400)
> > > +                       mode = 0x3;
> > > +               else
> > > +                       mode = 0x2; /* ddr mode and use divisor */
> > > +
> > >                 if (hz >= (host->src_clk_freq >> 2)) {
> > >                         div = 0; /* mean div = 1/4 */
> > >                         sclk = host->src_clk_freq >> 2; /* sclk = clk / 4 */
> > > @@ -511,6 +549,13 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
> > >                         sclk = (host->src_clk_freq >> 2) / div;
> > >                         div = (div >> 1);
> > >                 }
> > > +
> > > +               if (timing == MMC_TIMING_MMC_HS400 &&
> > > +                   hz >= (host->src_clk_freq >> 1)) {
> > > +                       sdr_set_bits(host->base + MSDC_CFG, MSDC_CFG_HS400_CK_MODE);
> > > +                       sclk = host->src_clk_freq >> 1;
> > > +                       div = 0; /* div is ignore when bit18 is set */
> > > +               }
> > >         } else if (hz >= host->src_clk_freq) {
> > >                 mode = 0x1; /* no divisor */
> > >                 div = 0;
> > > @@ -532,12 +577,12 @@ static void msdc_set_mclk(struct msdc_host *host, int ddr, u32 hz)
> > >                 cpu_relax();
> > >         host->sclk = sclk;
> > >         host->mclk = hz;
> > > -       host->ddr = ddr;
> > > +       host->timing = timing;
> > >         /* need because clk changed. */
> > >         msdc_set_timeout(host, host->timeout_ns, host->timeout_clks);
> > >         sdr_set_bits(host->base + MSDC_INTEN, flags);
> > >
> > > -       dev_dbg(host->dev, "sclk: %d, ddr: %d\n", host->sclk, ddr);
> > > +       dev_dbg(host->dev, "sclk: %d, timing: %d\n", host->sclk, timing);
> > >  }
> > >
> > >  static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
> > > @@ -725,10 +770,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
> > >         if (done)
> > >                 return true;
> > >
> > > -       sdr_clr_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
> > > -                       MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
> > > -                       MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
> > > -                       MSDC_INTEN_ACMDTMO);
> > > +       sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> > 
> > This belongs to separate code improvement patch.
> > 
> OK, will separate it.
> > >
> > >         if (cmd->flags & MMC_RSP_PRESENT) {
> > >                 if (cmd->flags & MMC_RSP_136) {
> > > @@ -818,10 +860,7 @@ static void msdc_start_command(struct msdc_host *host,
> > >         rawcmd = msdc_cmd_prepare_raw_cmd(host, mrq, cmd);
> > >         mod_delayed_work(system_wq, &host->req_timeout, DAT_TIMEOUT);
> > >
> > > -       sdr_set_bits(host->base + MSDC_INTEN, MSDC_INTEN_CMDRDY |
> > > -                       MSDC_INTEN_RSPCRCERR | MSDC_INTEN_CMDTMO |
> > > -                       MSDC_INTEN_ACMDRDY | MSDC_INTEN_ACMDCRCERR |
> > > -                       MSDC_INTEN_ACMDTMO);
> > > +       sdr_set_bits(host->base + MSDC_INTEN, cmd_ints_mask);
> > 
> > This belongs to separate code improvement patch.
> OK, will separate it.
> > 
> > >         writel(cmd->arg, host->base + SDC_ARG);
> > >         writel(rawcmd, host->base + SDC_CMD);
> > >  }
> > > @@ -895,7 +934,7 @@ static void msdc_data_xfer_next(struct msdc_host *host,
> > >                                 struct mmc_request *mrq, struct mmc_data *data)
> > >  {
> > >         if (mmc_op_multi(mrq->cmd->opcode) && mrq->stop && !mrq->stop->error &&
> > > -           (!data->bytes_xfered || !mrq->sbc))
> > > +           !mrq->sbc)
> > >                 msdc_start_command(host, mrq, mrq->stop);
> > >         else
> > >                 msdc_request_done(host, mrq);
> > > @@ -929,7 +968,7 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
> > >                 while (readl(host->base + MSDC_DMA_CFG) & MSDC_DMA_CFG_STS)
> > >                         cpu_relax();
> > >                 sdr_clr_bits(host->base + MSDC_INTEN, data_ints_mask);
> > > -               dev_dbg(host->dev, "DMA stop\n");
> > > +               dev_dbg(host->dev, "DMA stop event:0x%x\n", events);
> > 
> > Perhaps a separate debug patch?
> will add it to the improvement patch.
> > 
> > >
> > >                 if ((events & MSDC_INT_XFER_COMPL) && (!stop || !stop->error)) {
> > >                         data->bytes_xfered = data->blocks * data->blksz;
> > > @@ -941,6 +980,8 @@ static bool msdc_data_xfer_done(struct msdc_host *host, u32 events,
> > >
> > >                         if (events & MSDC_INT_DATTMO)
> > >                                 data->error = -ETIMEDOUT;
> > > +                       else if (events & MSDC_INT_DATCRCERR)
> > > +                               data->error = -EILSEQ;
> > >
> > >                         dev_err(host->dev, "%s: cmd=%d; blocks=%d",
> > >                                 __func__, mrq->cmd->opcode, data->blocks);
> > > @@ -1112,10 +1153,14 @@ static void msdc_init_hw(struct msdc_host *host)
> > >
> > >         writel(0, host->base + MSDC_PAD_TUNE);
> > >         writel(0, host->base + MSDC_IOCON);
> > > -       sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 1);
> > > -       writel(0x403c004f, host->base + MSDC_PATCH_BIT);
> > > +       sdr_set_field(host->base + MSDC_IOCON, MSDC_IOCON_DDLSEL, 0);
> > > +       writel(0x403c0046, host->base + MSDC_PATCH_BIT);
> > >         sdr_set_field(host->base + MSDC_PATCH_BIT, MSDC_CKGEN_MSDC_DLY_SEL, 1);
> > >         writel(0xffff0089, host->base + MSDC_PATCH_BIT1);
> > > +       sdr_set_bits(host->base + EMMC50_CFG0, EMMC50_CFG_CFCSTS_SEL);
> > > +
> > > +       if (host->mmc->caps2 & MMC_CAP2_HS400_1_8V)
> > 
> > Should you really do this even if the HS400 mode isn't supported by
> > the card, and thus we will never switch timing to that mode?
> > 
> > So, I am kind of wondering if this shouldn't be conditional depending
> > on the current selected timing mode. Or perhaps you need this done
> > from a ->prepare_hs400_tuning() callback)?
> > 
> Actually, set this register has no impact to the none HS400 mode.
> anyway, put it to ->prepare_hs400_tuning() is better, will do it
> at next revision.
> > > +               writel(host->hs400_ds_delay, host->base + PAD_DS_TUNE);
> > >         /* Configure to enable SDIO mode.
> > >          * it's must otherwise sdio cmd5 failed
> > >          */
> > > @@ -1151,7 +1196,6 @@ static void msdc_init_gpd_bd(struct msdc_host *host, struct msdc_dma *dma)
> > >
> > >         gpd->gpd_info = GPDMA_DESC_BDP; /* hwo, cs, bd pointer */
> > >         gpd->ptr = (u32)dma->bd_addr; /* physical address */
> > > -
> > 
> > White space.
> > 
> will fix at next revision.
> > >         memset(bd, 0, sizeof(struct mt_bdma_desc) * MAX_BD_NUM);
> > >         for (i = 0; i < (MAX_BD_NUM - 1); i++)
> > >                 bd[i].next = (u32)dma->bd_addr + sizeof(*bd) * (i + 1);
> > > @@ -1161,20 +1205,16 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >  {
> > >         struct msdc_host *host = mmc_priv(mmc);
> > >         int ret;
> > > -       u32 ddr = 0;
> > >
> > >         pm_runtime_get_sync(host->dev);
> > >
> > > -       if (ios->timing == MMC_TIMING_UHS_DDR50 ||
> > > -           ios->timing == MMC_TIMING_MMC_DDR52)
> > > -               ddr = 1;
> > > -
> > >         msdc_set_buswidth(host, ios->bus_width);
> > >
> > >         /* Suspend/Resume will do power off/on */
> > >         switch (ios->power_mode) {
> > >         case MMC_POWER_UP:
> > >                 if (!IS_ERR(mmc->supply.vmmc)) {
> > > +                       msdc_init_hw(host);
> > >                         ret = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
> > >                                         ios->vdd);
> > >                         if (ret) {
> > > @@ -1205,14 +1245,259 @@ static void msdc_ops_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > >                 break;
> > >         }
> > >
> > > -       if (host->mclk != ios->clock || host->ddr != ddr)
> > > -               msdc_set_mclk(host, ddr, ios->clock);
> > > +       if (host->mclk != ios->clock || host->timing != ios->timing)
> > > +               msdc_set_mclk(host, ios->timing, ios->clock);
> > >
> > >  end:
> > >         pm_runtime_mark_last_busy(host->dev);
> > >         pm_runtime_put_autosuspend(host->dev);
> > >  }
> > >
> > > +static u32 test_delay_bit(u32 delay, u32 bit)
> > > +{
> > > +       bit %= DELAY_MAX;
> > > +       return delay & (1 << bit);
> > > +}
> > > +
> > > +static int get_delay_len(u32 delay, u32 start_bit)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i = 0; i < (DELAY_MAX - start_bit); i++) {
> > > +               if (test_delay_bit(delay, start_bit + i) == 0)
> > > +                       return i;
> > > +       }
> > > +       return DELAY_MAX - start_bit;
> > > +}
> > > +
> > > +static struct msdc_delay_phase get_best_delay(u32 delay)
> > > +{
> > > +       int start = 0, len = 0;
> > > +       int start_final = 0, len_final = 0;
> > > +       u8 final_phase = 0xff;
> > > +       struct msdc_delay_phase delay_phase;
> > > +
> > > +       if (delay == 0) {
> > > +               pr_err("phase error: [map:%x]\n", delay);
> > 
> > Please use dev_err|warn|dbg|info instead.
> > 
> As you know, this function is just only parse the argument "u32 delay",
> it do not bind with any device.

Then please add the appropriate context pointer to this function.
Messages without any context are not helpful to the reader.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
