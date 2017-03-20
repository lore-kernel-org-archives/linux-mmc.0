From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH v2 06/14] mmc: dw_mmc: simplify optional reset handling
Date: Mon, 20 Mar 2017 10:22:54 +0100
Message-ID: <e70d77e9-bd60-a0f4-6510-48b72cb67624@samsung.com>
References: <20170315113139.17989-1-p.zabel@pengutronix.de>
 <CGME20170320092255eucas1p1459c023fd9b479c8e5323a6ac97dbf58@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20170315113139.17989-1-p.zabel@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>, linux-mmc@vger.kernel.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, "Szyprowski, Marek" <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi Philipp,

Todays next branch does not work with exynos5433-tm2 board.
I guess this patch causes regression. On MMC without reset controller I
get errors:
[    4.938222] dwmmc_exynos 15540000.mshc: platform data not available
[    4.943268] dwmmc_exynos: probe of 15540000.mshc failed with error -22
[    4.950184] dwmmc_exynos 15560000.mshc: platform data not available
[    4.955962] dwmmc_exynos: probe of 15560000.mshc failed with error -22

Commenting out reset controller get and error checks 'fixes' the issue.

On 15.03.2017 12:31, Philipp Zabel wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
> 
> This allows to return errors from devm_reset_control_get_optional and to
> call reset_control_(de)assert unconditionally.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/mmc/host/dw_mmc.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a9ac0b4573131..3d62b0a1f81cb 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2968,10 +2968,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  
>  	/* find reset controller when exist */
>  	pdata->rstc = devm_reset_control_get_optional(dev, "reset");
> -	if (IS_ERR(pdata->rstc)) {
> -		if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
> -			return ERR_PTR(-EPROBE_DEFER);
> -	}
> +	if (IS_ERR(pdata->rstc))
> +		return ERR_CAST(pdata->rstc);


With three lines above commented out it works.

Regards
Andrzej
