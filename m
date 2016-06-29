From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 2/3] phy: rockchip-emmc: Be tolerant to card clock of 0 in
 power on
Date: Wed, 29 Jun 2016 19:19:49 +0530
Message-ID: <5773D1FD.8020601@ti.com>
References: <1467049167-14628-1-git-send-email-dianders@chromium.org>
 <1467049167-14628-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1467049167-14628-3-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Monday 27 June 2016 11:09 PM, Douglas Anderson wrote:
> It's possible that there are some reasons to turn the PHY on while the
> clock is 0.  In this case we just won't wait for the DLL to lock.
> 
> This is a bit of a stopgap until we figure out exactly when we're
> supposed to wait for the DLL to lock and when we're supposed to power
> cycle the PHY.
> 
> Note: this patch should help with suspend/resume where the system will
> try to turn the PHY back on when the clock is 0.
> 
> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/phy/phy-rockchip-emmc.c | 59 ++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/phy/phy-rockchip-emmc.c b/drivers/phy/phy-rockchip-emmc.c
> index 9dce958233a0..a2aa6aca7dec 100644
> --- a/drivers/phy/phy-rockchip-emmc.c
> +++ b/drivers/phy/phy-rockchip-emmc.c
> @@ -88,15 +88,36 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>  	unsigned int caldone;
>  	unsigned int dllrdy;
>  	unsigned int freqsel = PHYCTRL_FREQSEL_200M;
> +	unsigned long rate;
>  	unsigned long timeout;
>  
> -	if (rk_phy->emmcclk != NULL) {
> -		unsigned long rate = clk_get_rate(rk_phy->emmcclk);
> +	/*
> +	 * Keep phyctrl_pdb and phyctrl_endll low to allow
> +	 * initialization of CALIO state M/C DFFs
> +	 */
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> +		     HIWORD_UPDATE(PHYCTRL_PDB_PWR_OFF,
> +				   PHYCTRL_PDB_MASK,
> +				   PHYCTRL_PDB_SHIFT));
> +	regmap_write(rk_phy->reg_base,
> +		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> +		     HIWORD_UPDATE(PHYCTRL_ENDLL_DISABLE,
> +				   PHYCTRL_ENDLL_MASK,
> +				   PHYCTRL_ENDLL_SHIFT));
> +
> +	/* Already finish power_off above */
> +	if (on_off == PHYCTRL_PDB_PWR_OFF)
> +		return 0;
> +
> +	rate = clk_get_rate(rk_phy->emmcclk);
> +
> +	if (rate != 0) {
>  		unsigned long ideal_rate;
>  		unsigned long diff;
>  
>  		switch (rate) {
> -		case 0 ... 74999999:
> +		case 1 ... 74999999:
>  			ideal_rate = 50000000;
>  			freqsel = PHYCTRL_FREQSEL_50M;
>  			break;
> @@ -127,25 +148,6 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>  	}
>  
>  	/*
> -	 * Keep phyctrl_pdb and phyctrl_endll low to allow
> -	 * initialization of CALIO state M/C DFFs
> -	 */
> -	regmap_write(rk_phy->reg_base,
> -		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> -		     HIWORD_UPDATE(PHYCTRL_PDB_PWR_OFF,
> -				   PHYCTRL_PDB_MASK,
> -				   PHYCTRL_PDB_SHIFT));
> -	regmap_write(rk_phy->reg_base,
> -		     rk_phy->reg_offset + GRF_EMMCPHY_CON6,
> -		     HIWORD_UPDATE(PHYCTRL_ENDLL_DISABLE,
> -				   PHYCTRL_ENDLL_MASK,
> -				   PHYCTRL_ENDLL_SHIFT));
> -
> -	/* Already finish power_off above */
> -	if (on_off == PHYCTRL_PDB_PWR_OFF)
> -		return 0;
> -
> -	/*
>  	 * According to the user manual, calpad calibration
>  	 * cycle takes more than 2us without the minimal recommended
>  	 * value, so we may need a little margin here
> @@ -183,6 +185,19 @@ static int rockchip_emmc_phy_power(struct phy *phy, bool on_off)
>  		     HIWORD_UPDATE(PHYCTRL_ENDLL_ENABLE,
>  				   PHYCTRL_ENDLL_MASK,
>  				   PHYCTRL_ENDLL_SHIFT));
> +
> +	/*
> +	 * We turned on the DLL even though the rate was 0 because we the
> +	 * clock might be turned on later.  ...but we can't wait for the DLL
> +	 * to lock when the rate is 0 because it will never lock with no
> +	 * input clock.
> +	 *
> +	 * Technically we should be checking the lock later when the clock
> +	 * is turned on, but for now we won't.
> +	 */
> +	if (rate == 0)
> +		return 0;

Why not return initially from rockchip_emmc_phy_power if the clock rate is '0'.
Are there other functions to lock the DLL apart from phy_power?

Thanks
Kishon
