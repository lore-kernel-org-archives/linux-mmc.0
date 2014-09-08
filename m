From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-pci: disable preset register for Baytrail
 and Merrifield
Date: Mon, 8 Sep 2014 13:59:42 +0200
Message-ID: <CAPDyKFqRsJqowqSuzdvEQaPv9n_c5SBMOg5iSiotFoSuWLfruQ@mail.gmail.com>
References: <1409815085-29542-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f169.google.com ([209.85.216.169]:50317 "EHLO
	mail-qc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752640AbaIHL7n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Sep 2014 07:59:43 -0400
Received: by mail-qc0-f169.google.com with SMTP id l6so15603758qcy.14
        for <linux-mmc@vger.kernel.org>; Mon, 08 Sep 2014 04:59:43 -0700 (PDT)
In-Reply-To: <1409815085-29542-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 4 September 2014 09:18, Yunpeng Gao <yunpeng.gao@intel.com> wrote:
> Due to HW issue, SDHCI host controller on Intel
> Baytrail/Merrifield platforms can not use preset
> register. So, disable preset registers for them by quirks.
>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index ff9ab62..580073b 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -287,13 +287,15 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
>  };
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
> -       .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON,
> +       .quirks2        = SDHCI_QUIRK2_HOST_OFF_CARD_ON |
> +                       SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .allow_runtime_pm = true,
>         .probe_slot     = byt_sdio_probe_slot,
>  };
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
> -       .quirks2        = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
> +       .quirks2        = SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON |
> +                       SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .allow_runtime_pm = true,
>         .own_cd_for_runtime_pm = true,
>  };
> @@ -317,7 +319,8 @@ static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
>
>  static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> -       .quirks2        = SDHCI_QUIRK2_BROKEN_HS200,
> +       .quirks2        = SDHCI_QUIRK2_BROKEN_HS200 |
> +                       SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .allow_runtime_pm = true,
>         .probe_slot     = intel_mrfl_mmc_probe_slot,
>  };
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
