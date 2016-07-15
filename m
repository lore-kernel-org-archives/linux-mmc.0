From: Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: mmc: dwmmc: exynos: Warn if HS400 is being used on non-Exynos5420
 chipset
Date: Fri, 15 Jul 2016 09:45:59 +0530
Message-ID: <5788637F.2070908@samsung.com>
References: <1468502547-18571-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1468502547-18571-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene@kernel.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Krzysztof,

On 07/14/2016 06:52 PM, Krzysztof Kozlowski wrote:
> Chipsets before Exynos5420 did not support HS400 so if MMC core tries to
> configure HS400 timing, this might or might not work.  Warn in such
> cases because this is DTB misconfiguration.
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>   drivers/mmc/host/dw_mmc-exynos.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index da0ef1765735..7ab3d749b5ae 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -225,8 +225,12 @@ static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
>   	 * Not supported to configure register
>   	 * related to HS400
>   	 */
> -	if (priv->ctrl_type < DW_MCI_TYPE_EXYNOS5420)
> +	if (priv->ctrl_type < DW_MCI_TYPE_EXYNOS5420) {
> +		if (timing == MMC_TIMING_MMC_HS400)
> +			dev_warn(host->dev,
> +				 "cannot configure HS400, unsupported chipset\n");
>   		return;
> +	}
>
It is good to have extra bit of debug information handy.

>   	dqs = priv->saved_dqs_en;
>   	strobe = priv->saved_strobe_ctrl;
>
