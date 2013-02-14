From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 2/3] mmc: davinci_mmc: add DT support
Date: Thu, 14 Feb 2013 06:19:44 +0000
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA46AE8@DBDE01.ent.ti.com>
References: <1360223825-23929-1-git-send-email-prakash.pm@ti.com>
 <1360223825-23929-3-git-send-email-prakash.pm@ti.com>
 <5119DF6E.9080501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <5119DF6E.9080501-l0cyMroinI0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: "Porter, Matt" <mporter-l0cyMroinI0@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org" <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, "hs-ynQEQJNshbs@public.gmane.org" <hs-ynQEQJNshbs@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Sekhar,

This mail reached my inbox after I sent out v3.

On Tue, Feb 12, 2013 at 11:51:34, Nori, Sekhar wrote:
> On 2/7/2013 1:27 PM, Manjunathappa, Prakash wrote:
> > Adds device tree support for davinci_mmc. Also add binding documentation.
> > Tested in non-dma PIO mode and without GPIO card_detect/write_protect
> > option because of dependencies on EDMA and GPIO module DT support.
> > 
> > Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
> > Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> > Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> > Cc: cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org
> > Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> > Cc: mporter-l0cyMroinI0@public.gmane.org
> > ---
> > Since v1:
> > Modified DT parse function to take default values and accomodate controller
> > version in compatible field.
> > 
> >  .../devicetree/bindings/mmc/davinci_mmc.txt        |   30 ++++++++
> >  drivers/mmc/host/davinci_mmc.c                     |   70 +++++++++++++++++++-
> >  2 files changed, 99 insertions(+), 1 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/davinci_mmc.txt b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> > new file mode 100644
> > index 0000000..6717ab1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mmc/davinci_mmc.txt
> > @@ -0,0 +1,30 @@
> > +* TI Highspeed MMC host controller for DaVinci
> > +
> > +The Highspeed MMC Host Controller on TI DaVinci family
> > +provides an interface for MMC, SD and SDIO types of memory cards.
> > +
> > +This file documents the properties used by the davinci_mmc driver.
> > +
> > +Required properties:
> > +- compatible:
> > + Should be "ti,davinci-mmc-da830": for da830, da850, dm365
> > + Should be "ti,davinci-mmc-dm355": for dm355, dm644x
> > +
> > +Optional properties:
> > +- bus-width: Number of data lines, can be <4>, or <8>, default <1>
> > +- max-frequency: Maximum operating clock frequency, default 25MHz.
> > +- mmc-cap-mmc-highspeed: Indicates support for MMC in high speed mode
> > +- mmc-cap-sd-highspeed: Indicates support for SD in high speed mode
> > +
> > +Example:
> > +	mmc0: mmc@1c40000 {
> > +		compatible = "ti,davinci-mmc-da830",
> > +		reg = <0x40000 0x1000>;
> > +		interrupts = <16>;
> > +		status = "okay";
> > +		bus-width = <4>;
> > +		max-frequency = <50000000>;
> > +		mmc-cap-sd-highspeed;
> > +		mmc-cap-mmc-highspeed;
> > +	};
> > +
> > diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> > index 27123f8..3f90316 100644
> > --- a/drivers/mmc/host/davinci_mmc.c
> > +++ b/drivers/mmc/host/davinci_mmc.c
> > @@ -34,6 +34,8 @@
> >  #include <linux/dma-mapping.h>
> >  #include <linux/edma.h>
> >  #include <linux/mmc/mmc.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> >  
> >  #include <linux/platform_data/mmc-davinci.h>
> >  
> > @@ -1157,15 +1159,80 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
> >  	mmc_davinci_reset_ctrl(host, 0);
> >  }
> >  
> > -static int __init davinci_mmcsd_probe(struct platform_device *pdev)
> > +static const struct of_device_id davinci_mmc_dt_ids[] = {
> > +	{
> > +		.compatible = "ti,davinci-mmc-dm355",
> > +		.data = (void *)MMC_CTLR_VERSION_1,
> > +	},
> > +	{
> > +		.compatible = "ti,davinci-mmc-da830",
> > +		.data = (void *)MMC_CTLR_VERSION_2,
> > +	},
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, davinci_mmc_dt_ids);
> 
> If you are doing this why not also kill passing IP version through
> platform data using a platform_device_id table? Look at what Afzal did
> for drivers/rtc/rtc-omap.c
> 

Agreed, I will send out v4 having these changes also in this series.

Thanks,
Prakash

> Thanks,
> Sekhar
> 
