Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D374FC433E4
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF17208E4
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZwP7bcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgHXJvn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729577AbgHXJvk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 05:51:40 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0E6C061755
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:39 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id h19so917999ual.10
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eYdZU1Gx87Iz13IeS4zaDwk004o6teDI2plWr+DNQM=;
        b=NZwP7bcEbZ6Wa7DKHj/1Ow5+/DR1K4A4wP2KAdUVHrcCLPivARHn0yPkduGnGgVcas
         l6ZvCgPqcst0xOZjWfnhTRc4zdac1y/uhTD0yH7y+w9WAufMLn7wXt/KctQrviFIBmSe
         PHsbsarbCJd9oy2Ln3kKctzQa00TvDJIStZ6QpcqspMlg0PuZZEMtrix/SEPKRzpeT01
         uY41mB8Sjj5qHbtDaBOO82Pdx6e6elvbNrfNutxpPFfhQVUCNiqeDUqjVs2mqNIO1ZDY
         uTSnNkPNm8Pc0y9W8vWV/o+J1iq5sZMD9EeMSO3iLcFUp4m8ZSldM9X2/gz4xS2XpFQt
         nT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eYdZU1Gx87Iz13IeS4zaDwk004o6teDI2plWr+DNQM=;
        b=CU4BQwC+9lV+TnsM66YNDuTDudwO6x4W3nvkG/j+jIdFhrt3Brn4s+iZq9q82ziRwM
         vKF+hPE45b8CNQU9bKVL/R6KzE+WHHNXP4YZb9s8FJS1LXSkJ7/9xENFq7Y/s1ZwbVnr
         PYreTh9sry2ZOQz+KOkVwCA7GljjdbpNi5AWEEKAK5FFsgjW+uvrgb7eQ/POduKJLH3L
         OsmyBgyvOeqRkmb5KY8h9ZfRXsRLBKWi8JzvTplzEvQQOP98xp1DWQ/VSBf4g9ijP6k/
         sDHWqJVJiKBbGzzwFKwArRc628oOXSVGWqKK1LFVhkNh1su/ZUjJ1BZZtDwSpZUP8/qD
         s6CQ==
X-Gm-Message-State: AOAM533+kdlNDW2kswVUKNyQ2imFsKJqOVfswrnIGTWB5pw4+fhQ7MpA
        ixSbBRE4lHleswjFPg8IpJJJdgsc+FOlqyQ7V/vMEw==
X-Google-Smtp-Source: ABdhPJwQ3FmaHpzdzoPOYyztuftvy3nyzV7PNgImWU/OVFERzw4JAxoUK6AGnxd6QLP8neYkxV2MyXLWUNqun9N8dzk=
X-Received: by 2002:ab0:64c3:: with SMTP id j3mr1813967uaq.129.1598262698954;
 Mon, 24 Aug 2020 02:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200818104508.7149-1-adrian.hunter@intel.com>
