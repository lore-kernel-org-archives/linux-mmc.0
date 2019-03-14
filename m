From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V3 07/10] mmc: tegra: add Tegra186 WAR for CQE
Date: Thu, 14 Mar 2019 11:04:59 +0530
Message-ID: <55701d04-1e55-e0a0-ecd7-d31eaec5240d@codeaurora.org>
References: <1552513552-23423-1-git-send-email-skomatineni@nvidia.com>
 <1552513552-23423-7-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552513552-23423-7-git-send-email-skomatineni@nvidia.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>, adrian.hunter@intel.com, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 3/14/2019 3:15 AM, Sowjanya Komatineni wrote:
> Tegra186 CQHCI host has a known bug where CQHCI controller selects
> DATA_PRESENT_SELECT bit to 1 for DCMDs with R1B response type and
> since DCMD does not trigger any data transfer, DCMD task complete
> happens leaving the DATA FSM of host controller in wait state for
> the data.
>
> This effects the data transfer tasks issued after the DCMDs with
> R1b response type resulting in timeout.
>
> SW WAR is to set CMD_TIMING to 1 in DCMD task descriptor. This bug
> and SW WAR is applicable only for Tegra186 and not for Tegra194.
>
> This patch implements this WAR thru NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING
> for Tegra186 and also implements update_dcmd_desc of cqhci_host_ops
> interface to set CMD_TIMING bit depending on the NVQUIRK.
>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>

Thanks,

Reviewed-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>   drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
> index f1aa0591112a..2f08b6e480df 100644
> --- a/drivers/mmc/host/sdhci-tegra.c
> +++ b/drivers/mmc/host/sdhci-tegra.c
> @@ -106,6 +106,7 @@
>   #define NVQUIRK_HAS_PADCALIB				BIT(6)
>   #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
>   #define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
> +#define NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING		BIT(9)
>   
>   /* SDMMC CQE Base Address for Tegra Host Ver 4.1 and Higher */
>   #define SDHCI_TEGRA_CQE_BASE_ADDR			0xF000
> @@ -1123,6 +1124,18 @@ static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
>   		tegra_host->pad_calib_required = true;
>   }
>   
> +static void sdhci_tegra_update_dcmd_desc(struct mmc_host *mmc,
> +					 struct mmc_request *mrq, u64 *data)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(mmc_priv(mmc));
> +	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
> +	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
> +
> +	if (soc_data->nvquirks & NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING &&
> +	    mrq->cmd->flags & MMC_RSP_R1B)
> +		*data |= CQHCI_CMD_TIMING(1);
> +}
> +
>   static void sdhci_tegra_cqe_enable(struct mmc_host *mmc)
>   {
>   	struct cqhci_host *cq_host = mmc->cqe_private;
> @@ -1164,6 +1177,7 @@ static const struct cqhci_host_ops sdhci_tegra_cqhci_ops = {
>   	.enable	= sdhci_tegra_cqe_enable,
>   	.disable = sdhci_cqe_disable,
>   	.dumpregs = sdhci_tegra_dumpregs,
> +	.update_dcmd_desc = sdhci_tegra_update_dcmd_desc,
>   };
>   
>   static const struct sdhci_ops tegra_sdhci_ops = {
> @@ -1345,7 +1359,8 @@ static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
>   		    NVQUIRK_HAS_PADCALIB |
>   		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP |
>   		    NVQUIRK_ENABLE_SDR50 |
> -		    NVQUIRK_ENABLE_SDR104,
> +		    NVQUIRK_ENABLE_SDR104 |
> +		    NVQUIRK_CQHCI_DCMD_R1B_CMD_TIMING,
>   	.min_tap_delay = 84,
>   	.max_tap_delay = 136,
>   };
