From: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/5] mmc: sdhci-pxav3: fix optional clock name
Date: Fri, 16 Oct 2015 19:40:32 +0800
Message-ID: <20151016194032.76514a5e@xhacker>
References: <1444628796-5484-1-git-send-email-jszhang@marvell.com>
	<1444628796-5484-2-git-send-email-jszhang@marvell.com>
	<56201D82.6080106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56201D82.6080106-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Dear Sebastian,

On Thu, 15 Oct 2015 23:41:22 +0200
Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 12.10.2015 07:46, Jisheng Zhang wrote:
> > Commit 8afdc9cca27f ("mmc: sdhci-pxav3: Get optional core clock") adds
> > additional optional clock support, but the clock names  isn't correct.
> > The current "io" clock is really the PXAv3 SDHCI IP's "core" clock
> > which is manadatory. The current "core" clock is really the IP's "axi"
> > clock which is optional.
> >
> > Signed-off-by: Jisheng Zhang <jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> > ---
> >   .../devicetree/bindings/mmc/sdhci-pxa.txt          |  8 ++---
> >   arch/arm/boot/dts/berlin2.dtsi                     |  6 ++--
> >   arch/arm/boot/dts/berlin2cd.dtsi                   |  2 +-
> >   arch/arm/boot/dts/berlin2q.dtsi                    |  2 +-
> >   drivers/mmc/host/sdhci-pxav3.c                     | 40 +++++++++++-----------
> >   5 files changed, 29 insertions(+), 29 deletions(-)  
> 
> 
> Jisheng,
> 
> Please split the DT changes from the driver changes.

Such split will break berlin SDHC functionality, I'm not sure whether this is
acceptable.

> 
> > diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> > index 3d1b449..25d5ba8 100644
> > --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> > +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> > @@ -17,9 +17,9 @@ Required properties:
> >   - reg names: should be "sdhci", "mbus", "conf-sdio3". only mandatory
> >     for "marvell,armada-380-sdhci"
> >   - clocks: Array of clocks required for SDHCI; requires at least one for
> > -    I/O clock.
> > +    core clock.
> >   - clock-names: Array of names corresponding to clocks property; shall be
> > -    "io" for I/O clock and "core" for optional core clock.
> > +    "core" for core clock and "axi" for optional axi clock.  
> 
> s/axi/bus/ ?

HW call this clk as axi, "bus" seems more generic, right?

