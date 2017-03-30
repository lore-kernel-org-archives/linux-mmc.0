From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci-acpi: Set MMC_CAP_AGGRESSIVE_PM for
 BYT-related Intel controllers
Date: Thu, 30 Mar 2017 21:31:18 +0200
Message-ID: <CAPDyKFptvekvJQDUVnNYYLT5SHH9i9-X3jLj38Qo-w9-u9UzEA@mail.gmail.com>
References: <1490724510-105153-1-git-send-email-azhar.shaikh@intel.com> <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:35850 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934770AbdC3TbZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Mar 2017 15:31:25 -0400
Received: by mail-vk0-f51.google.com with SMTP id s68so67115393vke.3
        for <linux-mmc@vger.kernel.org>; Thu, 30 Mar 2017 12:31:24 -0700 (PDT)
In-Reply-To: <1490811393-109654-1-git-send-email-azhar.shaikh@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Azhar Shaikh <azhar.shaikh@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 29 March 2017 at 20:16, Azhar Shaikh <azhar.shaikh@intel.com> wrote:
> Set MMC_CAP_AGGRESSIVE_PM for BYT-related Intel SD card
> controllers.
>
> Signed-off-by: Azhar Shaikh <azhar.shaikh@intel.com>


Thanks, applied for next!

Kind regards
Uffe


> ---
> Changes in v2:
>   - Rebased the patch on top of 'next' branch.
>   - No code change.
>
>  drivers/mmc/host/sdhci-acpi.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index 665c5f3..c6a9a1b 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -263,10 +263,8 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
>
>         /* Platform specific code during sd probe slot goes here */
>
> -       if (hid && !strcmp(hid, "80865ACA")) {
> +       if (hid && !strcmp(hid, "80865ACA"))
>                 host->mmc_host_ops.get_cd = bxt_get_cd;
> -               host->mmc->caps |= MMC_CAP_AGGRESSIVE_PM;
> -       }
>
>         return 0;
>  }
> @@ -302,7 +300,7 @@ static int sdhci_acpi_sd_probe_slot(struct platform_device *pdev,
>         .quirks  = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>         .quirks2 = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
>                    SDHCI_QUIRK2_STOP_WITH_TC,
> -       .caps    = MMC_CAP_WAIT_WHILE_BUSY,
> +       .caps    = MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_AGGRESSIVE_PM,
>         .probe_slot     = sdhci_acpi_sd_probe_slot,
>  };
>
> --
> 1.9.1
>
