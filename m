From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: Tidy o2micro definitions
Date: Fri, 20 Oct 2017 12:03:41 +0200
Message-ID: <CAPDyKFqraP-1i5RzibpjnKd0V+bMAWhyJSgZkTeA2+6pyCqqkQ@mail.gmail.com>
References: <1508414653-15030-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:56573 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752649AbdJTKDn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Oct 2017 06:03:43 -0400
Received: by mail-io0-f194.google.com with SMTP id m81so12680226ioi.13
        for <linux-mmc@vger.kernel.org>; Fri, 20 Oct 2017 03:03:42 -0700 (PDT)
In-Reply-To: <1508414653-15030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Adam Lee <adam.lee@canonical.com>, Peter Guo <peter.guo@bayhubtech.com>

On 19 October 2017 at 14:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
> We keep PCI Ids in sdhci-pci.h and the O2-specific definitions belong in
> sdhci-pci-o2micro.c. Move those definitions accordingly. Remove unused O2
> definitions in sdhci-pci-core.c. The 3 o2micro external function
> declarations might as well be in sdhci-pci.h as well, so move them there
> and get rid of sdhci-pci-o2micro.h entirely.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci-core.c    | 10 -----
>  drivers/mmc/host/sdhci-pci-o2micro.c | 35 ++++++++++++++++-
>  drivers/mmc/host/sdhci-pci-o2micro.h | 73 ------------------------------------
>  drivers/mmc/host/sdhci-pci.h         | 12 ++++++
>  4 files changed, 46 insertions(+), 84 deletions(-)
>  delete mode 100644 drivers/mmc/host/sdhci-pci-o2micro.h
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index e854ee5d7f4a..3e4f04fd5175 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -32,7 +32,6 @@
>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> -#include "sdhci-pci-o2micro.h"
>
>  static int sdhci_pci_enable_dma(struct sdhci_host *host);
>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
> @@ -798,15 +797,6 @@ static int intel_mrfld_mmc_probe_slot(struct sdhci_pci_slot *slot)
>         .probe_slot     = intel_mrfld_mmc_probe_slot,
>  };
>
> -/* O2Micro extra registers */
> -#define O2_SD_LOCK_WP          0xD3
> -#define O2_SD_MULTI_VCC3V      0xEE
> -#define O2_SD_CLKREQ           0xEC
> -#define O2_SD_CAPS             0xE0
> -#define O2_SD_ADMA1            0xE2
> -#define O2_SD_ADMA2            0xE7
> -#define O2_SD_INF_MOD          0xF1
> -
>  static int jmicron_pmos(struct sdhci_pci_chip *chip, int on)
>  {
>         u8 scratch;
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 14273ca00641..555970a29c94 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -19,7 +19,40 @@
>
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
> -#include "sdhci-pci-o2micro.h"
> +
> +/*
> + * O2Micro device registers
> + */
> +
> +#define O2_SD_MISC_REG5                0x64
> +#define O2_SD_LD0_CTRL         0x68
> +#define O2_SD_DEV_CTRL         0x88
> +#define O2_SD_LOCK_WP          0xD3
> +#define O2_SD_TEST_REG         0xD4
> +#define O2_SD_FUNC_REG0                0xDC
> +#define O2_SD_MULTI_VCC3V      0xEE
> +#define O2_SD_CLKREQ           0xEC
> +#define O2_SD_CAPS             0xE0
> +#define O2_SD_ADMA1            0xE2
> +#define O2_SD_ADMA2            0xE7
> +#define O2_SD_INF_MOD          0xF1
> +#define O2_SD_MISC_CTRL4       0xFC
> +#define O2_SD_TUNING_CTRL      0x300
> +#define O2_SD_PLL_SETTING      0x304
> +#define O2_SD_CLK_SETTING      0x328
> +#define O2_SD_CAP_REG2         0x330
> +#define O2_SD_CAP_REG0         0x334
> +#define O2_SD_UHS1_CAP_SETTING 0x33C
> +#define O2_SD_DELAY_CTRL       0x350
> +#define O2_SD_UHS2_L1_CTRL     0x35C
> +#define O2_SD_FUNC_REG3                0x3E0
> +#define O2_SD_FUNC_REG4                0x3E4
> +#define O2_SD_LED_ENABLE       BIT(6)
> +#define O2_SD_FREG0_LEDOFF     BIT(13)
> +#define O2_SD_FREG4_ENABLE_CLK_SET     BIT(22)
> +
> +#define O2_SD_VENDOR_SETTING   0x110
> +#define O2_SD_VENDOR_SETTING2  0x1C8
>
>  static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)
>  {
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.h b/drivers/mmc/host/sdhci-pci-o2micro.h
> deleted file mode 100644
> index 770f53857211..000000000000
> --- a/drivers/mmc/host/sdhci-pci-o2micro.h
> +++ /dev/null
> @@ -1,73 +0,0 @@
> -/*
> - * Copyright (C) 2013 BayHub Technology Ltd.
> - *
> - * Authors: Peter Guo <peter.guo@bayhubtech.com>
> - *          Adam Lee <adam.lee@canonical.com>
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#ifndef __SDHCI_PCI_O2MICRO_H
> -#define __SDHCI_PCI_O2MICRO_H
> -
> -#include "sdhci-pci.h"
> -
> -/*
> - * O2Micro device IDs
> - */
> -
> -#define PCI_DEVICE_ID_O2_SDS0          0x8420
> -#define PCI_DEVICE_ID_O2_SDS1          0x8421
> -#define PCI_DEVICE_ID_O2_FUJIN2                0x8520
> -#define PCI_DEVICE_ID_O2_SEABIRD0      0x8620
> -#define PCI_DEVICE_ID_O2_SEABIRD1      0x8621
> -
> -/*
> - * O2Micro device registers
> - */
> -
> -#define O2_SD_MISC_REG5                0x64
> -#define O2_SD_LD0_CTRL         0x68
> -#define O2_SD_DEV_CTRL         0x88
> -#define O2_SD_LOCK_WP          0xD3
> -#define O2_SD_TEST_REG         0xD4
> -#define O2_SD_FUNC_REG0                0xDC
> -#define O2_SD_MULTI_VCC3V      0xEE
> -#define O2_SD_CLKREQ           0xEC
> -#define O2_SD_CAPS             0xE0
> -#define O2_SD_ADMA1            0xE2
> -#define O2_SD_ADMA2            0xE7
> -#define O2_SD_INF_MOD          0xF1
> -#define O2_SD_MISC_CTRL4       0xFC
> -#define O2_SD_TUNING_CTRL      0x300
> -#define O2_SD_PLL_SETTING      0x304
> -#define O2_SD_CLK_SETTING      0x328
> -#define O2_SD_CAP_REG2         0x330
> -#define O2_SD_CAP_REG0         0x334
> -#define O2_SD_UHS1_CAP_SETTING 0x33C
> -#define O2_SD_DELAY_CTRL       0x350
> -#define O2_SD_UHS2_L1_CTRL     0x35C
> -#define O2_SD_FUNC_REG3                0x3E0
> -#define O2_SD_FUNC_REG4                0x3E4
> -#define O2_SD_LED_ENABLE       BIT(6)
> -#define O2_SD_FREG0_LEDOFF     BIT(13)
> -#define O2_SD_FREG4_ENABLE_CLK_SET     BIT(22)
> -
> -#define O2_SD_VENDOR_SETTING   0x110
> -#define O2_SD_VENDOR_SETTING2  0x1C8
> -
> -extern int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
> -
> -extern int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
> -
> -extern int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip);
> -
> -#endif /* __SDHCI_PCI_O2MICRO_H */
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 3c1dd79fdbde..063506cc2ca9 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -5,6 +5,12 @@
>   * PCI device IDs, sub IDs
>   */
>
> +#define PCI_DEVICE_ID_O2_SDS0          0x8420
> +#define PCI_DEVICE_ID_O2_SDS1          0x8421
> +#define PCI_DEVICE_ID_O2_FUJIN2                0x8520
> +#define PCI_DEVICE_ID_O2_SEABIRD0      0x8620
> +#define PCI_DEVICE_ID_O2_SEABIRD1      0x8621
> +
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO0  0x8809
>  #define PCI_DEVICE_ID_INTEL_PCH_SDIO1  0x880a
>  #define PCI_DEVICE_ID_INTEL_BYT_EMMC   0x0f14
> @@ -164,4 +170,10 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
>  #endif
>
> +int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
> +int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
> +#ifdef CONFIG_PM_SLEEP
> +int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip);
> +#endif
> +
>  #endif /* __SDHCI_PCI_H */
> --
> 1.9.1
>
