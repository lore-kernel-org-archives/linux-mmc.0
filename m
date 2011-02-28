From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Mon, 28 Feb 2011 09:05:28 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900C7850@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
 <1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
 <20110225203849.GC2192@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1outboundpool.messaging.microsoft.com ([216.32.181.182]:26458
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752577Ab1B1JFg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Feb 2011 04:05:36 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "eric@eukrea.com" <eric@eukrea.com>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>, Zhao Richard-B20223 <B20223@freescale.com>

Hi WolfSang:
See my comments below.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Zhu Richard-R65037
> Sent: Monday, February 28, 2011 10:29 AM
> To: 'Wolfram Sang'
> Cc: linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de; linux-
> mmc@vger.kernel.org; cjb@laptop.org; avorontsov@ru.mvista.com;
> eric@eukrea.com; linuxzsc@gmail.com; Zhao Richard-B20223
> Subject: RE: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
>
> Hi WolfSang:
> This phenomena is caused by the IC modifications on imx53 refer to imx51.
> The details about this patch used for are listed below:
> In order to generate the TC INT correctly, the CMD type of CMD12 should
> be set in the CMD register for  mass storage Multi-BLK IO(CMD18/CMD25),
> and the bit1 of the Vendor Spec register should be set/clear  at the
> begin/end of the Multi-BLK read.
> Otherwise, there wouldn't TC INT generation in the mass storage Multi-BLK
> IO(CMD18/CMD25) and  SDIO Multi-BLK read operations.
>
> That's all. How about add these description into the commit?
>
> Best Regards
> Richard Zhu
>
> > -----Original Message-----
> > From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> > Sent: Saturday, February 26, 2011 4:39 AM
> > To: Zhu Richard-R65037
> > Cc: linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de;
> > linux- mmc@vger.kernel.org; cjb@laptop.org; avorontsov@ru.mvista.com;
> > eric@eukrea.com; linuxzsc@gmail.com; Zhao Richard-B20223
> > Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
> >
> > On Tue, Feb 22, 2011 at 06:13:26PM +0800, Richard Zhu wrote:
> >
> > > Fix the NO INT in the Multi-BLK IO in SD/MMC, and Multi-BLK read in
> > > SDIO
> >
> > This description is too short. Why does it not work before, and why
> > does this patch help?
> >
> > >
> > > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > > ---
> > >  drivers/mmc/host/sdhci-esdhc-imx.c |   41
> > +++++++++++++++++++++++++++++++++++-
> > >  drivers/mmc/host/sdhci-esdhc.h     |    5 ++++
> > >  2 files changed, 45 insertions(+), 1 deletions(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > index 9b82910..a09f786 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > > @@ -17,6 +17,8 @@
> > >  #include <linux/clk.h>
> > >  #include <linux/mmc/host.h>
> > >  #include <linux/mmc/sdhci-pltfm.h>
> > > +#include <linux/mmc/mmc.h>
> > > +#include <linux/mmc/sdio.h>
> > >  #include <mach/hardware.h>
> > >  #include "sdhci.h"
> > >  #include "sdhci-pltfm.h"
> > > @@ -38,6 +40,27 @@ static u16 esdhc_readw_le(struct sdhci_host
> > > *host,
> > int reg)
> > >   return readw(host->ioaddr + reg);
> > >  }
> > >
> > > +static void esdhc_writel_le(struct sdhci_host *host, u32 val, int
> > > +reg) {
> > > + switch (reg) {
> > > + case SDHCI_INT_STATUS:
> > > +         /*
> > > +          * Fix no INT bug in SDIO MULTI-BLK read
> > > +          * clear bit1 of Vendor Spec registor after TC
> > > +          */
> >
> > Same for this comment. Make it more descriptive, please

This bit is used to abort the exact blocks transfer in SDIO.
Imx53 eSDHC can't generate the TC INT in the SDIO exact blocks read if this bit is not set.
Here is the IC errata number.
ENGcm11328 eSDHCv2/eSDHCv3: Transfer complete flag is not asserted in
SDIO exact multi-block read transfer
Description:
SDIO protocol defines two types of multi-block data transfer.
* Infinite block transfer - The card is not informed on the number of transferred blocks in advance.
When done, the Host sends an abort command to stop data transfer.
* Exact block transfer - The Host issues a block command providing correct block count. After
the exact blocks transfer is complete, the SDIO card automatically stops the operation without
requiring the abort command.
The issue occurs in case of exact multi-block read transfer. The eSDHC does not complete the
operation automatically as required at the end of the transfer and remains on hold if the abort
command is not sent. As a result, the transfer complete flag is not asserted and software receives
timeout exception

> >
> > > +         if (val & SDHCI_INT_DATA_END) {
> > > +                 u32 v;
> > > +                 v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> > > +                 if (v & 0x2) {
> > > +                         v &= (~0x2);
> >
> > Braces not needed.
Yes

> >
> > > +                         writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> > > +                 }
> >
> > Can't you clear it unconditionally?

Accepted. We can clear it unconditionally.
> >
> > > +         }
> > > +         break;
> > > + }
> > > + writel(val, host->ioaddr + reg);
> > > +}
> > > +
> > >  static void esdhc_writew_le(struct sdhci_host *host, u16 val, int
> > > reg)  {
> > >   struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host); @@ -45,12
> > > +68,27 @@ static void esdhc_writew_le(struct sdhci_host *host, u16
> > > +val,
> > int reg)
> > >   switch (reg) {
> > >   case SDHCI_TRANSFER_MODE:
> > >           /*
> > > +          * Fix no INT bug in SDIO MULTI-BLK read
> > > +          * set bit1 of Vendor Spec registor
> > > +          */
> > > +         if ((host->cmd->opcode == SD_IO_RW_EXTENDED)
> > > +                         && (host->cmd->data->blocks > 1)
> > > +                         && (host->cmd->data->flags & MMC_DATA_READ)) {
> > > +                 u32 v;
> > > +                 v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> > > +                 v |= 0x2;
> > > +                 writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> > > +         }
> > > +         /*
> > >            * Postpone this write, we must do it together with a
> > >            * command write that is down below.
> > >            */
> > >           pltfm_host->scratchpad = val;
> > >           return;
> > >   case SDHCI_COMMAND:
> > > +         /*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO
> > */
> > > +         if (host->cmd->opcode == MMC_STOP_TRANSMISSION)
> > > +                 val |= SDHCI_CMD_ABORTCMD;
> >
> > Can't we handle it the same way than the SDIO case? I have to admit,
> > even after reading the docs, I don't fully get what this bit1 is about.

The usage of this bit is introduced by imx53, maybe the latest doc would update it in soon.

> >
> > >           writel(val << 16 | pltfm_host->scratchpad,
> > >                   host->ioaddr + SDHCI_TRANSFER_MODE);
> > >           return;
> > > @@ -113,7 +151,7 @@ static int esdhc_pltfm_init(struct sdhci_host
> > > *host,
> > struct sdhci_pltfm_data *pd
> > >   clk_enable(clk);
> > >   pltfm_host->clk = clk;
> > >
> > > - if (cpu_is_mx35() || cpu_is_mx51())
> > > + if (!cpu_is_mx25())
> > >           host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> > >
> > >   /* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
> > @@
> > > -133,6 +171,7 @@ static void esdhc_pltfm_exit(struct sdhci_host
> > > *host)
> > >
> > >  static struct sdhci_ops sdhci_esdhc_ops = {
> > >   .read_w = esdhc_readw_le,
> > > + .write_l = esdhc_writel_le,
> >
> > You are applying it for all imx-versions?

Should be only for mx53, would change it later.

> >
> > >   .write_w = esdhc_writew_le,
> > >   .write_b = esdhc_writeb_le,
> > >   .set_clock = esdhc_set_clock,
> > > diff --git a/drivers/mmc/host/sdhci-esdhc.h
> > > b/drivers/mmc/host/sdhci-esdhc.h index 303cde0..c93168c 100644
> > > --- a/drivers/mmc/host/sdhci-esdhc.h
> > > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > > @@ -43,6 +43,11 @@
> > >
> > >  #define ESDHC_HOST_CONTROL_RES   0x05
> > >
> > > +/* Abort type definition in the command register  */
> > > +#define  SDHCI_CMD_ABORTCMD      0xC0
> >
> > So, this is vendor-specific, too?

The CMD-TYE definitions of the CMD register should be set when CMD12 is issued to
 abort the transfer on imx53, otherwise, the
Refer to the SD HOST controller spec, these two bits should be set to 11 when CMD12 is used
to abort the transfer too.
It seems that these two bits wouldn't be set in the original common sd/mmc driver when CMD12
is issued to abort the multi-block transfer.
I'm a little confused about this.
Do you have any conclusions about it?

> >
> > > +/* VENDOR SPEC register */
> > > +#define SDHCI_VENDOR_SPEC        0xC0
> > > +
> > >  static inline void esdhc_set_clock(struct sdhci_host *host,
> > > unsigned int clock)  {
> > >   int pre_div = 2;
> >
> > Regards,
> >
> >    Wolfram
> >
> > --
> > Pengutronix e.K.                           | Wolfram Sang
> > |
> > Industrial Linux Solutions                 | http://www.pengutronix.de/
> > |

