From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 01/11] phy: rockchip-emmc: Increase lock time allowance
Date: Tue, 14 Jun 2016 08:28:46 +0800
Message-ID: <1c62147b-0464-6ecc-3ba4-2ec9ddf19111@rock-chips.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465859076-4868-2-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

=D4=DA 2016/6/14 7:04, Douglas Anderson =D0=B4=B5=C0:
> Previous PHY code waited a fixed amount of time for the DLL to lock a=
t
> power on time.  Unfortunately, the time for the DLL to lock is actual=
ly
> a bit more dynamic and can be longer if the card clock is slower.
>
> Instead of waiting a fixed 30 us, let's now dynamically wait until th=
e
> lock bit gets set.  We'll wait up to 10 ms which should be OK even if
> the card clock is at the super slow 100 kHz.
>
> On its own, this change makes the PHY power on code a little more
> robust.  Before this change the PHY was relying on the eMMC code to m=
ake
> sure the PHY was only powered on when the card clock was set to at le=
ast
> 50 MHz before, though this reliance wasn't documented anywhere.
>
> This change will be even more useful in future changes where we actua=
lly
> need to be able to wait for a DLL lock at slower clock speeds.
>

Looks good to me.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2:
> - Indicate that 5.1 ms is calculated (Shawn).
>
>  drivers/phy/phy-rockchip-emmc.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockch=
ip-emmc.c
> index a69f53630e67..2d059c046978 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -85,6 +85,7 @@ static int rockchip_emmc_phy_power(struct rockchip_=
emmc_phy *rk_phy,
>  {
>  	unsigned int caldone;
>  	unsigned int dllrdy;
> +	unsigned long timeout;
>
>  	/*
>  	 * Keep phyctrl_pdb and phyctrl_endll low to allow
> @@ -137,15 +138,26 @@ static int rockchip_emmc_phy_power(struct rockc=
hip_emmc_phy *rk_phy,
>  				   PHYCTRL_ENDLL_MASK,
>  				   PHYCTRL_ENDLL_SHIFT));
>  	/*
> -	 * After enable analog DLL circuits, we need an extra 10.2us
> -	 * for dll to be ready for work. But according to testing, we
> -	 * find some chips need more than 25us.
> +	 * After enabling analog DLL circuits docs say that we need 10.2 us=
 if
> +	 * our source clock is at 50 MHz and that lock time scales linearly
> +	 * with clock speed.  If we are powering on the PHY and the card cl=
ock
> +	 * is super slow (like 100 kHZ) this could take as long as 5.1 ms a=
s
> +	 * per the math: 10.2 us * (50000000 Hz / 100000 Hz) =3D> 5.1 ms
> +	 * Hopefully we won't be running at 100 kHz, but we should still ma=
ke
> +	 * sure we wait long enough.
>  	 */
> -	udelay(30);
> -	regmap_read(rk_phy->reg_base,
> -		    rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
> -		    &dllrdy);
> -	dllrdy =3D (dllrdy >> PHYCTRL_DLLRDY_SHIFT) & PHYCTRL_DLLRDY_MASK;
> +	timeout =3D jiffies + msecs_to_jiffies(10);
> +	do {
> +		udelay(1);
> +
> +		regmap_read(rk_phy->reg_base,
> +			rk_phy->reg_offset + GRF_EMMCPHY_STATUS,
> +			&dllrdy);
> +		dllrdy =3D (dllrdy >> PHYCTRL_DLLRDY_SHIFT) & PHYCTRL_DLLRDY_MASK;
> +		if (dllrdy =3D=3D PHYCTRL_DLLRDY_DONE)
> +			break;
> +	} while (!time_after(jiffies, timeout));
> +
>  	if (dllrdy !=3D PHYCTRL_DLLRDY_DONE) {
>  		pr_err("rockchip_emmc_phy_power: dllrdy timeout.\n");
>  		return -ETIMEDOUT;
>


--=20
Best Regards
Shawn Lin
