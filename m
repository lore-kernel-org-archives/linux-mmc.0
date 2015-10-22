From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-acpi: Add more ACPI HIDs for Intel controllers
Date: Thu, 22 Oct 2015 15:32:46 +0200
Message-ID: <CAPDyKFoXGufsfFwqG7kh5ioHa4SbPanx=zSbb5KMGT7_kEhJYw@mail.gmail.com>
References: <1445415346-12929-1-git-send-email-adrian.hunter@intel.com>
	<1445415346-12929-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38064 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757548AbbJVNcr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Oct 2015 09:32:47 -0400
Received: by wicll6 with SMTP id ll6so119350665wic.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Oct 2015 06:32:46 -0700 (PDT)
In-Reply-To: <1445415346-12929-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 21 October 2015 at 10:15, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Add ACPI HIDs for Intel host controllers including one
> supporting HS400.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 78aa16aed07b..f6047fc94062 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -207,7 +207,9 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>         .caps2   = MMC_CAP2_HC_ERASE_SZ,
>         .flags   = SDHCI_ACPI_RUNTIME_PM,
>         .quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> -       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN | SDHCI_QUIRK2_STOP_WITH_TC,
> +       .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> +                  SDHCI_QUIRK2_STOP_WITH_TC |
> +                  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
>         .probe_slot     = sdhci_acpi_emmc_probe_slot,
>  };
>
> @@ -239,6 +241,9 @@ struct sdhci_acpi_uid_slot {
>  };
>
>  static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
> +       { "80865ACA", NULL, &sdhci_acpi_slot_int_sd },
> +       { "80865ACC", NULL, &sdhci_acpi_slot_int_emmc },
> +       { "80865AD0", NULL, &sdhci_acpi_slot_int_sdio },
>         { "80860F14" , "1" , &sdhci_acpi_slot_int_emmc },
>         { "80860F14" , "3" , &sdhci_acpi_slot_int_sd   },
>         { "80860F16" , NULL, &sdhci_acpi_slot_int_sd   },
> @@ -253,6 +258,9 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
>  };
>
>  static const struct acpi_device_id sdhci_acpi_ids[] = {
> +       { "80865ACA" },
> +       { "80865ACC" },
> +       { "80865AD0" },
>         { "80860F14" },
>         { "80860F16" },
>         { "INT33BB"  },
> --
> 1.9.1
>
