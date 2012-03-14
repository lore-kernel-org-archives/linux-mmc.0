From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 3/3] mmc: sdhci-pci: allow 8-bit bus width for Intel PCH
Date: Wed, 14 Mar 2012 10:17:35 +0900
Message-ID: <CANKRQniUQNJmf=H-pY3Wha4qWGh9OJR9GfdTUhMw_t7ZFSnPzA@mail.gmail.com>
References: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com>
	<1331659002-13743-3-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1331659002-13743-3-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Chris Ball <cjb@laptop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Alexander

As a matter of interest,
do you mean that current MMC of eg20t on Linux doesn't support 8-bit ac=
cess?

thanks,
--=20
ROHM Co., Ltd.
tomoya


On Wed, Mar 14, 2012 at 2:16 AM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com=
>
> ---
> =A0drivers/mmc/host/sdhci-pci.c | =A0 27 +++++++++++++++++++++++++++
> =A0include/linux/pci_ids.h =A0 =A0 =A0| =A0 =A02 ++
> =A02 files changed, 29 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pc=
i.c
> index 9382f27..0218cb2 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -172,6 +172,12 @@ static int mrst_hc_probe(struct sdhci_pci_chip *=
chip)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static int pch_hc_probe_slot(struct sdhci_pci_slot *slot)
> +{
> + =A0 =A0 =A0 slot->host->mmc->caps |=3D MMC_CAP_8_BIT_DATA;
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0#ifdef CONFIG_PM_RUNTIME
>
> =A0static irqreturn_t sdhci_pci_sd_cd(int irq, void *dev_id)
> @@ -281,6 +287,11 @@ static const struct sdhci_pci_fixes sdhci_intel_=
mfd_emmc =3D {
> =A0 =A0 =A0 =A0.probe_slot =A0 =A0 =3D mfd_emmc_probe_slot,
> =A0};
>
> +static const struct sdhci_pci_fixes sdhci_intel_pch_sdio =3D {
> + =A0 =A0 =A0 .quirks =A0 =A0 =A0 =A0 =3D SDHCI_QUIRK_BROKEN_ADMA,
> + =A0 =A0 =A0 .probe_slot =A0 =A0 =3D pch_hc_probe_slot,
> +};
> +
> =A0/* O2Micro extra registers */
> =A0#define O2_SD_LOCK_WP =A0 =A0 =A0 =A0 =A00xD3
> =A0#define O2_SD_MULTI_VCC3V =A0 =A0 =A00xEE
> @@ -817,6 +828,22 @@ static const struct pci_device_id pci_ids[] __de=
vinitdata =3D {
> =A0 =A0 =A0 =A0},
>
> =A0 =A0 =A0 =A0{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR_=
ID_INTEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D PCI_DEVICE_=
ID_INTEL_PCH_SDIO0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D (kernel_ulong_t=
)&sdhci_intel_pch_sdio,
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR_=
ID_INTEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .device =A0 =A0 =A0 =A0 =3D PCI_DEVICE_=
ID_INTEL_PCH_SDIO1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .subdevice =A0 =A0 =A0=3D PCI_ANY_ID,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .driver_data =A0 =A0=3D (kernel_ulong_t=
)&sdhci_intel_pch_sdio,
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.vendor =A0 =A0 =A0 =A0 =3D PCI_VENDOR=
_ID_O2,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.device =A0 =A0 =A0 =A0 =3D PCI_DEVICE=
_ID_O2_8120,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.subvendor =A0 =A0 =A0=3D PCI_ANY_ID,
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 31d77af..28cd019 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2800,6 +2800,8 @@
> =A0#define PCI_DEVICE_ID_INTEL_82454NX =A0 =A0 0x84cb
> =A0#define PCI_DEVICE_ID_INTEL_84460GX =A0 =A00x84ea
> =A0#define PCI_DEVICE_ID_INTEL_IXP4XX =A0 =A0 0x8500
> +#define PCI_DEVICE_ID_INTEL_PCH_SDIO0 =A00x8809
> +#define PCI_DEVICE_ID_INTEL_PCH_SDIO1 =A00x880a
> =A0#define PCI_DEVICE_ID_INTEL_IXP2800 =A0 =A00x9004
> =A0#define PCI_DEVICE_ID_INTEL_S21152BB =A0 0xb152
>
> --
> 1.7.3.4
