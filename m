From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH v2 3/4] omap4 hsmmc: Register offset handling
Date: Mon, 20 Sep 2010 22:56:48 +0200
Message-ID: <4C97CA90.9030706@ti.com>
References: <33958.10.24.255.17.1284827654.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <33958.10.24.255.17.1284827654.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>
List-Id: linux-mmc@vger.kernel.org

Hi Kishore

On 9/18/2010 6:34 PM, Kadiyala, Kishore wrote:
> The offset handling implementation of omap4 mmc registers which
> was already present can't be reused once hwmod modifications are done
> for mmc driver.
> Since hwmod data file for OMAP4 is an auto generated the base
> address for MMC will remain same as OMAP3 and thus the offset deviation
> of registers should be updated in the hsmmc driver.

That explanation does not sound very accurate to me.
The fact that the hwmods are auto-generated has nothing to do with your 
offset problem. The real cause is due to the update of the IP to support 
the new PM programming model.
Because of that, and to keep a certain level of compatibility, the 
legacy registers were all shifted by 0x100 and the new one were added 
from offset 0 to 0x10.

Regards,
Benoit

> The omap-mmc platform data is updated with a register offset which
> will be updated and used in the driver accordingly.
>
> Signed-off-by: Kishore Kadiyala<kishore.kadiyala@ti.com>
> ---
>   arch/arm/mach-omap2/devices.c         |    8 +++-----
>   arch/arm/mach-omap2/hsmmc.c           |    4 ++++
>   arch/arm/plat-omap/include/plat/mmc.h |    3 +++
>   drivers/mmc/host/omap_hsmmc.c         |    2 +-
>   4 files changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
> index 2dbb265..bb7ec13 100644
> --- a/arch/arm/mach-omap2/devices.c
> +++ b/arch/arm/mach-omap2/devices.c
> @@ -745,13 +745,13 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
>   		case 3:
>   			if (!cpu_is_omap44xx())
>   				return;
> -			base = OMAP4_MMC4_BASE + OMAP4_MMC_REG_OFFSET;
> +			base = OMAP4_MMC4_BASE;
>   			irq = OMAP44XX_IRQ_MMC4;
>   			break;
>   		case 4:
>   			if (!cpu_is_omap44xx())
>   				return;
> -			base = OMAP4_MMC5_BASE + OMAP4_MMC_REG_OFFSET;
> +			base = OMAP4_MMC5_BASE;
>   			irq = OMAP44XX_IRQ_MMC5;
>   			break;
>   		default:
> @@ -762,10 +762,8 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
>   			size = OMAP2420_MMC_SIZE;
>   			name = "mmci-omap";
>   		} else if (cpu_is_omap44xx()) {
> -			if (i<  3) {
> -				base += OMAP4_MMC_REG_OFFSET;
> +			if (i<  3)
>   				irq += OMAP44XX_IRQ_GIC_START;
> -			}
>   			size = OMAP4_HSMMC_SIZE;
>   			name = "mmci-omap-hs";
>   		} else {
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index c8f647b..49d76a7 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -261,6 +261,10 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>   		mmc->slots[0].wires = c->wires;
>   		mmc->slots[0].internal_clock = !c->ext_clock;
>   		mmc->dma_mask = 0xffffffff;
> +		if (cpu_is_omap44xx())
> +			mmc->reg_offset = OMAP4_MMC_REG_OFFSET;
> +		else
> +			mmc->reg_offset = 0;
>
>   		mmc->get_context_loss_count = hsmmc_get_context_loss;
>
> diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
> index 9b89ec6..4e6ef07 100644
> --- a/arch/arm/plat-omap/include/plat/mmc.h
> +++ b/arch/arm/plat-omap/include/plat/mmc.h
> @@ -71,6 +71,9 @@ struct omap_mmc_platform_data {
>
>   	u64 dma_mask;
>
> +	/* Register offset deviation */
> +	u16 reg_offset;
> +
>   	struct omap_mmc_slot_data {
>
>   		/* 4 wire signaling is optional, and is used for SD/SDIO/HSMMC;
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index a51894d..bfca9ca 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2034,7 +2034,7 @@ static int __init omap_hsmmc_probe(struct platform_device *pdev)
>   	host->irq	= irq;
>   	host->id	= pdev->id;
>   	host->slot_id	= 0;
> -	host->mapbase	= res->start;
> +	host->mapbase	= res->start + pdata->reg_offset;
>   	host->base	= ioremap(host->mapbase, SZ_4K);
>   	host->power_mode = MMC_POWER_OFF;
>

