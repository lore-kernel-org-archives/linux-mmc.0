From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
Date: Mon, 28 Feb 2011 02:28:54 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900C7701@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298369606-29972-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298369606-29972-5-git-send-email-Hong-Xing.Zhu@freescale.com>
	<20110225203849.GC2192@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110225203849.GC2192@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Zhao Richard-B20223 <B20223@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>, "eric@eukrea.com" <eric@eukrea.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi WolfSang:
This phenomena is caused by the IC modifications on imx53 refer to imx51.
The details about this patch used for are listed below:
In order to generate the TC INT correctly, the CMD type of CMD12 should be set in the CMD register for
 mass storage Multi-BLK IO(CMD18/CMD25), and the bit1 of the Vendor Spec register should be set/clear
 at the begin/end of the Multi-BLK read.
Otherwise, there wouldn't TC INT generation in the mass storage Multi-BLK IO(CMD18/CMD25) and
 SDIO Multi-BLK read operations.

That's all. How about add these description into the commit?

Best Regards
Richard Zhu

> -----Original Message-----
> From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> Sent: Saturday, February 26, 2011 4:39 AM
> To: Zhu Richard-R65037
> Cc: linux-arm-kernel@lists.infradead.org; kernel@pengutronix.de; linux-
> mmc@vger.kernel.org; cjb@laptop.org; avorontsov@ru.mvista.com;
> eric@eukrea.com; linuxzsc@gmail.com; Zhao Richard-B20223
> Subject: Re: [PATCH v2 5/5] mmc: sdhci-esdhc: enable esdhc on imx53
>
> On Tue, Feb 22, 2011 at 06:13:26PM +0800, Richard Zhu wrote:
>
> > Fix the NO INT in the Multi-BLK IO in SD/MMC, and Multi-BLK read in
> > SDIO
>
> This description is too short. Why does it not work before, and why does
> this patch help?
>
> >
> > Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc-imx.c |   41
> +++++++++++++++++++++++++++++++++++-
> >  drivers/mmc/host/sdhci-esdhc.h     |    5 ++++
> >  2 files changed, 45 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c
> > b/drivers/mmc/host/sdhci-esdhc-imx.c
> > index 9b82910..a09f786 100644
> > --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> > +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> > @@ -17,6 +17,8 @@
> >  #include <linux/clk.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/mmc/sdhci-pltfm.h>
> > +#include <linux/mmc/mmc.h>
> > +#include <linux/mmc/sdio.h>
> >  #include <mach/hardware.h>
> >  #include "sdhci.h"
> >  #include "sdhci-pltfm.h"
> > @@ -38,6 +40,27 @@ static u16 esdhc_readw_le(struct sdhci_host *host,
> int reg)
> >     return readw(host->ioaddr + reg);
> >  }
> >
> > +static void esdhc_writel_le(struct sdhci_host *host, u32 val, int
> > +reg) {
> > +   switch (reg) {
> > +   case SDHCI_INT_STATUS:
> > +           /*
> > +            * Fix no INT bug in SDIO MULTI-BLK read
> > +            * clear bit1 of Vendor Spec registor after TC
> > +            */
>
> Same for this comment. Make it more descriptive, please
>
> > +           if (val & SDHCI_INT_DATA_END) {
> > +                   u32 v;
> > +                   v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> > +                   if (v & 0x2) {
> > +                           v &= (~0x2);
>
> Braces not needed.
>
> > +                           writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> > +                   }
>
> Can't you clear it unconditionally?
>
> > +           }
> > +           break;
> > +   }
> > +   writel(val, host->ioaddr + reg);
> > +}
> > +
> >  static void esdhc_writew_le(struct sdhci_host *host, u16 val, int
> > reg)  {
> >     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host); @@ -45,12
> > +68,27 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val,
> int reg)
> >     switch (reg) {
> >     case SDHCI_TRANSFER_MODE:
> >             /*
> > +            * Fix no INT bug in SDIO MULTI-BLK read
> > +            * set bit1 of Vendor Spec registor
> > +            */
> > +           if ((host->cmd->opcode == SD_IO_RW_EXTENDED)
> > +                           && (host->cmd->data->blocks > 1)
> > +                           && (host->cmd->data->flags & MMC_DATA_READ)) {
> > +                   u32 v;
> > +                   v = readl(host->ioaddr + SDHCI_VENDOR_SPEC);
> > +                   v |= 0x2;
> > +                   writel(v, host->ioaddr + SDHCI_VENDOR_SPEC);
> > +           }
> > +           /*
> >              * Postpone this write, we must do it together with a
> >              * command write that is down below.
> >              */
> >             pltfm_host->scratchpad = val;
> >             return;
> >     case SDHCI_COMMAND:
> > +           /*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO
> */
> > +           if (host->cmd->opcode == MMC_STOP_TRANSMISSION)
> > +                   val |= SDHCI_CMD_ABORTCMD;
>
> Can't we handle it the same way than the SDIO case? I have to admit, even
> after reading the docs, I don't fully get what this bit1 is about.
>
> >             writel(val << 16 | pltfm_host->scratchpad,
> >                     host->ioaddr + SDHCI_TRANSFER_MODE);
> >             return;
> > @@ -113,7 +151,7 @@ static int esdhc_pltfm_init(struct sdhci_host *host,
> struct sdhci_pltfm_data *pd
> >     clk_enable(clk);
> >     pltfm_host->clk = clk;
> >
> > -   if (cpu_is_mx35() || cpu_is_mx51())
> > +   if (!cpu_is_mx25())
> >             host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> >
> >     /* Fix errata ENGcm07207 which is present on i.MX25 and i.MX35 */
> @@
> > -133,6 +171,7 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
> >
> >  static struct sdhci_ops sdhci_esdhc_ops = {
> >     .read_w = esdhc_readw_le,
> > +   .write_l = esdhc_writel_le,
>
> You are applying it for all imx-versions?
>
> >     .write_w = esdhc_writew_le,
> >     .write_b = esdhc_writeb_le,
> >     .set_clock = esdhc_set_clock,
> > diff --git a/drivers/mmc/host/sdhci-esdhc.h
> > b/drivers/mmc/host/sdhci-esdhc.h index 303cde0..c93168c 100644
> > --- a/drivers/mmc/host/sdhci-esdhc.h
> > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > @@ -43,6 +43,11 @@
> >
> >  #define ESDHC_HOST_CONTROL_RES     0x05
> >
> > +/* Abort type definition in the command register  */
> > +#define  SDHCI_CMD_ABORTCMD        0xC0
>
> So, this is vendor-specific, too?
>
> > +/* VENDOR SPEC register */
> > +#define SDHCI_VENDOR_SPEC  0xC0
> > +
> >  static inline void esdhc_set_clock(struct sdhci_host *host, unsigned
> > int clock)  {
> >     int pre_div = 2;
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
