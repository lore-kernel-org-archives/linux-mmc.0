From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: Intel SDIO has broken card detect
Date: Mon, 7 Apr 2014 09:42:08 +0200
Message-ID: <CAPDyKFpyfGA2=SpeK=6Mh_E3WtiCe7K=Oegjpu+fJ6VRN8_3Kw@mail.gmail.com>
References: <1396526319-614-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:33430 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaDGHmJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Apr 2014 03:42:09 -0400
Received: by mail-qg0-f49.google.com with SMTP id 63so2738071qgz.8
        for <linux-mmc@vger.kernel.org>; Mon, 07 Apr 2014 00:42:08 -0700 (PDT)
In-Reply-To: <1396526319-614-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 3 April 2014 13:58, Adrian Hunter <adrian.hunter@intel.com> wrote:
> Intel SDIO has broken card detect so add a quirk
> to reflect that.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sdhci-acpi.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 0d372f0..ebb3f39 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -122,6 +122,7 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_emmc = {
>  };
>
>  static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sdio = {
> +       .quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
>         .quirks2 = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
>         .caps    = MMC_CAP_NONREMOVABLE | MMC_CAP_POWER_OFF_CARD,
>         .flags   = SDHCI_ACPI_RUNTIME_PM,
> --
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
