From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 3/3] SDHCI: Change AMD SDHCI quirk application scope
Date: Mon, 15 Jun 2015 11:55:08 +0200
Message-ID: <CAPDyKFpPSNr-J9Nx=aMAdTm8f33vOBSytzyFQGo6xE+WF-KGdA@mail.gmail.com>
References: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
	<1434024707-6245-3-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:34236 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724AbbFOJzJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2015 05:55:09 -0400
Received: by qgf75 with SMTP id 75so24868440qgf.1
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 02:55:08 -0700 (PDT)
In-Reply-To: <1434024707-6245-3-git-send-email-Vincent.Wan@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan ZongShun <Vincent.Wan@amd.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, bp@alien8.de, Jean Delvare <jdelvare@suse.de>, Linux PCI <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ZongShun Wan <mcuos.com@gmail.com>

On 11 June 2015 at 14:11, Wan ZongShun <Vincent.Wan@amd.com> wrote:
> Change this quirk to apply to AMD Carrizo platform.
>
> Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>
>
> Tested-by: Nath, Arindam <Arindam.Nath@amd.com>
> Tested-by: Ramesh, Ramya <Ramya.Ramesh@amd.com>

Thanks, applied! I changed the prefix of the commit message header
from "SDHCI." to "mmc: sdhci-pci:"

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index f208f20..94f54d2 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -724,14 +724,37 @@ static const struct sdhci_pci_fixes sdhci_rtsx = {
>         .probe_slot     = rtsx_probe_slot,
>  };
>
> +/*AMD chipset generation*/
> +enum amd_chipset_gen {
> +       AMD_CHIPSET_BEFORE_ML,
> +       AMD_CHIPSET_CZ,
> +       AMD_CHIPSET_NL,
> +       AMD_CHIPSET_UNKNOWN,
> +};
> +
>  static int amd_probe(struct sdhci_pci_chip *chip)
>  {
>         struct pci_dev  *smbus_dev;
> +       enum amd_chipset_gen gen;
>
>         smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
>                         PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
> +       if (smbus_dev) {
> +               gen = AMD_CHIPSET_BEFORE_ML;
> +       } else {
> +               smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
> +                               PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
> +               if (smbus_dev) {
> +                       if (smbus_dev->revision < 0x51)
> +                               gen = AMD_CHIPSET_CZ;
> +                       else
> +                               gen = AMD_CHIPSET_NL;
> +               } else {
> +                       gen = AMD_CHIPSET_UNKNOWN;
> +               }
> +       }
>
> -       if (smbus_dev && (smbus_dev->revision < 0x51)) {
> +       if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
>                 chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
>                 chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>         }
> --
> 1.9.1
>
