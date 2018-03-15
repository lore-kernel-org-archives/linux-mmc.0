From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 06/11] mmc: sdhci: Add quirk to disable HW timeout
Date: Thu, 15 Mar 2018 13:26:10 +0200
Message-ID: <e98930eb-aaca-c193-1e5a-185195e71de5@intel.com>
References: <20180307132020.30951-1-kishon@ti.com>
 <20180307132020.30951-7-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180307132020.30951-7-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 07/03/18 15:20, Kishon Vijay Abraham I wrote:
> Add quirk to disable HW timeout if the requested timeout is more than
> the maximum obtainable timeout.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++++------
>  drivers/mmc/host/sdhci.h |  5 +++++
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index aa8b5ca0d1b0..1dd117cbeb6e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -767,12 +767,6 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  			break;
>  	}
>  
> -	if (count >= 0xF) {
> -		DBG("Too large timeout 0x%x requested for CMD%d!\n",
> -		    count, cmd->opcode);
> -		count = 0xE;
> -	}
> -
>  	return count;
>  }
>  
> @@ -790,6 +784,16 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
>  	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>  }
>  
> +static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
> +{
> +	if (enable)
> +		host->ier |= SDHCI_INT_DATA_TIMEOUT;
> +	else
> +		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
> +	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
> +	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
> +}
> +
>  static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  {
>  	u8 count;
> @@ -798,6 +802,17 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  		host->ops->set_timeout(host, cmd);
>  	} else {
>  		count = sdhci_calc_timeout(host, cmd);
> +		if (count >= 0xF &&
> +		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT)
> +			sdhci_set_data_timeout_irq(host, false);
> +		else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT))
> +			sdhci_set_data_timeout_irq(host, true);
> +
> +		if (count >= 0xF) {
> +			DBG("Too large timeout 0x%x requested for CMD%d!\n",
> +			    count, cmd->opcode);
> +			count = 0xE;
> +		}
>  		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
>  	}
>  }

I guess I misunderstood you, but we need to cater for
open-ended busy timeouts (i.e. busy_timeout==0) and broken
timeout (i.e. SDHCI_QUIRK_BROKEN_TIMEOUT_VAL and
SDHCI_QUIRK2_DISABLE_HW_TIMEOUT together mean never use the
HW timeout)

So maybe like this:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index aa8b5ca0d1b0..a358eb5c5f98 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -709,12 +709,15 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
-static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd,
+			     bool *too_big)
 {
 	u8 count;
 	struct mmc_data *data = cmd->data;
 	unsigned target_timeout, current_timeout;
 
+	*too_big = true;
+
 	/*
 	 * If the host controller provides us with an incorrect timeout
 	 * value, just skip the check and use 0xE.  The hardware may take
@@ -768,9 +771,12 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (count >= 0xF) {
-		DBG("Too large timeout 0x%x requested for CMD%d!\n",
-		    count, cmd->opcode);
+		if (!(host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT))
+			DBG("Too large timeout 0x%x requested for CMD%d!\n",
+			    count, cmd->opcode);
 		count = 0xE;
+	} else {
+		*too_big = false;
 	}
 
 	return count;
@@ -790,6 +796,16 @@ static void sdhci_set_transfer_irqs(struct sdhci_host *host)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static void sdhci_set_data_timeout_irq(struct sdhci_host *host, bool enable)
+{
+	if (enable)
+		host->ier |= SDHCI_INT_DATA_TIMEOUT;
+	else
+		host->ier &= ~SDHCI_INT_DATA_TIMEOUT;
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
 static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 count;
@@ -797,7 +813,17 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	if (host->ops->set_timeout) {
 		host->ops->set_timeout(host, cmd);
 	} else {
-		count = sdhci_calc_timeout(host, cmd);
+		bool too_big = false;
+
+		count = sdhci_calc_timeout(host, cmd, &too_big);
+
+		if (too_big &&
+		    host->quirks2 & SDHCI_QUIRK2_DISABLE_HW_TIMEOUT) {
+			sdhci_set_data_timeout_irq(host, false);
+		} else if (!(host->ier & SDHCI_INT_DATA_TIMEOUT)) {
+			sdhci_set_data_timeout_irq(host, true);
+		}
+
 		sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
 	}
 }

> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c95b0a4a7594..ff283ee08854 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -437,6 +437,11 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
>  /* Controller has CRC in 136 bit Command Response */
>  #define SDHCI_QUIRK2_RSP_136_HAS_CRC			(1<<16)
> +/*
> + * Disable HW timeout if the requested timeout is more than the maximum
> + * obtainable timeout
> + */
> +#define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 
