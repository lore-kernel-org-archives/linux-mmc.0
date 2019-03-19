From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci: Make sdhci_send_command() public
Date: Tue, 19 Mar 2019 13:28:32 +0530
Message-ID: <53872d7f-9339-b288-4e48-a6164ee463c5@ti.com>
References: <20190319063533.12171-1-faiz_abbas@ti.com>
 <20190319063533.12171-2-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190319063533.12171-2-faiz_abbas@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Faiz Abbas <faiz_abbas@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi Faiz,

On 19/03/19 12:05 PM, Faiz Abbas wrote:
> Make sdhci_send_command() public so that it can be called from platform
> drivers.

This should be sdhci_finish_command here and also in subject
How about using "mmc: sdhci: Export sdhci_finish_command()"?

Thanks
Kishon
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  drivers/mmc/host/sdhci.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index a8141ff9be03..76d36e13a011 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1445,7 +1445,7 @@ static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  }
>  
> -static void sdhci_finish_command(struct sdhci_host *host)
> +void sdhci_finish_command(struct sdhci_host *host)
>  {
>  	struct mmc_command *cmd = host->cmd;
>  
> @@ -1495,6 +1495,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  			sdhci_finish_mrq(host, cmd->mrq);
>  	}
>  }
> +EXPORT_SYMBOL_GPL(sdhci_finish_command);
>  
>  static u16 sdhci_get_preset_value(struct sdhci_host *host)
>  {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 01002cba1359..49b133babf47 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -798,5 +798,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
>  void sdhci_end_tuning(struct sdhci_host *host);
>  void sdhci_reset_tuning(struct sdhci_host *host);
>  void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
> +void sdhci_finish_command(struct sdhci_host *host);
>  
>  #endif /* __SDHCI_HW_H */
> 