In-Reply-To: <20200818104508.7149-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:51:02 +0200
Message-ID: <CAPDyKFomnD_NsdicXD64ZqvBYAwe5PCNNB3aOzt58g4dQKm+5Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Add LTR support for some Intel BYT based controllers
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 18 Aug 2020 at 12:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Some Intel BYT based host controllers support the setting of latency
> tolerance.  Accordingly, implement the PM QoS ->set_latency_tolerance()
> callback.  The raw register values are also exposed via debugfs.
>
> Intel EHL controllers require this support.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Fixes: cb3a7d4a0aec4e ("mmc: sdhci-pci: Add support for Intel EHL")
> Cc: stable@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 154 ++++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index bb6802448b2f..c0e081e48d3f 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -24,6 +24,8 @@
>  #include <linux/iopoll.h>
>  #include <linux/gpio.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/pm_qos.h>
> +#include <linux/debugfs.h>
>  #include <linux/mmc/slot-gpio.h>
>  #include <linux/mmc/sdhci-pci-data.h>
>  #include <linux/acpi.h>
> @@ -508,6 +510,8 @@ struct intel_host {
>         bool    rpm_retune_ok;
>         u32     glk_rx_ctrl1;
>         u32     glk_tun_val;
> +       u32     active_ltr;
> +       u32     idle_ltr;
>  };
>
>  static const guid_t intel_dsm_guid =
> @@ -752,6 +756,108 @@ static int intel_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         return 0;
>  }
>
> +#define INTEL_ACTIVELTR                0x804
> +#define INTEL_IDLELTR          0x808
> +
> +#define INTEL_LTR_REQ          BIT(15)
> +#define INTEL_LTR_SCALE_MASK   GENMASK(11, 10)
> +#define INTEL_LTR_SCALE_1US    (2 << 10)
> +#define INTEL_LTR_SCALE_32US   (3 << 10)
> +#define INTEL_LTR_VALUE_MASK   GENMASK(9, 0)
> +
> +static void intel_cache_ltr(struct sdhci_pci_slot *slot)
> +{
> +       struct intel_host *intel_host = sdhci_pci_priv(slot);
> +       struct sdhci_host *host = slot->host;
> +
> +       intel_host->active_ltr = readl(host->ioaddr + INTEL_ACTIVELTR);
> +       intel_host->idle_ltr = readl(host->ioaddr + INTEL_IDLELTR);
> +}
> +
> +static void intel_ltr_set(struct device *dev, s32 val)
> +{
> +       struct sdhci_pci_chip *chip = dev_get_drvdata(dev);
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +       struct intel_host *intel_host = sdhci_pci_priv(slot);
> +       struct sdhci_host *host = slot->host;
> +       u32 ltr;
> +
> +       pm_runtime_get_sync(dev);
> +
> +       /*
> +        * Program latency tolerance (LTR) accordingly what has been asked
> +        * by the PM QoS layer or disable it in case we were passed
> +        * negative value or PM_QOS_LATENCY_ANY.
> +        */
> +       ltr = readl(host->ioaddr + INTEL_ACTIVELTR);
> +
> +       if (val == PM_QOS_LATENCY_ANY || val < 0) {
> +               ltr &= ~INTEL_LTR_REQ;
> +       } else {
> +               ltr |= INTEL_LTR_REQ;
> +               ltr &= ~INTEL_LTR_SCALE_MASK;
> +               ltr &= ~INTEL_LTR_VALUE_MASK;
> +
> +               if (val > INTEL_LTR_VALUE_MASK) {
> +                       val >>= 5;
> +                       if (val > INTEL_LTR_VALUE_MASK)
> +                               val = INTEL_LTR_VALUE_MASK;
> +                       ltr |= INTEL_LTR_SCALE_32US | val;
> +               } else {
> +                       ltr |= INTEL_LTR_SCALE_1US | val;
> +               }
> +       }
> +
> +       if (ltr == intel_host->active_ltr)
> +               goto out;
> +
> +       writel(ltr, host->ioaddr + INTEL_ACTIVELTR);
> +       writel(ltr, host->ioaddr + INTEL_IDLELTR);
> +
> +       /* Cache the values into lpss structure */
> +       intel_cache_ltr(slot);
> +out:
> +       pm_runtime_put_autosuspend(dev);
> +}
> +
> +static bool intel_use_ltr(struct sdhci_pci_chip *chip)
> +{
> +       switch (chip->pdev->device) {
> +       case PCI_DEVICE_ID_INTEL_BYT_EMMC:
> +       case PCI_DEVICE_ID_INTEL_BYT_EMMC2:
> +       case PCI_DEVICE_ID_INTEL_BYT_SDIO:
> +       case PCI_DEVICE_ID_INTEL_BYT_SD:
> +       case PCI_DEVICE_ID_INTEL_BSW_EMMC:
> +       case PCI_DEVICE_ID_INTEL_BSW_SDIO:
> +       case PCI_DEVICE_ID_INTEL_BSW_SD:
> +               return false;
> +       default:
> +               return true;
> +       }
> +}
> +
> +static void intel_ltr_expose(struct sdhci_pci_chip *chip)
> +{
> +       struct device *dev = &chip->pdev->dev;
> +
> +       if (!intel_use_ltr(chip))
> +               return;
> +
> +       dev->power.set_latency_tolerance = intel_ltr_set;
> +       dev_pm_qos_expose_latency_tolerance(dev);
> +}
> +
> +static void intel_ltr_hide(struct sdhci_pci_chip *chip)
> +{
> +       struct device *dev = &chip->pdev->dev;
> +
> +       if (!intel_use_ltr(chip))
> +               return;
> +
> +       dev_pm_qos_hide_latency_tolerance(dev);
> +       dev->power.set_latency_tolerance = NULL;
> +}
> +
>  static void byt_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
> @@ -766,6 +872,43 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
>         ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
>
>         device_property_read_u32(dev, "max-frequency", &mmc->f_max);
> +
> +       if (!mmc->slotno) {
> +               slot->chip->slots[mmc->slotno] = slot;
> +               intel_ltr_expose(slot->chip);
> +       }
> +}
> +
> +static void byt_add_debugfs(struct sdhci_pci_slot *slot)
> +{
> +       struct intel_host *intel_host = sdhci_pci_priv(slot);
> +       struct mmc_host *mmc = slot->host->mmc;
> +       struct dentry *dir = mmc->debugfs_root;
> +
> +       if (!intel_use_ltr(slot->chip))
> +               return;
> +
> +       debugfs_create_x32("active_ltr", 0444, dir, &intel_host->active_ltr);
> +       debugfs_create_x32("idle_ltr", 0444, dir, &intel_host->idle_ltr);
> +
> +       intel_cache_ltr(slot);
> +}
> +
> +static int byt_add_host(struct sdhci_pci_slot *slot)
> +{
> +       int ret = sdhci_add_host(slot->host);
> +
> +       if (!ret)
> +               byt_add_debugfs(slot);
> +       return ret;
> +}
> +
> +static void byt_remove_slot(struct sdhci_pci_slot *slot, int dead)
> +{
> +       struct mmc_host *mmc = slot->host->mmc;
> +
> +       if (!mmc->slotno)
> +               intel_ltr_hide(slot->chip);
>  }
>
>  static int byt_emmc_probe_slot(struct sdhci_pci_slot *slot)
> @@ -846,6 +989,8 @@ static int glk_emmc_add_host(struct sdhci_pci_slot *slot)
>         if (ret)
>                 goto cleanup;
>
> +       byt_add_debugfs(slot);
> +
>         return 0;
>
>  cleanup:
> @@ -1023,6 +1168,8 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
>  #endif
>         .allow_runtime_pm = true,
>         .probe_slot     = byt_emmc_probe_slot,
> +       .add_host       = byt_add_host,
> +       .remove_slot    = byt_remove_slot,
>         .quirks         = SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC |
>                           SDHCI_QUIRK_NO_LED,
>         .quirks2        = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> @@ -1036,6 +1183,7 @@ static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
>         .allow_runtime_pm       = true,
>         .probe_slot             = glk_emmc_probe_slot,
>         .add_host               = glk_emmc_add_host,
> +       .remove_slot            = byt_remove_slot,
>  #ifdef CONFIG_PM_SLEEP
>         .suspend                = sdhci_cqhci_suspend,
>         .resume                 = sdhci_cqhci_resume,
> @@ -1066,6 +1214,8 @@ static const struct sdhci_pci_fixes sdhci_ni_byt_sdio = {
>                           SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .allow_runtime_pm = true,
>         .probe_slot     = ni_byt_sdio_probe_slot,
> +       .add_host       = byt_add_host,
> +       .remove_slot    = byt_remove_slot,
>         .ops            = &sdhci_intel_byt_ops,
>         .priv_size      = sizeof(struct intel_host),
>  };
> @@ -1083,6 +1233,8 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>                         SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
>         .allow_runtime_pm = true,
>         .probe_slot     = byt_sdio_probe_slot,
> +       .add_host       = byt_add_host,
> +       .remove_slot    = byt_remove_slot,
>         .ops            = &sdhci_intel_byt_ops,
>         .priv_size      = sizeof(struct intel_host),
>  };
> @@ -1102,6 +1254,8 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>         .allow_runtime_pm = true,
>         .own_cd_for_runtime_pm = true,
>         .probe_slot     = byt_sd_probe_slot,
> +       .add_host       = byt_add_host,
> +       .remove_slot    = byt_remove_slot,
>         .ops            = &sdhci_intel_byt_ops,
>         .priv_size      = sizeof(struct intel_host),
>  };
> --
> 2.17.1
>
