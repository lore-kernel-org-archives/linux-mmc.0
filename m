From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/6] mmc: dw_mmc: remove the deprecated
 "clock-freq-min-max" property
Date: Thu, 15 Mar 2018 11:22:36 +0100
Message-ID: <CAPDyKFp2TCBfBvA53+UTJYYRrn2x_Szwb92x_2ahHhOKWdvntw@mail.gmail.com>
References: <CGME20180223064140epcas2p104fe6cca431ec24f2b09a6f5a45ed342@epcas2p1.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180223064138.18401-1-jh80.chung@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org, Will Deacon <will.deacon@arm.com>, Wei Xu <xuwei5@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org

On 23 February 2018 at 07:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 'clock-freq-min-max' property had already deprecated.
> Remove the 'clock-freq-min-max' property that is kept to maintain
> the compatibility.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  .../devicetree/bindings/mmc/synopsys-dw-mshc.txt          |  4 ----
>  drivers/mmc/host/dw_mmc.c                                 | 15 ++++-----------
>  2 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index ef3e5f14067a..75c9fdca4aaf 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -59,10 +59,6 @@ Optional properties:
>    is specified and the ciu clock is specified then we'll try to set the ciu
>    clock to this at probe time.
>
> -* clock-freq-min-max (DEPRECATED): Minimum and Maximum clock frequency for card output
> -  clock(cclk_out). If it's not specified, max is 200MHZ and min is 400KHz by default.
> -         (Use the "max-frequency" instead of "clock-freq-min-max".)
> -
>  * num-slots (DEPRECATED): specifies the number of slots supported by the controller.
>    The number of physical slots actually used could be equal or less than the
>    value specified by num-slots. If this property is not specified, the value
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0aa39975f33b..38e0e7c4ffd9 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2784,7 +2784,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
>         struct dw_mci_slot *slot;
>         const struct dw_mci_drv_data *drv_data = host->drv_data;
>         int ctrl_id, ret;
> -       u32 freq[2];
>
>         mmc = mmc_alloc_host(sizeof(struct dw_mci_slot), host->dev);
>         if (!mmc)
> @@ -2798,16 +2797,6 @@ static int dw_mci_init_slot(struct dw_mci *host)
>         host->slot = slot;
>
>         mmc->ops = &dw_mci_ops;
> -       if (device_property_read_u32_array(host->dev, "clock-freq-min-max",
> -                                          freq, 2)) {
> -               mmc->f_min = DW_MCI_FREQ_MIN;
> -               mmc->f_max = DW_MCI_FREQ_MAX;
> -       } else {
> -               dev_info(host->dev,
> -                       "'clock-freq-min-max' property was deprecated.\n");
> -               mmc->f_min = freq[0];
> -               mmc->f_max = freq[1];
> -       }
>
>         /*if there are external regulators, get them*/
>         ret = mmc_regulator_get_supply(mmc);
> @@ -2846,6 +2835,10 @@ static int dw_mci_init_slot(struct dw_mci *host)
>         if (ret)
>                 goto err_host_allocated;
>
> +       mmc->f_min = DW_MCI_FREQ_MIN;
> +       if (!mmc->f_max)
> +               mmc->f_max = DW_MCI_FREQ_MAX;
> +
>         /* Process SDIO IRQs through the sdio_irq_work. */
>         if (mmc->caps & MMC_CAP_SDIO_IRQ)
>                 mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
> --
> 2.15.1
>
