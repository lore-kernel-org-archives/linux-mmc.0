From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v4] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Wed, 26 Sep 2012 03:17:14 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C194B54@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1348563632-23659-1-git-send-email-r66093@freescale.com>
 <CAGxe1ZG_5bcG1fJhPE0jsHYWDLK6eww9sa29H8E1gSFBQ36aXQ@mail.gmail.com>
 <110EED8CC96DFC488B7E717A2027A27C194AFB@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:45311
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751376Ab2IZDRU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Sep 2012 23:17:20 -0400
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C194AFB@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>, Chris Ball <cjb@laptop.org>

Next version, I will change it to the warning and report to user.

Best Regards
Jerry Huang


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Huang Changming-R66093
> Sent: Wednesday, September 26, 2012 10:40 AM
> To: Girish K S
> Cc: linux-mmc@vger.kernel.org; Xie Shaohui-B21989; Anton Vorontsov; Chris
> Ball
> Subject: RE: [PATCH v4] powerpc/esdhc: disable CMD23 for some Freescale
> SoCs
> 
> 
> 
> Best Regards
> Jerry Huang
> 
> 
> > -----Original Message-----
> > From: Girish K S [mailto:girish.shivananjappa@linaro.org]
> > Sent: Tuesday, September 25, 2012 10:45 PM
> > To: Huang Changming-R66093
> > Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Xie
> > Shaohui-B21989; Anton Vorontsov; Chris Ball
> > Subject: Re: [PATCH v4] powerpc/esdhc: disable CMD23 for some
> > Freescale SoCs
> >
> > On 25 September 2012 18:00,  <r66093@freescale.com> wrote:
> > > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > >
> > > CMD23 causes lots of errors in kernel on some freescale SoCs (P1020,
> > > P1021, P1022, P1024, P1025 and P4080) when MMC card used, which is
> > > because these controllers does not support CMD23, even on the SoCs
> > > which declares CMD23 is supported.
> > > Therefore, we'll not use CMD23.
> > >
> > > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > > CC: Anton Vorontsov <cbouatmailru@gmail.com>
> > > CC: Chris Ball <cjb@laptop.org>
> > > ---
> > > changes for v4:
> > >         - change to detect the IP version
> > >         - don't use callback function changes for v3:
> > >         - move the limitation detect function to eSDHC file
> > >         - add the callback funtion to do this limitation detect
> > > changes for v2:
> > >         - discard the property mode and add the processor detection
> > >
> > >  drivers/mmc/host/sdhci-of-esdhc.c |   33
> > +++++++++++++++++++++++++++++++++
> > >  drivers/mmc/host/sdhci-pltfm.c    |    4 +++-
> > >  drivers/mmc/host/sdhci-pltfm.h    |    1 +
> > >  drivers/mmc/host/sdhci.c          |    3 +++
> > >  include/linux/mmc/sdhci.h         |    1 +
> > >  5 files changed, 41 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-of-esdhc.c
> > > b/drivers/mmc/host/sdhci-of-esdhc.c
> > > index ae5fcbf..231672b 100644
> > > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > > @@ -169,6 +169,38 @@ static void esdhc_of_resume(struct sdhci_host
> > > *host)  }  #endif
> > >
> > > +static void esdhc_of_detect_limitation(struct platform_device *pdev,
> > > +       struct sdhci_pltfm_data *pdata) {
> > > +       void __iomem *ioaddr;
> > > +       struct resource *iomem;
> > > +       u32 vvn;
> > > +
> > > +       iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +       if (!iomem) {
> > > +               dev_err(&pdev->dev, "failed to get resource\n");
> > > +               goto err;
> > > +       }
> > > +       if (resource_size(iomem) < 0x100)
> > > +               dev_err(&pdev->dev, "Invalid iomem size!\n");
> > > +
> > > +       ioaddr = ioremap(iomem->start, resource_size(iomem));
> > > +       if (!ioaddr) {
> > > +               dev_err(&pdev->dev, "failed to remap registers\n");
> > > +               goto err;
> > > +       }
> > > +
> > > +       /* P102x and P4080 has IP version VVN2.2, CMD23 is not
> > supported */
> > > +       vvn = in_be32(ioaddr + SDHCI_SLOT_INT_STATUS);
> > > +       vvn = (vvn & SDHCI_VENDOR_VER_MASK) >> SDHCI_VENDOR_VER_SHIFT;
> > > +       if (vvn == VENDOR_V_22)
> > > +               pdata->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > > +
> > > +       iounmap(ioaddr);
> > > +err:
> > > +       return;
> > return a err value so that it is checked when called. If err then dont
> > have to proceed further.
> I don't care the return value, and just report to user there is one error
> when checking CMD23 limitation. 


