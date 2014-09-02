From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: enable runtime pm for Intel Merrifield platform
Date: Tue, 2 Sep 2014 12:04:20 +0200
Message-ID: <CAPDyKFp1sRP5jtUGv3QKqqOLh1xW8AiazNXdDngOFeR0RRuOXA@mail.gmail.com>
References: <1408345552-24029-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:65413 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbaIBKEW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Sep 2014 06:04:22 -0400
Received: by mail-lb0-f172.google.com with SMTP id 10so7254629lbg.17
        for <linux-mmc@vger.kernel.org>; Tue, 02 Sep 2014 03:04:20 -0700 (PDT)
In-Reply-To: <1408345552-24029-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 18 August 2014 09:05, Yunpeng Gao <yunpeng.gao@intel.com> wrote:
> Enable runtime pm support on Intel Merrifield platform.
>
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-pci.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 52c42fc..1b50a4a 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -313,6 +313,7 @@ static int intel_mrfl_mmc_probe_slot(struct sdhci_pci_slot *slot)
>  static const struct sdhci_pci_fixes sdhci_intel_mrfl_mmc = {
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>         .quirks2        = SDHCI_QUIRK2_BROKEN_HS200,
> +       .allow_runtime_pm = true,
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
