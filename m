From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 10/11] phy: rockchip-emmc: Minor code cleanup in
 rockchip_emmc_phy_power_off()
Date: Mon, 13 Jun 2016 16:56:47 +0800
Message-ID: <f80ba471-95dd-5cda-00a2-9006cfe15167@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-11-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:57701 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422852AbcFMI4z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 04:56:55 -0400
In-Reply-To: <1465339484-969-11-git-send-email-dianders@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 2016/6/8 6:44, Douglas Anderson wrote:
> There's no reason to store the return value of rockchip_emmc_phy_power()
> in a variable nor to check it.  Just return it.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 0fce7359d468..188e4c387ba8 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -227,8 +227,6 @@ static int rockchip_emmc_phy_power_off(struct phy *phy)
>  static int rockchip_emmc_phy_power_on(struct phy *phy)
>  {

I saw the cleanup for power_off is done on [patch 9/11]

shouldn't be in this patch? :)

>  	struct rockchip_emmc_phy *rk_phy = phy_get_drvdata(phy);
> -	int ret = 0;
> -
>
>  	/* Drive impedance: 50 Ohm */
>  	regmap_write(rk_phy->reg_base,
> @@ -252,11 +250,7 @@ static int rockchip_emmc_phy_power_on(struct phy *phy)
>  				   PHYCTRL_OTAPDLYSEL_SHIFT));
>
>  	/* Power up emmc phy analog blocks */
> -	ret = rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> +	return rockchip_emmc_phy_power(phy, PHYCTRL_PDB_PWR_ON);
>  }
>
>  static const struct phy_ops ops = {
>


-- 
Best Regards
Shawn Lin

