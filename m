From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 2/3] eSDHC: Fix errors when booting kernel with fsl esdhc
Date: Mon, 18 Jul 2011 06:01:20 +0000
Message-ID: <2239AC579C7D3646A720227A37E0268116E839@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
	<1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
 <CANfBPZ_xXQ0ZiLOmaJ=yC=Nm9Poumb45pyTpJ7fBQ3+Zbg+ZAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:20745
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750712Ab1GRGBZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 18 Jul 2011 02:01:25 -0400
In-Reply-To: <CANfBPZ_xXQ0ZiLOmaJ=yC=Nm9Poumb45pyTpJ7fBQ3+Zbg+ZAA@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, cbouatmailru <cbouatmailru@gmail.com>, akpm <akpm@linux-foundation.org>, Xu Lei-B33228 <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>



> -----Original Message-----
> From: S, Venkatraman [mailto:svenkatr@ti.com]
> Sent: Tuesday, July 05, 2011 14:17 PM
> To: Zang Roy-R61911
> Cc: linux-mmc; linuxppc-dev; cbouatmailru; akpm; Xu Lei-B33228; Kumar=
 Gala
> Subject: Re: [PATCH 2/3] eSDHC: Fix errors when booting kernel with f=
sl esdhc
>=20
> On Tue, Jul 5, 2011 at 9:49 AM, Roy Zang <tie-fei.zang@freescale.com>=
 wrote:
> > From: Xu lei <B33228@freescale.com>
> >
> > When esdhc module was enabled in p5020, there were following errors=
:
> >
> > mmc0: Timeout waiting for hardware interrupt.
> > mmc0: error -110 whilst initialising SD card
> > mmc0: Unexpected interrupt 0x02000000.
> > mmc0: Timeout waiting for hardware interrupt.
> > mmc0: error -110 whilst initialising SD card
> > mmc0: Unexpected interrupt 0x02000000.
> >
> > It is because ESDHC controller has different bit setting for PROCTL
> > register, when kernel sets Power Control Register by method for sta=
ndard
> > SD Host Specification, it would overwritten FSL ESDHC PROCTL[DMAS];
> > when it set Host Control Registers[DMAS], it sets PROCTL[EMODE] and
> > PROCTL[D3CD]. These operations will set bad bits for PROCTL Registe=
r
> > on FSL ESDHC Controller and cause errors, so this patch will make e=
sdhc
> > driver access FSL PROCTL Register according to block guide instead =
of
> > standard SD Host Specification.
> >
> > For some FSL chips, such as MPC8536/P2020, PROCTL[VOLT_SEL] and PRO=
CTL[DMAS]
> > bits are reserved and even if they are set to wrong bits there is n=
o error.
> > But considering that all FSL ESDHC Controller register map is not f=
ully
> > compliant to standard SD Host Specification, we put the patch to al=
l of
> > FSL ESDHC Controllers.
> >
> > Signed-off-by: Lei Xu <B33228@freescale.com>
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> > ---
> > =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A03 ++
> > =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 62 ++++++++++++++=
++++++++++++++++-----
> --
> > =A0include/linux/mmc/sdhci.h =A0 =A0 =A0 =A0| =A0 =A06 ++-
> > =A03 files changed, 57 insertions(+), 14 deletions(-)
[snip]

> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 58d5436..77174e5 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -674,7 +674,7 @@ static void sdhci_set_transfer_irqs(struct sdhc=
i_host
> *host)
> > =A0static void sdhci_prepare_data(struct sdhci_host *host, struct m=
mc_command
> *cmd)
> > =A0{
> > =A0 =A0 =A0 =A0u8 count;
> > - =A0 =A0 =A0 u8 ctrl;
> > + =A0 =A0 =A0 u32 ctrl;
> > =A0 =A0 =A0 =A0struct mmc_data *data =3D cmd->data;
> > =A0 =A0 =A0 =A0int ret;
> >
> > @@ -807,14 +807,28 @@ static void sdhci_prepare_data(struct sdhci_h=
ost *host,
> struct mmc_command *cmd)
> > =A0 =A0 =A0 =A0 * is ADMA.
> > =A0 =A0 =A0 =A0 */
> > =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_200) {
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST=
_CONTROL);
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_DMA_MASK;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_REQ_USE_DMA)=
 &&
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_=
USE_ADMA))
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_=
ADMA32;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_=
SDMA;
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_C=
ONTROL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_QORIQ_=
PROCTL_WEIRD) {
> > +#define ESDHCI_PROCTL_DMAS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0=
0000300
> > +#define ESDHCI_PROCTL_ADMA32 =A0 =A0 =A0 =A0 =A0 0x00000200
> > +#define ESDHCI_PROCTL_SDMA =A0 =A0 =A0 =A0 =A0 =A0 0x00000000
>=20
> Breaks the code flow / readability. Can be moved to top of the file ?
The defines are only used in the following section. Why it will break
the readability?
I can also see this kind of define in the file
=2E..
#define SAMPLE_COUNT    5

static int sdhci_get_ro(struct mmc_host *mmc)
=2E..

Any rule should follow?


[snip]
> > @@ -1162,6 +1189,17 @@ static void sdhci_set_power(struct sdhci_hos=
t *host,
> unsigned short power)
> >
> > =A0 =A0 =A0 =A0host->pwr =3D pwr;
> >
> > + =A0 =A0 =A0 /* Now FSL ESDHC Controller has no Bus Power bit,
> > + =A0 =A0 =A0 =A0* and PROCTL[21] bit is for voltage selection */
>=20
> Multiline comment style needed..
Will update.
please help to explain your previous comment.
Thanks.
Roy

