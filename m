From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 09/11] phy: rockchip-emmc: Minor code cleanup in
 rockchip_emmc_phy_power_on/off()
Date: Mon, 20 Jun 2016 18:34:19 +0530
Message-ID: <5767E9D3.7080407@ti.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-10-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1465859076-4868-10-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
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
> There's no reason to store the return value of rockchip_emmc_phy_power()
> in a variable nor to check it.  Just return it.
> 
> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

Acked-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
> Changes in v2:
> - Move code cleanup before set phyctrl_frqsel based on card clock (Shawn)
> 
>  drivers/phy/phy-rockchip-emmc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 2d059c046978..23fe50864526 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -169,20 +169,14 @@ static int rockchip_emmc_phy_power(struct rockchip_emmc_phy *rk_phy,
>  static int rockchip_emmc_phy_power_off(struct phy *phy)
>  {
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	int ret = 0;
>  
>  	/* Power down emmc phy analog blocks */
> -	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
>  }
>  
>  static int rockchip_emmc_phy_power_on(struct phy *phy)
>  {
>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	int ret = 0;
>  
>  	/* DLL operation: 200 MHz */
>  	regmap_write(rk_phy->reg_base,
> @@ -213,11 +207,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  				   PHYCTRL_OTAPDLYSEL_SHIFT));
>  
>  	/* Power up emmc phy analog blocks */
> -	ret = rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
>  }
>  
>  static const struct phy_ops ops = {
> 
