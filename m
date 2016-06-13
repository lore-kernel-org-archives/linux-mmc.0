From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 02/11] mmc: sdhci-of-arasan: Always power the PHY off/on
 when clock changes
Date: Mon, 13 Jun 2016 16:08:54 +0800
Message-ID: <ae4409b0-48a5-e30f-a244-7a28bd7a9daa@rock-chips.com>
References: <1465339484-969-1-git-send-email-dianders@chromium.org>
 <1465339484-969-3-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465339484-969-3-git-send-email-dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

=D4=DA 2016/6/8 6:44, Douglas Anderson =D0=B4=B5=C0:
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

 From the design doc, there is no need to off/on phy when not in
HS200/400, but maybe someone will limit the clk freq by assigning
max-frequency in DT when in HS200/400, which will make things worse.

So your patch looks sane.

> Note: as part of this, we make sure that we never try to turn the PHY=
 on
> when the clock is off (when the clock rate is 0).  The PHY cannot wor=
k
> when the clock is off since its DLL can't lock.
>
> This change requires ("phy: rockchip-emmc: Increase lock time
> allowance") and will cause problems if picked without that change.
>
> Signed-off-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
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

Because there is too much dependency between phy and controller, so
previous solution is to setup clk by firmware. The same case for
suspend and resume.

Look really good to do it more legit.

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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
