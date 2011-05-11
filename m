From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH] sdhci-s3c: fixed compiler error for renamed register
Date: Wed, 11 May 2011 08:53:04 -0500
Message-ID: <6C03668EAF45B747AF947A1603D1B300EBE0327C@SAUSEXMBP01.amd.com>
References: <4DCA3B54.3000607@samsung.com>
 <m3liyd2vl1.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:6102
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753015Ab1EKPie convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 11 May 2011 11:38:34 -0400
In-Reply-To: <m3liyd2vl1.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ben Dooks <ben-linux@fluff.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Chris,


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, May 11, 2011 7:22 PM
> To: Jaehoon Chung
> Cc: linux-mmc@vger.kernel.org; Ben Dooks; Kyungmin Park; Nath, Arindam
> Subject: Re: [PATCH] sdhci-s3c: fixed compiler error for renamed
> register
> 
> Hi,
> 
> On Wed, May 11 2011, Jaehoon Chung wrote:
> > In Arindam Nath's patch "mmc:sd: add support for driver type
> selection"
> > included renamed SDHCI_HOST_CONTROL1.
> >
> > In sdhci-s3c, we used SDHCI_HOST_CONTROL in
> sdhci_s3c_platform_8bit_width().
> > Also we need to use the renamed register in sdhci-s3c.c
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > ---
> >  drivers/mmc/host/sdhci-s3c.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-
> s3c.c
> > index 69e3ee3..15a6195 100644
> > --- a/drivers/mmc/host/sdhci-s3c.c
> > +++ b/drivers/mmc/host/sdhci-s3c.c
> > @@ -289,7 +289,7 @@ static int sdhci_s3c_platform_8bit_width(struct
> sdhci_host *host, int width)
> >  {
> >  	u8 ctrl;
> >
> > -	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
> >
> >  	switch (width) {
> >  	case MMC_BUS_WIDTH_8:
> > @@ -304,7 +304,7 @@ static int sdhci_s3c_platform_8bit_width(struct
> sdhci_host *host, int width)
> >  		break;
> >  	}
> >
> > -	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> >
> >  	return 0;
> >  }
> >
> 
> Thanks, this affects other drivers too:
> 
> sdhci-esdhc-imx.c:      case SDHCI_HOST_CONTROL:
> sdhci-of-esdhc.c:       if (reg == SDHCI_HOST_CONTROL)
> sdhci-s3c.c:    ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> sdhci-s3c.c:    sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> sdhci-tegra.c:  ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> sdhci-tegra.c:  sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> 
> Arindam, is there any problem with continuing to use SDHCI_HOST_CONTROL
> for the first register, and adding SDHCI_HOST_CONTROL2 for the second?
> I think that would be better than modifying all of the drivers.

I am okay with your suggestion. I just changed the name as per the SDHC3.0 spec.

Thanks,
Arindam

> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child


