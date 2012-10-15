From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH] MMC: fix sdhci-dove removal
Date: Mon, 15 Oct 2012 16:58:55 +0200
Message-ID: <20121015145855.GY12801@game.jcrosoft.org>
References: <20121015094348.GP21164@n2100.arm.linux.org.uk>
 <20121015103725.GQ21164@n2100.arm.linux.org.uk>
 <20121015104456.GR21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20121015104456.GR21164@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 11:44 Mon 15 Oct     , Russell King - ARM Linux wrote:
> On Mon, Oct 15, 2012 at 11:37:25AM +0100, Russell King - ARM Linux wrote:
> > On Mon, Oct 15, 2012 at 10:43:48AM +0100, Russell King - ARM Linux wrote:
> > > 1. Unregister the device _BEFORE_ taking away any resources it may
> > >    be using.
> > > 2. Don't check clks against NULL.
> > > 
> > > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > 
> > Looking at this driver some more, who the hell came up with the sdhci
> > registration interface?  It violates one of the most fundamental
> > principles of kernel driver programming.  You do _NOT_ publish your
> > driver interfaces _UNTIL_ you have finished setting your device up.
> > Otherwise, in a preemptible or SMP kernel, your driver can be used
> > before the initialization has completed.
> > 
> > As this driver calls sdhci_pltfm_register() before it has obtained the
> > clock for the interface, and this function does:
> > 	sdhci_pltfm_init
> > 	sdhci_add_host
> > 		mmc_add_host
> > 			mmc_start_host
> > 				mmc_power_up
> > 					mmc_set_ios
> > 						sdhci_set_ios
> > 
> > See, we're trying to power up and clock the card _before_ the dove
> > sdhci driver has even claimed the clock let alone enabled it.  This
> > is total bollocks.  The sdhci platform interface is total crap for
> > creating this broken design in the first place.  This is why MMC has
> > the init + add interfaces, they're there to allow drivers to do stuff
> > the Right(tm) way and avoid shit like the above.
> > 
> > This should have been picked up at review time before the driver went
> > into mainline.  In any case, it needs to be fixed.
> 
> Here's an updated patch which just about fixes the sdhci-dove driver.
> I would not be surprised given the idiotic sdhci-pltfm API if many
> other drivers suffered the same bug.
> 
> 8<====
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] MMC: fix sdhci-dove probe/removal
> 
> 1. Never ever publish a device in the system before it has been setup
>    to a usable state.
> 2. Unregister the device _BEFORE_ taking away any resources it may be
>    using.
> 3. Don't check clks against NULL.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/mmc/host/sdhci-dove.c |   36 ++++++++++++++++++------------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
> index a6e53a1..7d3a4e4 100644
> --- a/drivers/mmc/host/sdhci-dove.c
> +++ b/drivers/mmc/host/sdhci-dove.c
> @@ -83,30 +83,31 @@ static int __devinit sdhci_dove_probe(struct platform_device *pdev)
>  	struct sdhci_dove_priv *priv;
>  	int ret;
>  
> -	ret = sdhci_pltfm_register(pdev, &sdhci_dove_pdata);
> -	if (ret)
> -		goto sdhci_dove_register_fail;
> -
>  	priv = devm_kzalloc(&pdev->dev, sizeof(struct sdhci_dove_priv),
>  			    GFP_KERNEL);
>  	if (!priv) {
>  		dev_err(&pdev->dev, "unable to allocate private data");
> -		ret = -ENOMEM;
> -		goto sdhci_dove_allocate_fail;
> +		return -ENOMEM;
>  	}
>  
> +	priv->clk = clk_get(&pdev->dev, NULL);
you have devm_clk_get too

maybe you could use it here too

Best Regards,
J.
