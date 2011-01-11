From: Philip Rakity <prakity@marvell.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v4]
Date: Mon, 10 Jan 2011 16:06:02 -0800
Message-ID: <5207861A-5CC3-4F04-A429-35ED564E86C1@marvell.com>
References: <AANLkTi=EP1dJEEHa49N26s0Hfsq_fie69aqTtNAqbvzZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:47056 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752823Ab1AKAGI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 10 Jan 2011 19:06:08 -0500
In-Reply-To: <AANLkTi=EP1dJEEHa49N26s0Hfsq_fie69aqTtNAqbvzZ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Mark Brown <markb@marvell.com>


On Jan 9, 2011, at 3:50 AM, zhangfei gao wrote:

> From d65af1e0a51bd4cc6b7a55b48df2bc23ccb84f2d Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Sun, 9 Jan 2011 18:09:12 -0500
> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
> 
> 	1. spec sdhc 3.0 does not claim support 1.2v ddr mode
> 	2. Call back function set_uhs is added, since some controller count
> on external pmic to provide io voltage
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> drivers/mmc/core/core.c  |   17 ++++++++++++
> drivers/mmc/core/core.h  |    1 +
> drivers/mmc/core/mmc.c   |    5 +++
> drivers/mmc/host/sdhci.c |   62 +++++++++++++++++++++++++++++++++++++++++++--
> drivers/mmc/host/sdhci.h |   14 +++++++++-
> include/linux/mmc/host.h |    2 +
> 6 files changed, 97 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a8e89f3..964b44f 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -623,6 +623,23 @@ static inline void mmc_set_ios(struct mmc_host *host)
> 	host->ops->set_ios(host, ios);
> }
> 
> +int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode)
> +{
> +	int ret = -EINVAL;
> +
> +	if (host->ops->set_uhs) {
> +		ret = host->ops->set_uhs(host, uhs_mode);
> +
> +		/*
> +		 * According to sdhc standard spec v3.0
> +		 * 1.8v regulator should be stable withing 5ms
> +		 */
> +		mmc_delay(5);

The delay should be set in set_uhs IHMO

> +	}
> +
> +	return ret;
> +}
> +
> /*
>  * Control chip select pin on a host.
>  */
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 026c975..4b1ea7e 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
> unsigned int width);
> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
> 			   unsigned int ddr);
> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> +int mmc_set_uhs(struct mmc_host *host, unsigned int uhs_mode);
> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> 
> static inline void mmc_delay(unsigned int ms)
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 86cac0d..4dac82f 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -529,6 +529,11 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
> 				ddr = MMC_1_2V_DDR_MODE;
> 	}
> 
> +	if (ddr) {
> +		if (mmc_set_uhs(host, ddr))
> +			ddr = MMC_SDR_MODE;
> +	}
> +


This code is setting 1.8v signaling on the host controller before the switch command to ask the card to go to DDR mode and use 1.8v signalling.
Is this valid before the card has moved into that state ?

