From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] mmc: dw_mmc: use the use_hold_reg bit in CMD register
Date: Fri, 30 Sep 2011 12:05:55 +0100
Message-ID: <4E85A293.6020006@imgtec.com>
References: <4E859DEF.7090308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:55408 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755517Ab1I3LF7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 30 Sep 2011 07:05:59 -0400
In-Reply-To: <4E859DEF.7090308@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin.park@samsung.com, Will Newton <will.newton@imgtec.com>

Hi,

On 09/30/2011 11:46 AM, Jaehoon Chung wrote:
> This patch is added the use_hold_reg bit in CMD register.
> 
> In 2.40a, bit[29] of CMD register is used the use_hold_reg.
> Some SoC is affected by this bit.
> (This bit means whether use hold register when send data and cmd.
>  And related with cclk_in_drv phase)
> if set IMPLEMENT_HOLD_REG in HCON register, i think fine that set this
> bit by default.
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |    9 +++++++++
>  drivers/mmc/host/dw_mmc.h  |    1 +
>  include/linux/mmc/dw_mmc.h |    1 +
>  3 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0ed1d28..544a616 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -276,6 +276,13 @@ static void dw_mci_start_command(struct dw_mci *host,
>  	mci_writel(host, CMDARG, cmd->arg);
>  	wmb();
> 
> +	/*
> +	 * If use HOLD register,
> +	 * CMD and DATA sent to card through HOLD register.
> +	 */
> +	if (host->use_hold_reg)
> +		cmd_flags |= SDMMC_CMD_USE_HOLD_REG;
> +

Is the HOLD register an internal register that is always required for
hardware that has it to work? What effect does it have on the transaction?

>  	mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
>  }
> 
> @@ -1886,6 +1893,8 @@ static int dw_mci_probe(struct platform_device *pdev)
>  		host->data_shift = 2;
>  	}
> 
> +	host->use_hold_reg = (mci_readl(host, HCON) >> 22) & 0x1;
> +

it'd be nice to have a #define for the HCON bit.

>  	/* Reset all blocks */
>  	if (!mci_wait_reset(&pdev->dev, host)) {
>  		ret = -ENODEV;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index bfa3c1c..8c4edca 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -102,6 +102,7 @@
>  #define SDMMC_INT_ERROR			0xbfc2
>  /* Command register defines */
>  #define SDMMC_CMD_START			BIT(31)
> +#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
>  #define SDMMC_CMD_CCS_EXP		BIT(23)
>  #define SDMMC_CMD_CEATA_RD		BIT(22)
>  #define SDMMC_CMD_UPD_CLK		BIT(21)
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 6b46819..d6d1515 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -147,6 +147,7 @@ struct dw_mci {
>  	u32			current_speed;
>  	u32			num_slots;
>  	u32			fifoth_val;
> +	bool			use_hold_reg;

in case of other similar bits being added it may be better to have a
copy of the hcon register here, but its fine as it is too.

>  	struct platform_device	*pdev;
>  	struct dw_mci_board	*pdata;
>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];

Cheers
James

