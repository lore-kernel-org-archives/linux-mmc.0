From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 2/3] eSDHC: Fix errors when booting kernel with fsl esdhc
Date: Tue, 5 Jul 2011 11:47:08 +0530
Message-ID: <CANfBPZ_xXQ0ZiLOmaJ=yC=Nm9Poumb45pyTpJ7fBQ3+Zbg+ZAA@mail.gmail.com>
References: <1309839543-6031-1-git-send-email-tie-fei.zang@freescale.com>
	<1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:59970 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753633Ab1GEGRJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Jul 2011 02:17:09 -0400
Received: by mail-iw0-f180.google.com with SMTP id 9so10796275iwn.11
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jul 2011 23:17:08 -0700 (PDT)
In-Reply-To: <1309839543-6031-2-git-send-email-tie-fei.zang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Roy Zang <tie-fei.zang@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, cbouatmailru <cbouatmailru@gmail.com>, akpm <akpm@linux-foundation.org>, Xu lei <B33228@freescale.com>, Kumar Gala <galak@kernel.crashing.org>

On Tue, Jul 5, 2011 at 9:49 AM, Roy Zang <tie-fei.zang@freescale.com> w=
rote:
> From: Xu lei <B33228@freescale.com>
>
> When esdhc module was enabled in p5020, there were following errors:
>
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: error -110 whilst initialising SD card
> mmc0: Unexpected interrupt 0x02000000.
> mmc0: Timeout waiting for hardware interrupt.
> mmc0: error -110 whilst initialising SD card
> mmc0: Unexpected interrupt 0x02000000.
>
> It is because ESDHC controller has different bit setting for PROCTL
> register, when kernel sets Power Control Register by method for stand=
ard
> SD Host Specification, it would overwritten FSL ESDHC PROCTL[DMAS];
> when it set Host Control Registers[DMAS], it sets PROCTL[EMODE] and
> PROCTL[D3CD]. These operations will set bad bits for PROCTL Register
> on FSL ESDHC Controller and cause errors, so this patch will make esd=
hc
> driver access FSL PROCTL Register according to block guide instead of
> standard SD Host Specification.
>
> For some FSL chips, such as MPC8536/P2020, PROCTL[VOLT_SEL] and PROCT=
L[DMAS]
> bits are reserved and even if they are set to wrong bits there is no =
error.
> But considering that all FSL ESDHC Controller register map is not ful=
ly
> compliant to standard SD Host Specification, we put the patch to all =
of
> FSL ESDHC Controllers.
>
> Signed-off-by: Lei Xu <B33228@freescale.com>
> Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> =A0drivers/mmc/host/sdhci-of-core.c | =A0 =A03 ++
> =A0drivers/mmc/host/sdhci.c =A0 =A0 =A0 =A0 | =A0 62 ++++++++++++++++=
++++++++++++++-------
> =A0include/linux/mmc/sdhci.h =A0 =A0 =A0 =A0| =A0 =A06 ++-
> =A03 files changed, 57 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-core.c b/drivers/mmc/host/sdhc=
i-of-core.c
> index 60e4186..fede43d 100644
> --- a/drivers/mmc/host/sdhci-of-core.c
> +++ b/drivers/mmc/host/sdhci-of-core.c
> @@ -179,6 +179,9 @@ static int __devinit sdhci_of_probe(struct platfo=
rm_device *ofdev)
> =A0 =A0 =A0 =A0if (sdhci_of_wp_inverted(np))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D SDHCI_QUIRK_INVERTED=
_WRITE_PROTECT;
>
> + =A0 =A0 =A0 if (of_device_is_compatible(np, "fsl,esdhc"))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->quirks |=3D SDHCI_QUIRK_QORIQ_PRO=
CTL_WEIRD;
> +
> =A0 =A0 =A0 =A0clk =3D of_get_property(np, "clock-frequency", &size);
> =A0 =A0 =A0 =A0if (clk && size =3D=3D sizeof(*clk) && *clk)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0of_host->clock =3D be32_to_cpup(clk);
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 58d5436..77174e5 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -674,7 +674,7 @@ static void sdhci_set_transfer_irqs(struct sdhci_=
host *host)
> =A0static void sdhci_prepare_data(struct sdhci_host *host, struct mmc=
_command *cmd)
> =A0{
> =A0 =A0 =A0 =A0u8 count;
> - =A0 =A0 =A0 u8 ctrl;
> + =A0 =A0 =A0 u32 ctrl;
> =A0 =A0 =A0 =A0struct mmc_data *data =3D cmd->data;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -807,14 +807,28 @@ static void sdhci_prepare_data(struct sdhci_hos=
t *host, struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 * is ADMA.
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (host->version >=3D SDHCI_SPEC_200) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(host, SDHCI_HOST_C=
ONTROL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_DMA_MASK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_REQ_USE_DMA) &=
&
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->flags & SDHCI_US=
E_ADMA))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_AD=
MA32;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_SD=
MA;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl, SDHCI_HOST_CON=
TROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_QORIQ_PR=
OCTL_WEIRD) {
> +#define ESDHCI_PROCTL_DMAS_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x000=
00300
> +#define ESDHCI_PROCTL_ADMA32 =A0 =A0 =A0 =A0 =A0 0x00000200
> +#define ESDHCI_PROCTL_SDMA =A0 =A0 =A0 =A0 =A0 =A0 0x00000000

Breaks the code flow / readability. Can be moved to top of the file ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readl(ho=
st, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~ESDHCI_PROCT=
L_DMAS_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHC=
I_REQ_USE_DMA) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->=
flags & SDHCI_USE_ADMA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D=
 ESDHCI_PROCTL_ADMA32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D=
 ESDHCI_PROCTL_SDMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writel(host, ctrl=
, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl =3D sdhci_readb(ho=
st, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl &=3D ~SDHCI_CTRL_D=
MA_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHC=
I_REQ_USE_DMA) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (host->=
flags & SDHCI_USE_ADMA))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D=
 SDHCI_CTRL_ADMA32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D=
 SDHCI_CTRL_SDMA;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, ctrl=
, SDHCI_HOST_CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!(host->flags & SDHCI_REQ_USE_DMA)) {
> @@ -1138,19 +1152,32 @@ out:
> =A0static void sdhci_set_power(struct sdhci_host *host, unsigned shor=
t power)
> =A0{
> =A0 =A0 =A0 =A0u8 pwr =3D 0;
> + =A0 =A0 =A0 u8 volt =3D 0;
>
> =A0 =A0 =A0 =A0if (power !=3D (unsigned short)-1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (1 << power) {
> +#define =A0 =A0 =A0 =A0ESDHCI_FSL_POWER_MASK =A0 0x40
> +#define =A0 =A0 =A0 =A0ESDHCI_FSL_POWER_180 =A0 =A00x00
> +#define =A0 =A0 =A0 =A0ESDHCI_FSL_POWER_300 =A0 =A00x40

<As above>

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_165_195:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDHCI_POWER_180=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHC=
I_QUIRK_QORIQ_PROCTL_WEIRD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D=
 ESDHCI_FSL_POWER_180;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D=
 SDHCI_POWER_180;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_29_30:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_30_31:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDHCI_POWER_300=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHC=
I_QUIRK_QORIQ_PROCTL_WEIRD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D=
 ESDHCI_FSL_POWER_300;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D=
 SDHCI_POWER_300;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_32_33:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case MMC_VDD_33_34:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D SDHCI_POWER_330=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & SDHC=
I_QUIRK_QORIQ_PROCTL_WEIRD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D=
 ESDHCI_FSL_POWER_300;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwr =3D=
 SDHCI_POWER_330;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BUG();
> @@ -1162,6 +1189,17 @@ static void sdhci_set_power(struct sdhci_host =
*host, unsigned short power)
>
> =A0 =A0 =A0 =A0host->pwr =3D pwr;
>
> + =A0 =A0 =A0 /* Now FSL ESDHC Controller has no Bus Power bit,
> + =A0 =A0 =A0 =A0* and PROCTL[21] bit is for voltage selection */

Multiline comment style needed..

> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_QORIQ_PROCTL_WEIRD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt =3D sdhci_readb(host, SDHCI_POWER_=
CONTROL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt &=3D ~ESDHCI_FSL_POWER_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 volt |=3D pwr;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, volt, SDHCI_POWER_CO=
NTROL);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (pwr =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_writeb(host, 0, SDHCI_POWER_CONT=
ROL);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 6a68c4e..d87abc7 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -21,7 +21,7 @@ struct sdhci_host {
> =A0 =A0 =A0 =A0/* Data set by hardware interface driver */
> =A0 =A0 =A0 =A0const char *hw_name; =A0 =A0/* Hardware bus name */
>
> - =A0 =A0 =A0 unsigned int quirks; =A0 =A0/* Deviations from spec. */
> + =A0 =A0 =A0 u64 quirks; =A0 =A0 /* Deviations from spec. */
>
> =A0/* Controller doesn't honor resets unless we touch the clock regis=
ter */
> =A0#define SDHCI_QUIRK_CLOCK_BEFORE_RESET =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (1<<0)
> @@ -86,7 +86,9 @@ struct sdhci_host {
> =A0/* Controller treats ADMA descriptors with length 0000h incorrectl=
y */
> =A0#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =A0 =A0 =A0 =A0 =A0 (=
1<<30)
> =A0/* The read-only detection via SDHCI_PRESENT_STATE register is uns=
table */
> -#define SDHCI_QUIRK_UNSTABLE_RO_DETECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<31)
> +#define SDHCI_QUIRK_UNSTABLE_RO_DETECT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (1U<<31)
> +/* Controller has weird bit setting for Protocol Control Register */
> +#define SDHCI_QUIRK_QORIQ_PROCTL_WEIRD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 (0x100000000U)
>
> =A0 =A0 =A0 =A0int irq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Device IRQ =
*/
> =A0 =A0 =A0 =A0void __iomem *ioaddr; =A0 /* Mapped address */
> --
> 1.6.0.6
>