> 	/*
> 	 * Activate wide bus and DDR (if supported).
> 	 */
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d5febe5..906f85b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -986,6 +986,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
> 	host->cmd = NULL;
> }
> 
> +static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
> +{
> +	u16 con;
> +
> +	if (ddr == MMC_SDR_MODE)
> +		return;
> +
> +	con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	if (con & SDHCI_CTRL2_1_8V) {
> +		con &= ~SDHCI_CTRL2_UHS_MASK;
> +		if (ddr & MMC_1_8V_DDR_MODE)
> +			con |= SDHCI_CTRL2_DDR50;
> +		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
> +	}
> +}
> +
> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> {
> 	int div;
> @@ -1180,6 +1196,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios)
> 	}
> 
> 	sdhci_set_clock(host, ios->clock);
> +	sdhci_set_ddr(host, ios->ddr);
> 
> 	if (ios->power_mode == MMC_POWER_OFF)
> 		sdhci_set_power(host, -1);
> @@ -1237,6 +1254,35 @@ out:
> 	spin_unlock_irqrestore(&host->lock, flags);
> }
> 
> +static int sdhci_set_uhs(struct mmc_host *mmc, unsigned int uhs_mode)
> +{
> +	struct sdhci_host *host;
> +	unsigned long flags;
> +	int ret = 0;
> +
> +	host = mmc_priv(mmc);
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +	if (host->mmc->caps & MMC_CAP_1_8V_DDR) {

since only 1_8V is supported is the if check necessary.    Failure would imply the core layer was broken.

> +		u16 con;
> +
> +		con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		con |= SDHCI_CTRL2_1_8V;
> +		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
> +	} else
> +		goto err;
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	if (host->ops->set_uhs)
> +		ret = host->ops->set_uhs(host, uhs_mode);
> +
> +	return ret;
> +err:
> +	spin_unlock_irqrestore(&host->lock, flags);
> +	return  -EINVAL;
> +}
> +
> static int sdhci_get_ro(struct mmc_host *mmc)
> {
> 	struct sdhci_host *host;
> @@ -1287,6 +1333,7 @@ out:
> static const struct mmc_host_ops sdhci_ops = {
> 	.request	= sdhci_request,
> 	.set_ios	= sdhci_set_ios,
> +	.set_uhs	= sdhci_set_uhs,
> 	.get_ro		= sdhci_get_ro,
> 	.enable_sdio_irq = sdhci_enable_sdio_irq,
> };
> @@ -1744,7 +1791,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> int sdhci_add_host(struct sdhci_host *host)
> {
> 	struct mmc_host *mmc;
> -	unsigned int caps, ocr_avail;
> +	unsigned int caps, caps_h = 0, ocr_avail;
> 	int ret;
> 
> 	WARN_ON(host == NULL);
> @@ -1767,8 +1814,17 @@ int sdhci_add_host(struct sdhci_host *host)
> 			host->version);
> 	}
> 
> -	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
> -		sdhci_readl(host, SDHCI_CAPABILITIES);
> +	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
> +		caps = host->caps;
> +	else {
> +		caps = sdhci_readl(host, SDHCI_CAPABILITIES);
> +		caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_1);
> +	}
> +
> +	if (caps & SDHCI_CAN_VDD_180) {
> +		if (caps_h & SDHCI_CAN_SDR50)
> +			mmc->caps |= (MMC_CAP_1_8V_DDR);
> +	}
> 

SDHCI_CAN_ DDR50 -  wrong bit being checked.
missing check for SD 3.0 Controller -- see my patch
see chris comments on the name caps_h

> 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> 		host->flags |= SDHCI_USE_SDMA;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6e0969e..f8e94b9 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -145,7 +145,14 @@
> 
> #define SDHCI_ACMD12_ERR	0x3C
> 
> -/* 3E-3F reserved */
> +#define SDHCI_HOST_CONTROL2	0x3E
> +#define  SDHCI_CTRL2_UHS_MASK	0x0007
> +#define   SDHCI_CTRL2_SDR12	0x0000
> +#define   SDHCI_CTRL2_SDR25	0x0001
> +#define   SDHCI_CTRL2_SDR50	0x0002
> +#define   SDHCI_CTRL2_SDR104	0x0003
> +#define   SDHCI_CTRL2_DDR50	0x0004
> +#define  SDHCI_CTRL2_1_8V	0x0008
> 
> #define SDHCI_CAPABILITIES	0x40
> #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
> @@ -167,6 +174,9 @@
> #define  SDHCI_CAN_64BIT	0x10000000
> 
> #define SDHCI_CAPABILITIES_1	0x44
> +#define  SDHCI_CAN_SDR50	0x00000001
> +#define  SDHCI_CAN_SDR104	0x00000002
> +#define  SDHCI_CAN_DDR50	0x00000004
> 
> #define SDHCI_MAX_CURRENT	0x48
> 
> @@ -222,6 +232,8 @@ struct sdhci_ops {
> 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
> 					     u8 power_mode);
> 	unsigned int    (*get_ro)(struct sdhci_host *host);
> +	unsigned int    (*set_uhs)(struct sdhci_host *host,
> +				unsigned int uhs_mode);
> };
> 
> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index bcb793e..07131b0 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -117,6 +117,8 @@ struct mmc_host_ops {
> 
> 	/* optional callback for HC quirks */
> 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
> +
> +	int	(*set_uhs)(struct mmc_host *host, unsigned int uhs_mode);
> };
> 
> struct mmc_card;
> -- 
> 1.7.0.4
> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>

