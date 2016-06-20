From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 10/11] phy: rockchip-emmc: Set phyctrl_frqsel based on
 card clock
Date: Mon, 20 Jun 2016 18:38:30 +0530
Message-ID: <5767EACE.6030304@ti.com>
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
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org



On Tuesday 14 June 2016 04:34 AM, Douglas Anderson wrote:
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

Acked-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
> Changes in v2:
> - Warn if we're more than 15 MHz from ideal rate (Shawn)
> - Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)
> - Fix typo USB => SDHCI (Shawn)
> 
>  drivers/phy/phy-rockchip-emmc.c | 82 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 69 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 23fe50864526..51ddd543fd04 100644
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
> +		unsigned long rate = clk_get_rate(rk_phy->emmcclk);
> +		unsigned long ideal_rate;
> +		unsigned long diff;
> +
> +		switch (rate) {
> +		case 0 ... 74999999:
> +			ideal_rate = 50000000;
> +			freqsel = PHYCTRL_FREQSEL_50M;
> +			break;
> +		case 75000000 ... 124999999:
> +			ideal_rate = 100000000;
> +			freqsel = PHYCTRL_FREQSEL_100M;
> +			break;
> +		case 125000000 ... 174999999:
> +			ideal_rate = 150000000;
> +			freqsel = PHYCTRL_FREQSEL_150M;
> +			break;
> +		default:
> +			ideal_rate = 200000000;
> +			break;
> +		};
> +
> +		diff = (rate > ideal_rate) ?
> +			rate - ideal_rate : ideal_rate - rate;
> +
> +		/*
> +		 * In order for tuning delays to be accurate we need to be
> +		 * pretty spot on for the DLL range, so warn if we're too
> +		 * far off.  Also warn if we're above the 200 MHz max.  Don't
> +		 * warn for really slow rates since we won't be tuning then.
> +		 */
> +		if ((rate > 50000000 && diff > 15000000) || (rate > 200000000))
> +			dev_warn(&phy->dev, "Unsupported rate: %lu\n", rate);
> +	}
> +
> +	/*
>  	 * Keep phyctrl_pdb and phyctrl_endll low to allow
>  	 * initialization of CALIO state M/C DFFs
>  	 */
> @@ -132,6 +190,13 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  		return -ETIMEDOUT;
>  	}
>  
> +	/* Set the frequency of the DLL operation */
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
> +		     HIWORD_UPDATE(freqsel, PHYCTRL_FREQSEL_MASK,
> +				   PHYCTRL_FREQSEL_SHIFT));
> +
> +	/* Turn on the DLL */
>  	regmap_write(rk_phy->reg_base,
>  		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
>  		     HIWORD_UPDATE(PHYCTRL_ENDLL_ENABLE,
> @@ -168,23 +233,14 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  
>  static int rockchip_emmc_phy_power_off(struct phy *phy)
>  {
> -	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -
>  	/* Power down emmc phy analog blocks */
> -	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
> +	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_OFF);
>  }
>  
>  static int rockchip_emmc_phy_power_on(struct phy *phy)
>  {
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
>  
> -	/* DLL operation: 200 MHz */
> -	regmap_write(rk_phy->reg_base,
> -		     rk_phy->reg_offset + GRF_EMMCPHY_CON0,
> -		     HIWORD_UPDATE(PHYCTRL_FREQSEL_200M,
> -				   PHYCTRL_FREQSEL_MASK,
> -				   PHYCTRL_FREQSEL_SHIFT));
> -
>  	/* Drive impedance: 50 Ohm */
>  	regmap_write(rk_phy->reg_base,
>  		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> @@ -207,7 +263,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  				   PHYCTRL_OTAPDLYSEL_SHIFT));
>  
>  	/* Power up emmc phy analog blocks */
> -	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
> +	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
>  }
>  
>  static const struct phy_ops ops = {
> 
