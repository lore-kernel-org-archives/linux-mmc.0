From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: debugfs: expose the SDCLK frq in sys ios (v2)
Date: Tue, 25 Oct 2011 11:40:44 +0300
Message-ID: <4EA6760C.3080806@intel.com>
References: <1319031945-2630-1-git-send-email-peppe.cavallaro@st.com> <1319185001-10226-1-git-send-email-peppe.cavallaro@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:29759 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026Ab1JYIkr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Oct 2011 04:40:47 -0400
In-Reply-To: <1319185001-10226-1-git-send-email-peppe.cavallaro@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Cc: linux-mmc@vger.kernel.org

On 21/10/11 11:16, Giuseppe CAVALLARO wrote:
> This patch is to expose the actual SDCLK frequency in
> /sys/kernel/debug/mmcX/ios entry.
>
> For example, if the max clk for a normal speed card is 20MHz
> this is reported in /sys/kernel/debug/mmcX/ios.
> Unfortunately the actual SDCLK frequency (i.e. Baseclock / divisor)
> is not reported at all: for example, in that case, on Arasan HC,
> it should be 48/4=12 (MHz).
>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  drivers/mmc/core/debugfs.c |    2 ++
>  drivers/mmc/host/sdhci.c   |    7 +++++++
>  include/linux/mmc/host.h   |    2 ++
>  3 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 998797e..0b9a4aa 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -46,6 +46,8 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>  	const char *str;
>  
>  	seq_printf(s, "clock:\t\t%u Hz\n", ios->clock);
> +	if (host->actual_clock)
> +		seq_printf(s, "actual clock:\t%u Hz\n", host->actual_clock);
>  	seq_printf(s, "vdd:\t\t%u ", ios->vdd);
>  	if ((1 << ios->vdd) & MMC_VDD_165_195)
>  		seq_printf(s, "(1.65 - 1.95 V)\n");
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 0e02cc1..a0d61b0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1043,6 +1043,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	int div = 0; /* Initialized for compiler warning */
> +	int actual_div = 0;
>  	u16 clk = 0;
>  	unsigned long timeout;

What if the clock is gated i.e. zero?  Maybe add

	host->mmc->actual_clock = 0;


>  
> @@ -1088,6 +1089,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  				clk = SDHCI_PROG_CLOCK_MODE;
>  				div--;
>  			}
> +			actual_div = div;

What about the clock multiplier?

>  		} else {
>  			/* Version 3.00 divisors must be a multiple of 2. */
>  			if (host->max_clk <= clock)
> @@ -1099,6 +1101,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  						break;
>  				}
>  			}
> +			actual_div = div;
>  			div >>= 1;
>  		}
>  	} else {
> @@ -1107,9 +1110,13 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>  			if ((host->max_clk / div) <= clock)
>  				break;
>  		}
> +			actual_div = div;
>  		div >>= 1;
>  	}
>  
> +	if (actual_div)
> +		host->mmc->actual_clock = host->max_clk / actual_div;
> +
>  	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>  	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>  		<< SDHCI_DIVIDER_HI_SHIFT;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1d09562..d815311 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -302,6 +302,8 @@ struct mmc_host {
>  
>  	struct mmc_async_req	*areq;		/* active async req */
>  
> +	unsigned int		actual_clock;	/* Actual HC clock rate */
> +
>  	unsigned long		private[0] ____cacheline_aligned;
>  };
>  

