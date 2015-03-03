From: Maxime Coquelin <maxime.coquelin@st.com>
Subject: Re: [PATCH v2 5/8] mmc: sdhci-st: Add sdhci_st_set_uhs_signaling
 function.
Date: Tue, 3 Mar 2015 11:56:34 +0100
Message-ID: <54F59362.40605@st.com>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org> <1424956227-18258-6-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424956227-18258-6-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-mmc@vger.kernel.org


On 02/26/2015 02:10 PM, Peter Griffin wrote:
> To allow UHS modes to work properly we need to provide the st specific
> set_uhs_signaling callback function. This function differs from the
> generic sdhci_set_uhs_signaling callback in that we need to configure
> the correct delay depending on the UHS mode, and also set the V18_EN
> bit.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>   drivers/mmc/host/sdhci-st.c | 50 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
> index 11cf4e2..d53bc82 100644
> --- a/drivers/mmc/host/sdhci-st.c
> +++ b/drivers/mmc/host/sdhci-st.c
> @@ -260,6 +260,55 @@ static int sdhci_st_set_dll_for_clock(struct sdhci_host *host)
>   	return ret;
>   }
>   
> +static void sdhci_st_set_uhs_signaling(struct sdhci_host *host,
> +					unsigned int uhs)
> +{
> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +	struct st_mmc_platform_data *pdata = pltfm_host->priv;
> +	u16 ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> +	int ret = 0;
> +
> +	/* Select Bus Speed Mode for host */
> +	ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
> +	switch (uhs) {
> +	/*
> +	 * Set V18_EN -- UHS modes do not work without this.
> +	 * does not change signaling voltage
> +	 */
> +
> +	case MMC_TIMING_UHS_SDR12:
> +		st_mmcss_set_static_delay(pdata->top_ioaddr);
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR12 | SDHCI_CTRL_VDD_180;
> +		break;
> +	case MMC_TIMING_UHS_SDR25:
> +		st_mmcss_set_static_delay(pdata->top_ioaddr);
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR25 | SDHCI_CTRL_VDD_180;
> +		break;
> +	case MMC_TIMING_UHS_SDR50:
> +		st_mmcss_set_static_delay(pdata->top_ioaddr);
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR50 | SDHCI_CTRL_VDD_180;
> +		ret = sdhci_st_set_dll_for_clock(host);
> +		break;
> +	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_MMC_HS200:
> +		st_mmcss_set_static_delay(pdata->top_ioaddr);
> +		ctrl_2 |= SDHCI_CTRL_UHS_SDR104 | SDHCI_CTRL_VDD_180;
> +		ret =  sdhci_st_set_dll_for_clock(host);
> +		break;
> +	case MMC_TIMING_UHS_DDR50:
> +	case MMC_TIMING_MMC_DDR52:
> +		st_mmcss_set_static_delay(pdata->top_ioaddr);
> +		ctrl_2 |= SDHCI_CTRL_UHS_DDR50 | SDHCI_CTRL_VDD_180;
> +		break;
> +	}
> +
> +	if (ret)
> +		dev_warn(mmc_dev(host->mmc), "Error setting dll for clock\n");
Maybe you could  print the uhs value to know which mode it was trying to 
set?
> +
> +	dev_dbg(mmc_dev(host->mmc), "uhs %d, ctrl_2 %04X\n", uhs, ctrl_2);
> +
> +	sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +}
>   
>   static u32 sdhci_st_readl(struct sdhci_host *host, int reg)
>   {
> @@ -283,6 +332,7 @@ static const struct sdhci_ops sdhci_st_ops = {
>   	.set_bus_width = sdhci_set_bus_width,
>   	.read_l = sdhci_st_readl,
>   	.reset = sdhci_reset,
> +	.set_uhs_signaling = sdhci_st_set_uhs_signaling,
>   };
>   
>   static const struct sdhci_pltfm_data sdhci_st_pdata = {

Other than that, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
