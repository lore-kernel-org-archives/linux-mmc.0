From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC]  sdhci: 8 bit bus width changes
Date: Sat, 20 Nov 2010 08:37:47 -0800
Message-ID: <6A786561-31A9-4D58-A3E3-AF366AD139F2@marvell.com>
References: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com>
 <20101119214002.GA19272@void.printf.net>
 <20101119215333.GB19272@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:49987 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754187Ab0KTQj3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 20 Nov 2010 11:39:29 -0500
In-Reply-To: <20101119215333.GB19272@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


code is fine.

On Nov 19, 2010, at 1:53 PM, Chris Ball wrote:

> On Fri, Nov 19, 2010 at 09:40:02PM +0000, Chris Ball wrote:
>> I don't see why we should re-read ctrl here, since we've already written
>> it back to the device at this point, and we don't use it anywhere below
>> this line.
> 
> Ah, I see why now; please ignore this. 
> 
> Here's a rebased version of the patch, with some more comments:
> 
> From: Philip Rakity <prakity@marvell.com>
> Date: Fri, 19 Nov 2010 16:48:39 -0500
> Subject: [PATCH] mmc: sdhci: 8-bit bus width changes
> 
> We now:
> * check for a v3 controller before setting 8-bit bus width
> * offer a callback for platform code to switch to 8-bit mode, which
>   allows non-v3 controllers to support it
> * introduce a quirk to specify that the board designers have indeed
>   brought out all the pins for 8-bit to the slot.
> 
> We were previously relying only on whether the controller supported
> 8-bit, which doesn't tell us anything about the pin configuration in
> the board design.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Chris Ball <cjb@laptop.org>
> ---
> drivers/mmc/host/sdhci.c  |   48 +++++++++++++++++++++++++++++++++-----------
> drivers/mmc/host/sdhci.h  |    5 +++-
> include/linux/mmc/sdhci.h |    2 +
> 3 files changed, 42 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 154cbf8..f1f9658 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1185,17 +1185,31 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 	if (host->ops->platform_send_init_74_clocks)
> 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
> 
> -	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> -
> -	if (ios->bus_width == MMC_BUS_WIDTH_8)
> -		ctrl |= SDHCI_CTRL_8BITBUS;
> -	else
> -		ctrl &= ~SDHCI_CTRL_8BITBUS;
> +	/*
> +	 * If your platform has 8-bit width support but is not a v3 controller,
> +	 * or if it requires special setup code, you should implement that in
> +	 * platform_8bit_width().
> +	 */
> +	if (host->ops->platform_8bit_width)
> +		host->ops->platform_8bit_width(host, ios->bus_width);
> +	else {
> +		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> +		if (ios->bus_width == MMC_BUS_WIDTH_8) {
> +			ctrl &= ~SDHCI_CTRL_4BITBUS;
> +			if (host->version >= SDHCI_SPEC_300)
> +				ctrl |= SDHCI_CTRL_8BITBUS;
> +		} else {
> +			if (host->version >= SDHCI_SPEC_300)
> +				ctrl &= ~SDHCI_CTRL_8BITBUS;
> +			if (ios->bus_width == MMC_BUS_WIDTH_4)
> +				ctrl |= SDHCI_CTRL_4BITBUS;
> +			else
> +				ctrl &= ~SDHCI_CTRL_4BITBUS;
> +		}
> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> +	}
> 
> -	if (ios->bus_width == MMC_BUS_WIDTH_4)
> -		ctrl |= SDHCI_CTRL_4BITBUS;
> -	else
> -		ctrl &= ~SDHCI_CTRL_4BITBUS;
> +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> 
> 	if ((ios->timing == MMC_TIMING_SD_HS ||
> 	     ios->timing == MMC_TIMING_MMC_HS)
> @@ -1855,11 +1869,21 @@ int sdhci_add_host(struct sdhci_host *host)
> 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
> 	else
> 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
> +
> 	mmc->f_max = host->max_clk;
> 	mmc->caps |= MMC_CAP_SDIO_IRQ;
> 
> -	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
> -		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> +	/*
> +	 * A controller may support 8-bit width, but the board itself
> +	 * might not have the pins brought out.  So, boards that support
> +	 * 8-bit width should set the below quirk, and we won't assume
> +	 * that devices without the quirk can use 8-bit width.
> +	 */
> +	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA)) {
> +		mmc->caps |= MMC_CAP_4_BIT_DATA;
> +		if (host->quirks & SDHCI_QUIRK_SLOT_CAN_DO_8_BITS)
> +			mmc->caps |= MMC_CAP_8_BIT_DATA;
> +	}
> 
> 	if (caps & SDHCI_CAN_DO_HISPD)
> 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index d52a716..e42d7f0 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -76,7 +76,7 @@
> #define   SDHCI_CTRL_ADMA1	0x08
> #define   SDHCI_CTRL_ADMA32	0x10
> #define   SDHCI_CTRL_ADMA64	0x18
> -#define  SDHCI_CTRL_8BITBUS	0x20
> +#define   SDHCI_CTRL_8BITBUS	0x20
> 
> #define SDHCI_POWER_CONTROL	0x29
> #define  SDHCI_POWER_ON		0x01
> @@ -155,6 +155,7 @@
> #define  SDHCI_CLOCK_BASE_SHIFT	8
> #define  SDHCI_MAX_BLOCK_MASK	0x00030000
> #define  SDHCI_MAX_BLOCK_SHIFT  16
> +#define  SDHCI_CAN_DO_8BIT	0x00040000
> #define  SDHCI_CAN_DO_ADMA2	0x00080000
> #define  SDHCI_CAN_DO_ADMA1	0x00100000
> #define  SDHCI_CAN_DO_HISPD	0x00200000
> @@ -215,6 +216,8 @@ struct sdhci_ops {
> 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
> 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
> 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
> +	int		(*platform_8bit_width)(struct sdhci_host *host,
> +					       int width);
> 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
> 					     u8 power_mode);
> 	unsigned int    (*get_ro)(struct sdhci_host *host);
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 1fdc673..7fdcfca 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -83,6 +83,8 @@ struct sdhci_host {
> #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
> /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
> #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
> +/* Slot has 8 data pins going to eMMC/MMC card */
> +#define SDHCI_QUIRK_SLOT_CAN_DO_8_BITS			(1<<30)
> 
> 	int irq;		/* Device IRQ */
> 	void __iomem *ioaddr;	/* Mapped address */
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

