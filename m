From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/3] mmc: dw_mmc: k3: support hi6220
Date: Thu, 14 May 2015 07:17:12 +0900
Message-ID: <5553CD68.8000101@samsung.com>
References: <1430985401-12202-1-git-send-email-zhangfei.gao@linaro.org>
 <1430985401-12202-4-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:62476 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754671AbbEMWRP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 May 2015 18:17:15 -0400
In-reply-to: <1430985401-12202-4-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, "Jorge A. Ramirez-Ortiz" <jorge.ramirez-ortiz@linaro.org>, Dan Yuan <yuandan@hisilicon.com>

On 05/07/2015 04:56 PM, Zhangfei Gao wrote:
> Support hi6220, tested on hikey board
> emmc: support hs
> sd: support hs, sdr12, sdr25
> 
> Signed-off-by: Jorge A. Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Dan Yuan <yuandan@hisilicon.com>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-k3.c | 101 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> index 650f9cc..bc16bee 100644
> --- a/drivers/mmc/host/dw_mmc-k3.c
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -8,16 +8,28 @@
>   * (at your option) any later version.
>   */
>  
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/clk.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/dw_mmc.h>
> +#include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
>  
> +#define AO_SCTRL_SEL18		BIT(10)
> +#define AO_SCTRL_CTRL3		0x40C

how about adding the comment?

> +
> +#define SDMMC_CMD_DISABLE_BOOT	BIT(26)

I can't find where this define is used.

> +
> +struct k3_priv {
> +	struct regmap	*reg;
> +};
> +
>  static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>  	int ret;
> @@ -33,8 +45,93 @@ static const struct dw_mci_drv_data k3_drv_data = {
>  	.set_ios		= dw_mci_k3_set_ios,
>  };
>  
> +static int dw_mci_hi6220_parse_dt(struct dw_mci *host)
> +{
> +	struct k3_priv *priv;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->reg = syscon_regmap_lookup_by_phandle(host->dev->of_node,
> +					 "hisilicon,peripheral-syscon");
> +	if (IS_ERR(priv->reg))
> +		priv->reg = NULL;
> +
> +	host->priv = priv;
> +	return 0;
> +}
> +
> +static int dw_mci_hi6220_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct dw_mci_slot *slot = mmc_priv(mmc);
> +	struct k3_priv *priv;
> +	struct dw_mci *host;
> +	int min_uv, max_uv;
> +	int ret;
> +
> +	host = slot->host;
> +	priv = host->priv;
> +
> +	if (!priv || !priv->reg)
> +		return 0;

Is it right that return to 0?

> +
> +	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
> +		ret = regmap_update_bits(priv->reg, AO_SCTRL_CTRL3,
> +					 AO_SCTRL_SEL18, 0);
> +		min_uv = 3000000;
> +		max_uv = 3000000;
> +	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
> +		ret = regmap_update_bits(priv->reg, AO_SCTRL_CTRL3,
> +					 AO_SCTRL_SEL18, AO_SCTRL_SEL18);
> +		min_uv = 1800000;
> +		max_uv = 1800000;

max_uv and min_uv are fixed as 3.0v and 1.8V?

> +	} else {
> +		dev_dbg(host->dev, "voltage not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ret) {
> +		dev_dbg(host->dev, "switch voltage failed\n");
> +		return ret;
> +	}
> +
> +	if (IS_ERR_OR_NULL(mmc->supply.vqmmc))
> +		return 0;
> +
> +	ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
> +	if (ret) {
> +		dev_dbg(host->dev, "Regulator set error %d: %d - %d\n",
> +				 ret, min_uv, max_uv);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +	int ret;
> +	unsigned int clock;
> +
> +	clock = (ios->clock <= 25000000) ? 25000000 : ios->clock;
> +
> +	ret = clk_set_rate(host->biu_clk, clock);
> +	if (ret)
> +		dev_warn(host->dev, "failed to set rate %uHz\n", clock);
> +
> +	host->bus_hz = clk_get_rate(host->biu_clk);
> +}
> +
> +static const struct dw_mci_drv_data hi6220_data = {
> +	.switch_voltage		= dw_mci_hi6220_switch_voltage,
> +	.set_ios		= dw_mci_hi6220_set_ios,
> +	.parse_dt		= dw_mci_hi6220_parse_dt,
> +};
> +
>  static const struct of_device_id dw_mci_k3_match[] = {
>  	{ .compatible = "hisilicon,hi4511-dw-mshc", .data = &k3_drv_data, },
> +	{ .compatible = "hisilicon,hi6220-dw-mshc", .data = &hi6220_data, },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_k3_match);
> 

