From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 3/9] mmc: tmio: Add UHS-I mode support
Date: Tue, 16 Aug 2016 20:05:19 +0200
Message-ID: <CAMuHMdVyNsm+hpoJfjxLkKt_5zydx9csgPB0zqCdtPMipqmFFQ@mail.gmail.com>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de> <1459525479-20842-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1459525479-20842-4-git-send-email-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Simon Horman <horms@verge.net.au>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Fri, Apr 1, 2016 at 5:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Based on work by Shinobu Uehara and Ben Dooks. This adds the voltage
> switch operation needed for all UHS-I modes, but not the tuning needed
> for SDR-104 which will come later.
>
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

This patch causes a regression on r8a73a4/ape6evm, where the system feels
sluggish, and the load average is always ca. 1.
According to "top", "kworker/0:1" is consuming up to 80% of CPU time.

"echo t > /proc/sysrq-trigger" tells me:

    kworker/0:1     R running      0    57      2 0x00000000
    Workqueue: events_freezable mmc_rescan
    [<c0465e3c>] (__schedule) from [<c04662c4>]
(preempt_schedule_common+0x1c/0x2c)
    [<c04662c4>] (preempt_schedule_common) from [<c0466430>]
(_cond_resched+0x34/0x44)
    [<c0466430>] (_cond_resched) from [<c02f9d04>]
(__mmc_start_request+0x6c/0x204)
    [<c02f9d04>] (__mmc_start_request) from [<c02f9fa0>]
(mmc_start_request+0x104/0x118)
    [<c02f9fa0>] (mmc_start_request) from [<c02fa4b0>]
(mmc_wait_for_req+0x3c/0x14c)
    [<c02fa4b0>] (mmc_wait_for_req) from [<c02fa624>]
(mmc_wait_for_cmd+0x64/0x74)
    [<c02fa624>] (mmc_wait_for_cmd) from [<c03041dc>]
(mmc_io_rw_direct_host+0xbc/0x124)
    [<c03041dc>] (mmc_io_rw_direct_host) from [<c0304608>]
(sdio_reset+0x58/0x60)
    [<c0304608>] (sdio_reset) from [<c02fc4e8>] (mmc_rescan+0x244/0x338)
    [<c02fc4e8>] (mmc_rescan) from [<c00469a8>] (process_one_work+0x324/0x67c)
    [<c00469a8>] (process_one_work) from [<c0046fdc>]
(worker_thread+0x2ac/0x3d4)
    [<c0046fdc>] (worker_thread) from [<c004caf4>] (kthread+0xd8/0xec)
    [<c004caf4>] (kthread) from [<c000fc10>] (ret_from_fork+0x14/0x24)

I've bisected this to
commit 452e5eef6d311e52f657b34d999758107ec3dd4a
Author: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date:   Fri Apr 1 17:44:33 2016 +0200

    mmc: tmio: Add UHS-I mode support

The problem goes away by:
  1. Commenting-out the assignment to .card_busy
  2. OR disabling the second SDHI channel, e.g.
       echo ee120000.sd > /sys/bus/platform/drivers/sh_mobile_sdhi/unbind

The first SDHI channel (ee100000.sd) doesn't seem to be affected
by the problem.

I've added some debug code to dev_warn_ratelimited() the status value.
This shows the SDHI channel keeps on reporting busy:

# dmesg | grep -E "(tmio|sdhi)" | uniq -c
      1 iommu: Adding device regulator-sdhi0 to group 0
      1 iommu: Removing device regulator-sdhi0 from group 0
      1 sh_mobile_sdhi ee100000.sd: could not find pctldev for node
/pfc@e6050000/sd0, deferring probe
      1 sh_mobile_sdhi ee120000.sd: could not find pctldev for node
/pfc@e6050000/sd1, deferring probe
      1 sh_mobile_sdhi ee100000.sd: adding to PM domain a3sp
      1 _host->start_signal_voltage_switch =
sh_mobile_sdhi_start_signal_voltage_switch
      1 sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock
rate 88 MHz
      1 sh_mobile_sdhi ee120000.sd: adding to PM domain a3sp
      1 _host->start_signal_voltage_switch =
