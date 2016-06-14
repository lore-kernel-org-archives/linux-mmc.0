From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 09/11] phy: rockchip-emmc: Minor code cleanup in
 rockchip_emmc_phy_power_on/off()
Date: Tue, 14 Jun 2016 08:36:11 +0800
Message-ID: <361ee77c-ae92-a8f5-c716-1867652db653@rock-chips.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-10-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465859076-4868-10-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

=D4=DA 2016/6/14 7:04, Douglas Anderson =D0=B4=B5=C0:
> There's no reason to store the return value of rockchip_emmc_phy_powe=
r()
> in a variable nor to check it.  Just return it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Move code cleanup before set phyctrl_frqsel based on card clock (Sh=
awn)

Looks good to me.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>
>  drivers/phy/phy-rockchip-emmc.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockch=
ip-emmc.c
> index 2d059c046978..23fe50864526 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -169,20 +169,14 @@ static int rockchip_emmc_phy_power(struct rockc=
hip_emmc_phy *rk_phy,
>  static int rockchip_emmc_phy_power_off(struct phy *phy)
>  {
>  	struct rockchip_emmc_phy *rk_phy =3D phy_get_drvdata(phy);
> -	int ret =3D 0;
>
>  	/* Power down emmc phy analog blocks */
> -	ret =3D rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_OFF);
>  }
>
>  static int rockchip_emmc_phy_power_on(struct phy *phy)
>  {
>  	struct rockchip_emmc_phy *rk_phy =3D phy_get_drvdata(phy);
> -	int ret =3D 0;
>
>  	/* DLL operation: 200 MHz */
>  	regmap_write(rk_phy->reg_base,
> @@ -213,11 +207,7 @@ static int rockchip_emmc_phy_power_on(struct phy=
 *phy)
>  				   PHYCTRL_OTAPDLYSEL_SHIFT));
>
>  	/* Power up emmc phy analog blocks */
> -	ret =3D rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(rk_phy, PHYCTRL_PDB_PWR_ON);
>  }
>
>  static const struct phy_ops ops =3D {
>


--=20
Best Regards
Shawn Lin