> 
> >   Optional properties:
> >   - mrvl,clk-delay-cycles: Specify a number of cycles to delay for tuning.
> > @@ -32,7 +32,7 @@ sdhci@d4280800 {
> >   	bus-width = <8>;
> >   	interrupts = <27>;
> >   	clocks = <&chip CLKID_SDIO1XIN>, <&chip CLKID_SDIO1>;
> > -	clock-names = "io", "core";
> > +	clock-names = "core", "axi";  
> 
> This will break backward compatibility, right?
> 
> >   	non-removable;
> >   	mrvl,clk-delay-cycles = <31>;
> >   };
> > @@ -45,6 +45,6 @@ sdhci@d8000 {
> >   		<0x18454 0x4>;
> >   	interrupts = <0 25 0x4>;
> >   	clocks = <&gateclk 17>;
> > -	clock-names = "io";
> > +	clock-names = "core";
> >   	mrvl,clk-delay-cycles = <0x1F>;
> >   };  
> [...]
> > diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> > index f5edf9d..cec95f1 100644
> > --- a/drivers/mmc/host/sdhci-pxav3.c
> > +++ b/drivers/mmc/host/sdhci-pxav3.c
> > @@ -59,8 +59,8 @@
> >   #define SDCE_MISC_INT_EN	(1<<1)
> >
> >   struct sdhci_pxa {
> > +	struct clk *clk_axi;  
> 
> s/clk_axi/clk_bus/g
> 
> >   	struct clk *clk_core;
> > -	struct clk *clk_io;
> >   	u8	power_mode;
> >   	void __iomem *sdio3_conf_reg;
> >   };
> > @@ -381,20 +381,20 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
> >   	pltfm_host = sdhci_priv(host);
> >   	pltfm_host->priv = pxa;
> >
> > -	pxa->clk_io = devm_clk_get(dev, "io");
> > -	if (IS_ERR(pxa->clk_io))
> > -		pxa->clk_io = devm_clk_get(dev, NULL);
> > -	if (IS_ERR(pxa->clk_io)) {
> > -		dev_err(dev, "failed to get io clock\n");
> > -		ret = PTR_ERR(pxa->clk_io);
> > +	pxa->clk_core = devm_clk_get(dev, "core");  
> 
> To maintain backward compatibility, we should still

I just grep the kernel source, found that only mrvl berlin SoCs have two clks,
other SoCs just have one clk and don't provide clock name. So the question
here is whether we can break linux backward compatibility for mrvl berlin
SoCs. I think we could for the following reason:

1. rare boards outside mrvl can boot user self-built kernel, most boards should
be protected by trust-chainloader mechanism.

2. mrvl berlin SoCs upgrade linux kernel and dtb at the same time

what do you think?

Is it better to refine patch 2, 3, 4, 5 to make use current "io","core" binding
to clean up the clk's CLK_IGNORE_UNUSED flags? In fact, they doesn't depend
on patch1. Could you please kindly give advice?

Thanks in advance,
Jisheng



> devm_clk_get(dev, "io") here - or even better, first
> probe for "io" to catch old binding semantics including
> old "core"/"bus" misnaming.
> 
> If we detected old semantics, print a warning that
> firmware should be updated.
> 
> Sebastian
> 
> > +	if (IS_ERR(pxa->clk_core))
> > +		pxa->clk_core = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(pxa->clk_core)) {
> > +		dev_err(dev, "failed to get core clock\n");
> > +		ret = PTR_ERR(pxa->clk_core);
> >   		goto err_clk_get;
> >   	}
> > -	pltfm_host->clk = pxa->clk_io;
> > -	clk_prepare_enable(pxa->clk_io);
> > +	pltfm_host->clk = pxa->clk_core;
> > +	clk_prepare_enable(pxa->clk_core);
> >
> > -	pxa->clk_core = devm_clk_get(dev, "core");
> > -	if (!IS_ERR(pxa->clk_core))
> > -		clk_prepare_enable(pxa->clk_core);
> > +	pxa->clk_axi = devm_clk_get(dev, "axi");
> > +	if (!IS_ERR(pxa->clk_axi))
> > +		clk_prepare_enable(pxa->clk_axi);
> >
> >   	/* enable 1/8V DDR capable */
> >   	host->mmc->caps |= MMC_CAP_1_8V_DDR;
> > @@ -475,8 +475,8 @@ err_add_host:
> >   err_of_parse:
> >   err_cd_req:
> >   err_mbus_win:
> > -	clk_disable_unprepare(pxa->clk_io);
> >   	clk_disable_unprepare(pxa->clk_core);
> > +	clk_disable_unprepare(pxa->clk_axi);
> >   err_clk_get:
> >   	sdhci_pltfm_free(pdev);
> >   	return ret;
> > @@ -494,8 +494,8 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
> >
> >   	sdhci_remove_host(host, 1);
> >
> > -	clk_disable_unprepare(pxa->clk_io);
> >   	clk_disable_unprepare(pxa->clk_core);
> > +	clk_disable_unprepare(pxa->clk_axi);
> >
> >   	sdhci_pltfm_free(pdev);
> >
> > @@ -542,9 +542,9 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
> >   	if (ret)
> >   		return ret;
> >
> > -	clk_disable_unprepare(pxa->clk_io);
> > -	if (!IS_ERR(pxa->clk_core))
> > -		clk_disable_unprepare(pxa->clk_core);
> > +	clk_disable_unprepare(pxa->clk_core);
> > +	if (!IS_ERR(pxa->clk_axi))
> > +		clk_disable_unprepare(pxa->clk_axi);
> >
> >   	return 0;
> >   }
> > @@ -555,9 +555,9 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
> >   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> >   	struct sdhci_pxa *pxa = pltfm_host->priv;
> >
> > -	clk_prepare_enable(pxa->clk_io);
> > -	if (!IS_ERR(pxa->clk_core))
> > -		clk_prepare_enable(pxa->clk_core);
> > +	clk_prepare_enable(pxa->clk_core);
> > +	if (!IS_ERR(pxa->clk_axi))
> > +		clk_prepare_enable(pxa->clk_axi);
> >
> >   	return sdhci_runtime_resume_host(host);
> >   }
> >  
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
