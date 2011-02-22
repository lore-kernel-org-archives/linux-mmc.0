From: Zhu Richard-R65037 <R65037@freescale.com>
Subject: RE: [PATCH 5/5] mmc: sdhci: add quirk
 SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
Date: Tue, 22 Feb 2011 05:56:21 +0000
Message-ID: <010C9052C42A00499CE76D637FA5EE900C5A5A@039-SN1MPN1-001.039d.mgd.msft.net>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
 <1298282095-2279-5-git-send-email-richard.zhao@freescale.com>
 <20110221100439.GE2616@pengutronix.de>
 <010C9052C42A00499CE76D637FA5EE900C579F@039-SN1MPN1-001.039d.mgd.msft.net>
 <20110221104608.GF2616@pengutronix.de>
 <20110221110905.GL14495@n2100.arm.linux.org.uk>
 <20110221111557.GG2616@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:15562
	"EHLO VA3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752258Ab1BVF41 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 22 Feb 2011 00:56:27 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Zhao Richard-B20223 <B20223@freescale.com>, "cjb@laptop.org" <cjb@laptop.org>, "eric@eukrea.com" <eric@eukrea.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "avorontsov@ru.mvista.com" <avorontsov@ru.mvista.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linuxzsc@gmail.com" <linuxzsc@gmail.com>

Hi WolfSang:
I mis-understand your meaning of the IO-Accessors.
It maybe work when the IO-Accessors are used.
Wait a minute, I would resend the patches use he IO-Accessors methods.

Best Regards
Richard Zhu


> -----Original Message-----
> From: Zhu Richard-R65037
> Sent: Tuesday, February 22, 2011 10:22 AM
> To: 'Wolfram Sang'; Russell King - ARM Linux
> Cc: Zhao Richard-B20223; cjb@laptop.org; eric@eukrea.com; linux-
> mmc@vger.kernel.org; kernel@pengutronix.de; avorontsov@ru.mvista.com;
> linux-arm-kernel@lists.infradead.org; linuxzsc@gmail.com
> Subject: RE: [PATCH 5/5] mmc: sdhci: add quirk
> SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
>
> Hi Wolfsang:
> Maybe I don't describe my thoughts clearly and exactly.
> I feel it's not easy to add the the IO-accessors in every cmd execution
> procedure, to make a double check why a IO-accessor is needed or not.
>
> Best Regards
> Richard Zhu
>
>
> > -----Original Message-----
> > From: Wolfram Sang [mailto:w.sang@pengutronix.de]
> > Sent: Monday, February 21, 2011 7:16 PM
> > To: Russell King - ARM Linux
> > Cc: Zhu Richard-R65037; Zhao Richard-B20223; cjb@laptop.org;
> > eric@eukrea.com; linux-mmc@vger.kernel.org; kernel@pengutronix.de;
> > avorontsov@ru.mvista.com; linux-arm-kernel@lists.infradead.org;
> > linuxzsc@gmail.com
> > Subject: Re: [PATCH 5/5] mmc: sdhci: add quirk
> > SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO
> >
> > On Mon, Feb 21, 2011 at 11:09:05AM +0000, Russell King - ARM Linux
> wrote:
> > > On Mon, Feb 21, 2011 at 11:46:08AM +0100, Wolfram Sang wrote:
> > > > > > > -   if (cpu_is_mx35() || cpu_is_mx51())
> > > > > > > +   if (cpu_is_mx53())
> > > > > > > +           host->quirks |=
> > > > > > > + SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO;
> > > > > >
> > > > > > Have you tried it doing it via IO-accessors?
> > > > > Richard Zhu: This quirk is used to fix a mechanism problem in
> > > > > the
> > MMC CMDs execution procedure.
> > > > > It would be very abrupt and ugly, if the IO-accessors are added
> > into these original procedures.
> > > >
> > > > Please don't get it personal, but IMHO it is pretty ugly the way
> > > > it is now. This quirk is very imx-specific and calling something
> > > > like SDHCI_VENDOR_SPEC in sdhci.c looks clearly wrong to me. By
> > > > the way, what does this bit do, the description doesn't say so?
> > >
> > > SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO is rather too verbose.  Isn't
> > > there a shorter version which could be used?
> > > SDHCI_QUIRK_SDIO_MULTIBLK_INT maybe?
> >
> > As I understand, the non-SDIO part is handled here:
> Yes, it is. The following codes are used to solve non-sdio part.
> That bit is introduced by imx53 latest spec.
> I think so too that the SDHCI_VENDOR_SPEC shouldn't be used in sdhci.c
> file, but I don't have better idea to fix the issue in this situation.
> Option:
> Make a double check when issue every MMC CMD, to figure out whether a IO-
> accessor is needed or not?
> Two checkpoints would be needed, one is in the sdhci_send_command
> function, the other should be in sdhci_data_finish func.
> How do you think this method?
>
> >
> > +       /*Set the CMD_TYPE of the CMD12, fix no INT in MULTI_BLK IO */
> > +       if (host->quirks & SDHCI_QUIRK_FIX_NO_INT_IN_MULTI_BLK_IO) {
> > +               if (cmd->opcode == 12)
> > +                       flags |= SDHCI_CMD_ABORTCMD;
> > +       }
> >
> > But I'd really like to avoid the quirk bit. Maybe we'll get a better
> > idea once we understand what that magic bit actually does. For a
> > start, we might simply set SDHCI_QUIRK_NO_MULTIBLOCK for mx53 like we
> > do for other imx.
> As I know that, this bit is used to make the machine stat of the eSDHC IC
> to be a correct stat after SDIO Multi-Read.
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

