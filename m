From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v6 12/14] mmc: sdhci-msm: Save the calculated tuning phase
Date: Tue, 8 Nov 2016 14:41:19 +0200
Message-ID: <eb259443-e783-3abc-80c7-d4e7ec96ff9b@intel.com>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-13-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1478517877-23733-13-git-send-email-riteshh@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com, sboyd@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, andy.gross@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 07/11/16 13:24, Ritesh Harjani wrote:
> Save the tuning phase once the tuning is performed.
> This phase value will be used while calibrating DLL
> for HS400 mode.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 2561c41..6431bb8 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -74,6 +74,7 @@
>  
>  #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
>  
> +#define INVALID_TUNING_PHASE	-1
>  #define TCXO_FREQ		19200000
>  #define SDHCI_MSM_MIN_CLOCK	400000
>  #define CORE_FREQ_100MHZ	(100 * 1000 * 1000)
> @@ -95,6 +96,7 @@ struct sdhci_msm_host {
>  	bool use_14lpp_dll_reset;
>  	bool tuning_done;
>  	bool calibration_done;
> +	u8 saved_tuning_phase;
>  };
>  
>  /* Platform specific tuning */
> @@ -134,6 +136,9 @@ static int msm_config_cm_dll_phase(struct sdhci_host *host, u8 phase)
>  	u32 config;
>  	struct mmc_host *mmc = host->mmc;
>  
> +	if (phase > 0xf)
> +		return -EINVAL;
> +
>  	spin_lock_irqsave(&host->lock, flags);
>  
>  	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> @@ -431,6 +436,8 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	int rc;
>  	struct mmc_host *mmc = host->mmc;
>  	struct mmc_ios ios = host->mmc->ios;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  
>  	/*
>  	 * Tuning is required for SDR104, HS200 and HS400 cards and
> @@ -455,6 +462,7 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  		if (rc)
>  			return rc;
>  
> +		msm_host->saved_tuning_phase = phase;
>  		rc = mmc_send_tuning(mmc, opcode, NULL);
>  		if (!rc) {
>  			/* Tuning is successful at this tuning point */
> @@ -826,6 +834,8 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  
>  	sdhci_get_of_property(pdev);
>  
> +	msm_host->saved_tuning_phase = INVALID_TUNING_PHASE;
> +
>  	/* Setup SDCC bus voter clock. */
>  	msm_host->bus_clk = devm_clk_get(&pdev->dev, "bus");
>  	if (!IS_ERR(msm_host->bus_clk)) {
> 
