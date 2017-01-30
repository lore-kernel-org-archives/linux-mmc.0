From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCHv1 1/2] mmc: sdhci-msm: Remove platform_execute_tuning from
 sdhci_msm_ops
Date: Mon, 30 Jan 2017 11:04:09 +0200
Message-ID: <70dce604-ffb9-eefb-dbd8-b287aef5ff0c@intel.com>
References: <1485247827-12898-1-git-send-email-riteshh@codeaurora.org>
 <1485247827-12898-2-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1485247827-12898-2-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de
List-Id: linux-mmc@vger.kernel.org

On 24/01/17 10:50, Ritesh Harjani wrote:
> platform_execute_tuning should not really exist as it does not
> do anything useful.
> 
> So remove this ops and directly plug sdhci_msm_execute_tuning
> with mmc_host_ops.
> 
> Also in case of HS400 tuning clear SDHCI_HS400_TUNING flag once
> HS400 related mode selection is done.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index f958697..b3e8f44 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -827,12 +827,12 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>  	return ret;
>  }
>  
> -static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
> +static int sdhci_msm_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  {
> +	struct sdhci_host *host = mmc_priv(mmc);
>  	int tuning_seq_cnt = 3;
>  	u8 phase, tuned_phases[16], tuned_phase_cnt = 0;
>  	int rc;
> -	struct mmc_host *mmc = host->mmc;
>  	struct mmc_ios ios = host->mmc->ios;
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> @@ -855,6 +855,7 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	if (host->flags & SDHCI_HS400_TUNING) {
>  		sdhci_msm_hc_select_mode(host);
>  		msm_set_clock_rate_for_bus_mode(host, ios.clock);
> +		host->flags &= ~SDHCI_HS400_TUNING;
>  	}
>  
>  retry:
> @@ -1119,7 +1120,6 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  MODULE_DEVICE_TABLE(of, sdhci_msm_dt_match);
>  
>  static const struct sdhci_ops sdhci_msm_ops = {
> -	.platform_execute_tuning = sdhci_msm_execute_tuning,
>  	.reset = sdhci_reset,
>  	.set_clock = sdhci_msm_set_clock,
>  	.get_min_clock = sdhci_msm_get_min_clock,
> @@ -1294,6 +1294,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  					 MSM_MMC_AUTOSUSPEND_DELAY_MS);
>  	pm_runtime_use_autosuspend(&pdev->dev);
>  
> +	host->mmc_host_ops.execute_tuning = sdhci_msm_execute_tuning;
>  	ret = sdhci_add_host(host);
>  	if (ret)
>  		goto pm_runtime_disable;
> 
