From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH] mmc: dw_mmc: rework the accurate timeout calculation
Date: Fri, 20 Apr 2018 09:14:51 +0200
Message-ID: <CAPDyKFpjNwOv7qBKD2SUCEDR7yR97R6OXy7KPB-8DVqV8sTo=Q@mail.gmail.com>
References: <1522311530-87337-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1522311530-87337-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 29 March 2018 at 10:18, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> The intention of this patch is to rework the timeout calculation
> for dw_mmc, which isn't ideal enough. It's harmless to add longest
> timeout as normally the transfer is fine and the occasional failure
> could break out by no matter the Hardware interrupt or software timer.
>
> However, it doesn't make sense in the tuning process, as it could
> trigger more timeout than usual, which is very painful for booting
> time. Currently we set TMOUT to 0xffffffff anyway. Assume the max
> clock is 200MHz when doing tuning for HS200, the we have:
>
> MSEC_PER_SEC * 0xffffff / 200MHz = 83ms for hardware timemout interrupt
> and 93ms for software timer.
>
> However, we should note that the cards should guarantee to complete a
> sequence of 40 times CMD21 execulations within 150ms per the spec. But
> we now have 83ms timeout for each CMD21, which only contains 128Bytes
> data playload.
>
> Maybe the simplest way is to reduce the HW/SW timeout value for tuning
> process but it's still worth trying to rework a more accurate timeout.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>

