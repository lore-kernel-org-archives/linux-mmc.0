From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v1 2/5] mmc: mxs-mmc: add dt probe support
Date: Wed, 14 Mar 2012 09:52:52 +0100
Message-ID: <20120314085252.GK18320@game.jcrosoft.org>
References: <1331628428-24017-1-git-send-email-b29396@freescale.com>
 <1331628428-24017-3-git-send-email-b29396@freescale.com>
 <20120314072343.GG18320@game.jcrosoft.org>
 <20120314080939.GA1180@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120314080939.GA1180-Fb7DQEYuewWctlrPMvKcciBecyulp+rMXqFh9Ls21Oc@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Dong Aisheng <aisheng.dong-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org" <rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org>, "kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 16:09 Wed 14 Mar     , Dong Aisheng wrote:
> On Wed, Mar 14, 2012 at 03:23:43PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 16:47 Tue 13 Mar     , Dong Aisheng wrote:
> > > From: Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > 
> > > Signed-off-by: Dong Aisheng <dong.aisheng-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > 
> > > ---
> > > The patch is still using a private way for dma part binding
> > > since the common dma binding is still under discussion.
> > > http://www.spinics.net/lists/linux-omap/msg65528.html
> > > 
> > > Will update to use common dma binding when it hits mainline.
> > > ---
> > >  .../devicetree/bindings/mmc/fsl-mxs-mmc.txt        |   23 ++++++
> > >  drivers/mmc/host/mxs-mmc.c                         |   82 +++++++++++++++++++-
> > >  2 files changed, 102 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mmc/fsl-mxs-mmc.txt b/Documentation/devicetree/bindings/mmc/fsl-mxs-mmc.txt
> > > new file mode 100644
> > > index 0000000..adc1142
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/mmc/fsl-mxs-mmc.txt
> > > @@ -0,0 +1,23 @@
> > > +* FREESCALE MXS MMC peripheral
> > > +
> > > +Required properties:
> > > +- compatible : Should be "fsl,<chip>-mmc"
> > > +- reg : Should contain registers location and length
> > > +- interrupts : Should contain interrupt.
> > > +  The format is <irq_err irq_dma>.
> > > +- dma_channel: Should contain the dma channel it uses
> > > +
> > > +Optional properties:
> > > +- wp-gpios : Specify GPIOs for write protection
> > > +- slot-4bit: Specify 4 bit mode support
> > > +- slot-8bit: Specify 8 bit and 4 bit mode support
> > > +
> > > +Examples:
> > > +mmc1: ssp@80010000 {
> > > +	compatible = "fsl,imx28-mmc";
> > > +	reg = <0x80010000 2000>;
> > > +	/* <irq_err irq_dma> */
> > > +	interrupts = <96 82>;
> > > +	dma_channel = <0>;
> > > +	slot-8bit;
> > > +};
> > > diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> > > index 382c835..6cf2d17 100644
> > > --- a/drivers/mmc/host/mxs-mmc.c
> > > +++ b/drivers/mmc/host/mxs-mmc.c
> > > @@ -38,6 +38,10 @@
> > >  #include <linux/gpio.h>
> > >  #include <linux/regulator/consumer.h>
> > >  #include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/of_gpio.h>
> > > +#include <linux/slab.h>
> > >  
> > >  #include <mach/mxs.h>
> > >  #include <mach/common.h>
> > > @@ -673,17 +677,79 @@ static bool mxs_mmc_dma_filter(struct dma_chan *chan, void *param)
> > >  	return true;
> > >  }
> > >  
> > > +#ifdef CONFIG_OF
> > > +static struct resource * __devinit mxs_mmc_get_of_dmares(
> > > +				struct platform_device *pdev)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct resource *dmares;
> > > +	int ret;
> > > +
> > > +	if (!np)
> > > +		return NULL;
> > > +
> > > +	dmares = kzalloc(sizeof(*dmares), GFP_KERNEL);
> > > +	dmares->flags = IORESOURCE_DMA;
> > > +	ret = of_property_read_u32(np, "dma_channel", &dmares->start);
> > > +	if (ret) {
> > > +		dev_err(&pdev->dev, "unable to get dmares from dt\n");
> > > +		return NULL;
> > > +	}
> > > +	dmares->end = dmares->start;
> > > +
> > > +	return dmares;
> > > +}
> > > +
> > > +static int __devinit mxs_mmc_get_of_property(struct platform_device *pdev,
> > > +				struct mxs_mmc_platform_data **ppdata)
> > > +{
> > > +	struct device_node *np = pdev->dev.of_node;
> > > +	struct mxs_mmc_platform_data *pdata = *ppdata;
> > > +
> > > +	if (!np)
> > > +		return -ENODEV;
> > > +
> > > +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> > > +
> > > +	if (of_get_property(np, "slot-8bit", NULL))
> > > +		pdata->flags |= SLOTF_8_BIT_CAPABLE;
> > > +
> > > +	if (of_get_property(np, "slot-4bit", NULL))
> > > +		pdata->flags |= SLOTF_4_BIT_CAPABLE;
> > it will conflit if both binding are set use a number instead
> > 
> Hmm, i did not see conflict, can you explain more?
> The "slot-8bit" includes the support for 4bit.(see binding doc)
> Even user define them two property in dt by mistake, it does not cause conflict.
> See:
> if (pdata) {
> 	if (pdata->flags & SLOTF_8_BIT_CAPABLE)
> 		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
> 	if (pdata->flags & SLOTF_4_BIT_CAPABLE)
> 		mmc->caps |= MMC_CAP_4_BIT_DATA;
> }

this is mmc specifc sohould have a generic binding

Best Regards,
J.
