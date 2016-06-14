From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 02/11] mmc: sdhci-of-arasan: Always power the PHY
 off/on when clock changes
Date: Tue, 14 Jun 2016 08:30:25 +0800
Message-ID: <e57b0c79-1b80-20c9-65e8-b8b784946ec0@rock-chips.com>
References: <1465859076-4868-1-git-send-email-dianders@chromium.org>
 <1465859076-4868-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465859076-4868-3-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, kishon@ti.com, Heiko Stuebner <heiko@sntech.de>, robh+dt@kernel.org
Cc: shawn.lin@rock-chips.com, xzy.xu@rock-chips.com, briannorris@chromium.org, adrian.hunter@intel.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

=D4=DA 2016/6/14 7:04, Douglas Anderson =D0=B4=B5=C0:
> In commit 802ac39a5566 ("mmc: sdhci-of-arasan: fix set_clock when a p=
hy
> is supported") we added code to power the PHY off and on whenever the
> clock was changed but we avoided doing the power cycle code when the
> clock was low speed.  Let's now do it always.
>
> Although there may be other reasons for power cycling the PHY when th=
e
> clock changes, one of the main reasons is that we need to give the DL=
L a
> chance to re-lock with the new clock.
>
> One of the things that the DLL is for is tuning the Receive Clock in
> HS200 mode and STRB in HS400 mode.  Thus it is clear that we should m=
ake
> sure we power cycle the PHY (and wait for the DLL to lock) when we kn=
ow
> we'll be in one of these two speed modes.  That's what the original c=
ode
> did, though it used the clock rate rather than the speed mode.  Howev=
er,
> even in speed modes other than HS200,/HS400 the DLL is used for
> something since it can be clearly observed that the PHY doesn't funct=
ion
> properly if you leave the DLL off.
>
> Although it appears less important to power cycle the PHY and wait fo=
r
> the DLL to lock when not in HS200/HS400 modes (no bugs were reported)=
,
> it still seems wise to let the locking always happen nevertheless.
>
> Note: as part of this, we make sure that we never try to turn the PHY=
 on
> when the clock is off (when the clock rate is 0).  The PHY cannot wor=
k
> when the clock is off since its DLL can't lock.
>
> This change requires ("phy: rockchip-emmc: Increase lock time
> allowance") and will cause problems if picked without that change.

Thanks for doint it.

Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Changes in v2: None
>
>  drivers/mmc/host/sdhci-of-arasan.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sd=
hci-of-arasan.c
> index 533e2bcb10bc..3ff1711077c2 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -35,11 +35,13 @@
>  /**
>   * struct sdhci_arasan_data
>   * @clk_ahb:	Pointer to the AHB clock
> - * @phy: Pointer to the generic phy
> + * @phy:	Pointer to the generic phy
> + * @phy_on:	True if the PHY is turned on.
>   */
>  struct sdhci_arasan_data {
>  	struct clk	*clk_ahb;
>  	struct phy	*phy;
> +	bool		phy_on;
>  };
>
>  static unsigned int sdhci_arasan_get_timeout_clock(struct sdhci_host=
 *host)
> @@ -61,12 +63,10 @@ static void sdhci_arasan_set_clock(struct sdhci_h=
ost *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
>  	struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_h=
ost);
> -	bool ctrl_phy =3D false;
>
> -	if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
> -		ctrl_phy =3D true;
> +	if (sdhci_arasan->phy_on && !IS_ERR(sdhci_arasan->phy)) {
> +		sdhci_arasan->phy_on =3D false;
>
> -	if (ctrl_phy) {
>  		spin_unlock_irq(&host->lock);
>  		phy_power_off(sdhci_arasan->phy);
>  		spin_lock_irq(&host->lock);
> @@ -74,7 +74,9 @@ static void sdhci_arasan_set_clock(struct sdhci_hos=
t *host, unsigned int clock)
>
>  	sdhci_set_clock(host, clock);
>
> -	if (ctrl_phy) {
> +	if (host->mmc->actual_clock && !IS_ERR(sdhci_arasan->phy)) {
> +		sdhci_arasan->phy_on =3D true;
> +
>  		spin_unlock_irq(&host->lock);
>  		phy_power_on(sdhci_arasan->phy);
>  		spin_lock_irq(&host->lock);
> @@ -257,12 +259,6 @@ static int sdhci_arasan_probe(struct platform_de=
vice *pdev)
>  			goto clk_disable_all;
>  		}
>
> -		ret =3D phy_power_on(sdhci_arasan->phy);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "phy_power_on err.\n");
> -			goto err_phy_power;
> -		}
> -
>  		host->mmc_host_ops.hs400_enhanced_strobe =3D
>  					sdhci_arasan_hs400_enhanced_strobe;
>  	}
> @@ -275,9 +271,6 @@ static int sdhci_arasan_probe(struct platform_dev=
ice *pdev)
>
>  err_add_host:
>  	if (!IS_ERR(sdhci_arasan->phy))
> -		phy_power_off(sdhci_arasan->phy);
> -err_phy_power:
> -	if (!IS_ERR(sdhci_arasan->phy))
>  		phy_exit(sdhci_arasan->phy);
>  clk_disable_all:
>  	clk_disable_unprepare(clk_xin);
>


--=20
Best Regards
Shawn Lin
