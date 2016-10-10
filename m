From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v5 10/12] mmc: sdhci-msm: Add HS400 platform support
Date: Mon, 10 Oct 2016 15:08:24 +0300
Message-ID: <0596e37d-0d8d-0f8e-8884-4404e2979593@intel.com>
References: <1475678440-3525-1-git-send-email-riteshh@codeaurora.org>
 <1475678440-3525-11-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:49957 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbcJJMNQ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 10 Oct 2016 08:13:16 -0400
In-Reply-To: <1475678440-3525-11-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, shawn.lin@rock-chips.com
Cc: david.brown@linaro.org, andy.gross@linaro.org, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, sboyd@codeaurora.org, bjorn.andersson@linaro.org, pramod.gurav@linaro.org

On 05/10/16 17:40, Ritesh Harjani wrote:
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> 
> The following msm platform specific changes are added to support HS400.
> - Allow tuning for HS400 mode.
> - Configure HS400 timing mode using the VENDOR_SPECIFIC_FUNC register.
> 
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/sdhci-msm.c | 124 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 113 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index eb1a9e3..612fa82 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -31,6 +31,7 @@
>  #define HC_MODE_EN		0x1
>  #define CORE_POWER		0x0
>  #define CORE_SW_RST		BIT(7)
> +#define FF_CLK_SW_RST_DIS	BIT(13)
>  
>  #define CORE_PWRCTL_STATUS	0xdc
>  #define CORE_PWRCTL_MASK	0xe0
> @@ -64,11 +65,18 @@
>  
>  #define CORE_VENDOR_SPEC	0x10c
>  #define CORE_CLK_PWRSAVE	BIT(1)
> +#define CORE_HC_MCLK_SEL_DFLT	(2 << 8)
> +#define CORE_HC_MCLK_SEL_HS400	(3 << 8)
> +#define CORE_HC_MCLK_SEL_MASK	(3 << 8)
> +#define CORE_HC_SELECT_IN_EN	(1 << 18)
> +#define CORE_HC_SELECT_IN_HS400	(6 << 19)
> +#define CORE_HC_SELECT_IN_MASK	(7 << 19)
>  
>  #define CORE_VENDOR_SPEC_CAPABILITIES0	0x11c
>  
>  #define TCXO_FREQ		19200000
>  #define SDHCI_MSM_MIN_CLOCK	400000
> +#define CORE_FREQ_100MHZ	(100 * 1000 * 1000)
>  
>  #define CDR_SELEXT_SHIFT	20
>  #define CDR_SELEXT_MASK		(0xf << CDR_SELEXT_SHIFT)
> @@ -87,6 +95,8 @@ struct sdhci_msm_host {
>  	u32 clk_rate;
>  	struct mmc_host *mmc;
>  	bool use_14lpp_dll_reset;
> +	bool tuning_done;
> +	bool calibration_done;
>  };
>  
>  /* Platform specific tuning */
> @@ -175,8 +185,8 @@ out:
>   * Find out the greatest range of consecuitive selected
>   * DLL clock output phases that can be used as sampling
>   * setting for SD3.0 UHS-I card read operation (in SDR104
> - * timing mode) or for eMMC4.5 card read operation (in HS200
> - * timing mode).
> + * timing mode) or for eMMC4.5 card read operation (in
> + * HS400/HS200 timing mode).
>   * Select the 3/4 of the range and configure the DLL with the
>   * selected DLL clock output phase.
>   */
> @@ -428,9 +438,10 @@ static int sdhci_msm_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	 * Tuning is required for SDR104, HS200 and HS400 cards and
>  	 * if clock frequency is greater than 100MHz in these modes.
>  	 */
> -	if (host->clock <= 100 * 1000 * 1000 ||
> -	    !((ios.timing == MMC_TIMING_MMC_HS200) ||
> -	      (ios.timing == MMC_TIMING_UHS_SDR104)))
> +	if (host->clock <= CORE_FREQ_100MHZ ||
> +		!((ios.timing == MMC_TIMING_MMC_HS400) ||
> +		(ios.timing == MMC_TIMING_MMC_HS200) ||
> +		(ios.timing == MMC_TIMING_UHS_SDR104)))

Don't need () around ios.timing == MMC_TIMING_MMC_HS400 etc

