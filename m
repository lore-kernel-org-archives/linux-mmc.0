From: Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 1/5] mmc: sdhci: make sdhci-pltfm device drivers self
	registered
Date: Fri, 1 Apr 2011 14:10:21 +0800
Message-ID: <20110401061020.GF25866@S2100-06.ap.freescale.net>
References: <1301042931-4869-1-git-send-email-shawn.guo@linaro.org>
	<1301042931-4869-2-git-send-email-shawn.guo@linaro.org>
	<20110331153322.GA26612@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110331153322.GA26612-e0URQFbLeQY2iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 31, 2011 at 09:33:22AM -0600, Grant Likely wrote:
> On Fri, Mar 25, 2011 at 04:48:47PM +0800, Shawn Guo wrote:
> > The patch turns the common stuff in sdhci-pltfm.c into functions, and
> > add device drivers their own .probe and .remove which in turn call
> > into the common functions, so that those sdhci-pltfm device drivers
> > register itself and keep all device specific things away from common
> > sdhci-pltfm file.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Looks really good.  Relatively minor comments below, but you can add
> this to the next version:
> 
> Reviewed-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> 
Thanks for the review.

[...]
> > +
> > +static int __devinit sdhci_cns3xxx_probe(struct platform_device *pdev)
> > +{
> > +	struct sdhci_host *host;
> > +	int ret;
> > +
> > +	host = sdhci_pltfm_init(pdev, &sdhci_cns3xxx_pdata);
> > +	if (!host)
> > +		return -ENOMEM;
> > +
> > +	ret = sdhci_add_host(host);
> > +	if (ret)
> > +		goto err_add_host;
> > +
> > +	return 0;
> > +
> > +err_add_host:
> > +	sdhci_pltfm_free(pdev);
> > +	return ret;
> > +}
> 
> This pattern in this function is used by 2 drivers in this patch, and
> 2 more users (with the addition of an sdhci_get_of_property() call) in
> the 3rd patch.  An sdchi_pltfm_register(pdev, &pdata) that does the
> whole sequence would probably be valuable.  Same for the _remove hook.
> 
OK, one more pair of helper function will be added.

> Drivers that still need 2 stage registration, like the tegra driver,
> would still be able to call sdhci_pltfm_init() and sdhci_add_host()
> directly.
> 
> > +
> > +static int __devexit sdhci_cns3xxx_remove(struct platform_device *pdev)
> > +{
> > +	struct sdhci_host *host = platform_get_drvdata(pdev);
> > +	int dead = 0;
> > +	u32 scratch;
> > +
> > +	scratch = readl(host->ioaddr + SDHCI_INT_STATUS);
> > +	if (scratch == (u32)-1)
> > +		dead = 1;
> > +
> > +	sdhci_remove_host(host, dead);
> 
> The following would be equivalent to the above three lines:
> 
> 	sdhci_remove_host(host, scratch == (u32)-1);
> 
OK.

[...]
> > @@ -3,7 +3,7 @@
> >   *
> >   * Author: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
> >   *	   Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
> > - * Based on sdhci-cns3xxx.c
> > + * Based on sdhci-dove.c
> 
> This file *is* sdhci-dove.c.  Did you intend this change?  :-)
> 
My bad.

[...]
> > +#ifdef CONFIG_OF
> > +	plat = kzalloc(sizeof(*plat), GFP_KERNEL);
> > +	if (!plat) {
> > +		rc = -ENOMEM;
> > +		goto err_no_plat;
> > +	}
> > +	pdev->dev.platform_data = plat;
> > +
> > +	plat->cd_gpio = of_get_gpio(pdev->dev.of_node, 0);
> > +	plat->wp_gpio = of_get_gpio(pdev->dev.of_node, 1);
> > +	plat->power_gpio = of_get_gpio(pdev->dev.of_node, 2);
> > +
> > +	dev_info(&pdev->dev, "using gpios cd=%i, wp=%i power=%i\n",
> > +		plat->cd_gpio, plat->wp_gpio, plat->power_gpio);
> > +#endif
> 
> This will need to be reworked for mainline since the Tegra device tree
> support only exists in my git tree.  Basing it on devicetree/arm would
> work.
> 
OK. Will against mmc-next and test esdhc dt changes on devicetree/arm.

-- 
Regards,
Shawn
