From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 2/6] pinctrl: sh-pfc: Implement pinconf power-source param for voltage switching
Date: Mon, 29 Jun 2015 11:32:38 +0300
Message-ID: <3056637.adr2b5Zij1@avalon>
References: <1435332116.23818.7.camel@codethink.co.uk> <1435332204.23818.9.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1435332204.23818.9.camel@codethink.co.uk>
Sender: linux-sh-owner@vger.kernel.org
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Ian Molton <ian@mnementh.co.uk>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@lists.codethink.co.uk, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Hi Ben,

Thank you for the patch.

On Friday 26 June 2015 16:23:24 Ben Hutchings wrote:
> The pfc in the R8A7790 (and probably others in the R-Car gen 2 family)
> supports switching SDHI signals between 3.3V and 1.8V voltage, and the
> SD driver should do that when selecting a higher-speed mode.
> 
> Add a flag for pins that support low voltage mode and SoC operations to
> get and set it.  Implement the pinconf power-source parameter using these
> operations.

As Geert has already pointed out, we should use an integer value instead of a 
boolean for voltages. How about expressing them in microvolts as done by the 
regulators API ?

Apart from that the patch looks quite good to me. Please see below for a 
couple of other comments.

> Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |  4 ++-
>  drivers/pinctrl/sh-pfc/pinctrl.c                   | 34 +++++++++++++++++--
>  drivers/pinctrl/sh-pfc/sh_pfc.h                    |  6 ++++
>  3 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt index
> bfe72ec055e3..93651742f1c1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> @@ -69,7 +69,9 @@ Pin Configuration Node Properties:
> 
>  The pin configuration parameters use the generic pinconf bindings defined
> in pinctrl-bindings.txt in this directory. The supported parameters are
> -bias-disable, bias-pull-up and bias-pull-down.
> +bias-disable, bias-pull-up, bias-pull-down and power-source. For pins that
> +can operate with either 3.3V or 1.8V signals, the power-source value should
> +be 0 for 3.3V or 1 for 1.8V.
> 
> 
>  GPIO
> diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c
> b/drivers/pinctrl/sh-pfc/pinctrl.c index 072e7c62cab7..fa4066d4bc61 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -465,6 +465,9 @@ static bool sh_pfc_pinconf_validate(struct sh_pfc *pfc,
> unsigned int _pin, case PIN_CONFIG_BIAS_PULL_DOWN:
>  		return pin->configs & SH_PFC_PIN_CFG_PULL_DOWN;
> 
> +	case PIN_CONFIG_POWER_SOURCE:
> +		return pin->configs & SH_PFC_PIN_CFG_LOW_VOLTAGE;
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
> @@ -498,6 +502,16 @@ static int sh_pfc_pinconf_get(struct pinctrl_dev
> *pctldev, unsigned _pin,
> 
>  		*config = 0;
>  		break;
> +	}
> +
> +	case PIN_CONFIG_POWER_SOURCE:
> +		if (!pfc->info->ops || !pfc->info->ops->get_low_voltage)
> +			return -ENOTSUPP;
> +
> +		spin_lock_irqsave(&pfc->lock, flags);
> +		*config = pfc->info->ops->get_low_voltage(pfc, _pin);
> +		spin_unlock_irqrestore(&pfc->lock, flags);
> +		break;
> 
>  	default:
>  		return -ENOTSUPP;
> @@ -534,6 +548,22 @@ static int sh_pfc_pinconf_set(struct pinctrl_dev
> *pctldev, unsigned _pin,
> 
>  			break;
> 
> +		case PIN_CONFIG_POWER_SOURCE: {
> +			unsigned int arg =
> +				pinconf_to_config_argument(configs[i]);
> +
> +			if (!pfc->info->ops || !pfc->info->ops->set_low_voltage)
> +				return -ENOTSUPP;
> +			if (arg > 1)
> +				return -ENOTSUPP;
> +
> +			spin_lock_irqsave(&pfc->lock, flags);
> +			pfc->info->ops->set_low_voltage(pfc, _pin, arg);
> +			spin_unlock_irqrestore(&pfc->lock, flags);
> +
> +			break;
> +		}
> +
>  		default:
>  			return -ENOTSUPP;
>  		}
> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
> b/drivers/pinctrl/sh-pfc/sh_pfc.h index c7508d5f6886..b95d60bf2f1b 100644
> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -13,6 +13,7 @@
> 
>  #include <linux/bug.h>
>  #include <linux/stringify.h>
> +#include <linux/pinctrl/pinconf-generic.h>

Could you please keep the headers alphabetically sorted ?

> 
>  enum {
>  	PINMUX_TYPE_NONE,
> @@ -26,8 +27,11 @@ enum {
>  #define SH_PFC_PIN_CFG_OUTPUT		(1 << 1)
>  #define SH_PFC_PIN_CFG_PULL_UP		(1 << 2)
>  #define SH_PFC_PIN_CFG_PULL_DOWN	(1 << 3)
> +#define SH_PFC_PIN_CFG_LOW_VOLTAGE	(1 << 4)

As we should move away from using a bool to represent the voltage, I would 
name this SH_PFC_PIN_CFG_IO_VOLTAGE, or possibly SH_PFC_PIN_CFG_POWER_SOURCE.

>  #define SH_PFC_PIN_CFG_NO_GPIO		(1 << 31)
> 
> +struct sh_pfc;
> +

I don't think this is needed, struct sh_pfc is already forward-declared right 
above struct sh_pfc_soc_operations.

>  struct sh_pfc_pin {
>  	u16 pin;
>  	u16 enum_id;
> @@ -121,6 +125,8 @@ struct sh_pfc_soc_operations {
>  	unsigned int (*get_bias)(struct sh_pfc *pfc, unsigned int pin);
>  	void (*set_bias)(struct sh_pfc *pfc, unsigned int pin,
>  			 unsigned int bias);
> +	bool (*get_low_voltage)(struct sh_pfc *pfc, unsigned int pin);
> +	void (*set_low_voltage)(struct sh_pfc *pfc, unsigned int pin, bool low);

[gs]et_io_voltage() or [gs]et_power_source() ?

>  };
> 
>  struct sh_pfc_soc_info {

-- 
Regards,

Laurent Pinchart
-- 
Regards,

Laurent Pinchart