>  		return 0;
>  
>  retry:
> @@ -488,7 +499,10 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  					unsigned int uhs)
>  {
>  	struct mmc_host *mmc = host->mmc;
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  	u16 ctrl_2;
> +	u32 config;
>  
>  	ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>  	/* Select Bus Speed Mode for host */
> @@ -503,6 +517,7 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  	case MMC_TIMING_UHS_SDR50:
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>  		break;
> +	case MMC_TIMING_MMC_HS400:
>  	case MMC_TIMING_MMC_HS200:
>  	case MMC_TIMING_UHS_SDR104:
>  		ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> @@ -519,11 +534,33 @@ static void sdhci_msm_set_uhs_signaling(struct sdhci_host *host,
>  	 * provide feedback clock, the mode selection can be any value less
>  	 * than 3'b011 in bits [2:0] of HOST CONTROL2 register.
>  	 */
> -	if (host->clock <= 100000000 &&
> -	    (uhs == MMC_TIMING_MMC_HS400 ||
> -	     uhs == MMC_TIMING_MMC_HS200 ||
> -	     uhs == MMC_TIMING_UHS_SDR104))
> -		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +	if (host->clock <= CORE_FREQ_100MHZ) {
> +		if ((uhs == MMC_TIMING_MMC_HS400) ||
> +			(uhs == MMC_TIMING_MMC_HS200) ||
> +			(uhs == MMC_TIMING_UHS_SDR104))
> +			ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +		/*
> +		 * Make sure DLL is disabled when not required
> +		 *
> +		 * Write 1 to DLL_RST bit of DLL_CONFIG register
> +		 */
> +		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +		config |= CORE_DLL_RST;
> +		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +
> +		/* Write 1 to DLL_PDN bit of DLL_CONFIG register */
> +		config = readl_relaxed(host->ioaddr + CORE_DLL_CONFIG);
> +		config |= CORE_DLL_PDN;
> +		writel_relaxed(config, host->ioaddr + CORE_DLL_CONFIG);
> +
> +		wmb(); /* drain writebuffer */

Memory barrier could use more explanation.

> +
> +		/*
> +		 * The DLL needs to be restored and CDCLP533 recalibrated
> +		 * when the clock frequency is set back to 400MHz.
> +		 */
> +		msm_host->calibration_done = false;
> +	}
>  
>  	dev_dbg(mmc_dev(mmc), "%s: clock=%u uhs=%u ctrl_2=0x%x\n",
>  		mmc_hostname(host->mmc), host->clock, uhs, ctrl_2);
> @@ -670,7 +707,7 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
>  	struct mmc_ios curr_ios = host->mmc->ios;
> -	u32 msm_clock;
> +	u32 msm_clock, config;
>  	int rc;
>  
>  	if (!clock)
> @@ -691,6 +728,66 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>  	}
>  	msm_clock = sdhci_msm_get_msm_clk_rate(host, clock);
>  
> +	/*
> +	 * In general all timing modes are controlled via UHS mode select in
> +	 * Host Control2 register. eMMC specific HS200/HS400 doesn't have
> +	 * their respective modes defined here, hence we use these values.
> +	 *
> +	 * HS200 - SDR104 (Since they both are equivalent in functionality)
> +	 * HS400 - This involves multiple configurations
> +	 *		Initially SDR104 - when tuning is required as HS200
> +	 *		Then when switching to DDR @ 400MHz (HS400) we use
> +	 *		the vendor specific HC_SELECT_IN to control the mode.
> +	 *
> +	 * In addition to controlling the modes we also need to select the
> +	 * correct input clock for DLL depending on the mode.
> +	 *
> +	 * HS400 - divided clock (free running MCLK/2)
> +	 * All other modes - default (free running MCLK)
> +	 */
> +	if (curr_ios.timing == MMC_TIMING_MMC_HS400) {
> +		/* Select the divided clock (free running MCLK/2) */
> +		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +		config &= ~CORE_HC_MCLK_SEL_MASK;
> +		config |= CORE_HC_MCLK_SEL_HS400;
> +
> +		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
> +		/*
> +		 * Select HS400 mode using the HC_SELECT_IN from VENDOR SPEC
> +		 * register
> +		 */
> +		if (msm_host->tuning_done && !msm_host->calibration_done) {


In this patch, tuning_done and calibration_done are never true.  Is that
intended?


> +			/*
> +			 * Write 0x6 to HC_SELECT_IN and 1 to HC_SELECT_IN_EN
> +			 * field in VENDOR_SPEC_FUNC
> +			 */
> +			config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +			config |= CORE_HC_SELECT_IN_HS400;
> +			config |= CORE_HC_SELECT_IN_EN;
> +			writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
> +		}
> +	} else {
> +		/* Select the default clock (free running MCLK) */
> +		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +		config &= ~CORE_HC_MCLK_SEL_MASK;
> +		config |= CORE_HC_MCLK_SEL_DFLT;
> +		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
> +
> +		/*
> +		 * Disable HC_SELECT_IN to be able to use the UHS mode select
> +		 * configuration from Host Control2 register for all other
> +		 * modes.
> +		 *
> +		 * Write 0 to HC_SELECT_IN and HC_SELECT_IN_EN field
> +		 * in VENDOR_SPEC_FUNC
> +		 */
> +		config = readl_relaxed(host->ioaddr + CORE_VENDOR_SPEC);
> +		config &= ~CORE_HC_SELECT_IN_EN;
> +		config &= ~CORE_HC_SELECT_IN_MASK;
> +		writel_relaxed(config, host->ioaddr + CORE_VENDOR_SPEC);
> +	}
> +	wmb(); /* drain writebuffer */

Memory barrier could use more explanation.

> +
>  	if ((msm_clock != msm_host->clk_rate) && msm_host->clk_table) {
>  		rc = clk_set_rate(msm_host->clk, msm_clock);
>  		if (rc) {
> @@ -876,6 +973,11 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  	/* Set HC_MODE_EN bit in HC_MODE register */
>  	writel_relaxed(HC_MODE_EN, (msm_host->core_mem + CORE_HC_MODE));
>  
> +	/* Set FF_CLK_SW_RST_DIS bit in HC_MODE register */
> +	config = readl_relaxed(msm_host->core_mem + CORE_HC_MODE);
> +	config |= FF_CLK_SW_RST_DIS;
> +	writel_relaxed(config, msm_host->core_mem + CORE_HC_MODE);
> +
>  	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
>  	dev_dbg(&pdev->dev, "Host Version: 0x%x Vendor Version 0x%x\n",
>  		host_version, ((host_version & SDHCI_VENDOR_VER_MASK) >>
> 

