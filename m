From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 10/11] phy: rockchip-emmc: Set phyctrl_frqsel based on
 card clock
Date: Sat, 18 Jun 2016 14:20:45 +0200
Message-ID: <1814673.npx1FlT4Pz@diego>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-11-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1465859076-4868-11-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Am Montag, 13. Juni 2016, 16:04:34 schrieb Douglas Anderson:
> The "phyctrl_frqsel" is described in the Arasan datasheet [1] as "the
> frequency range of DLL operation".  Although the Rockchip variant of
> this PHY has different ranges than the reference Arasan PHY it appears
> as if the functionality is similar.  We should set this phyctrl field
> properly.
> 
> Note: as per Rockchip engineers, apparently the "phyctrl_frqsel" is
> actually only useful in HS200 / HS400 modes even though the DLL itself
> it used for some purposes in all modes.  See the discussion in the
> earlier change in this series: ("mmc: sdhci-of-arasan: Always power the
> PHY off/on when clock changes").  In any case, it shouldn't hurt to set
> this always.
> 
> Note that this change should allow boards to run at HS200 / HS400 speed
> modes while running at 100 MHz or 150 MHz.  In fact, running HS400 at
> 150 MHz (giving 300 MB/s) is the main motivation of this series, since
> performance is still good but signal integrity problems are less
> prevelant at 150 MHz.
> 
> [1]: https://arasan.com/wp-content/media/eMMC-5-1-Total-Solution_Rev-1-3.pdf
> 
> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
> Changes in v2:
> - Warn if we're more than 15 MHz from ideal rate (Shawn)
> - Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)
> - Fix typo USB => SDHCI (Shawn)
> 
>  drivers/phy/phy-rockchip-emmc.c | 82
> ++++++++++++++++++++++++++++++++++------- 1 file changed, 69 insertions(+),
> 13 deletions(-)
> 
> diff --git a/drivers/phy/phy-rockchip-emmc.c
> b/drivers/phy/phy-rockchip-emmc.c index 23fe50864526..51ddd543fd04 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -14,6 +14,7 @@
>   * GNU General Public License for more details.
>   */
> 
> +#include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> @@ -78,16 +79,73 @@
>  struct rockchip_emmc_phy {
>  	unsigned int	reg_offset;
>  	struct regmap	*reg_base;
> +	struct clk	*emmcclk;
>  };
> 
> -static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
> -				   bool on_off)
> +static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>  {
> +	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>  	unsigned int caldone;
>  	unsigned int dllrdy;
> +	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
>  	unsigned long timeout;
> 
>  	/*
> +	 * We purposely get the clock here and not in probe to avoid the
> +	 * circular dependency problem.  We expect:
> +	 * - PHY driver to probe
> +	 * - SDHCI driver to start probe
> +	 * - SDHCI driver to register it's clock
> +	 * - SDHCI driver to get the PHY
> +	 * - SDHCI driver to power on the PHY
> +	 */

Doesn't that leave open the unbind / removal case with that same circular 
dependency? While true that the clock-framework does some special handling on 
clk_unregister, I don't think this would catch multiple unbind/bind actions.

The emmc-phy would still hold on to the old clock-instance with the empty clk-
ops the ccf assigns, even when the rebind of the arasan-sdhci would create a 
new clock.

How about using phy-init / phy-exit callbacks for that instead? (Aka clk_get 
and clk_put the emmc clock in there instead of using the devm variant)


> +	if (!rk_phy->emmcclk) {
> +		rk_phy->emmcclk = devm_clk_get(&phy->dev, "emmcclk");
> +
> +		/* Don't expect defer at this point; try next time */
> +		if (PTR_ERR(rk_phy->emmcclk) == -EPROBE_DEFER) {
> +			dev_warn(&phy->dev, "Unexpected emmcclk defer\n");
> +			rk_phy->emmcclk = NULL;
> +		}
> +	}
> +
> +	if (!IS_ERR_OR_NULL(rk_phy->emmcclk)) {

you just made it NULL in the error case above?


Heiko
