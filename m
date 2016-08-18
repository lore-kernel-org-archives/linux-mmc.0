From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Don't power PHY w/ slow/no clock
Date: Thu, 18 Aug 2016 16:46:12 +0300
Message-ID: <9fa82cfa-e9b1-5c79-4fcb-b32da49e993a@intel.com>
References: <1471450148-28307-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1471450148-28307-1-git-send-email-dianders@chromium.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Douglas Anderson <dianders@chromium.org>, ulf.hansson@linaro.org, Heiko Stuebner <heiko@sntech.de>, shawn.lin@rock-chips.com
Cc: xzy.xu@rock-chips.com, linux-mmc@vger.kernel.org, michal.simek@xilinx.com, linux-kernel@vger.kernel.org, soren.brinkmann@xilinx.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 17/08/16 19:09, Douglas Anderson wrote:
>>From empirical evidence (tested on Rockchip rk3399), it appears that the
> PHY intended to be used with the Arasan SDHCI 5.1 controller has trouble
> turning on when the card clock is slow or off.  Strangely these problems
> appear to show up consistently on some boards while other boares work

boares -> boards

> fine, but on the boards where it shows up the problem reproduces 100% of
> the time and is quite consistent in its behavior.
> 
> These problems can be fixed by always making sure that we power on the
> PHY (and turn on its DLL) when the card clock is faster than about 50
> MHz.  Once on, we need to make sure that we never power down the PHY /
> turn off its DLL until the clock is faster again.
> 
> We'll add logic for handling this into the sdhci-of-arasan driver.  Note
> that right now the only user of a PHY in the sdhci-of-arasan driver is
> arasan,sdhci-5.1.  It's presumed that all arasan,sdhci-5.1 PHY
> implementations need this workaround, so the logic is only contingent on
> having a PHY to control.  If future Arasan controllers don't have this
> problem we can add code to decide if we want this flow or not.
> 
> Also note that we check for slow clocks by checking for <= 400 kHz
> rather than checking for 50 MHz.  This keeps things the most consistent
> and also means we can power the PHY on at max speed (where the DLL will
> lock fastest).  Presumably anyone who intends to run with a card clock
> of < 50 MHz and > 400 Khz will be running on a device where this problem

Khz -> kHz

