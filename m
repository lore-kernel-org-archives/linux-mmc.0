From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/1] mmc: sunxi: Disable irq during pm_suspend
Date: Wed, 4 Jul 2018 12:50:42 +0200
Message-ID: <CAPDyKFo_fadfNbt8YMS3MMjaxjt1B54DtZJ+-LoH9y5JeRi5pQ@mail.gmail.com>
References: <1530685741-20604-1-git-send-email-stefan@olimex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530685741-20604-1-git-send-email-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Mavrodiev <stefan@olimex.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>, "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>
List-Id: linux-mmc@vger.kernel.org

+ Marc

On 4 July 2018 at 08:28, Stefan Mavrodiev <stefan@olimex.com> wrote:
> When mmc host controller enters suspend state, the clocks are
> disabled, but irqs are not. For some reason the irqchip emits
> false interrupts, which causes system lock loop.
>
> Debug log is:
>   ...
>   sunxi-mmc 1c11000.mmc: setting clk to 52000000, rounded 51200000
>   sunxi-mmc 1c11000.mmc: enabling the clock
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 6(80000146) arg 3210101 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   sunxi-mmc 1c11000.mmc: cmd 13(8000014d) arg 10000 ie 0x0000bbc6 len 0
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00000004 idi 00000000
>   mmc1: new DDR MMC card at address 0001
>   mmcblk1: mmc1:0001 AGND3R 14.6 GiB
>   mmcblk1boot0: mmc1:0001 AGND3R partition 1 4.00 MiB
>   mmcblk1boot1: mmc1:0001 AGND3R partition 2 4.00 MiB
>   sunxi-mmc 1c11000.mmc: cmd 18(80003352) arg 0 ie 0x0000fbc2 len 409
>   sunxi-mmc 1c11000.mmc: irq: rq (ptrval) mi 00004000 idi 00000002
>    mmcblk1: p1
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
>   sunxi-mmc 1c11000.mmc: irq: rq   (null) mi 00000000 idi 00000000
> and so on...
>
> This issue apears on eMMC cards, routed on MMC2 slot. The patch is
> tested with A20-OLinuXino-MICRO/LIME/LIME2 boards.
>
> Fixes: 9a8e1e8cc2c0 ("mmc: sunxi: Add runtime_pm support")
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  Changes in v2:
>   - Add comment why disable_irq() is necessary
>
> ---
>  drivers/mmc/host/sunxi-mmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> index e747259..8e7f3e3 100644
> --- a/drivers/mmc/host/sunxi-mmc.c
> +++ b/drivers/mmc/host/sunxi-mmc.c
> @@ -1446,6 +1446,7 @@ static int sunxi_mmc_runtime_resume(struct device *dev)
>         sunxi_mmc_init_host(host);
>         sunxi_mmc_set_bus_width(host, mmc->ios.bus_width);
>         sunxi_mmc_set_clk(host, &mmc->ios);
> +       enable_irq(host->irq);
>
>         return 0;
>  }
> @@ -1455,6 +1456,12 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
>         struct mmc_host *mmc = dev_get_drvdata(dev);
>         struct sunxi_mmc_host *host = mmc_priv(mmc);
>
> +       /*
> +        * When clocks are off, it's possible receiving
> +        * fake interrupts, which will stall the system.
> +        * Disabling the irq  will prevent this.
> +        */
> +       disable_irq(host->irq);

No, this doesn't work for shared IRQs.

>         sunxi_mmc_reset_host(host);
>         sunxi_mmc_disable(host);
>
> --
> 2.7.4
>

The only option today is to use free_irq() in runtime suspend and then
re-request the irq to re-install the handler at runtime resume.

That's not an optimal solution, which is pointed out in the below
discussion as well. Moreover, it has also turned out using free_irq()
is also problematic in cases threaded handlers are used.

Here's the link to the discussion, it's not the only one I know of, so
this is common problem.
https://lkml.org/lkml/2016/1/28/213

Care to have a hack on the "common" solution, which in principle means
adding APIs to genirq that can disable/enable handlers from being
called, rather than the entire IRQ line.

Kind regards
Uffe
