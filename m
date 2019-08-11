From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 07/18] clk: bcm2835: Introduce SoC specific clock
 registration
Date: Sun, 11 Aug 2019 22:43:41 +0200
Message-ID: <25c31fa6-6190-2742-07ab-4b34c3e08947@i2se.com>
References: <1563774880-8061-1-git-send-email-wahrenst@gmx.net>
 <1563774880-8061-8-git-send-email-wahrenst@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563774880-8061-8-git-send-email-wahrenst@gmx.net>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <wahrenst@gmx.net>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Matthias Brugger <mbrugger@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-gpio@vger.kernel.org, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com
List-Id: linux-mmc@vger.kernel.org

Hi,

Am 22.07.19 um 07:54 schrieb Stefan Wahren:
> In order to support SoC specific clocks (e.g. emmc2 for BCM2711), we
> extend the description with a SoC support flag. This approach avoids long
> and mostly redundant lists of clock IDs.
>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 103 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 86 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 867ae3c..3231b76 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -31,7 +31,7 @@
>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> -#include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <dt-bindings/clock/bcm2835.h>
> @@ -289,6 +289,9 @@
>  #define LOCK_TIMEOUT_NS		100000000
>  #define BCM2835_MAX_FB_RATE	1750000000u
>
> +#define SOC_BCM2835		BIT(0)
> +#define SOC_ALL			(SOC_BCM2835)
> +
...
>  		.cm_reg = CM_PLLD,
> @@ -1775,6 +1805,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  	 * It is in the HDMI power domain.
>  	 */
>  	[BCM2835_PLLH]		= REGISTER_PLL(
> +		SOC_ALL,
>  		"pllh",
>  		.cm_ctrl_reg = CM_PLLH,
>  		.a2w_ctrl_reg = A2W_PLLH_CTRL,
> @@ -1789,6 +1820,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.max_rate = 3000000000u,
>  		.max_fb_rate = BCM2835_MAX_FB_RATE),
>  	[BCM2835_PLLH_RCAL]	= REGISTER_PLL_DIV(
> +		SOC_ALL,
>  		.name = "pllh_rcal",
>  		.source_pll = "pllh",
>  		.cm_reg = CM_PLLH,
> @@ -1798,6 +1830,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.fixed_divider = 10,
>  		.flags = CLK_SET_RATE_PARENT),
>  	[BCM2835_PLLH_AUX]	= REGISTER_PLL_DIV(
> +		SOC_ALL,
>  		.name = "pllh_aux",
>  		.source_pll = "pllh",
>  		.cm_reg = CM_PLLH,
> @@ -1807,6 +1840,7 @@ static const struct bcm2835_clk_desc clk_desc_array[] = {
>  		.fixed_divider = 1,
>  		.flags = CLK_SET_RATE_PARENT),
>  	[BCM2835_PLLH_PIX]	= REGISTER_PLL_DIV(
> +		SOC_ALL,
>  		.name = "pllh_pix",
>  		.source_pll = "pllh",
>  		.cm_reg = CM_PLLH,
i was informed that at least all PLLH related clocks are BCM2835
specific. So please don't apply this patch. I will send a fixed version
soon.
