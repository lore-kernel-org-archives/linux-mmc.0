Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF89C433B4
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 12:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB66961969
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 12:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbhCaMxG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235568AbhCaMwg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 08:52:36 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03808C06175F
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 05:52:34 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id f11so4323832vkl.9
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 05:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kPvXXseEpD2+fM2KlQVwvHu1Vje5yvkbBF9+RP8/HAA=;
        b=sD2xbR4YTENyWYZk9KTr3Wf8CRnxVIJX/BAtt37d84OnI3R5V8uJsENiOB5gBdsU+b
         yTc7ANohquY+qCloNr5l3cOVqihteofMluuXbs6n2F2djUus+jJ1RHTm2KVwa3yWJ11C
         KSCwkgQjM7t1UAEu/on0ge7x2zuQwy9ca6W1zPeihmWLzq+OGyKjTBxbgJZ9U1QsWYxu
         zIeHAe8tFh5eBArHYqsVMfR13ylqYZbRkPaT9r8I14c6E+Vi67N+5vun45xBlDKMWTy8
         E9XuPHwih3Ji74OpmPY+J4XxMtl9vuGWGPRq9L19oVevaOSY4vUDzMNa4bKbtNv++Fwe
         R7xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kPvXXseEpD2+fM2KlQVwvHu1Vje5yvkbBF9+RP8/HAA=;
        b=YuOid7GdYO9ff2zs5j2RkpYH1ND9u8OOWjib9p2AEzDzbWZfM6hA+9yHQMZBMY67wn
         LvSrjdn+nFHGQ9tXgoVO6PGSmZIA1C91CtImTvo/boo7fMvwZ+xjrNxSbX92/mT1g+PY
         P1z/9v5tOCqi7lyEB4mxHhPsuvNhOtXKNQkpSzZTfgVhAOvaEel05ucfSKVYq09boM7H
         7kzU21nRPtiutStesS/teIZGadZcGxTEfHByX3TnwJ71AwNMRV4P00FMeb3NLxUZqYrj
         VXPnvrW3BuMQ4ay/FO+74cS5rrhr7jJusSwQF+r63CwmPmsylPn4D7mldSLQ5KSIvlOv
         jvrg==
X-Gm-Message-State: AOAM533AobCQ6hNuJSGT1B/bU0pLtK1WwM9VGdfuowwS/2RXd8G83BCz
        zYzjYpm6Y3iz/dN9bPRF7C+LYQpGeQ8kK1KzNPrcHQ==
X-Google-Smtp-Source: ABdhPJxrnJkDppvk4DzcmI3MgfWa/Hoom+SuJ4TqLBMA1p5Wo4adkOmEJO3ZUT4HN72lFYFnHmzNUkN9EWWWzMTvF9Q=
X-Received: by 2002:a1f:2a95:: with SMTP id q143mr1437575vkq.8.1617195153188;
 Wed, 31 Mar 2021 05:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210331081752.23621-1-adrian.hunter@intel.com>
In-Reply-To: <20210331081752.23621-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 14:51:56 +0200
Message-ID: <CAPDyKFpbA4x33yr4s7+csATm6zgsx=NA4Ya-_QZBUPzNqEGoqQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci: Fix initialization of some SD cards for
 Intel BYT-based controllers
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 31 Mar 2021 at 10:17, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Bus power may control card power, but the full reset done by SDHCI at
> initialization still may not reset the power, whereas a direct write to
> SDHCI_POWER_CONTROL can. That might be needed to initialize correctly, if
> the card was left powered on previously.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-core.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index b3caa174effe..be19785227fe 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -516,6 +516,7 @@ struct intel_host {
>         int     drv_strength;
>         bool    d3_retune;
>         bool    rpm_retune_ok;
> +       bool    needs_pwr_off;
>         u32     glk_rx_ctrl1;
>         u32     glk_tun_val;
>         u32     active_ltr;
> @@ -643,9 +644,25 @@ static int bxt_get_cd(struct mmc_host *mmc)
>  static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
>                                   unsigned short vdd)
>  {
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct intel_host *intel_host = sdhci_pci_priv(slot);
>         int cntr;
>         u8 reg;
>
> +       /*
> +        * Bus power may control card power, but a full reset still may not
> +        * reset the power, whereas a direct write to SDHCI_POWER_CONTROL can.
> +        * That might be needed to initialize correctly, if the card was left
> +        * powered on previously.
> +        */
> +       if (intel_host->needs_pwr_off) {
> +               intel_host->needs_pwr_off = false;
> +               if (mode != MMC_POWER_OFF) {
> +                       sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
> +                       usleep_range(10000, 12500);
> +               }
> +       }
> +
>         sdhci_set_power(host, mode, vdd);
>
>         if (mode == MMC_POWER_OFF)
> @@ -1135,6 +1152,14 @@ static int byt_sdio_probe_slot(struct sdhci_pci_slot *slot)
>         return 0;
>  }
>
> +static void byt_needs_pwr_off(struct sdhci_pci_slot *slot)
> +{
> +       struct intel_host *intel_host = sdhci_pci_priv(slot);
> +       u8 reg = sdhci_readb(slot->host, SDHCI_POWER_CONTROL);
> +
> +       intel_host->needs_pwr_off = reg  & SDHCI_POWER_ON;
> +}
> +
>  static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>  {
>         byt_probe_slot(slot);
> @@ -1152,6 +1177,8 @@ static int byt_sd_probe_slot(struct sdhci_pci_slot *slot)
>             slot->chip->pdev->subsystem_device == PCI_SUBDEVICE_ID_NI_78E3)
>                 slot->host->mmc->caps2 |= MMC_CAP2_AVOID_3_3V;
>
> +       byt_needs_pwr_off(slot);
> +
>         return 0;
>  }
>
> --
> 2.17.1
>