sh_mobile_sdhi_start_signal_voltage_switch
      1 sh_mobile_sdhi ee100000.sd: CTL_STATUS2 = 0x20800600
      1 sh_mobile_sdhi ee100000.sd: CTL_STATUS2 = 0x20800400
      1 sh_mobile_sdhi ee120000.sd: mmc1 base at 0xee120000 max clock
rate 12 MHz
      8 sh_mobile_sdhi ee120000.sd: CTL_STATUS2 = 0x20000600
      1 tmio_mmc_card_busy: 3509 callbacks suppressed
     10 sh_mobile_sdhi ee120000.sd: CTL_STATUS2 = 0x20000400
      1 tmio_mmc_card_busy: 2653 callbacks suppressed
     10 sh_mobile_sdhi ee120000.sd: CTL_STATUS2 = 0x20000400
      1 tmio_mmc_card_busy: 2028 callbacks suppressed
     10 sh_mobile_sdhi ee120000.sd: CTL_STATUS2 = 0x20000400
      1 tmio_mmc_card_busy: 2888 callbacks suppressed
     10 sh_mobile_sdhi ee120000.sd: CTL_STATUS2 = 0x20000400

Note that the reported values are the ones for a current tree.
On commit 452e5eef6d311e52, the values are 0x31d2080, 0x3002080,
0x31d2000, and 0x3182000.

As you can see ee100000.sd behaves normal.

> ---
>  drivers/mmc/host/tmio_mmc.h     |  2 ++
>  drivers/mmc/host/tmio_mmc_pio.c | 12 +++++++++++-
>  include/linux/mmc/tmio.h        |  2 ++
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index b44b5890290622..b1819c74965b47 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -101,6 +101,8 @@ struct tmio_mmc_host {
>         void (*clk_disable)(struct tmio_mmc_host *host);
>         int (*multi_io_quirk)(struct mmc_card *card,
>                               unsigned int direction, int blk_size);
> +       int (*start_signal_voltage_switch)(struct mmc_host *mmc,
> +                                          struct mmc_ios *ios);
>  };
>
>  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index ae81b34f17a5a5..53e5ba5a21914c 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1012,12 +1012,20 @@ static int tmio_multi_io_quirk(struct mmc_card *card,
>         return blk_size;
>  }
>
> -static const struct mmc_host_ops tmio_mmc_ops = {
> +static int tmio_mmc_card_busy(struct mmc_host *mmc)
> +{
> +       struct tmio_mmc_host *host = mmc_priv(mmc);
> +
> +       return !(sd_ctrl_read32(host, CTL_STATUS2) & TMIO_STATUS2_DAT0);
> +}
> +
> +static struct mmc_host_ops tmio_mmc_ops = {
>         .request        = tmio_mmc_request,
>         .set_ios        = tmio_mmc_set_ios,
>         .get_ro         = tmio_mmc_get_ro,
>         .get_cd         = mmc_gpio_get_cd,
>         .enable_sdio_irq = tmio_mmc_enable_sdio_irq,
> +       .card_busy      = tmio_mmc_card_busy,
>         .multi_io_quirk = tmio_multi_io_quirk,
>  };
>
> @@ -1116,7 +1124,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>                 goto host_free;
>         }
>
> +       tmio_mmc_ops.start_signal_voltage_switch = _host->start_signal_voltage_switch;
>         mmc->ops = &tmio_mmc_ops;
> +
>         mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
>         mmc->caps2 |= pdata->capabilities2;
>         mmc->max_segs = 32;
> diff --git a/include/linux/mmc/tmio.h b/include/linux/mmc/tmio.h
> index 5f5cd80e976500..b2f28e99503383 100644
> --- a/include/linux/mmc/tmio.h
> +++ b/include/linux/mmc/tmio.h
> @@ -63,6 +63,8 @@
>  #define TMIO_STAT_CMD_BUSY      0x40000000
>  #define TMIO_STAT_ILL_ACCESS    0x80000000
>
> +#define TMIO_STATUS2_DAT0      BIT(7)
> +
>  #define        CLK_CTL_DIV_MASK        0xff
>  #define        CLK_CTL_SCLKEN          BIT(8)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
