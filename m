From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH V1 01/11] mmc: tegra: fix ddr signaling for non-ddr modes
Date: Thu, 7 Mar 2019 21:31:36 +0000
Message-ID: <ff9d8656-fc4b-e460-d72b-2cb7ec4985ea@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, riteshh@codeaurora.org
Cc: thierry.reding@gmail.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Sowjanya,

On 02/03/2019 05:20, Sowjanya Komatineni wrote:
> ddr_signaling is set to true for DDR50 and DDR52 modes but is
> not set back to false for other modes. This programs incorrect
> host clock when mode change happens from DDR52/DDR50 to other
> SDR or HS modes like incase of mmc_retune where it switches
> from HS400 to HS DDR and then from HS DDR to HS mode and then
> to HS200.
> 
> This patch fixes the ddr_signaling to set properly for non DDR
> modes.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index 32e62904c0d3..46086dd43bfb 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -779,6 +779,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
>  	bool set_dqs_trim = false;
>  	bool do_hs400_dll_cal = false;
>  
> +	tegra_host->ddr_signaling = false;
>  	switch (timing) {
>  	case MMC_TIMING_UHS_SDR50:
>  	case MMC_TIMING_UHS_SDR104:

I have tested this series on Tegra210, Tegra186 and Tegra194 and see no
further issues. Thanks for getting this out! Feel free to add my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
