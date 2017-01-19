From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RESEND PATCHv1 8/8] mmc: sdhci-msm: Provide enhanced_strobe mode
 feature support
Date: Thu, 19 Jan 2017 12:21:46 +0200
Message-ID: <7a46319a-2b49-83c4-3dd0-d7f363052b77@intel.com>
References: <1484031652-12059-1-git-send-email-riteshh@codeaurora.org>
 <1484031652-12059-9-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:18696 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbdASK1p (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 05:27:45 -0500
In-Reply-To: <1484031652-12059-9-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, shawn.lin@rock-chips.com, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, asutoshd@codeaurora.org, stummala@codeaurora.org, venkatg@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com, git@kchr.de

On 10/01/17 09:00, Ritesh Harjani wrote:
> This provides enhanced_strobe mode feature support in sdhci-msm
> driver.
> 
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-msm.c | 34 +++++++++++++++++++++++++---------
>  1 file changed, 25 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index fa9bce3..f958697 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -103,6 +103,7 @@
>  
>  #define CORE_DDR_200_CFG		0x184
>  #define CORE_CDC_T4_DLY_SEL		BIT(0)
> +#define CORE_CMDIN_RCLK_EN		BIT(1)
>  #define CORE_START_CDC_TRAFFIC		BIT(6)
>  #define CORE_VENDOR_SPEC3	0x1b0
>  #define CORE_PWRSAVE_DLL	BIT(3)
> @@ -547,6 +548,7 @@ static void msm_hc_select_hs400(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_ios ios = host->mmc->ios;
>  	u32 config, dll_lock;
>  	int rc;
>  
> @@ -560,7 +562,8 @@ static void msm_hc_select_hs400(struct sdhci_host *host)
>  	 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
>  	 * register
>  	 */
> -	if (msm_host->tuning_done && !msm_host->calibration_done) {
> +	if ((msm_host->tuning_done || ios.enhanced_strobe) &&
> +	    !msm_host->calibration_done) {
>  		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
>  		config |= CORE_HC_SELECT_IN_HS400;
>  		config |= CORE_HC_SELECT_IN_EN;
> @@ -734,6 +737,7 @@ static int sdhci_msm_cdclp533_calibration(struct sdhci_host *host)
>  
>  static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
>  {
> +	struct mmc_host *mmc = host->mmc;
>  	u32 dll_status, config;
>  	int ret;
>  
> @@ -748,6 +752,12 @@ static int sdhci_msm_cm_dll_sdc4_calibration(struct sdhci_host *host)
>  	 */
>  	writel_relaxed(DDR_CONFIG_POR_VAL, host->ioaddr + CORE_DDR_CONFIG);
>  
> +	if (mmc->ios.enhanced_strobe) {
> +		config = readl_relaxed(host->ioaddr + CORE_DDR_200_CFG);
> +		config |= CORE_CMDIN_RCLK_EN;
> +		writel_relaxed(config, host->ioaddr + CORE_DDR_200_CFG);
> +	}
> +
>  	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG_2);
>  	config |= CORE_DDR_CAL_EN;
>  	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG_2);
> @@ -782,6 +792,7 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +	struct mmc_host *mmc = host->mmc;
>  	int ret;
>  	u32 config;
>  
> @@ -795,14 +806,17 @@ static int sdhci_msm_hs400_dll_calibration(struct sdhci_host *host)
>  	if (ret)
>  		goto out;
>  
> -	/* Set the selected phase in delay line hw block */
> -	ret = msm_config_cm_dll_phase(host, msm_host->saved_tuning_phase);
> -	if (ret)
> -		goto out;
> +	if (!mmc->ios.enhanced_strobe) {
> +		/* Set the selected phase in delay line hw block */
> +		ret = msm_config_cm_dll_phase(host,
> +					      msm_host->saved_tuning_phase);
> +		if (ret)
> +			goto out;
> +		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +		config |= CORE_CMD_DAT_TRACK_SEL;
> +		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +	}
>  
> -	config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> -	config |= CORE_CMD_DAT_TRACK_SEL;
> -	writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
>  	if (msm_host->use_cdclp533)
>  		ret = sdhci_msm_cdclp533_calibration(host);
>  	else
> @@ -899,6 +913,7 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  
>  /*
>   * sdhci_msm_hs400 - Calibrate the DLL for HS400 bus speed mode operation.
> + * This needs to be done for both tuning and enhanced_strobe mode.
>   * DLL operation is only needed for clock > 100MHz. For clock <= 100MHz
>   * fixed feedback clock is used.
>   */
> @@ -909,7 +924,8 @@ static void sdhci_msm_hs400(struct sdhci_host *host, struct mmc_ios *ios)
>  	int ret;
>  
>  	if (host->clock > CORE_FREQ_100MHZ &&
> -	    msm_host->tuning_done && !msm_host->calibration_done) {
> +	    (msm_host->tuning_done || ios->enhanced_strobe) &&
> +	    !msm_host->calibration_done) {
>  		ret = sdhci_msm_hs400_dll_calibration(host);
>  		if (!ret)
>  			msm_host->calibration_done = true;
> 

