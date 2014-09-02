From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-pci: disable preset register for Baytrail and Merrifield
Date: Tue, 2 Sep 2014 12:05:43 +0200
Message-ID: <CAPDyKFp3JMnHPJHBEnjaravC=Y=40kDp1xfqN9qaBqZ9Y3YJew@mail.gmail.com>
References: <1408347129-733-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:59579 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaIBKFp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 06:05:45 -0400
Received: by mail-lb0-f172.google.com with SMTP id 10so7357322lbg.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 03:05:44 -0700 (PDT)
In-Reply-To: <1408347129-733-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chuanxiao Dong <chuanxiao.dong@intel.com>

On 18 August 2014 09:32, Yunpeng Gao <yunpeng.gao@intel.com> wrote:
> Due to HW issue, SDHCI host controller on Intel
> Baytrail/Merrifield platforms can not use preset
> register. So, disable preset registers for them by quirks.
>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Hi Yunpeng,

Could you please rebase this patch, it didn't apply to my next branch.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c |   10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 52c42fc..98187ae 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -277,18 +277,21 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>  }
>
>  static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
> +       .quirks2        = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .allow_runtime_pm = true,
>         .probe_slot     = byt_emmc_probe_slot,
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
> @@ -312,7 +315,8 @@ static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
>
>  static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
> -       .quirks2        = SDHCI_QUIRK2_BROKEN_HS200,
> +       .quirks2        = SDHCI_QUIRK2_BROKEN_HS200 |
> +                       SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .probe_slot     = intel_mrfl_mmc_probe_slot,
>  };
>
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
