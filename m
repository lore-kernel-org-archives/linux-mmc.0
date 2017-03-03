From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: Re: [PATCH v4 2/2] mmc: host: s3cmci: allow probing from device tree
Date: Fri, 3 Mar 2017 08:38:47 -0300
Message-ID: <20170303113847.GA17377@sprado-desktop>
References: <1488417536-15110-1-git-send-email-sergio.prado@e-labworks.com>
 <CGME20170302012845epcas4p3d7e48f13c80b2115cea89e914b067eeb@epcas4p3.samsung.com>
 <1488417536-15110-3-git-send-email-sergio.prado@e-labworks.com>
 <39c2b81b-6519-826b-2c8d-344725ce2882@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <39c2b81b-6519-826b-2c8d-344725ce2882@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 03, 2017 at 11:14:29AM +0900, Jaehoon Chung wrote:
> On 03/02/2017 10:18 AM, Sergio Prado wrote:
> > Allows configuring Samsung S3C24XX MMC/SD/SDIO controller using a device
> > tree.
> > 
> > Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> > ---
> >  drivers/mmc/host/s3cmci.c | 298 ++++++++++++++++++++++++----------------------
> >  drivers/mmc/host/s3cmci.h |   3 +-
> >  2 files changed, 158 insertions(+), 143 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
> > index 7a173f8c455b..d066dbdb957c 100644
> > --- a/drivers/mmc/host/s3cmci.c
> > +++ b/drivers/mmc/host/s3cmci.c
> > @@ -24,6 +24,10 @@
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_gpio.h>
> > +#include <linux/mmc/slot-gpio.h>
> >  
> >  #include <plat/gpio-cfg.h>
> >  #include <mach/dma.h>
> > @@ -128,6 +132,22 @@ enum dbg_channels {
> >  	dbg_conf  = (1 << 8),
> >  };
> >  
> > +struct s3cmci_variant_data {
> > +	int s3c2440_compatible;
> > +};
> 
> I didn't understand why this structure needs.
> 
> Before this patch,
> host->is2440;
> 
> After this patch,
> host->variant->s3c2440_compatible;
> 
> Just add the one pointer for checking s3c2400 compatible..
> Is it really meaningful?
> (I didn't read the previous comments fully.)

Although just a pointer would be enought, having a structure makes it
more flexible to extend it in the future.

Best regards,

Sergio Prado
