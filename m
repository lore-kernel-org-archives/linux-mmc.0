From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND RFC 3/3] mmc: sdhci: Add more debug info in case of data
 error
Date: Thu, 19 Jan 2017 13:54:04 +0200
Message-ID: <74840dea-18b6-3b51-67ae-e1ce3bb7fb58@intel.com>
References: <1484030515-16722-1-git-send-email-riteshh@codeaurora.org>
 <1484030515-16722-4-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1484030515-16722-4-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

On 10/01/17 08:41, Ritesh Harjani wrote:
> print error log message and dump sdhc registers for debugging
> purpose in case of data errors (except when tuning commands
> generate CRC/timeout/end bit errors).

It is a bit ugly and probably only useful during driver development, so I am
not at all enthusiastic about this.

> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 73a8918..2e51e49 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2616,9 +2616,26 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>  			host->ops->adma_workaround(host, intmask);
>  	}
>  
> -	if (host->data->error)
> +	if (host->data->error) {
> +		bool pr_msg = true;
> +
> +		if (intmask & (SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT |
> +		    SDHCI_INT_DATA_END_BIT)) {
> +			command = SDHCI_GET_CMD(sdhci_readw(host,
> +							    SDHCI_COMMAND));
> +			if (command == MMC_SEND_TUNING_BLOCK_HS200 ||
> +			    command == MMC_SEND_TUNING_BLOCK)
> +				pr_msg = false;
> +		}
> +		if (pr_msg) {
> +			pr_err("%s: data txfr (0x%08x) error: %d\n",
> +			       mmc_hostname(host->mmc), intmask,
> +			       host->data->error);
> +			sdhci_dumpregs(host);
> +		}
> +
>  		sdhci_finish_data(host);
> -	else {
> +	} else {
>  		if (intmask & (SDHCI_INT_DATA_AVAIL | SDHCI_INT_SPACE_AVAIL))
>  			sdhci_transfer_pio(host);
>  
> 
