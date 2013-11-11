From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 3/3] mmc: omap_hsmmc: Extend debugfs for SDIO IRQ, GPIO
 and pinmux.
Date: Mon, 11 Nov 2013 20:00:39 +0100
Message-ID: <CAOf5uw=DB-saAsKXQ12Mry8jC=PsbOkkzj8JQBjJxeJYrfHEeg@mail.gmail.com>
References: <5281287f.01d50e0a.1189.74ea@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <5281287f.01d50e0a.1189.74ea@mx.google.com>
Sender: linux-omap-owner@vger.kernel.org
To: afenkart@gmail.com
Cc: Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Balaji T K <balajitk@ti.com>, zonque@gmail.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-mmc@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi

On Mon, Nov 11, 2013 at 7:52 PM,  <afenkart@gmail.com> wrote:
> From: Andreas Fenkart <afenkart@gmail.com>
>
> Add SDIO IRQ entries to debugfs entry. Note that PSTATE shows current
> state of data lines, incl. SDIO IRQ pending
>
> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
> ---
>  drivers/mmc/host/omap_hsmmc.c |   22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e880b44..34e2ee0 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -81,6 +81,7 @@ static void apply_clk_hack(struct device *dev)
>  #define OMAP_HSMMC_RSP54       0x0118
>  #define OMAP_HSMMC_RSP76       0x011C
>  #define OMAP_HSMMC_DATA                0x0120
> +#define OMAP_HSMMC_PSTATE      0x0124
>  #define OMAP_HSMMC_HCTL                0x0128
>  #define OMAP_HSMMC_SYSCTL      0x012C
>  #define OMAP_HSMMC_STAT                0x0130
> @@ -1800,6 +1801,23 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
>  {
>         struct mmc_host *mmc = s->private;
>         struct omap_hsmmc_host *host = mmc_priv(mmc);
> +       unsigned long flags;
> +       bool suspended;
> +
> +       spin_lock_irqsave(&host->irq_lock, flags);

Why do you need a spin_lock_irqsave just to print out the status?

> +       seq_puts(s, "\n");
> +       seq_printf(s, "sdio irq\t%s\n", ((host->flags & HSMMC_SDIO_IRQ_ENABLED)
> +                                        ? "enabled" : "disabled"));
> +       suspended = host->dev->power.runtime_status != RPM_ACTIVE;
> +       if (host->flags & HSMMC_SWAKEUP_QUIRK) {
> +               seq_printf(s, "pinmux config\t%s\n", (suspended ?
> +                                                     "gpio" : "sdio"));
> +               if (suspended)
> +                       seq_printf(s, "sdio irq pin\t%s\n",
> +                                  gpio_get_value(mmc_slot(host).gpio_cirq) ?
> +                                  "high" : "low");
> +       }
> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>

Michael

>         if (host->suspended) {
>                 seq_printf(s, "host suspended, can't read registers\n");
> @@ -1807,9 +1825,11 @@ static int omap_hsmmc_regs_show(struct seq_file *s, void *data)
>         }
>
>         pm_runtime_get_sync(host->dev);
> -
> +       seq_puts(s, "\nregs:\n");
>         seq_printf(s, "CON:\t\t0x%08x\n",
>                         OMAP_HSMMC_READ(host->base, CON));
> +       seq_printf(s, "PSTATE:\t\t0x%08x\n",
> +                  OMAP_HSMMC_READ(host->base, PSTATE));
>         seq_printf(s, "HCTL:\t\t0x%08x\n",
>                         OMAP_HSMMC_READ(host->base, HCTL));
>         seq_printf(s, "SYSCTL:\t\t0x%08x\n",
> --
> 1.7.10.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
