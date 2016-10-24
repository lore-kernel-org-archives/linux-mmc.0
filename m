From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 1/3] mmc: mmci: clean up header defines
Date: Mon, 24 Oct 2016 16:33:53 +0100
Message-ID: <51235848-4aae-30e0-6e36-fe984921b749@arm.com>
References: <1477318886-24851-1-git-send-email-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55298 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935002AbcJXPd4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Oct 2016 11:33:56 -0400
In-Reply-To: <1477318886-24851-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>

Hi Linus,

One tiny nit which stands out from a cleanup perspective...

On 24/10/16 15:21, Linus Walleij wrote:
> There was some confusion in the CPSM (Command Path State Machine)
> and DPSM (Data Path State Machine) regarding the naming of the
> registers, clarify the meaning of this acronym so the naming is
> understandable, and consistently use BIT() to define these fields.
> 
> Include new definitions for a few bits found in a patch from
> Srinivas Kandagatla.
> 
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/host/mmci.c |  2 +-
>  drivers/mmc/host/mmci.h | 69 +++++++++++++++++++++++++++----------------------
>  2 files changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index df990bb8c873..79b135752d3d 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -210,7 +210,7 @@ static struct variant_data variant_qcom = {
>  				  MCI_QCOM_CLK_SELECT_IN_FBCLK,
>  	.clkreg_8bit_bus_enable = MCI_QCOM_CLK_WIDEBUS_8,
>  	.datactrl_mask_ddrmode	= MCI_QCOM_CLK_SELECT_IN_DDR_MODE,
> -	.data_cmd_enable	= MCI_QCOM_CSPM_DATCMD,
> +	.data_cmd_enable	= MCI_CPSM_QCOM_DATCMD,
>  	.blksz_datactrl4	= true,
>  	.datalength_bits	= 24,
>  	.pwrreg_powerup		= MCI_PWR_UP,
> diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
> index a1f5e4f49e2a..8952285196cd 100644
> --- a/drivers/mmc/host/mmci.h
> +++ b/drivers/mmc/host/mmci.h
> @@ -51,25 +51,27 @@
>  #define MCI_QCOM_CLK_SELECT_IN_DDR_MODE	(BIT(14) | BIT(15))
>  
>  #define MMCIARGUMENT		0x008
> -#define MMCICOMMAND		0x00c
> -#define MCI_CPSM_RESPONSE	(1 << 6)
> -#define MCI_CPSM_LONGRSP	(1 << 7)
> -#define MCI_CPSM_INTERRUPT	(1 << 8)
> -#define MCI_CPSM_PENDING	(1 << 9)
> -#define MCI_CPSM_ENABLE		(1 << 10)
> -/* Argument flag extenstions in the ST Micro versions */
> -#define MCI_ST_SDIO_SUSP	(1 << 11)
> -#define MCI_ST_ENCMD_COMPL	(1 << 12)
> -#define MCI_ST_NIEN		(1 << 13)
> -#define MCI_ST_CE_ATACMD	(1 << 14)
>  
> -/* Modified on Qualcomm Integrations */
> -#define MCI_QCOM_CSPM_DATCMD		BIT(12)
> -#define MCI_QCOM_CSPM_MCIABORT		BIT(13)
> -#define MCI_QCOM_CSPM_CCSENABLE		BIT(14)
> -#define MCI_QCOM_CSPM_CCSDISABLE	BIT(15)
> -#define MCI_QCOM_CSPM_AUTO_CMD19	BIT(16)
> -#define MCI_QCOM_CSPM_AUTO_CMD21	BIT(21)
> +/* The command register controls the Command Path State Machine (CPSM) */
> +#define MMCICOMMAND		0x00c
> +#define MCI_CPSM_RESPONSE	BIT(6)
> +#define MCI_CPSM_LONGRSP	BIT(7)
> +#define MCI_CPSM_INTERRUPT	BIT(8)
> +#define MCI_CPSM_PENDING	BIT(9)
> +#define MCI_CPSM_ENABLE		BIT(10)
> +/* Command register flag extenstions in the ST Micro versions */
> +#define MCI_CPSM_ST_SDIO_SUSP		BIT(11)
> +#define MCI_CPSM_ST_ENCMD_COMPL		BIT(12)
> +#define MCI_CPSM_ST_NIEN		BIT(13)
> +#define MCI_CPSM_ST_CE_ATACMD		BIT(14)
> +/* Command register flag extensions in the Qualcomm versions */
> +#define MCI_CPSM_QCOM_PROGENA		BIT(11)
> +#define MCI_CPSM_QCOM_DATCMD		BIT(12)
> +#define MCI_CPSM_QCOM_MCIABORT		BIT(13)
> +#define MCI_CPSM_QCOM_CCSENABLE		BIT(14)
> +#define MCI_CPSM_QCOM_CCSDISABLE	BIT(15)
> +#define MCI_CPSM_QCOM_AUTO_CMD19	BIT(16)
> +#define MCI_CPSM_QCOM_AUTO_CMD21	BIT(21)

These definitions take the format of MCI_register_{vendor_}field...

>  #define MMCIRESPCMD		0x010
>  #define MMCIRESPONSE0		0x014
> @@ -78,22 +80,27 @@
>  #define MMCIRESPONSE3		0x020
>  #define MMCIDATATIMER		0x024
>  #define MMCIDATALENGTH		0x028
> +
> +/* The data control register controls the Data Path State Machine (DPSM) */
>  #define MMCIDATACTRL		0x02c
> -#define MCI_DPSM_ENABLE		(1 << 0)
> -#define MCI_DPSM_DIRECTION	(1 << 1)
> -#define MCI_DPSM_MODE		(1 << 2)
> -#define MCI_DPSM_DMAENABLE	(1 << 3)
> -#define MCI_DPSM_BLOCKSIZE	(1 << 4)
> +#define MCI_DPSM_ENABLE		BIT(0)
> +#define MCI_DPSM_DIRECTION	BIT(1)
> +#define MCI_DPSM_MODE		BIT(2)
> +#define MCI_DPSM_DMAENABLE	BIT(3)
> +#define MCI_DPSM_BLOCKSIZE	BIT(4)
>  /* Control register extensions in the ST Micro U300 and Ux500 versions */
> -#define MCI_ST_DPSM_RWSTART	(1 << 8)
> -#define MCI_ST_DPSM_RWSTOP	(1 << 9)
> -#define MCI_ST_DPSM_RWMOD	(1 << 10)
> -#define MCI_ST_DPSM_SDIOEN	(1 << 11)
> +#define MCI_ST_DPSM_RWSTART	BIT(8)
> +#define MCI_ST_DPSM_RWSTOP	BIT(9)
> +#define MCI_ST_DPSM_RWMOD	BIT(10)
> +#define MCI_ST_DPSM_SDIOEN	BIT(11)
>  /* Control register extensions in the ST Micro Ux500 versions */
> -#define MCI_ST_DPSM_DMAREQCTL	(1 << 12)
> -#define MCI_ST_DPSM_DBOOTMODEEN	(1 << 13)
> -#define MCI_ST_DPSM_BUSYMODE	(1 << 14)
> -#define MCI_ST_DPSM_DDRMODE	(1 << 15)
> +#define MCI_ST_DPSM_DMAREQCTL	BIT(12)
> +#define MCI_ST_DPSM_DBOOTMODEEN	BIT(13)
> +#define MCI_ST_DPSM_BUSYMODE	BIT(14)
> +#define MCI_ST_DPSM_DDRMODE	BIT(15)
> +/* Control register extensions in the Qualcomm versions */
> +#define MCI_QCOM_DPSM_DATA_PEND	BIT(17)
> +#define MCI_QCOM_DPSM_RX_DATA_PEND BIT(20)

...but these retain the previous MCI_{vendor_}register_field format - it
seems like a needless inconsistency, but if there is some good reason
then fair enough (I only have the vaguest familiarity with this IP/driver).

Robin.

>  
>  #define MMCIDATACNT		0x030
>  #define MMCISTATUS		0x034
> 

