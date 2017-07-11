From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: Workaround conflict with PCI wifi on GPD
 Win handheld
Date: Tue, 11 Jul 2017 15:11:55 +0200
Message-ID: <CAPDyKFpBqXQ-Npz9HfASi8QGpSdW5p6+Mg829Y7YuTGgvuZN_g@mail.gmail.com>
References: <1498046919-2273-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:34588 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755296AbdGKNL4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Jul 2017 09:11:56 -0400
Received: by mail-qk0-f170.google.com with SMTP id d78so103564070qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Jul 2017 06:11:56 -0700 (PDT)
In-Reply-To: <1498046919-2273-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>

On 21 June 2017 at 14:08, Adrian Hunter <adrian.hunter@intel.com> wrote:
> GPDwin uses PCI wifi which conflicts with SDIO's use of
> acpi_device_fix_up_power() on child device nodes. Specifically
> acpi_device_fix_up_power() causes the wifi module to get turned off.
> Identifying GPDwin is problematic, but since SDIO is only used for wifi,
> the presence of the PCI wifi card in the expected slot with an ACPI
> companion node, is used to indicate that acpi_device_fix_up_power() should
> be avoided.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Hans de Goede <hdegoede@redhat.com>
> Cc: stable@vger.kernel.org

Sorry for the delay.

Applied for fixes!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 70 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 64 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index cf66a3db71b8..ac678e9fb19a 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -45,6 +45,7 @@
>  #include <asm/cpu_device_id.h>
>  #include <asm/intel-family.h>
>  #include <asm/iosf_mbi.h>
> +#include <linux/pci.h>
>  #endif
>
>  #include "sdhci.h"
> @@ -134,6 +135,16 @@ static bool sdhci_acpi_byt(void)
>         return x86_match_cpu(byt);
>  }
>
> +static bool sdhci_acpi_cht(void)
> +{
> +       static const struct x86_cpu_id cht[] = {
> +               { X86_VENDOR_INTEL, 6, INTEL_FAM6_ATOM_AIRMONT },
> +               {}
> +       };
> +
> +       return x86_match_cpu(cht);
> +}
> +
>  #define BYT_IOSF_SCCEP                 0x63
>  #define BYT_IOSF_OCP_NETCTRL0          0x1078
>  #define BYT_IOSF_OCP_TIMEOUT_BASE      GENMASK(10, 8)
> @@ -178,6 +189,45 @@ static bool sdhci_acpi_byt_defer(struct device *dev)
>         return false;
>  }
>
> +static bool sdhci_acpi_cht_pci_wifi(unsigned int vendor, unsigned int device,
> +                                   unsigned int slot, unsigned int parent_slot)
> +{
> +       struct pci_dev *dev, *parent, *from = NULL;
> +
> +       while (1) {
> +               dev = pci_get_device(vendor, device, from);
> +               pci_dev_put(from);
> +               if (!dev)
> +                       break;
> +               parent = pci_upstream_bridge(dev);
> +               if (ACPI_COMPANION(&dev->dev) && PCI_SLOT(dev->devfn) == slot &&
> +                   parent && PCI_SLOT(parent->devfn) == parent_slot &&
> +                   !pci_upstream_bridge(parent)) {
> +                       pci_dev_put(dev);
> +                       return true;
> +               }
> +               from = dev;
> +       }
> +
> +       return false;
> +}
> +
> +/*
> + * GPDwin uses PCI wifi which conflicts with SDIO's use of
> + * acpi_device_fix_up_power() on child device nodes. Identifying GPDwin is
> + * problematic, but since SDIO is only used for wifi, the presence of the PCI
> + * wifi card in the expected slot with an ACPI companion node, is used to
> + * indicate that acpi_device_fix_up_power() should be avoided.
> + */
> +static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
> +                                                  const char *uid)
> +{
> +       return sdhci_acpi_cht() &&
> +              !strcmp(hid, "80860F14") &&
> +              !strcmp(uid, "2") &&
> +              sdhci_acpi_cht_pci_wifi(0x14e4, 0x43ec, 0, 28);
> +}
> +
>  #else
>
>  static inline void sdhci_acpi_byt_setting(struct device *dev)
> @@ -189,6 +239,12 @@ static inline bool sdhci_acpi_byt_defer(struct device *dev)
>         return false;
>  }
>
> +static inline bool sdhci_acpi_no_fixup_child_power(const char *hid,
> +                                                  const char *uid)
> +{
> +       return false;
> +}
> +
>  #endif
>
>  static int bxt_get_cd(struct mmc_host *mmc)
> @@ -389,18 +445,20 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
>         if (acpi_bus_get_device(handle, &device))
>                 return -ENODEV;
>
> +       hid = acpi_device_hid(device);
> +       uid = device->pnp.unique_id;
> +
>         /* Power on the SDHCI controller and its children */
>         acpi_device_fix_up_power(device);
> -       list_for_each_entry(child, &device->children, node)
> -               if (child->status.present && child->status.enabled)
> -                       acpi_device_fix_up_power(child);
> +       if (!sdhci_acpi_no_fixup_child_power(hid, uid)) {
> +               list_for_each_entry(child, &device->children, node)
> +                       if (child->status.present && child->status.enabled)
> +                               acpi_device_fix_up_power(child);
> +       }
>
>         if (sdhci_acpi_byt_defer(dev))
>                 return -EPROBE_DEFER;
>
> -       hid = acpi_device_hid(device);
> -       uid = device->pnp.unique_id;
> -
>         iomem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!iomem)
>                 return -ENOMEM;
> --
> 1.9.1
>
