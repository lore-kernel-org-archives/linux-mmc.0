From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
Date: Fri, 19 Feb 2010 15:05:06 -0600
Message-ID: <008801cab1a7$36c49c70$544ff780@am.dhcp.ti.com>
References: <cover.1265801967.git.david.vrabel@csr.com> <846fbf1a68cde5fd2d7c7ab084ace239c8de6867.1265801967.git.david.vrabel@csr.com> <f4f02c7875316b7f65466a5ac06f5b2b2960aa96.1265801967.git.david.vrabel@csr.com> <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56582 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab0BSVFM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 19 Feb 2010 16:05:12 -0500
In-Reply-To: <9ce6cf93ba1e6c3fd239f732ea5889a856948db3.1265801967.git.david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'David Vrabel' <david.vrabel@csr.com>, linux-mmc@vger.kernel.org
Cc: linux-omap@vger.kernel.org



> -----Original Message-----
> From: David Vrabel [mailto:david.vrabel@csr.com]
> Sent: Wednesday, February 10, 2010 5:52 AM
> To: linux-mmc@vger.kernel.org
> Cc: David Vrabel; linux-omap@vger.kernel.org; madhu.cr@ti.com
> Subject: [PATCH 3/3] mmc: omap_hsmmc: enable SDIO card interrupts
> 
> Enable the use of SDIO card interrupts.  This requires setting ENAWAKEUP
> in SYSCONFIG and IWE in HTCL to allow the MMC block to wake-up when in
> smart-idle mode.
> 
> FCLK must be enabled while SDIO interrupts are enabled or the MMC block
> won't wake-up.
> 
> The writes to STAT and ISE when starting a command are unnecessary and
> have been removed.
> 
> Signed-off-by: David Vrabel <david.vrabel@csr.com>
> ---
> As noted in the FIXME comment, I think the correct thing to do is to
> always leave FCLK enabled.  The clock/clockdomain subsystems should be
> configuring smart-idle mode making explicit calls to disable FCLK
> unnecessary.  I couldn't follow the clock subsystem to see if it was
> actually doing this, though.

I Just noticed that SD cards stopped working on Zoom2 if I apply this patch.
I will come back with details on what's going on in a bit unless someone
else beats me on that.

Regards,
Madhu


