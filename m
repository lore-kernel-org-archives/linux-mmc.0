From: Philip Rakity <prakity@marvell.com>
Subject: Re: [patch]: sdhci support emmc ddr50 mode [v3]
Date: Tue, 21 Dec 2010 21:09:06 -0800
Message-ID: <0A929BFA-55C4-45DF-A11D-2BC8B2B0BCEF@marvell.com>
References: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:45021 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750740Ab0LVFNU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Dec 2010 00:13:20 -0500
In-Reply-To: <AANLkTinbp0i5WmNp5VnfTChDmy2c0gF5_G9YMAHbeGvo@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>, Zhangfei Gao <zgao6@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>


Resend as plain test -- with additional comments.
On Dec 21, 2010, at 4:37 AM, zhangfei gao wrote:

> v3: sync to mmc-next
> 
> Emmc speed could double if using ddr50 mode, help check
> 
> From 895c3d15a200d5f5803f992dab46ff114ad26f90 Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Tue, 21 Dec 2010 19:51:38 -0500
> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
> 
> 	1. spec sdhc 3.0 does not claim support 1.2v ddr mode
> 	2. Call back function set_power is added, since some controller count
> on external pmic to provide power
> 	3. According to spec sdhc 3.0, uhs mode, including emmc ddr50 takes
> effect only when 1.8v Signaling Enable bit, which used for providing
> 1.8v.
> 	   So emmc ddr50 mode works after 1.8v switching process, though emmc
> ddr50 could work at high voltage such as 3.3v if external pmic provide
> voltage.
> 	   Limitation: emmc ddr50 mode only workable when both host and emmc
> card support 1.70-1.90v


signaling voltage is not the same as card voltage.  card voltage can be 3.3v and
signaling voltage 1.8v.  

> 	4. According to JESD84, power down and power up is required to
> provide low voltage 1.70-1.90v to mmc.
> 
> 	Verified: toshiba emmc on mmp2, with io voltage at 1.8v provided by
> external pmic.
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> drivers/mmc/core/core.c  |   13 +++++++++++++
> drivers/mmc/core/core.h  |    1 +
> drivers/mmc/core/mmc.c   |    6 +++++-
> drivers/mmc/host/sdhci.c |   44 +++++++++++++++++++++++++++++++++++++++++---
> drivers/mmc/host/sdhci.h |   14 +++++++++++++-
> 5 files changed, 73 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index a8e89f3..fd657f1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1012,6 +1012,19 @@ static void mmc_power_off(struct mmc_host *host)
> }
> 
> /*
> + * mmc select low voltage 1.70-1.95v
> + */
> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr)
> +{
> +	if (!(ocr & MMC_VDD_165_195))
> +		return;
> +
> +	mmc_power_off(host);
> +	host->ocr = ocr & host->ocr_avail;
> +	mmc_power_up(host);
> +}
> +
> +/*
>  * Cleanup when the last reference to the bus operator is dropped.
>  */
> static void __mmc_release_bus(struct mmc_host *host)
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 026c975..b05c20a 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -41,6 +41,7 @@ void mmc_set_bus_width(struct mmc_host *host,
> unsigned int width);
> void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
> 			   unsigned int ddr);
> u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
> +void mmc_select_low_voltage(struct mmc_host *host, u32 ocr);
> void mmc_set_timing(struct mmc_host *host, unsigned int timing);
> 
> static inline void mmc_delay(unsigned int ms)
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 86cac0d..8779339 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -790,7 +790,11 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr)
> 		ocr &= ~0x7F;
> 	}
> 
> -	host->ocr = mmc_select_voltage(host, ocr);
> +	if ((ocr & MMC_VDD_165_195)
> +			&& (host->ocr_avail & MMC_VDD_165_195))
> +		mmc_select_low_voltage(host, ocr);
> +	else
> +		host->ocr = mmc_select_voltage(host, ocr);
> 

The patch for dual voltage cards should be a separate patch.  It is independent of
support for dual data rate.

> 	/*
> 	 * Can we support the voltage of the card?
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index d5febe5..aafbb42 100644
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
> @@ -1084,6 +1100,18 @@ static void sdhci_set_power(struct sdhci_host
> *host, unsigned short power)
> 		return;
> 	}
> 
> +	if ((pwr == SDHCI_POWER_180) &&
> +		(host->mmc->caps & MMC_CAP_1_8V_DDR)) {
> +		u16 con;
> +
> +		con = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +		con |= SDHCI_CTRL2_1_8V;
> +		sdhci_writew(host, con, SDHCI_HOST_CONTROL2);
> +
> +		if (host->ops->set_power)
> +			host->ops->set_power(host, pwr);
> +	}
> +

power to the card can be at 3.3v and signaling at 1.8v.  This is a legal combination.
The
> +	if ((pwr == SDHCI_POWER_180) &&
> +		(host->mmc->caps & MMC_CAP_1_8V_DDR)) {
should be reworked.

> 	/*
> 	 * Spec says that we should clear the power reg before setting
> 	 * a new value. Some controllers don't seem to like this though.
> @@ -1180,6 +1208,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios)
> 	}
> 
> 	sdhci_set_clock(host, ios->clock);
> +	sdhci_set_ddr(host, ios->ddr);
> 
> 	if (ios->power_mode == MMC_POWER_OFF)
> 		sdhci_set_power(host, -1);
> @@ -1744,7 +1773,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> int sdhci_add_host(struct sdhci_host *host)
> {
> 	struct mmc_host *mmc;
> -	unsigned int caps, ocr_avail;
> +	unsigned int caps, caps_h = 0, ocr_avail;
> 	int ret;
> 
> 	WARN_ON(host == NULL);
> @@ -1767,8 +1796,17 @@ int sdhci_add_host(struct sdhci_host *host)
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
> 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> 		host->flags |= SDHCI_USE_SDMA;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 6e0969e..c4bd5dd 100644
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
> +	unsigned int    (*set_power)(struct sdhci_host *host,
> +				unsigned short power);
> };
> 
> #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> -- 
> 1.7.0.4
> <0001-mmc-sdhci-support-emmc-ddr50-mode.patch>

