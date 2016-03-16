From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-acpi: add QCOM controllers
Date: Wed, 16 Mar 2016 12:37:44 +0100
Message-ID: <CAPDyKFodFfpRfXoLkQwL3ZDmpPdSQZ7uD5iMn0Rfu6SfzhGykg@mail.gmail.com>
References: <1457023128-23720-1-git-send-email-pelcan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36254 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934854AbcCPLhq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Mar 2016 07:37:46 -0400
Received: by mail-wm0-f50.google.com with SMTP id l124so44946414wmf.1
        for <linux-mmc@vger.kernel.org>; Wed, 16 Mar 2016 04:37:45 -0700 (PDT)
In-Reply-To: <1457023128-23720-1-git-send-email-pelcan@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Elcan <pelcan@codeaurora.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Michele Curti <michele.curti@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On 3 March 2016 at 17:38, Philip Elcan <pelcan@codeaurora.org> wrote:
> This adds the HIDs for Qualcomm Technologies Inc SDHC
> controllers:
> QCOM8051: non-removable device that does not support 1.8v
> QCOM8052: non-removable device that does support 1.8v
>
> Signed-off-by: Philip Elcan <pelcan@codeaurora.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-acpi.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
> index a5cda92..041e739 100644
> --- a/drivers/mmc/host/sdhci-acpi.c
> +++ b/drivers/mmc/host/sdhci-acpi.c
> @@ -264,6 +264,17 @@ static const struct sdhci_acpi_slot sdhci_acpi_slot_int_sd = {
>         .probe_slot     = sdhci_acpi_sd_probe_slot,
>  };
>
> +static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd_3v = {
> +       .quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
> +       .quirks2 = SDHCI_QUIRK2_NO_1_8_V,
> +       .caps    = MMC_CAP_NONREMOVABLE,
> +};
> +
> +static const struct sdhci_acpi_slot sdhci_acpi_slot_qcom_sd = {
> +       .quirks  = SDHCI_QUIRK_BROKEN_CARD_DETECTION,
> +       .caps    = MMC_CAP_NONREMOVABLE,
> +};
> +
>  struct sdhci_acpi_uid_slot {
>         const char *hid;
>         const char *uid;
> @@ -284,6 +295,8 @@ static const struct sdhci_acpi_uid_slot sdhci_acpi_uids[] = {
>         { "INT344D"  , NULL, &sdhci_acpi_slot_int_sdio },
>         { "PNP0FFF"  , "3" , &sdhci_acpi_slot_int_sd   },
>         { "PNP0D40"  },
> +       { "QCOM8051", NULL, &sdhci_acpi_slot_qcom_sd_3v },
> +       { "QCOM8052", NULL, &sdhci_acpi_slot_qcom_sd },
>         { },
>  };
>
> @@ -298,6 +311,8 @@ static const struct acpi_device_id sdhci_acpi_ids[] = {
>         { "INT3436"  },
>         { "INT344D"  },
>         { "PNP0D40"  },
> +       { "QCOM8051" },
> +       { "QCOM8052" },
>         { },
>  };
>  MODULE_DEVICE_TABLE(acpi, sdhci_acpi_ids);
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
