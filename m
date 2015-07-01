From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 1/8] pinctrl: sh-pfc: Implement pinconf power-source param for voltage switching
Date: Wed, 01 Jul 2015 10:24:05 +0300
Message-ID: <2811849.YDX6UYqz97@avalon>
References: <1435683177.23818.60.camel@codethink.co.uk> <1435683239.23818.61.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1435683239.23818.61.camel@codethink.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Tuesday 30 June 2015 17:53:59 Ben Hutchings wrote:
> The pfc in the R8A7790 (and probably others in the R-Car gen 2 family)
> supports switching SDHI signals between 3.3V and 1.8V nominal voltage,
> and the SD driver should do that when switching to and from UHS modes.
> 
> Add a flag for pins that have configurable I/O voltage and SoC
> operations to get and set the nominal voltage.  Implement the pinconf
> power-source parameter using these operations.
> 
> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  4 +-
>  drivers/pinctrl/sh-pfc/pinctrl.c                   | 44 ++++++++++++++++++-
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |  5 +++
>  3 files changed, 50 insertions(+), 3 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt index
> bfe72ec055e3..57487481ce8c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> @@ -69,7 +69,9 @@ Pin Configuration Node Properties:
> 
>  The pin configuration parameters use the generic pinconf bindings defined
> in pinctrl-bindings.txt in this directory. The supported parameters are
> -bias-disable, bias-pull-up and bias-pull-down.
> +bias-disable, bias-pull-up, bias-pull-down and power-source. For pins that
> +have a configurable I/O voltage, the power-source value should be the
> +nominal I/O voltage in millivolts.
> 
> 
>  GPIO
> diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c
> b/drivers/pinctrl/sh-pfc/pinctrl.c index 072e7c62cab7..72ae7d0d8b75 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -465,6 +465,9 @@ static bool sh_pfc_pinconf_validate(struct sh_pfc *pfc,
> unsigned int _pin, case PIN_CONFIG_BIAS_PULL_DOWN:
>  		return pin->configs & SH_PFC_PIN_CFG_PULL_DOWN;
> 
> +	case PIN_CONFIG_POWER_SOURCE:
> +		return pin->configs & SH_PFC_PIN_CFG_IO_VOLTAGE;
> +
>  	default:
>  		return false;
>  	}
> @@ -477,7 +480,6 @@ static int sh_pfc_pinconf_get(struct pinctrl_dev
> *pctldev, unsigned _pin, struct sh_pfc *pfc = pmx->pfc;
>  	enum pin_config_param param = pinconf_to_config_param(*config);
>  	unsigned long flags;
> -	unsigned int bias;
> 
>  	if (!sh_pfc_pinconf_validate(pfc, _pin, param))
>  		return -ENOTSUPP;
> @@ -485,7 +487,9 @@ static int sh_pfc_pinconf_get(struct pinctrl_dev
> *pctldev, unsigned _pin, switch (param) {
>  	case PIN_CONFIG_BIAS_DISABLE:
>  	case PIN_CONFIG_BIAS_PULL_UP:
> -	case PIN_CONFIG_BIAS_PULL_DOWN:
> +	case PIN_CONFIG_BIAS_PULL_DOWN: {
> +		unsigned int bias;
> +
>  		if (!pfc->info->ops || !pfc->info->ops->get_bias)
>  			return -ENOTSUPP;
> 
> @@ -498,6 +502,24 @@ static int sh_pfc_pinconf_get(struct pinctrl_dev
> *pctldev, unsigned _pin,
> 
>  		*config = 0;
>  		break;
> +	}
> +
> +	case PIN_CONFIG_POWER_SOURCE: {
> +		int ret;
> +
> +		if (!pfc->info->ops || !pfc->info->ops->get_io_voltage)
> +			return -ENOTSUPP;
> +
> +		spin_lock_irqsave(&pfc->lock, flags);
> +		ret = pfc->info->ops->get_io_voltage(pfc, _pin);
> +		spin_unlock_irqrestore(&pfc->lock, flags);
> +
> +		if (ret < 0)
> +			return ret;
> +
> +		*config = ret;
> +		break;
> +	}
> 
>  	default:
>  		return -ENOTSUPP;
> @@ -534,6 +556,24 @@ static int sh_pfc_pinconf_set(struct pinctrl_dev
> *pctldev, unsigned _pin,
> 
>  			break;
> 
> +		case PIN_CONFIG_POWER_SOURCE: {
> +			unsigned int arg =
> +				pinconf_to_config_argument(configs[i]);
> +			int ret;
> +
> +			if (!pfc->info->ops || !pfc->info->ops->set_io_voltage)
> +				return -ENOTSUPP;
> +
> +			spin_lock_irqsave(&pfc->lock, flags);
> +			ret = pfc->info->ops->set_io_voltage(pfc, _pin, arg);
> +			spin_unlock_irqrestore(&pfc->lock, flags);
> +
> +			if (ret)
> +				return ret;
> +
> +			break;
> +		}
> +
>  		default:
>  			return -ENOTSUPP;
>  		}
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index c7508d5f6886..734f7a92229c 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -12,6 +12,7 @@
>  #define __SH_PFC_H
> 
>  #include <linux/bug.h>
> +#include <linux/pinctrl/pinconf-generic.h>
>  #include <linux/stringify.h>
> 
>  enum {
> @@ -26,6 +27,7 @@ enum {
>  #define SH_PFC_PIN_CFG_OUTPUT		(1 << 1)
>  #define SH_PFC_PIN_CFG_PULL_UP		(1 << 2)
>  #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
> +#define SH_PFC_PIN_CFG_IO_VOLTAGE	(1 << 4)
>  #define SH_PFC_PIN_CFG_NO_GPIO		(1 << 31)
> 
>  struct sh_pfc_pin {
> @@ -121,6 +123,9 @@ struct sh_pfc_soc_operations {
>  	unsigned int (*get_bias)(struct sh_pfc *pfc, unsigned int pin);
>  	void (*set_bias)(struct sh_pfc *pfc, unsigned int pin,
>  			 unsigned int bias);
> +	int (*get_io_voltage)(struct sh_pfc *pfc, unsigned int pin);
> +	int (*set_io_voltage)(struct sh_pfc *pfc, unsigned int pin,
> +			      u16 voltage_mV);
>  };
> 
>  struct sh_pfc_soc_info {

-- 
Regards,

Laurent Pinchart

