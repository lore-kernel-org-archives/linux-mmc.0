From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 1/1] sdhci support emmc ddr50 mode
Date: Mon, 6 Dec 2010 19:10:32 -0800
Message-ID: <E3E29FC5-7D18-4207-AF6B-6D61BD361F29@marvell.com>
References: <AANLkTiknFGMQczA-bcnDLv7K4ZpDOZgiG-iQNLDm+aNC@mail.gmail.com>
 <AANLkTikTHVORPN6U4qgEij=ig7zROERV_k+q-6RL-AYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:56163 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751905Ab0LGDPa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Dec 2010 22:15:30 -0500
In-Reply-To: <AANLkTikTHVORPN6U4qgEij=ig7zROERV_k+q-6RL-AYQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, Hanumath Prasad <hanumath.prasad@stericsson.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>


On Dec 6, 2010, at 4:15 AM, Zhangfei Gao wrote:

> From f2194b46c2c3ded86009d36a4a8b4eebb7d0b9eb Mon Sep 17 00:00:00 2001
> From: Zhangfei Gao <zhangfei.gao@marvell.com>
> Date: Fri, 3 Dec 2010 07:21:15 -0500
> Subject: [PATCH] mmc: sdhci support emmc ddr50 mode
> 
> 	1. spec 3.0 does not claim support 1.2v ddr mode
> 	2. Call back function set_power is added, since some controller count
> on external pmic to provide power
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
> ---
> drivers/mmc/core/core.c   |    8 ++++++++
> drivers/mmc/host/sdhci.c  |   36 +++++++++++++++++++++++++++++++++++-
> drivers/mmc/host/sdhci.h  |   14 ++++++++++++--
> include/linux/mmc/mmc.h   |    1 +
> include/linux/mmc/sdhci.h |    2 ++
> 5 files changed, 58 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 8bf542c..8f172cd 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -1573,6 +1573,14 @@ void mmc_rescan(struct work_struct *work)
> 		 */
> 		err = mmc_send_op_cond(host, 0, &ocr);
> 		if (!err) {
> +			if ((ocr & MMC_CARD_1_8V)
> +				&& (host->ocr_avail & MMC_CARD_1_8V)) {
> +				/* switch voltage to 1.8v */
> +				mmc_power_off(host);
> +				host->ocr = ocr & host->ocr_avail;
> +				mmc_power_up(host);
> +			}
> +

is the 1.2v case missing ? 

/*
 * Mask off any voltages we don't support and select
 * the lowest voltage
 */
u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)

Doesn't this code already handle the voltage correctly ?


> 			if (mmc_attach_mmc(host, ocr))
> 				mmc_power_off(host);
> 			goto out;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a25db42..b7ad2f6 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -982,6 +982,22 @@ static void sdhci_finish_command(struct sdhci_host *host)
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


The host controller should not enable the CAP if 1.8V is not supported.  DDR should not be 
invoked if CAP is not set.  Thus

> +	if (con & SDHCI_CTRL2_1_8V) {

and
> +		if (ddr & MMC_1_8V_DDR_MODE)

are not needed.

This code should move to driver specific function since tuning may be done on some systems and
some systems (not mmp2) may need to delay the 5ms for voltage to be stable.  Would prefer a
host->ops callback.

> static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> {
> 	int div;
> @@ -1080,6 +1096,17 @@ static void sdhci_set_power(struct sdhci_host
> *host, unsigned short power)
> 		return;
> 	}
> 
> +	if (pwr == SDHCI_POWER_180) {
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

This code should be moved to sdhci_set_ddr (aboe).  Not needed if voltage is 1.8v and card
is not running ddr.

> 	/*
> 	 * Spec says that we should clear the power reg before setting
> 	 * a new value. Some controllers don't seem to like this though.
> @@ -1176,6 +1203,7 @@ static void sdhci_set_ios(struct mmc_host *mmc,
> struct mmc_ios *ios)
> 	}
> 
> 	sdhci_set_clock(host, ios->clock);
> +	sdhci_set_ddr(host, ios->ddr);
> 
> 	if (ios->power_mode == MMC_POWER_OFF)
> 		sdhci_set_power(host, -1);
> @@ -1736,7 +1764,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> int sdhci_add_host(struct sdhci_host *host)
> {
> 	struct mmc_host *mmc;
> -	unsigned int caps;
> +	unsigned int caps, caps_h;
> 	int ret;
> 
> 	WARN_ON(host == NULL);
> @@ -1761,6 +1789,12 @@ int sdhci_add_host(struct sdhci_host *host)
> 
> 	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
> 		sdhci_readl(host, SDHCI_CAPABILITIES);
> +	caps_h = sdhci_readl(host, SDHCI_CAPABILITIES_H);
> +
> +	if (caps & SDHCI_CAN_VDD_180) {
> +		if (caps_h & SDHCI_CAN_SDR50)
> +			mmc->caps |= (MMC_CAP_1_8V_DDR);
> +	}
> 
> 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
> 		host->flags |= SDHCI_USE_SDMA;
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b689cc6..28c460a 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -144,7 +144,14 @@
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
> @@ -165,7 +172,10 @@
> #define  SDHCI_CAN_VDD_180	0x04000000
> #define  SDHCI_CAN_64BIT	0x10000000
> 
> -/* 44-47 reserved for more caps */
> +#define SDHCI_CAPABILITIES_H	0x44
> +#define  SDHCI_CAN_SDR50	0x00000001
> +#define  SDHCI_CAN_SDR104	0x00000002
> +#define  SDHCI_CAN_DDR50	0x00000004
> 
> #define SDHCI_MAX_CURRENT	0x48
> 
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 956fbd8..bd09b19 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -202,6 +202,7 @@ struct _mmc_csd {
>  * OCR bits are mostly in host.h
>  */
> #define MMC_CARD_BUSY	0x80000000	/* Card Power up status bit */
> +#define MMC_CARD_1_8V	0x00000080	/* Card 1.70-1.95V support bit */
> 
> /*
>  * Card Command Classes (CCC)
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 86e8380..57bcda9 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -163,6 +163,8 @@ struct sdhci_ops {
> 	void (*platform_send_init_74_clocks)(struct sdhci_host *host,
> 					     u8 power_mode);
> 	unsigned int    (*get_ro)(struct sdhci_host *host);
> +	unsigned int    (*set_power)(struct sdhci_host *host,
> +				unsigned short power);
> };
> 
> 
> -- 
> 1.7.0.4
> 
> Update the condition of voltage switch.
> +			if ((ocr & MMC_CARD_1_8V)
> +				&& (host->ocr_avail & MMC_CARD_1_8V)) {
> +				/* switch voltage to 1.8v */
> 
> Any comments are welcome.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

