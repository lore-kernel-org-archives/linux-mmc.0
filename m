From: Robin van der Gracht <robin@protonic.nl>
Subject: Re: [PATCH] mmc: mxs-mmc: Introduce regulator support
Date: Fri, 25 Jan 2019 15:52:48 +0100
Message-ID: <20190125155248.23937600@erd987>
References: <20190125113449.10128-1-martink@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190125113449.10128-1-martink@posteo.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Martin Kepplinger <martink@posteo.de>
Cc: ulf.hansson@linaro.org, s.hauer@pengutronix.de, Martin Kepplinger <martin.kepplinger@ginzinger.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Martin,

On Fri, 25 Jan 2019 12:34:49 +0100
Martin Kepplinger <martink@posteo.de> wrote:

> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> This adds support for explicitly switching the mmc's power on and off.
> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
> 
> This is not my patch. It's taken from https://patchwork.kernel.org/patch/4365751/
> rebased and minimally changed; but we use this.
> 
> Are there any objections to this?
> 
> Robin, can I still add your Signed-off-by to this? Also, should I set you
> as the author?

It's old, but thanks for keeping me in the loop :)

> 
> thanks,
> 
>                                 martin
> 
>  drivers/mmc/host/mxs-mmc.c | 31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index add1e70195ea..e3c19fabb723 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -517,6 +517,26 @@ static void mxs_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	else
>  		host->bus_width = 0;
>  
> +	if (ios->power_mode != host->power_mode) {
> +		switch (ios->power_mode) {
> +		case MMC_POWER_OFF:
> +			if ((host->vmmc) && regulator_disable(host->vmmc)) {
> +				dev_err(mmc_dev(host->mmc),
> +					"Failed to disable vmmc regulator\n");
> +			}
> +			break;
> +		case MMC_POWER_UP:
> +			if ((host->vmmc) && regulator_enable(host->vmmc)) {
> +				dev_err(mmc_dev(host->mmc),
> +					"Failed to enable vmmc regulator\n");
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +		host->power_mode = ios->power_mode;
> +	}
> +

A single check in the root contitional for the availability of vmmc
should suffice, so:

if (host->vmmc && ios->power_mode != host->power_mode) {
	...
	case MMC_POWER_XX:
		if (regulator_xx(host->vmmc))
			dev_err;
	...


>  	if (ios->clock)
>  		mxs_ssp_set_clk_rate(&host->ssp, ios->clock);
>  }
> @@ -613,16 +633,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>  
>  	host->mmc = mmc;
>  	host->sdio_irq_en = 0;
> +	host->power_mode = MMC_POWER_OFF;

My patch added 'power_mode' and 'vmmc' to the drivers private struct
(which are missing in this email?)

>  
>  	reg_vmmc = devm_regulator_get(&pdev->dev, "vmmc");
> -	if (!IS_ERR(reg_vmmc)) {
> -		ret = regulator_enable(reg_vmmc);
> -		if (ret) {
> -			dev_err(&pdev->dev,
> -				"Failed to enable vmmc regulator: %d\n", ret);
> -			goto out_mmc_free;
> -		}
> -	}
> +	if (!IS_ERR(reg_vmmc))
> +		host->vmmc = reg_vmmc;

what about mmc_regulator_get_supply(mmc)?

If we use that the vmmc will be made available under mmv->supply->vmmc
if probe was successfull instead of storing it in the drivers private
struct.

>  
>  	ssp->clk = devm_clk_get(&pdev->dev, NULL);
>  	if (IS_ERR(ssp->clk)) {

Robin van der Gracht
