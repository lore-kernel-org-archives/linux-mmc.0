From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH v2] powerpc/esdhc: disable CMD23 for some Freescale SoCs
Date: Fri, 21 Sep 2012 10:27:21 +0000
Message-ID: <110EED8CC96DFC488B7E717A2027A27C18F74A@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1348218514-30655-1-git-send-email-r66093@freescale.com>
 <CAGxe1ZFRm6BVY3zYyQOjAkgONuL2oijUxZjYgwGuboRg4a8EyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe004.messaging.microsoft.com ([216.32.180.187]:24993
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753525Ab2IUK10 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Sep 2012 06:27:26 -0400
In-Reply-To: <CAGxe1ZFRm6BVY3zYyQOjAkgONuL2oijUxZjYgwGuboRg4a8EyA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Xie Shaohui-B21989 <B21989@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>



Best Regards
Jerry Huang


> -----Original Message-----
> From: Girish K S [mailto:girish.shivananjappa@linaro.org]
> Sent: Friday, September 21, 2012 5:56 PM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Xie Shaohui-B21989;
> Anton Vorontsov
> Subject: Re: [PATCH v2] powerpc/esdhc: disable CMD23 for some Freescale
> SoCs
> 
> On 21 September 2012 14:38,  <r66093@freescale.com> wrote:
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> >
> > CMD23 causes lots of errors in kernel on some freescale SoCs (P1020,
> > P1021, P1022, P1024, P1025 and P4080) when mmc card used, which is
> > because these controllers does not support CMD23, but even on SoCs
> > which declare CMD23 is supported, so we'll not use CMD23.
> >
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
> > CC: Anton Vorontsov <cbouatmailru@gmail.com>
> > ---
> > changes for v2:
> >         - discard the property mode and add the processor detection
> >
> >  drivers/mmc/host/sdhci-pltfm.c |   32 ++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci.c       |    3 +++
> >  include/linux/mmc/sdhci.h      |    1 +
> >  3 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pltfm.c
> > b/drivers/mmc/host/sdhci-pltfm.c index d9a4ef4..ad55181 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -93,6 +93,36 @@ void sdhci_get_of_property(struct platform_device
> > *pdev) {}  #endif /* CONFIG_OF */
> > EXPORT_SYMBOL_GPL(sdhci_get_of_property);
> >
> > +static const u32 processor_table[] = {
> > +       /* P1020 Dual/Single core */
> > +       0x80EC00, 0x80E400, 0x80ED00, 0x80E500,
> > +       /* P1021 Dual/Single core */
> > +       0x80EC01, 0x80E401, 0x80ED01, 0x80E501,
> > +       /* P1022 Dual/Single core */
> > +       0x80EE00, 0x80E600, 0x80EF00, 0x80E700,
> > +       /* P1024 Dual/Single core */
> > +       0x80EC02, 0x80E402, 0x80ED02, 0x80E502,
> > +       /* P1025 Dual/Single core */
> > +       0x80EC03, 0x80E403, 0x80ED03, 0x80E503,
> > +       /* P4080 and P4040 */
> > +       0x820000, 0x820800, 0x820100, 0x820900 };
> > +
> > +void sdhci_detect_limitation(struct platform_device *pdev) {
> > +       struct sdhci_host *host = platform_get_drvdata(pdev);
> > +       u32 svr = mfspr(SPRN_SVR) >> 8;
> > +       u32 table_size = ARRAY_SIZE(processor_table);
> > +       int i;
> > +
> > +       for (i = 0; i < table_size; i++) {
> > +               if (processor_table[i] == svr) {
> > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
> > +                       break;
> > +               }
> > +       }
> > +}
> > +
> These changes are specific to powerpc platform. And sdhci-pltfm.c is a
> generic sdhci file. adding platform Soc code into this is not good.
> You can find how other Socs are making use of this file by creating a new
> Soc specific extension file.
>  Similarly you can have something like sdhci-powerpc.c
Yes, it is the better way, I once thought about this way. But, one callback function will be added.

