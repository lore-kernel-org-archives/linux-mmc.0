From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 4/5] mmc: sdhci: Export sdhci_abort_tuning function
 symbol
Date: Wed, 28 Aug 2019 13:49:18 +0300
Message-ID: <ecd70199-d3c9-b92d-493e-b49e23e6d91c@intel.com>
References: <20190827003322.2445-1-benchuanggli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827003322.2445-1-benchuanggli@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
List-Id: linux-mmc@vger.kernel.org

On 27/08/19 3:33 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Export sdhci_abort_tuning() function symbols which are used by other SD Host
> controller driver modules.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9106ebc7a422..0f2f110534db 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2328,7 +2328,7 @@ void sdhci_reset_tuning(struct sdhci_host *host)
>  }
>  EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
>  
> -static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
> +void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>  {
>  	sdhci_reset_tuning(host);
>  
> @@ -2339,6 +2339,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
>  
>  	mmc_abort_tuning(host->mmc, opcode);
>  }
> +EXPORT_SYMBOL_GPL(sdhci_abort_tuning);
>  
>  /*
>   * We use sdhci_send_tuning() because mmc_send_tuning() is not a good fit. SDHCI
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 72601a4d2e95..437bab3af195 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -797,5 +797,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
>  void sdhci_end_tuning(struct sdhci_host *host);
>  void sdhci_reset_tuning(struct sdhci_host *host);
>  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
>  
>  #endif /* __SDHCI_HW_H */
> 
