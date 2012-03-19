From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dwmci: Add new register bit at IP version of 240A.
Date: Mon, 19 Mar 2012 19:29:48 +0900
Message-ID: <4F670A9C.107@samsung.com>
References: <005401cd05b2$6bde22d0$439a6870$%jung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <005401cd05b2$6bde22d0$439a6870$%jung@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: JaeHun Jung <jh0801.jung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Jaehun.

I have sent the similar to your patch.
(http://www.spinics.net/lists/linux-mmc/msg10305.html)
I think good that add the checking point whether implement hold_reg in dwmmc-IP or not.

On 03/19/2012 06:26 PM, JaeHun Jung wrote:

> use_hold_reg bit is added at 240A version.
> This register is..
> Use Hold Register
> 0 - CMD and DATA sent to card bypassing HOLD Register
> 1 - CMD and DATA sent to card through the HOLD Register
> Note:
> Set to 1'b1 for SDR12 and SDR25
> (with non-zero phase-shifted cclk_in_drv)
> zero phase shift is not allowed in these modes.
> Set to 1'b0 for SDR50, SDR104, and DDR50
> (with zero phaseshifted cclk_in_drv)
> Set to 1'b1 for SDR50, SDR104, and DDR50
> (with non-zero phase-shifted cclk_in_drv)
> 
> Signed-off-by: JaeHun Jung <jh0801.jung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |    5 +++++
>  drivers/mmc/host/dw_mmc.h |    1 +
>  2 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 8bec1c3..e23bd5b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -232,6 +232,7 @@ static void dw_mci_set_timeout(struct dw_mci *host)
>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  {
>  	struct mmc_data	*data;
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
>  	u32 cmdr;
>  	cmd->error = -EINPROGRESS;
>  
> @@ -261,6 +262,10 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  			cmdr |= SDMMC_CMD_DAT_WR;
>  	}
>  
> +	/* Use hold bit register */
> +	if (slot->host->pdata->set_io_timing)
> +		cmdr |= SDMMC_USE_HOLD_REG;

Where is defined set_io_timing?

> +
>  	return cmdr;
>  }
>  
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index df392a1..06c2818 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -111,6 +111,7 @@
>  #define SDMMC_INT_ERROR			0xbfc2
>  /* Command register defines */
>  #define SDMMC_CMD_START			BIT(31)
> +#define SDMMC_USE_HOLD_REG		BIT(29)
>  #define SDMMC_CMD_CCS_EXP		BIT(23)
>  #define SDMMC_CMD_CEATA_RD		BIT(22)
>  #define SDMMC_CMD_UPD_CLK		BIT(21)


Best Regards,
Jaehoon Chung
