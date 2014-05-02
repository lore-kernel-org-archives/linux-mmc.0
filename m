From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH 9/9] mmc: omap_hsmmc: enable wakeup event for sdio
Date: Fri, 2 May 2014 21:03:21 +0530
Message-ID: <5363BAC1.2040201@ti.com>
References: <1395404448-30030-2-git-send-email-afenkart@gmail.com> <1395418658-2375-1-git-send-email-balajitk@ti.com> <1395418658-2375-10-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1395418658-2375-10-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, linux-omap@vger.kernel.org, Andreas Fenkart <afenkart@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Friday 21 March 2014 09:47 PM, Balaji T K wrote:
> To detect sdio irqs properly without spurious events,
> OMAP4 needs IWE in CON and CTPL, CLKEXTFREE in HCTL to be set
>
> Signed-off-by: Balaji T K <balajitk@ti.com>
Hi Andreas,

Can you please test this patch on top of your current(v10) series
and confirm that there are no regression due to this
additional programming on your am335x platform.

Thanks and Regards,
Balaji T K
> ---
>   drivers/mmc/host/omap_hsmmc.c |   13 ++++++++++++-
>   1 files changed, 12 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 2482783..120f7cf 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -94,7 +94,10 @@
>   #define BCE			(1 << 1)
>   #define FOUR_BIT		(1 << 1)
>   #define HSPE			(1 << 2)
> +#define IWE			(1 << 24)
>   #define DDR			(1 << 19)
> +#define CLKEXTFREE		(1 << 16)
> +#define CTPL			(1 << 11)
>   #define DW8			(1 << 5)
>   #define OD			0x1
>   #define STAT_CLEAR		0xFFFFFFFF
> @@ -732,6 +735,8 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
>   		capa = VS18;
>   	}
>
> +	if (host->mmc->caps & MMC_CAP_SDIO_IRQ)
> +		hctl |= IWE;
>   	OMAP_HSMMC_WRITE(host->base, HCTL,
>   			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
>
> @@ -1728,7 +1733,7 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
>   static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>   {
>   	struct omap_hsmmc_host *host = mmc_priv(mmc);
> -	u32 irq_mask;
> +	u32 irq_mask, con;
>   	unsigned long flags;
>
>   	if (enable)
> @@ -1737,14 +1742,18 @@ static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
>   	if (host->flags & HSMMC_RUNTIME_SUSPENDED)
>   		goto out;
>
> +	con = OMAP_HSMMC_READ(host->base, CON);
>   	irq_mask = OMAP_HSMMC_READ(host->base, ISE);
>   	if (enable) {
>   		host->flags |= HSMMC_SDIO_IRQ_ENABLED;
>   		irq_mask |= CIRQ_EN;
> +		con |= CTPL | CLKEXTFREE;
>   	} else {
>   		host->flags &= ~HSMMC_SDIO_IRQ_ENABLED;
>   		irq_mask &= ~CIRQ_EN;
> +		con &= ~(CTPL | CLKEXTFREE);
>   	}
> +	OMAP_HSMMC_WRITE(host->base, CON, con);
>   	OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
>
>   	/*
> @@ -1801,6 +1810,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_hsmmc_host *host)
>   		}
>   		host->flags |= HSMMC_SWAKEUP_QUIRK;
>   	}
> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			 OMAP_HSMMC_READ(host->base, HCTL) | IWE);
>
>   	return 0;
>   }
>

