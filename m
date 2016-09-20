From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 4/6] mmc: tmio: add eMMC support
Date: Tue, 20 Sep 2016 18:35:00 +0900
Message-ID: <e13ee5da-ad48-703a-5220-089f1f1ca0e0@samsung.com>
References: <20160919205750.4766-1-wsa+renesas@sang-engineering.com>
 <CGME20160919210038epcas1p1e9339bd774291e7131c270ca130056ab@epcas1p1.samsung.com>
 <20160919205750.4766-5-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-reply-to: <20160919205750.4766-5-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Dirk Behme <dirk.behme@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 09/20/2016 05:57 AM, Wolfram Sang wrote:
> We need to add R1 without CRC support, refactor the bus width routine a
> little and extend a quirk check. To support "non-removable;" we need a
> workaround which will be hopefully removed when reworking PM soon.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/mmc/host/tmio_mmc.h     |  3 +++
>  drivers/mmc/host/tmio_mmc_pio.c | 38 ++++++++++++++++++++++++++------------
>  2 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 4b501f2d529f6e..637581faf756b1 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -79,6 +79,9 @@
>  #define	CLK_CTL_DIV_MASK	0xff
>  #define	CLK_CTL_SCLKEN		BIT(8)
>  
> +#define CARD_OPT_WIDTH8		BIT(13)
> +#define CARD_OPT_WIDTH		BIT(15)

Just confusing whether CARD_OPT_WIDTH is 4bit or 1bit?

> +
>  #define TMIO_BBS		512		/* Boot block size */
>  
>  /* Definitions for values the CTRL_SDIO_STATUS register can take. */
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 46b5a456243b84..a0f05eb4f34490 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -340,7 +340,9 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host, struct mmc_command
>  
>  	switch (mmc_resp_type(cmd)) {
>  	case MMC_RSP_NONE: c |= RESP_NONE; break;
> -	case MMC_RSP_R1:   c |= RESP_R1;   break;
> +	case MMC_RSP_R1:
> +	case MMC_RSP_R1_NO_CRC:
> +			   c |= RESP_R1;   break;

Just wonder..It there case that hit "case MMC_RSP_R1_NO_CRC" ?

>  	case MMC_RSP_R1B:  c |= RESP_R1B;  break;
>  	case MMC_RSP_R2:   c |= RESP_R2;   break;
>  	case MMC_RSP_R3:   c |= RESP_R3;   break;
> @@ -737,12 +739,13 @@ static int tmio_mmc_start_data(struct tmio_mmc_host *host,
>  	pr_debug("setup data transfer: blocksize %08x  nr_blocks %d\n",
>  		 data->blksz, data->blocks);
>  
> -	/* Some hardware cannot perform 2 byte requests in 4 bit mode */
> -	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4) {
> +	/* Some hardware cannot perform 2 byte requests in 4/8 bit mode */
> +	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4 ||
> +	    host->mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
>  		int blksz_2bytes = pdata->flags & TMIO_MMC_BLKSZ_2BYTES;
>  
>  		if (data->blksz < 2 || (data->blksz < 4 && !blksz_2bytes)) {
> -			pr_err("%s: %d byte block unsupported in 4 bit mode\n",
> +			pr_err("%s: %d byte block unsupported in 4/8 bit mode\n",
>  			       mmc_hostname(host->mmc), data->blksz);
>  			return -EINVAL;
>  		}
> @@ -922,14 +925,16 @@ static void tmio_mmc_power_off(struct tmio_mmc_host *host)
>  static void tmio_mmc_set_bus_width(struct tmio_mmc_host *host,
>  				unsigned char bus_width)
>  {
> -	switch (bus_width) {
> -	case MMC_BUS_WIDTH_1:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x80e0);
> -		break;
> -	case MMC_BUS_WIDTH_4:
> -		sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, 0x00e0);
> -		break;
> -	}
> +	u16 reg = sd_ctrl_read16(host, CTL_SD_MEM_CARD_OPT)
> +				& ~(CARD_OPT_WIDTH | CARD_OPT_WIDTH8);
> +
> +	/* reg now applies to MMC_BUS_WIDTH_4 */
> +	if (bus_width == MMC_BUS_WIDTH_1)
> +		reg |= CARD_OPT_WIDTH;
> +	else if (bus_width == MMC_BUS_WIDTH_8)
> +		reg |= CARD_OPT_WIDTH8;
> +
> +	sd_ctrl_write16(host, CTL_SD_MEM_CARD_OPT, reg);
>  }
>  
>  /* Set MMC clock / power.
> @@ -1149,6 +1154,15 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>  				  !mmc_card_is_removable(mmc) ||
>  				  mmc->slot.cd_irq >= 0);
>  
> +	/*
> +	 * On Gen2+, eMMC with NONREMOVABLE currently fails because native
> +	 * hotplug gets disabled. It seems RuntimePM related yet we need further
> +	 * research. Since we are planning a PM overhaul anyway, let's enforce
> +	 * for now the device being active by enabling native hotplug always.
> +	 */
> +	if (pdata->flags & TMIO_MMC_MIN_RCAR2)
> +		_host->native_hotplug = true;
> +
>  	if (tmio_mmc_clk_enable(_host) < 0) {
>  		mmc->f_max = pdata->hclk;
>  		mmc->f_min = mmc->f_max / 512;
> 
