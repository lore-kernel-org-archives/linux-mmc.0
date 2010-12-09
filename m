From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v2] mmc: Add support for JMicron 388 SD/MMC controller
Date: Wed, 8 Dec 2010 21:18:38 -0500
Message-ID: <AANLkTimhu9+42H1PYGjXih=J_x480g16SpWASUi+joUC@mail.gmail.com>
References: <s5h7hfk3aap.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:38543 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab0LICSk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 21:18:40 -0500
In-Reply-To: <s5h7hfk3aap.wl%tiwai@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Aries Lee <arieslee@jmicron.com>, Wolfram Sang <w.sang@pengutronix.de>

On Wed, Dec 8, 2010 at 4:04 AM, Takashi Iwai <tiwai@suse.de> wrote:
> JMicron 388 SD/MMC combo controller supports the 1.8V low-voltage for
> SD, but MMC doesn't work with the low-voltage, resulting in an error
> at probing.
>
> This patch adds the support for multiple voltage mask per device type=
,
> so that SD works with 1.8V while MMC forces 3.3V. =A0Here new ocr_ava=
il_*
> fields for each device are introduced, so that the actual OCR mask is
> switched dynamically.

It is great that you also have 1.8v requirement, could you help share s=
ome info?
What's the card you are using, mmc or sd, if sd, does cmd11 is required=
?
Which component will provide voltage in your platform, external pmic
or controller?
What's the init voltage, 3.3v? and then switch to 1.8v, does some time
required to wait voltage to be stable?

Thanks a lot.

