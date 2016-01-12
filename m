From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/3] mmc: sdhci-pci: Add platform tuning callback for amd
 hs200 mode
Date: Tue, 12 Jan 2016 15:34:03 +0100
Message-ID: <CAPDyKFp++EZB7a3PtAanJV7Wcn8ziwdFUJe80L36UwAFAEQzdA@mail.gmail.com>
References: <1450802408-16354-1-git-send-email-vincent.wan@amd.com>
	<1450802408-16354-2-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34011 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762293AbcALOeF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2016 09:34:05 -0500
Received: by mail-qk0-f182.google.com with SMTP id t64so21333266qke.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jan 2016 06:34:03 -0800 (PST)
In-Reply-To: <1450802408-16354-2-git-send-email-vincent.wan@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan Zongshun <vincent.wan@amd.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Wan Zongshun <mcuos.com@gmail.com>, Borislav Petkov <bp@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Huang Rui <ray.huang@amd.com>

On 22 December 2015 at 17:40, Wan Zongshun <vincent.wan@amd.com> wrote:
> From: Wan Zongshun <Vincent.Wan@amd.com>
>
> AMD hs200 mode tuning mode is not compatible with standard tuning process,
> so we need .platform_execute_tuning callback support in sdhci-pci-core.c,
> this patch is to do:
>
> 1. Add platform_execute_tuning callback in sdhci_pci_slot.
> 2. Implement sdhci_pci_ops.platform_execute_tuning function.
>
> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
> ---
> Hi Ulf,
>
> Though modifying sdhci_pci_ops to be not const that is easy to implement
> my requirement, I am not sure it is right to do this.
>
> So I just follow sdhci_pci_select_drive_strength style to add new callback:
> sdhci_pci_platform_execute_tuning.

No thanks, please don't add new sdhci callbacks (or quirks).

>
> But I also met trouble in sdhci_execute_tuning of sdhci.c, I have to suppose
> only sdhci_pci_platform_execute_tuning is returning -EPERM(current code,
> my assumption is right), so that those vendor that has no
> slot->platform_execute_tuning could be skipped and go next standard
> tuning process.
>
> If you have better idea for my requirement, please correct me.

sdhci needs to become a set of library functions.

Typically the mmc_host_ops ->execute_tuning() callback for sdhci,
should be assigned to a default function, unless the sdhci variant has
assigned it to something else.

Yes, I realize that it requires core changes to sdhci to allow this.
Although it's necessary do this conversion as I won't accept any more
changes for sdhci that doesn't move the code into this direction.

Kind regards
Uffe

>
> Thanks!
> Wan Zongshun.
>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 23 +++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |  1 +
>  drivers/mmc/host/sdhci.c          |  3 ++-
>  3 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 01c5723..e7b2bbe 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -905,8 +905,19 @@ static int amd_probe(struct sdhci_pci_chip *chip)
>         return 0;
>  }
>
> +static int amd_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +       struct sdhci_host *host = slot->host;
> +
> +       if (host->quirks2 & SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD)
> +               slot->platform_execute_tuning = amd_execute_tuning;
> +
> +       return 0;
> +}
> +
>  static const struct sdhci_pci_fixes sdhci_amd = {
>         .probe          = amd_probe,
> +       .probe_slot     = amd_probe_slot,
>  };
>
>  static const struct pci_device_id pci_ids[] = {
> @@ -1508,6 +1519,17 @@ static int sdhci_pci_select_drive_strength(struct sdhci_host *host,
>                                            card_drv, drv_type);
>  }
>
> +static int sdhci_pci_platform_execute_tuning(struct sdhci_host *host,
> +                                            u32 opcode)
> +{
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +
> +       if (!slot->platform_execute_tuning)
> +               return -EPERM;
> +
> +       return slot->platform_execute_tuning(host, opcode);
> +}
> +
>  static const struct sdhci_ops sdhci_pci_ops = {
>         .set_clock      = sdhci_set_clock,
>         .enable_dma     = sdhci_pci_enable_dma,
> @@ -1516,6 +1538,7 @@ static const struct sdhci_ops sdhci_pci_ops = {
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
>         .hw_reset               = sdhci_pci_hw_reset,
>         .select_drive_strength  = sdhci_pci_select_drive_strength,
> +       .platform_execute_tuning = sdhci_pci_platform_execute_tuning,
>  };
>
>  /*****************************************************************************\
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index d1a0b4d..48d98f1 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -83,6 +83,7 @@ struct sdhci_pci_slot {
>                                      struct mmc_card *card,
>                                      unsigned int max_dtr, int host_drv,
>                                      int card_drv, int *drv_type);
> +       int (*platform_execute_tuning)(struct sdhci_host *host, u32 opcode);
>  };
>
>  struct sdhci_pci_chip {
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 2753b722d..2a5a6ce 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1937,7 +1937,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>                 spin_unlock_irqrestore(&host->lock, flags);
>                 err = host->ops->platform_execute_tuning(host, opcode);
>                 sdhci_runtime_pm_put(host);
> -               return err;
> +               if (err != EPERM)
> +                       return err;
>         }
>
>         ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> --
> 1.9.1
>