> ---
>  drivers/mmc/host/omap_hsmmc.c |   94 ++++++++++++++++++++++++++++--------
> -----
>  1 files changed, 65 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e6d8cb3..ad0f867 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -64,6 +64,7 @@
>  #define SDVS_MASK		0x00000E00
>  #define SDVSCLR			0xFFFFF1FF
>  #define SDVSDET			0x00000400
> +#define ENAWAKEUP		(1 << 2)
>  #define AUTOIDLE		0x1
>  #define SDBP			(1 << 8)
>  #define DTO			0xe
> @@ -74,9 +75,11 @@
>  #define CLKD_SHIFT		6
>  #define DTO_MASK		0x000F0000
>  #define DTO_SHIFT		16
> +#define CIRQ_ENABLE		(1 << 8)
>  #define INT_EN_MASK		0x307F0033
>  #define BWR_ENABLE		(1 << 4)
>  #define BRR_ENABLE		(1 << 5)
> +#define CTPL			(1 << 11)
>  #define INIT_STREAM		(1 << 1)
>  #define DP_SELECT		(1 << 21)
>  #define DDIR			(1 << 4)
> @@ -84,10 +87,12 @@
>  #define MSBS			(1 << 5)
>  #define BCE			(1 << 1)
>  #define FOUR_BIT		(1 << 1)
> +#define IWE			(1 << 24)
>  #define DW8			(1 << 5)
>  #define CC			0x1
>  #define TC			0x02
>  #define OD			0x1
> +#define CIRQ			(1 << 8)
>  #define ERR			(1 << 15)
>  #define CMD_TIMEOUT		(1 << 16)
>  #define DATA_TIMEOUT		(1 << 20)
> @@ -228,7 +233,7 @@ static int omap_hsmmc_context_restore(struct
> omap_hsmmc_host *host)
>  		;
> 
>  	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
> -			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
> +			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE |
> ENAWAKEUP);
> 
>  	if (host->id == OMAP_MMC1_DEVID) {
>  		if (host->power_mode != MMC_POWER_OFF &&
> @@ -243,7 +248,7 @@ static int omap_hsmmc_context_restore(struct
> omap_hsmmc_host *host)
>  	}
> 
>  	OMAP_HSMMC_WRITE(host->base, HCTL,
> -			OMAP_HSMMC_READ(host->base, HCTL) | hctl);
> +			OMAP_HSMMC_READ(host->base, HCTL) | hctl | IWE);
> 
>  	OMAP_HSMMC_WRITE(host->base, CAPA,
>  			OMAP_HSMMC_READ(host->base, CAPA) | capa);
> @@ -257,7 +262,7 @@ static int omap_hsmmc_context_restore(struct
> omap_hsmmc_host *host)
>  		;
> 
>  	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> +	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK | CIRQ);
>  	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> 
>  	/* Do not initialize card-specific things if the power is off */
> @@ -426,12 +431,6 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
> *host, struct mmc_command *cmd,
>  		mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
>  	host->cmd = cmd;
> 
> -	/*
> -	 * Clear status bits and enable interrupts
> -	 */
> -	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> -	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> -
>  	if (host->use_dma)
>  		OMAP_HSMMC_WRITE(host->base, IE,
>  				 INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE));
> @@ -638,18 +637,21 @@ static irqreturn_t omap_hsmmc_irq(int irq, void
> *dev_id)
>  {
>  	struct omap_hsmmc_host *host = dev_id;
>  	struct mmc_data *data;
> -	int end_cmd = 0, end_trans = 0, status;
> +	u32 status;
> +	int end_cmd = 0, end_trans = 0;
> +	bool card_irq = false;
> 
>  	spin_lock(&host->irq_lock);
> 
> -	if (host->mrq == NULL) {
> -		OMAP_HSMMC_WRITE(host->base, STAT,
> -			OMAP_HSMMC_READ(host->base, STAT));
> -		/* Flush posted write */
> -		OMAP_HSMMC_READ(host->base, STAT);
> -		spin_unlock(&host->irq_lock);
> -		return IRQ_HANDLED;
> -	}
> +	status = OMAP_HSMMC_READ(host->base, STAT);
> +	OMAP_HSMMC_WRITE(host->base, STAT, status);
> +	OMAP_HSMMC_READ(host->base, STAT); /* Flush posted write. */
> +
> +	if (status & CIRQ)
> +		card_irq = true;
> +
> +	if (host->mrq == NULL)
> +		goto out;
> 
>  	data = host->data;
>  	status = OMAP_HSMMC_READ(host->base, STAT);
> @@ -704,17 +706,16 @@ static irqreturn_t omap_hsmmc_irq(int irq, void
> *dev_id)
>  		}
>  	}
> 
> -	OMAP_HSMMC_WRITE(host->base, STAT, status);
> -	/* Flush posted write */
> -	OMAP_HSMMC_READ(host->base, STAT);
> -
>  	if (end_cmd || ((status & CC) && host->cmd))
>  		omap_hsmmc_cmd_done(host, host->cmd);
>  	if ((end_trans || (status & TC)) && host->mrq)
>  		omap_hsmmc_xfer_done(host, data);
> -
> +out:
>  	spin_unlock(&host->irq_lock);
> 
> +	if (card_irq)
> +		mmc_signal_sdio_irq(host->mmc);
> +
>  	return IRQ_HANDLED;
>  }
> 
> @@ -1248,6 +1249,41 @@ static int omap_hsmmc_get_ro(struct mmc_host *mmc)
>  	return mmc_slot(host).get_ro(host->dev, 0);
>  }
> 
> +static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
> +{
> +	struct omap_hsmmc_host *host = mmc_priv(mmc);
> +	u32 ie, con;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&host->irq_lock, flags);
> +
> +	/*
> +	 * When interrupts are enabled, CTPL must be set to enable
> +	 * DAT1 input buffer (or the card interrupt is always
> +	 * asserted) and FCLK must be enabled else wakeup does not
> +	 * work.
> +	 *
> +	 * FIXME: the power save code probably shouldn't be playing
> +	 * with FCLK and allow the clock subsystem to put it into
> +	 * smart-idle mode instead.
> +	 */
> +	con = OMAP_HSMMC_READ(host->base, CON);
> +	ie = OMAP_HSMMC_READ(host->base, IE);
> +	if (enable) {
> +		clk_enable(host->fclk);
> +		ie |= CIRQ_ENABLE;
> +		con |= CTPL;
> +	} else {
> +		clk_disable(host->fclk);
> +		ie &= ~CIRQ_ENABLE;
> +		con &= ~CTPL;
> +	}
> +	OMAP_HSMMC_WRITE(host->base, CON, con);
> +	OMAP_HSMMC_WRITE(host->base, IE, ie);
> +
> +	spin_unlock_irqrestore(&host->irq_lock, flags);
> +}
> +
>  static void omap_hsmmc_conf_bus_power(struct omap_hsmmc_host *host)
>  {
>  	u32 hctl, capa, value;
> @@ -1262,14 +1298,14 @@ static void omap_hsmmc_conf_bus_power(struct
> omap_hsmmc_host *host)
>  	}
> 
>  	value = OMAP_HSMMC_READ(host->base, HCTL) & ~SDVS_MASK;
> -	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl);
> +	OMAP_HSMMC_WRITE(host->base, HCTL, value | hctl | IWE);
> 
>  	value = OMAP_HSMMC_READ(host->base, CAPA);
>  	OMAP_HSMMC_WRITE(host->base, CAPA, value | capa);
> 
>  	/* Set the controller to AUTO IDLE mode */
>  	value = OMAP_HSMMC_READ(host->base, SYSCONFIG);
> -	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE);
> +	OMAP_HSMMC_WRITE(host->base, SYSCONFIG, value | AUTOIDLE |
> ENAWAKEUP);
> 
>  	/* Set SD bus power bit */
>  	set_sd_bus_power(host);
> @@ -1516,7 +1552,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>  	.set_ios = omap_hsmmc_set_ios,
>  	.get_cd = omap_hsmmc_get_cd,
>  	.get_ro = omap_hsmmc_get_ro,
> -	/* NYET -- enable_sdio_irq */
> +	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>  };
> 
>  static const struct mmc_host_ops omap_hsmmc_ps_ops = {
> @@ -1526,7 +1562,7 @@ static const struct mmc_host_ops omap_hsmmc_ps_ops =
> {
>  	.set_ios = omap_hsmmc_set_ios,
>  	.get_cd = omap_hsmmc_get_cd,
>  	.get_ro = omap_hsmmc_get_ro,
> -	/* NYET -- enable_sdio_irq */
> +	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
>  };
> 
>  #ifdef CONFIG_DEBUG_FS
> @@ -1731,7 +1767,7 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
>  	mmc->max_seg_size = mmc->max_req_size;
> 
>  	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
> -		     MMC_CAP_WAIT_WHILE_BUSY;
> +		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_SDIO_IRQ;
> 
>  	if (mmc_slot(host).wires >= 8)
>  		mmc->caps |= MMC_CAP_8_BIT_DATA;
> @@ -1802,7 +1838,7 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
>  		}
>  	}
> 
> -	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> +	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK | CIRQ);
>  	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> 
>  	mmc_host_lazy_disable(host->mmc);
> --
> 1.6.3.3


