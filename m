From: icenowy@aosc.io
Subject: Re: [PATCH 1/2] clk: sunxi-ng: Provide a default reset hook
Date: Sun, 27 Aug 2017 21:01:04 +0800
Message-ID: <884514a2d304315f54dc81b8b42aea74@aosc.io>
References: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20170825094953.3247-1-maxime.ripard@free-electrons.com>
Sender: linux-clk-owner@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Mike Turquette <mturquette@baylibre.com>, linux-mmc@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

在 2017-08-25 17:49，Maxime Ripard 写道：
> The reset hook was left implemented. Provide a dumb implementation so 
> that
> client drivers can depend on it.

I think some clients should also convert to use this.

For example:

- The TCON driver in sun4i-drm. (It now uses reset_control_status, but
   this is also not implemented in CCU.)
- The EPHY in dwmac-sun8i driver. (It uses explicit assert then 
deassert)

P.S. maybe the status hook should also be implemented?

> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/ccu_reset.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clk/sunxi-ng/ccu_reset.c 
> b/drivers/clk/sunxi-ng/ccu_reset.c
> index 6c31d48783a7..1dc4e98ea802 100644
> --- a/drivers/clk/sunxi-ng/ccu_reset.c
> +++ b/drivers/clk/sunxi-ng/ccu_reset.c
> @@ -8,6 +8,7 @@
>   * the License, or (at your option) any later version.
>   */
> 
> +#include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/reset-controller.h>
> 
> @@ -49,7 +50,18 @@ static int ccu_reset_deassert(struct
> reset_controller_dev *rcdev,
>  	return 0;
>  }
> 
> +static int ccu_reset_reset(struct reset_controller_dev *rcdev,
> +			   unsigned long id)
> +{
> +	ccu_reset_assert(rcdev, id);
> +	udelay(10);
> +	ccu_reset_deassert(rcdev, id);
> +
> +	return 0;
> +}
> +
>  const struct reset_control_ops ccu_reset_ops = {
>  	.assert		= ccu_reset_assert,
>  	.deassert	= ccu_reset_deassert,
> +	.reset		= ccu_reset_reset,
>  };