Jaehoon, any comments on this one?

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/host/dw_mmc.c | 107 +++++++++++++++++++++++++++++++++-------------
>  drivers/mmc/host/dw_mmc.h |   4 ++
>  2 files changed, 82 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 623f4d2..c85d703 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -378,23 +378,84 @@ static u32 dw_mci_prep_stop_abort(struct dw_mci *host, struct mmc_command *cmd)
>         return cmdr;
>  }
>
> -static inline void dw_mci_set_cto(struct dw_mci *host)
> +static void dw_mci_calc_timeout(struct dw_mci *host)
>  {
> -       unsigned int cto_clks;
> -       unsigned int cto_div;
> -       unsigned int cto_ms;
> -       unsigned long irqflags;
> +       struct mmc_data *data = host->data;
> +       struct mmc_host *mmc = host->slot->mmc;
> +       u64 trsf_time_per_blksz;
> +       u64 idle_time_per_trsf;
> +       u64 val;
> +       struct mmc_ios *ios = &mmc->ios;
> +       unsigned char bus_width = ios->bus_width;
> +       unsigned int freq, clk_div;
> +       unsigned int cto_clks, drto_clks;
> +
> +       clk_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
> +       if (clk_div == 0)
> +               clk_div = 1;
> +
> +       freq = host->bus_hz / clk_div;
> +
> +       /*
> +        * The largest 136 bit response in 100KHz is nearly 1ms,
> +        * and add other transfer parameter per spec, we should
> +        * allow 2ms maybe. And should also add some spare time
> +        * to tolerate anything unknown leading to unexpect long
> +        * latency.
> +        */
> +       host->cmd_timeout_ns = 10 * NSEC_PER_MSEC;
> +       host->data_timeout_ns = 10 * NSEC_PER_MSEC;
> +
> +       if (data) {
> +               trsf_time_per_blksz = DIV_ROUND_UP_ULL((u64)data->blksz *
> +                                       NSEC_PER_SEC * (8 / bus_width), freq);
> +
> +               /*
> +                * Especially multiply by 2 to account for write for anything
> +                * unknown in the cards, for each block.
> +                */
> +               if (data->flags & MMC_DATA_WRITE)
> +                       trsf_time_per_blksz *= 2;
> +
> +               /* Calculate idle time from core basd on spec */
> +               idle_time_per_trsf = DIV_ROUND_UP_ULL(data->timeout_ns,
> +                                                     NSEC_PER_USEC);
> +               if (data->timeout_clks) {
> +                       /* Align up from cycle of MHz to Hz */
> +                       val = 1000000ULL * data->timeout_clks;
> +                       if (DIV_ROUND_UP_ULL(val, freq))
> +                               idle_time_per_trsf++;
> +                       idle_time_per_trsf += val;
> +               }
> +
> +               /* Calculate timeout for the entire data */
> +               host->data_timeout_ns +=
> +                       data->blocks * (DIV_ROUND_UP_ULL(idle_time_per_trsf,
> +                                       NSEC_PER_USEC) + trsf_time_per_blksz);
>
> -       cto_clks = mci_readl(host, TMOUT) & 0xff;
> -       cto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
> -       if (cto_div == 0)
> -               cto_div = 1;
> +               drto_clks = DIV_ROUND_UP_ULL(host->data_timeout_ns * freq,
> +                                            NSEC_PER_SEC);
> +               if (drto_clks > 0xffffff)
> +                       drto_clks = 0xffffff;
>
> -       cto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * cto_clks * cto_div,
> -                                 host->bus_hz);
> +               /* Set accurate hw data timeout */
> +               mci_writel(host, TMOUT, drto_clks << 8);
> +       }
>
> -       /* add a bit spare time */
> -       cto_ms += 10;
> +       host->cmd_timeout_ns += host->cmd->busy_timeout * NSEC_PER_MSEC;
> +       cto_clks = DIV_ROUND_UP_ULL(host->cmd_timeout_ns * freq,
> +                                   NSEC_PER_SEC);
> +       if (cto_clks > 0xff)
> +               cto_clks = 0xff;
> +
> +       /* Set accurate cmd timeout */
> +       mci_writel(host, TMOUT, cto_clks |
> +                               (mci_readl(host, TMOUT) & 0xffffff00));
> +}
> +
> +static inline void dw_mci_set_cto(struct dw_mci *host)
> +{
> +       unsigned long irqflags;
>
>         /*
>          * The durations we're working with are fairly short so we have to be
> @@ -412,7 +473,7 @@ static inline void dw_mci_set_cto(struct dw_mci *host)
>         spin_lock_irqsave(&host->irq_lock, irqflags);
>         if (!test_bit(EVENT_CMD_COMPLETE, &host->pending_events))
>                 mod_timer(&host->cto_timer,
> -                       jiffies + msecs_to_jiffies(cto_ms) + 1);
> +                       jiffies + nsecs_to_jiffies(host->cmd_timeout_ns) + 1);
>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  }
>
> @@ -424,6 +485,8 @@ static void dw_mci_start_command(struct dw_mci *host,
>                  "start command: ARGR=0x%08x CMDR=0x%08x\n",
>                  cmd->arg, cmd_flags);
>
> +       dw_mci_calc_timeout(host);
> +
>         mci_writel(host, CMDARG, cmd->arg);
>         wmb(); /* drain writebuffer */
>         dw_mci_wait_while_busy(host, cmd_flags);
> @@ -1923,26 +1986,12 @@ static int dw_mci_data_complete(struct dw_mci *host, struct mmc_data *data)
>
>  static void dw_mci_set_drto(struct dw_mci *host)
>  {
> -       unsigned int drto_clks;
> -       unsigned int drto_div;
> -       unsigned int drto_ms;
>         unsigned long irqflags;
>
> -       drto_clks = mci_readl(host, TMOUT) >> 8;
> -       drto_div = (mci_readl(host, CLKDIV) & 0xff) * 2;
> -       if (drto_div == 0)
> -               drto_div = 1;
> -
> -       drto_ms = DIV_ROUND_UP_ULL((u64)MSEC_PER_SEC * drto_clks * drto_div,
> -                                  host->bus_hz);
> -
> -       /* add a bit spare time */
> -       drto_ms += 10;
> -
>         spin_lock_irqsave(&host->irq_lock, irqflags);
>         if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
>                 mod_timer(&host->dto_timer,
> -                         jiffies + msecs_to_jiffies(drto_ms));
> +                         jiffies + nsecs_to_jiffies(host->data_timeout_ns));
>         spin_unlock_irqrestore(&host->irq_lock, irqflags);
>  }
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 46e9f8e..4330128 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -126,7 +126,9 @@ struct dw_mci_dma_slave {
>   * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
>   * @cmd11_timer: Timer for SD3.0 voltage switch over scheme.
>   * @cto_timer: Timer for broken command transfer over scheme.
> + * @cmd_timeout_ns: Timeout value accociated with cto_timer
>   * @dto_timer: Timer for broken data transfer over scheme.
> + * @data_timeout_ns: Timeout value accociated with dto_timer
>   *
>   * Locking
>   * =======
> @@ -233,7 +235,9 @@ struct dw_mci {
>
>         struct timer_list       cmd11_timer;
>         struct timer_list       cto_timer;
> +       u64                     cmd_timeout_ns;
>         struct timer_list       dto_timer;
> +       u64                     data_timeout_ns;
>  };
>
>  /* DMA ops for Internal/External DMAC interface */
> --
> 1.9.1
>
>
