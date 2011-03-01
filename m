From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Tue, 1 Mar 2011 01:51:28 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900C7B7B@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298892725-23672-4-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110228144741.GF15532@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:5140 "EHLO
	VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754056Ab1CABve convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 20:51:34 -0500
In-Reply-To: <20110228144741.GF15532@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>, Zhao Richard-B20223 <B20223@freescale.com>, "Freescale@lists.linaro.org" <Freescale@lists.linaro.org>, "eric.miao@linaro.org" <eric.miao@linaro.org>

Hi Wolfram:
Thanks a lot for your review-comments firstly. :)

Best Regards
Richard Zhu


> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Monday, February 28, 2011 10:48 PM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de; linux-
> mmc@vger.kernel.org; cjb@laptop.org; avorontsov@ru.mvista.com;
> eric@eukrea.com; linuxzsc@gmail.com; Zhao Richard-B20223;
> Freescale@lists.linaro.org; eric.miao@linaro.org
> Subject: Re: [PATCH V3 4/4] mmc: sdhci-esdhc: enable esdhc on imx53
>
> On Mon, Feb 28, 2011 at 07:32:05PM +0800, Richard Zhu wrote:
> > Fix the NO INT in the Multi-BLK IO in SD/MMC, and Multi-BLK read in
> > SDIO
> >
> > The CMDTYPE of the CMD register(offset 0xE) should be set to "11" when
> > the STOP CMD12 is issued on imx53 to abort one open ended multi-blk
> > IO. Otherwise one the TC INT wouldn't be generated.
> >
> > In exact block transfer, the controller doesn't complete the
> > operations automatically as required at the end of the transfer and
> > remains on hold if the abort command is not sent.
> > As a result, the TC flag is not asserted and SW  received timeout
> > exeception. set bit1 of Vendor Spec registor to fix it
> >
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c |   77
> ++++++++++++++++++++++++++++++++++-
> >  drivers/mmc/host/sdhci-pltfm.h     |    2 +-
> >  2 files changed, 75 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 9b82910..32af7c4 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -15,13 +15,41 @@
> >  #include <linux/delay.h>
> >  #include <linux/err.h>
> >  #include <linux/clk.h>
> > +#include <linux/slab.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/sdhci-pltfm.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sdio.h>
> >  #include <mach/hardware.h>
> >  #include "sdhci.h"
> >  #include "sdhci-pltfm.h"
> >  #include "sdhci-esdhc.h"
> >
> > +/* Abort type definition in the command register  */
> > +#define  SDHCI_CMD_ABORTCMD        0xC0
>
> Won't that belong into sd.h (unless I misunderstood your last mail)?
This is the bit definitions of the ABORTCMD CMD-TYPE on the bit6~7 of CMD register.
Here is the definition of the CMD register derived from SDHC spec. FYI.
D15   D14 D13  D08     D07 D06       D05                  D04                          D03                       D02         D01 D00
Rsvd  Command  Index   Command Type  Data Present Select  Command Index Check Enable   Command CRC Check Enable  Rsvd        Response Type Select
>
> > +/* VENDOR SPEC register */
> > +#define SDHCI_VENDOR_SPEC  0xC0
> > +
> > +/*
> > + * The CMDTYPE of the CMD register(offset 0xE) should be set to
>
> Check spaces.
I used the <kernel_dir>/./scripts/checkpatch.pl script to check the patches, and didn't find that there are issues about the spaces.
Can you tell me what's kinds of spaces issue should be fixed?
Thanks in advanced. :)

>
> > + * "11" when the STOP CMD12 is issued on imx53 to abort one
> > + * open ended multi-blk IO. Otherwise one the TC INT wouldn't
> > + * be generated.
> > + * In exact block transfer, the controller doesn't complete the
> > + * operations automatically as required at the end of the
> > + * transfer and remains on hold if the abort command is not sent.
> > + * As a result, the TC flag is not asserted and SW  received timeout
> > + * exeception. Bit1 of Vendor Spec registor is used to fix it.
> > + */
>
> This is a better description, thanks. But what does the bit technically
> do? Can't we keep it enabled all the time? Can't we use it to fix CMD12,
> too?
>

No, we can't keep it enabled all the time.
This bit should be set to '1'/clear to '0' at the begin/end of the transfer.
Unfortunately, We can't use it to fix CMD12 issue either, this bit is only used to fix SDIO Multi-BLK NO INT case.
IC guy insist that the CMD12 case is not a bug refer to the SD HOST controller spec, the bit7-6 should be
Set to 11b when the abort CMD is issued.

> > +#define IMX_MULTIBLK_NO_INT                (1 << 0)
> > +
> > +struct pltfm_imx_data {
> > +   int flags;
> > +   u32 mod_val;
> > +};
>
> Hmm, to me, just using cpu_is_mx53() is more readable than introducing
> another layer of flags/quirks.
Hi Wolfram:
I discussed it with Richard Zhao before sending out these V3 patches.
As we know that there is not only mx53 has this issue, maybe some following SOCs have this issue too.
So we make a decision that we introduce another flags/quirks to declare it for all those SOCs that required this
mechanism in the end.
>
> > +
> > +static struct sdhci_ops sdhci_esdhc_ops;
> > +
>
> Move them to the front. But I did this already, so no worries :) I will
> ping Chris to merge my series, so we will have something better to
> develop on.
>
Thanks.:)
>
> >  static inline void esdhc_clrset_le(struct sdhci_host *host, u32 mask,
> > u32 val, int reg)  {
> >     void __iomem *base = host->ioaddr + (reg & ~0x3); @@ -38,20 +66,51
> > @@ static u16 esdhc_readw_le(struct sdhci_host *host, int reg)
> >     return readw(host->ioaddr + reg);
> >  }
> >
> > +static void esdhc_writel_le(struct sdhci_host *host, u32 val, int
> > +reg) {
> > +   switch (reg) {
> > +   case SDHCI_INT_STATUS:
> > +           if (val & SDHCI_INT_DATA_END) {
> > +                   u32 v;
> > +                   v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> > +                   if (v & 0x2) {
> > +                           v &= ~0x2;
>
> Forgot to mention this before. Please use a define instead of hardocded
> values.
Ok, Accepted.
>
> I skipped the rest because we probably need to answer the questions above
> first and to get a stable base with out conflicts.
>
> Regards,
>
>    Wolfram
>
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |

