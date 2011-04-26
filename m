From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] mmc:  Add support for eMMC Dual Data Rate
Date: Tue, 26 Apr 2011 02:04:17 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EB72D382@SAUSEXMBP01.amd.com>
References: <7E008078-5B62-4418-857B-DBFF1E70E6D3@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:48304
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757059Ab1DZHE1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Apr 2011 03:04:27 -0400
In-Reply-To: <7E008078-5B62-4418-857B-DBFF1E70E6D3@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Saturday, April 23, 2011 1:57 AM
> To: linux-mmc@vger.kernel.org
> Cc: Nath, Arindam
> Subject: [PATCH] mmc: Add support for eMMC Dual Data Rate
> 
> 
> eMMC voltage change not required for 1.8V.  3.3V and 1.8V vcc
> are capable of doing DDR. vccq of 1.8v is not required.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/core/core.c  |   14 ++------------
>  drivers/mmc/core/core.h  |    2 --
>  drivers/mmc/core/mmc.c   |   33 ++++++++++++++++++++++++++++-----
>  include/linux/mmc/host.h |    1 +
>  4 files changed, 31 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 91ab31f..69df00c 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -720,22 +720,12 @@ void mmc_set_bus_mode(struct mmc_host *host,
> unsigned int mode)
>  }
> 
>  /*
> - * Change data bus width and DDR mode of a host.
> - */
> -void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
> -			   unsigned int ddr)
> -{
> -	host->ios.bus_width = width;
> -	host->ios.ddr = ddr;
> -	mmc_set_ios(host);
> -}
> -
> -/*
>   * Change data bus width of a host.
>   */
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width)
>  {
> -	mmc_set_bus_width_ddr(host, width, MMC_SDR_MODE);
> +	host->ios.bus_width = width;
> +	mmc_set_ios(host);
>  }
> 
>  /**
> diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
> index 6114ca5..c5d0e8b 100644
> --- a/drivers/mmc/core/core.h
> +++ b/drivers/mmc/core/core.h
> @@ -38,8 +38,6 @@ void mmc_ungate_clock(struct mmc_host *host);
>  void mmc_set_ungated(struct mmc_host *host);
>  void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
>  void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
> -void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
> -			   unsigned int ddr);
>  u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
>  void mmc_set_timing(struct mmc_host *host, unsigned int timing);
>  void mmc_set_driver_type(struct mmc_host *host, unsigned int
> drv_type);
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index ba1c878..f4b675b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -20,6 +20,7 @@
>  #include "core.h"
>  #include "bus.h"
>  #include "mmc_ops.h"
> +#include "sd_ops.h"
> 
>  static const unsigned int tran_exp[] = {
>  	10000,		100000,		1000000,	10000000,
> @@ -633,10 +634,12 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  	 */
>  	if (mmc_card_highspeed(card)) {
>  		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
> -			&& (host->caps & (MMC_CAP_1_8V_DDR)))
> +			&& ((host->caps & (MMC_CAP_1_8V_DDR |
> MMC_CAP_UHS_DDR50))
> +				== (MMC_CAP_1_8V_DDR | MMC_CAP_UHS_DDR50)))
>  				ddr = MMC_1_8V_DDR_MODE;
>  		else if ((card->ext_csd.card_type &
> EXT_CSD_CARD_TYPE_DDR_1_2V)
> -			&& (host->caps & (MMC_CAP_1_2V_DDR)))
> +			&& ((host->caps & (MMC_CAP_1_2V_DDR |
> MMC_CAP_UHS_DDR50))
> +				== (MMC_CAP_1_2V_DDR | MMC_CAP_UHS_DDR50)))
>  				ddr = MMC_1_2V_DDR_MODE;
>  	}
> 
> @@ -670,8 +673,7 @@ static int mmc_init_card(struct mmc_host *host, u32
> ocr,
>  					 ext_csd_bits[idx][0],
>  					 0);
>  			if (!err) {
> -				mmc_set_bus_width_ddr(card->host,
> -						      bus_width, MMC_SDR_MODE);
> +				mmc_set_bus_width(card->host, bus_width);
>  				/*
>  				 * If controller can't handle bus width test,
>  				 * use the highest bus width to maintain
> @@ -697,8 +699,29 @@ static int mmc_init_card(struct mmc_host *host,
> u32 ocr,
>  				1 << bus_width, ddr);
>  			goto free_card;
>  		} else if (ddr) {
> +			/*
> +			 * eMMC cards can support 3.3V to 1.2V i/o (vccq)
> +			 * signaling.
> +			 *
> +			 * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V
> vccq.
> +			 *
> +			 * 1.8V vccq at 3.3V core voltage (vcc) is not
> required
> +			 * in the JEDEC spec for DDR.
> +			 *
> +			 * Do not force change in vccq since we are obviously
> +			 * working and no change to vccq is needed.
> +			 *
> +			 * WARNING: eMMC rules are NOT the same as SD DDR
> +			 */
> +			if (ddr == EXT_CSD_CARD_TYPE_DDR_1_2V) {
> +				err = mmc_set_signal_voltage(host,
> +					MMC_SIGNAL_VOLTAGE_120, 0);

Will this call really have any effect? *cmd11* argument is 0, so CMD11 won't be sent in this case. Also since there is no handler in my sdhci_start_signal_voltage_switch() for MMC_SIGNAL_VOLTAGE_120, the function will simply return 0.

Thanks,
Arindam