> is fixed anyway.
> 
> I believe this brings some resolution to the problems reported before.
> See the commit 6fc09244d74d ("mmc: sdhci-of-arasan: Revert: Always power
> the PHY off/on when clock changes").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Apart from spelling and a define for 400000:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
> Tested on chromeos kernel-4.4 with backports.
> 
>  drivers/mmc/host/sdhci-of-arasan.c | 61 ++++++++++++++++++++++++++++----------
>  1 file changed, 46 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index e0f193f7e3e5..ec2fd00a913d 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -77,6 +77,7 @@ struct sdhci_arasan_soc_ctl_map {
>   * @host:		Pointer to the main SDHCI host structure.
>   * @clk_ahb:		Pointer to the AHB clock
>   * @phy:		Pointer to the generic phy
> + * @is_phy_on:		True if the PHY is on; false if not.
>   * @sdcardclk_hw:	Struct for the clock we might provide to a PHY.
>   * @sdcardclk:		Pointer to normal 'struct clock' for sdcardclk_hw.
>   * @soc_ctl_base:	Pointer to regmap for syscon for soc_ctl registers.
> @@ -86,6 +87,7 @@ struct sdhci_arasan_data {
>  	struct sdhci_host *host;
>  	struct clk	*clk_ahb;
>  	struct phy	*phy;
> +	bool		is_phy_on;
>  
>  	struct clk_hw	sdcardclk_hw;
>  	struct clk      *sdcardclk;
> @@ -170,13 +172,47 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
>  	bool ctrl_phy = false;
>  
> -	if (clock > MMC_HIGH_52_MAX_DTR && (!IS_ERR(sdhci_arasan->phy)))
> -		ctrl_phy = true;
> +	if (!IS_ERR(sdhci_arasan->phy)) {
> +		if (!sdhci_arasan->is_phy_on && clock <= 400000) {

Should probably use a #define for 400000

> +			/*
> +			 * If PHY off, set clock to max speed and power PHY on.
> +			 *
> +			 * Although PHY docs apparently suggest power cycling
> +			 * when changing the clock the PHY doesn't like to be
> +			 * powered on while at low speeds like those used in ID
> +			 * mode.  Even worse is powering the PHY on while the
> +			 * clock is off.
> +			 *
> +			 * To workaround the PHY limitatoins, the best we can

limitatoins -> limitations

> +			 * do is to power it on at a faster speed and then slam
> +			 * through low speeds without power cycling.
> +			 */
> +			sdhci_set_clock(host, host->max_clk);
> +			spin_unlock_irq(&host->lock);
> +			phy_power_on(sdhci_arasan->phy);
> +			spin_lock_irq(&host->lock);
> +			sdhci_arasan->is_phy_on = true;
> +
> +			/*
> +			 * We'll now fall through to the below case with
> +			 * ctrl_phy = false (so we won't turn off/on).  The
> +			 * sdhci_set_clock() will set the real clock.
> +			 */
> +		} else if (clock > 400000) {
> +			/*
> +			 * At higher clock speeds the PHY is fine being power
> +			 * cycled and docs say you _should_ power cycle when
> +			 * changing clock speeds.
> +			 */
> +			ctrl_phy = true;
> +		}
> +	}
>  
> -	if (ctrl_phy) {
> +	if (ctrl_phy && sdhci_arasan->is_phy_on) {
>  		spin_unlock_irq(&host->lock);
>  		phy_power_off(sdhci_arasan->phy);
>  		spin_lock_irq(&host->lock);
> +		sdhci_arasan->is_phy_on = false;
>  	}
>  
>  	sdhci_set_clock(host, clock);
> @@ -185,6 +221,7 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
>  		spin_unlock_irq(&host->lock);
>  		phy_power_on(sdhci_arasan->phy);
>  		spin_lock_irq(&host->lock);
> +		sdhci_arasan->is_phy_on = true;
>  	}
>  }
>  
> @@ -239,13 +276,14 @@ static int sdhci_arasan_suspend(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (!IS_ERR(sdhci_arasan->phy)) {
> +	if (!IS_ERR(sdhci_arasan->phy) && sdhci_arasan->is_phy_on) {
>  		ret = phy_power_off(sdhci_arasan->phy);
>  		if (ret) {
>  			dev_err(dev, "Cannot power off phy.\n");
>  			sdhci_resume_host(host);
>  			return ret;
>  		}
> +		sdhci_arasan->is_phy_on = false;
>  	}
>  
>  	clk_disable(pltfm_host->clk);
> @@ -281,12 +319,13 @@ static int sdhci_arasan_resume(struct device *dev)
>  		return ret;
>  	}
>  
> -	if (!IS_ERR(sdhci_arasan->phy)) {
> +	if (!IS_ERR(sdhci_arasan->phy) && host->mmc->actual_clock) {
>  		ret = phy_power_on(sdhci_arasan->phy);
>  		if (ret) {
>  			dev_err(dev, "Cannot power on phy.\n");
>  			return ret;
>  		}
> +		sdhci_arasan->is_phy_on = true;
>  	}
>  
>  	return sdhci_resume_host(host);
> @@ -547,12 +586,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  			goto unreg_clk;
>  		}
>  
> -		ret = phy_power_on(sdhci_arasan->phy);
> -		if (ret < 0) {
> -			dev_err(&pdev->dev, "phy_power_on err.\n");
> -			goto err_phy_power;
> -		}
> -
>  		host->mmc_host_ops.hs400_enhanced_strobe =
>  					sdhci_arasan_hs400_enhanced_strobe;
>  	}
> @@ -565,9 +598,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  
>  err_add_host:
>  	if (!IS_ERR(sdhci_arasan->phy))
> -		phy_power_off(sdhci_arasan->phy);
> -err_phy_power:
> -	if (!IS_ERR(sdhci_arasan->phy))
>  		phy_exit(sdhci_arasan->phy);
>  unreg_clk:
>  	sdhci_arasan_unregister_sdclk(&pdev->dev);
> @@ -589,7 +619,8 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
>  	struct clk *clk_ahb = sdhci_arasan->clk_ahb;
>  
>  	if (!IS_ERR(sdhci_arasan->phy)) {
> -		phy_power_off(sdhci_arasan->phy);
> +		if (sdhci_arasan->is_phy_on)
> +			phy_power_off(sdhci_arasan->phy);
>  		phy_exit(sdhci_arasan->phy);
>  	}
>  
> 
