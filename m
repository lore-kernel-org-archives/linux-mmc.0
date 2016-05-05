From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [RFC v2 02/13] power/mmc: Move pwrseq drivers to power/pwrseq
Date: Thu, 5 May 2016 14:44:50 -0400
Message-ID: <4532bfb4-38f9-a61d-1d80-e5af18cd3d98@osg.samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-3-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1462451666-17945-3-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: tjakobi@math.uni-bielefeld.de, m.szyprowski@samsung.com, hverkuil@xs4all.nl, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hello Krzysztof,

On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
> The MMC power sequence drivers are useful also outside of MMC world: for
> USB devices needed a hard-reset before probing. Before extending and
> re-using pwrseq drivers, move them to a new place.
> 
> The commit does not introduce significant changes in the pwrseq drivers
> code so still all the functions are prefixed with "mmc_pwrseq". However
> the MMC-specific pwrseq functions has to be now exported and everything
> is hidden not by CONFIG_OF but by new CONFIG_POWER_SEQ option.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---

[snip]

> --- a/drivers/mmc/core/Kconfig
> +++ b/drivers/power/pwrseq/Kconfig
> @@ -1,7 +1,12 @@
> -#
> -# MMC core configuration
> -#
> -config PWRSEQ_EMMC
> +menuconfig POWER_SEQ
> +	default y if OF
> +	bool "Hardware reset support for specific devices"
> +	help
> +	  Provides drivers which reset the specific device before...
> +

I think this text could be improved a little bit, maybe something like:

"Provides drivers that implements specific power sequences for chips,
using the generic power sequence management interface".

The rest looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