>
> Also, the restriction of low-voltage in core/sd.c is removed when the
> bit is allowed explicitly via ocr_avail_sd mask.
>
> This patch was rewritten from scratch based on Aries' original code.
>
> Signed-off-by: Aries Lee <arieslee@jmicron.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>
> v1->v2
> =A0- Rebased to the latest mmc-next branch of linux-mmc tree
>
> =A0drivers/mmc/core/mmc.c =A0 =A0 =A0 | =A0 =A02 +
> =A0drivers/mmc/core/sd.c =A0 =A0 =A0 =A0| =A0 =A05 +++-
> =A0drivers/mmc/core/sdio.c =A0 =A0 =A0| =A0 =A02 +
> =A0drivers/mmc/host/sdhci-pci.c | =A0 47 ++++++++++++++++++++++++++++=
++++++++-----
> =A0drivers/mmc/host/sdhci.c =A0 =A0 | =A0 23 ++++++++++++++++----
> =A0include/linux/mmc/host.h =A0 =A0 | =A0 =A03 ++
> =A0include/linux/mmc/sdhci.h =A0 =A0| =A0 =A04 +++
> =A0include/linux/pci_ids.h =A0 =A0 =A0| =A0 =A02 +
> =A08 files changed, 76 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 77f93c3..76bb621 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -745,6 +745,8 @@ int mmc_attach_mmc(struct mmc_host *host, u32 ocr=
)
> =A0 =A0 =A0 =A0WARN_ON(!host->claimed);
>
> =A0 =A0 =A0 =A0mmc_attach_bus_ops(host);
> + =A0 =A0 =A0 if (host->ocr_avail_mmc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ocr_avail =3D host->ocr_avail_mmc=
;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * We need to get OCR a different way for SPI.
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 49da4df..de062eb 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -772,6 +772,8 @@ int mmc_attach_sd(struct mmc_host *host, u32 ocr)
> =A0 =A0 =A0 =A0WARN_ON(!host->claimed);
>
> =A0 =A0 =A0 =A0mmc_sd_attach_bus_ops(host);
> + =A0 =A0 =A0 if (host->ocr_avail_sd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ocr_avail =3D host->ocr_avail_sd;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * We need to get OCR a different way for SPI.
> @@ -795,7 +797,8 @@ int mmc_attach_sd(struct mmc_host *host, u32 ocr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ocr &=3D ~0x7F;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (ocr & MMC_VDD_165_195) {
> + =A0 =A0 =A0 if ((ocr & MMC_VDD_165_195) &&
> + =A0 =A0 =A0 =A0 =A0 !(host->ocr_avail_sd & MMC_VDD_165_195)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "%s: SD card claim=
s to support the "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "incompletely defined 'lo=
w voltage range'. This "
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "will be ignored.\n", mmc=
_hostname(host));
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index efef5f9..c18810a 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -700,6 +700,8 @@ int mmc_attach_sdio(struct mmc_host *host, u32 oc=
r)
> =A0 =A0 =A0 =A0WARN_ON(!host->claimed);
>
> =A0 =A0 =A0 =A0mmc_attach_bus(host, &mmc_sdio_ops);
> + =A0 =A0 =A0 if (host->ocr_avail_sdio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ocr_avail =3D host->ocr_avail_sdi=
o;
>
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Sanity check the voltages that the card claims to
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pc=
i.c
> index 831cf91..d2638ff 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -272,6 +272,7 @@ static int jmicron_pmos(struct sdhci_pci_chip *ch=
ip, int on)
> =A0static int jmicron_probe(struct sdhci_pci_chip *chip)
> =A0{
> =A0 =A0 =A0 =A0int ret;
> + =A0 =A0 =A0 u16 mmcdev =3D 0;
>
> =A0 =A0 =A0 =A0if (chip->pdev->revision =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->quirks |=3D SDHCI_QUIRK_32BIT_DM=
A_ADDR |
> @@ -293,12 +294,17 @@ static int jmicron_probe(struct sdhci_pci_chip =
*chip)
> =A0 =A0 =A0 =A0 * 2. The MMC interface has a lower subfunction number
> =A0 =A0 =A0 =A0 * =A0 =A0than the SD interface.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON_JMB=
38X_SD) {
> + =A0 =A0 =A0 if (chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON_JMB=
38X_SD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmcdev =3D PCI_DEVICE_ID_JMICRON_JMB38X=
_MMC;
> + =A0 =A0 =A0 else if (chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRO=
N_JMB388_SD)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmcdev =3D PCI_DEVICE_ID_JMICRON_JMB388=
_ESD;
> +
> + =A0 =A0 =A0 if (mmcdev) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct pci_dev *sd_dev;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sd_dev =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0while ((sd_dev =3D pci_get_device(PCI_=
VENDOR_ID_JMICRON,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCI_DEVICE_ID_JMICRON_J=
MB38X_MMC, sd_dev)) !=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 mmcdev, sd_dev)) !=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((PCI_SLOT(chip->pd=
ev->devfn) =3D=3D
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PCI_SL=
OT(sd_dev->devfn)) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(chip-=
>pdev->bus =3D=3D sd_dev->bus))
> @@ -358,11 +364,21 @@ static int jmicron_probe_slot(struct sdhci_pci_=
slot *slot)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0slot->host->quirks |=3D=
 SDHCI_QUIRK_BROKEN_ADMA;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /* JM388 MMC doesn't support 1.8V while SD supports it =
*/
> + =A0 =A0 =A0 if (slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICR=
ON_JMB388_ESD) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot->host->ocr_avail_sd =3D MMC_VDD_32=
_33 | MMC_VDD_33_34 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_VDD_29_30 | MMC_VDD=
_30_31 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_VDD_165_195; /* all=
ow 1.8V */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 slot->host->ocr_avail_mmc =3D MMC_VDD_3=
2_33 | MMC_VDD_33_34 |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_VDD_29_30 | MMC_VDD=
_30_31; /* no 1.8V for MMC */
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The secondary interface requires a bit set to get t=
he
> =A0 =A0 =A0 =A0 * interrupts.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 if (slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICR=
ON_JMB38X_MMC)
> + =A0 =A0 =A0 if (slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICR=
ON_JMB38X_MMC ||
> + =A0 =A0 =A0 =A0 =A0 slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_J=
MICRON_JMB388_ESD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0jmicron_enable_mmc(slot->host, 1);
>
> =A0 =A0 =A0 =A0return 0;
> @@ -373,7 +389,8 @@ static void jmicron_remove_slot(struct sdhci_pci_=
slot *slot, int dead)
> =A0 =A0 =A0 =A0if (dead)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 if (slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICR=
ON_JMB38X_MMC)
> + =A0 =A0 =A0 if (slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICR=
ON_JMB38X_MMC ||
> + =A0 =A0 =A0 =A0 =A0 slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_J=
MICRON_JMB388_ESD)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0jmicron_enable_mmc(slot->host, 0);
> =A0}
>
> @@ -381,7 +398,8 @@ static int jmicron_suspend(struct sdhci_pci_chip =
*chip, pm_message_t state)
> =A0{
> =A0 =A0 =A0 =A0int i;
>
> - =A0 =A0 =A0 if (chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON_JMB=
38X_MMC) {
> + =A0 =A0 =A0 if (chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON_JMB=
38X_MMC ||
> + =A0 =A0 =A0 =A0 =A0 chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON=
_JMB388_ESD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0;i < chip->num_slots;i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0jmicron_enable_mmc(chi=
p->slots[i]->host, 0);
> =A0 =A0 =A0 =A0}
> @@ -393,7 +411,8 @@ static int jmicron_resume(struct sdhci_pci_chip *=
chip)
> =A0{
> =A0 =A0 =A0 =A0int ret, i;
>
> - =A0 =A0 =A0 if (chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON_JMB=
38X_MMC) {
> + =A0 =A0 =A0 if (chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON_JMB=
38X_MMC ||
> + =A0 =A0 =A0 =A0 =A0 chip->pdev->device =3D=3D PCI_DEVICE_ID_JMICRON=
_JMB388_ESD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0;i < chip->num_slots;i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0jmicron_enable_mmc(chi=
p->slots[i]->host, 1);
> =A0 =A0 =A0 =A0}
> @@ -582,6 +601,22 @@ static const struct pci_device_id pci_ids[] __de=
vinitdata =3D {
> =A0 =A0 =A0 =A0},
>
> =A0 =A0 =A0 =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR_=
ID_JMICRON,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D PCI_DEVICE_=
ID_JMICRON_JMB388_SD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D (kernel_ulong_t=
)&sdhci_jmicron,
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR_=
ID_JMICRON,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D PCI_DEVICE_=
ID_JMICRON_JMB388_ESD,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D (kernel_ulong_t=
)&sdhci_jmicron,
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR=
_ID_SYSKONNECT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.device =A0 =A0 =A0 =A0 =3D 0x8000,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8a74fcb..508ea5a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1739,7 +1739,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
> =A0int sdhci_add_host(struct sdhci_host *host)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *mmc;
> - =A0 =A0 =A0 unsigned int caps;
> + =A0 =A0 =A0 unsigned int caps, ocr_avail;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0WARN_ON(host =3D=3D NULL);
> @@ -1893,13 +1893,26 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0mmc_card_is_removable(mmc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>
> - =A0 =A0 =A0 mmc->ocr_avail =3D 0;
> + =A0 =A0 =A0 ocr_avail =3D 0;
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_VDD_330)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail |=3D MMC_VDD_32_33|MMC_V=
DD_33_34;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail |=3D MMC_VDD_32_33 | MMC_VDD_=
33_34;
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_VDD_300)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail |=3D MMC_VDD_29_30|MMC_V=
DD_30_31;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail |=3D MMC_VDD_29_30 | MMC_VDD_=
30_31;
> =A0 =A0 =A0 =A0if (caps & SDHCI_CAN_VDD_180)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail |=3D MMC_VDD_165_195;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail |=3D MMC_VDD_165_195;
> +
> + =A0 =A0 =A0 mmc->ocr_avail =3D ocr_avail;
> + =A0 =A0 =A0 mmc->ocr_avail_sdio =3D ocr_avail;
> + =A0 =A0 =A0 if (host->ocr_avail_sdio)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail_sdio &=3D host->ocr_avai=
l_sdio;
> + =A0 =A0 =A0 mmc->ocr_avail_sd =3D ocr_avail;
> + =A0 =A0 =A0 if (host->ocr_avail_sd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail_sd &=3D host->ocr_avail_=
sd;
> + =A0 =A0 =A0 else /* normal SD controllers don't support 1.8V */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail_sd &=3D ~MMC_VDD_165_195=
;
> + =A0 =A0 =A0 mmc->ocr_avail_mmc =3D ocr_avail;
> + =A0 =A0 =A0 if (host->ocr_avail_mmc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->ocr_avail_sd &=3D host->ocr_avail_=
mmc;
>
> =A0 =A0 =A0 =A0if (mmc->ocr_avail =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "%s: Hardware doesn't =
report any "
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 381c77f..4a9d9d25 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -131,6 +131,9 @@ struct mmc_host {
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0f_max;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0f_init;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail_s=
dio; /* SDIO-specific OCR */
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail_s=
d; =A0 /* SD-specific OCR */
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ocr_avail_m=
mc; =A0/* MMC-specific OCR */
> =A0 =A0 =A0 =A0struct notifier_block =A0 pm_notify;
>
> =A0#define MMC_VDD_165_195 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000080 =
=A0 =A0 =A0/* VDD voltage 1.65 - 1.95 */
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 1fdc673..0d953f5 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -139,6 +139,10 @@ struct sdhci_host {
>
> =A0 =A0 =A0 =A0unsigned int caps; =A0 =A0 =A0/* Alternative capabilit=
ies */
>
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ocr_avail_sdio; /* =
OCR bit masks */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ocr_avail_sd;
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0ocr_avail_mmc;
> +
> =A0 =A0 =A0 =A0unsigned long private[0] ____cacheline_aligned;
> =A0};
> =A0#endif /* __SDHCI_H */
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 7a58875..2f17b4c 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2368,6 +2368,8 @@
> =A0#define PCI_DEVICE_ID_JMICRON_JMB38X_SD =A0 =A0 =A0 =A00x2381
> =A0#define PCI_DEVICE_ID_JMICRON_JMB38X_MMC 0x2382
> =A0#define PCI_DEVICE_ID_JMICRON_JMB38X_MS =A0 =A0 =A0 =A00x2383
> +#define PCI_DEVICE_ID_JMICRON_JMB388_SD =A0 =A0 =A0 =A00x2391
> +#define PCI_DEVICE_ID_JMICRON_JMB388_ESD 0x2392
>
> =A0#define PCI_VENDOR_ID_KORENIX =A0 =A0 =A0 =A0 =A00x1982
> =A0#define PCI_DEVICE_ID_KORENIX_JETCARDF0 =A0 =A0 =A0 =A00x1600
> --
> 1.7.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
