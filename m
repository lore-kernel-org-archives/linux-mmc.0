From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/3] mmc: sdhci-of-arasan: Revert: Always power the PHY
 off/on when clock changes
Date: Thu, 21 Jul 2016 13:09:18 +0300
Message-ID: <57909F4E.7090608@intel.com>
References: <1467049167-14628-1-git-send-email-dianders@chromium.org>
 <1467049167-14628-2-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467049167-14628-2-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, ulf.hansson@linaro.org, kishon@ti.com
Cc: shawn.lin@rock-chips.com, linux-rockchip@lists.infradead.org, linux-mmc@vger.kernel.org, briannorris@chromium.org, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 27/06/16 20:39, Douglas Anderson wrote:
> This reverts commit 4ac0d5f245e1 ("mmc: sdhci-of-arasan: Always power
> the PHY off/on when clock changes"), resolving conflicts with other
> patches that have come after.  It appears that on some boards / with
> some eMMC devices that the patch is causing problems.
> 
> Presumably turning the phy off and on again at the wrong time while
> initially setting up the card is confusing the card, the host, or the
> PHY.  We have lots of power cycles while initially setting up the card
> because the main sdhci driver often turns off the clock by clearing
> SDHCI_CLOCK_CARD_EN and then calls host->ops->set_clock() to set the
> clock again.  With all of those, we ended up with lots of power cycles.
> 
> Presumably the arguments made in the original patch still hold.  That
> is, whenever the card clock is turned off and on again (or changed) we
> really should wait for the DLL to lock again.  However, perhaps it's
> really not that critical for the lower speeds.
> 
> It's possible that the right answer here is:
> * Whenever set_clock() is called we should double-check that the DLL is
>   locked.
> * Whenever set_clock() is called and we're actually changing clocks we
>   should do a power cycle around that.
> * When we're doing a power cycle just because the clock changed, we
>   probably shouldn't do quite as many things (maybe don't need to
>   recalibarate, etc).
> 
> Unfortunately the interaction between SDHCI and the PHY is extremely
> limited because of the limited PHY API.  The PHY does have a reference
> to the card clock and could theoretically register for notifications,
> except that our clock is query only (it uses CLK_GET_RATE_NOCACHE) and
> so can't really be notified about updates.  I believe we would need a
> major redesign of clock handling in SDHCI core to do better than that,
> or we would need to make our one fake notifications.  :(
> 
> Let's hope that we can eventually get more information from Arasan on
> how all this should be handled before doing tons more work.  Until then,
> let's get back to a known working state.  Note that the rest of the
> patches in the 150 MHz series should still work fine even without this
> one.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>


Acked-by: Adrian Hunter <adrian.hunter@intel.com>



> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 678f316702e0..e0f193f7e3e5 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -77,7 +77,6 @@ struct sdhci_arasan_soc_ctl_map {
>   * @host:		Pointer to the main SDHCI host structure.
>   * @clk_ahb:		Pointer to the AHB clock
>   * @phy:		Pointer to the generic phy
> - * @phy_on:		True if the PHY is turned on.
>   * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
>   * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
>   * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
> @@ -87,7 +86,6 @@ struct sdhci_arasan_data {
>  	struct sdhci_host *host;
>  	struct clk	*clk_ahb;
>  	struct phy	*phy;
> -	bool		phy_on;
>  
>  	struct clk_hw	sdcardclk_hw;
>  	struct clk      *sdcardclk;
> @@ -170,10 +168,12 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>  	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
> +	bool ctrl_phy = false;
>  
> -	if (sdhci_arasan->phy_on && !IS_ERR(sdhci_arasan->phy)) {
> -		sdhci_arasan->phy_on = false;
> +	if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
> +		ctrl_phy = true;
>  
> +	if (ctrl_phy) {
>  		spin_unlock_irq(&host->lock);
>  		phy_power_off(sdhci_arasan->phy);
>  		spin_lock_irq(&host->lock);
> @@ -181,9 +181,7 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	sdhci_set_clock(host, clock);
>  
> -	if (host->mmc->actual_clock && !IS_ERR(sdhci_arasan->phy)) {
> -		sdhci_arasan->phy_on = true;
> -
> +	if (ctrl_phy) {
>  		spin_unlock_irq(&host->lock);
>  		phy_power_on(sdhci_arasan->phy);
>  		spin_lock_irq(&host->lock);
> @@ -549,6 +547,12 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  			goto unreg_clk;
>  		}
>  
> +		ret = phy_power_on(sdhci_arasan->phy);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "phy_power_on err.\n");
> +			goto err_phy_power;
> +		}
> +
>  		host->mmc_host_ops.hs400_enhanced_strobe =
>  					sdhci_arasan_hs400_enhanced_strobe;
>  	}
> @@ -561,6 +565,9 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  
>  err_add_host:
>  	if (!IS_ERR(sdhci_arasan->phy))
> +		phy_power_off(sdhci_arasan->phy);
> +err_phy_power:
> +	if (!IS_ERR(sdhci_arasan->phy))
>  		phy_exit(sdhci_arasan->phy);
>  unreg_clk:
>  	sdhci_arasan_unregister_sdclk(&pdev->dev);
> 
