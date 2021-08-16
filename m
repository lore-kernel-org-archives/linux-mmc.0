Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC26C43216
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE8556330B
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 14:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhHPOBD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbhHPOAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 10:00:37 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CDDC06124C
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:43 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id k124so4461949vke.5
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FdgGtEcfAftNEDhyiW7J0wv4uiUYCUUhbtGTkeqqBj0=;
        b=lXKpKdwU/nxzKYQu0JVky+cOTbWt+XOYcwQewi4hNmjyGw32W8JHdNNw5R06zrZX8f
         kqNJOtrzz+qdGHVlmuofDwd6Cg4iYaEDYF3/SCa2bCbZCdE1lF3fLJ3JBp3hACPglTJT
         A93yJ6+i4J53clV+LyQqSs0HxAHMSlOjhfXtSHbSiJqq+n1F5onPinGmdkSPMFD8JKVz
         Fo9/1bsOeqLTzS2/r3eTliVo3Nq/B+ZEbbNfeXBc459bnWFw6IikOjymXWlGVSFJ7nNy
         4CZLQ2UNZUIspK7G6UzZNB4hA66/S4sbFaHvlo3FMh6zLXGpAj1xuwPQEk5mEJXIu+l4
         tAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FdgGtEcfAftNEDhyiW7J0wv4uiUYCUUhbtGTkeqqBj0=;
        b=CUHZuyeMMSqVMI64rKF2UidaGay3pHEMcWxq/187QswWJGTw1qFUhrbLJg113akBUn
         DcUn++8JD82le6CVKVX9oNPvMRBti4itQpkbQf0iImyeGKx4NsFQ1NCCiiMD/ropbgsL
         P6FlqrEP9CQnedISPhm+osxtZyDWnKPqgTrPhB5b7L1e336T/JeY2B09cjB2X4TvWifF
         mICVYoqM1bxP2JjUZBvC5Bi2LmgjvSDMpNIGMVCVLW5cXmlYQT/vr/bN15o3TnOACwDT
         oOI4RjY5GzBk/VtPZ1QqqQ697kwp3TNjBrxPqPoKeixvIHvWvNNZakj5CwfzZtM0Fs/g
         oKkg==
X-Gm-Message-State: AOAM532iUyetz2fV/fgf3CvuCQD6VTrWWDZeR+UVwkjT1gbkOeI41ucJ
        KXGKwz2B9CQkVYSmxQ0b3F7+/vAQFjrrKMIN2jLpVw==
X-Google-Smtp-Source: ABdhPJzBDfAgbW3pX7xmLsi5xJsPnYsejXMV3ITpbiRQm364lNRmYgHbWPp2xsFr8ZkGvwB2htEA73RIlio9ZyQA8vI=
X-Received: by 2002:a1f:a301:: with SMTP id m1mr8844692vke.6.1629122382002;
 Mon, 16 Aug 2021 06:59:42 -0700 (PDT)
MIME-Version: 1.0
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com> <1628334401-6577-5-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1628334401-6577-5-git-send-email-stefan.wahren@i2se.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:59:05 +0200
Message-ID: <CAPDyKFoAGx-1nQh81P3OPiAkR5cq1wGaioQ8Mxo4JCZsZC6NVQ@mail.gmail.com>
Subject: Re: [PATCH V2 04/10] mmc: sdhci-iproc: Cap min clock frequency on BCM2711
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        DTML <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2835..." 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 7 Aug 2021 at 13:07, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>
> From: Nicolas Saenz Julienne <nsaenz@kernel.org>
>
> There is a known bug on BCM2711's SDHCI core integration where the
> controller will hang when the difference between the core clock and the
> bus clock is too great. Specifically this can be reproduced under the
> following conditions:
>
> - No SD card plugged in, polling thread is running, probing cards at
>   100 kHz.
> - BCM2711's core clock configured at 500MHz or more.
>
> So set 200 kHz as the minimum clock frequency available for that board.
>
> For more information on the issue see this:
> https://lore.kernel.org/linux-mmc/20210322185816.27582-1-nsaenz@kernel.org/T/#m11f2783a09b581da6b8a15f302625b43a6ecdeca
>
> Fixes: f84e411c85be ("mmc: sdhci-iproc: Add support for emmc2 of the BCM2711")
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Applied for fixes and by adding a stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-iproc.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index cce390f..032bf85 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -173,6 +173,23 @@ static unsigned int sdhci_iproc_get_max_clock(struct sdhci_host *host)
>                 return pltfm_host->clock;
>  }
>
> +/*
> + * There is a known bug on BCM2711's SDHCI core integration where the
> + * controller will hang when the difference between the core clock and the bus
> + * clock is too great. Specifically this can be reproduced under the following
> + * conditions:
> + *
> + *  - No SD card plugged in, polling thread is running, probing cards at
> + *    100 kHz.
> + *  - BCM2711's core clock configured at 500MHz or more
> + *
> + * So we set 200kHz as the minimum clock frequency available for that SoC.
> + */
> +static unsigned int sdhci_iproc_bcm2711_get_min_clock(struct sdhci_host *host)
> +{
> +       return 200000;
> +}
> +
>  static const struct sdhci_ops sdhci_iproc_ops = {
>         .set_clock = sdhci_set_clock,
>         .get_max_clock = sdhci_iproc_get_max_clock,
> @@ -271,6 +288,7 @@ static const struct sdhci_ops sdhci_iproc_bcm2711_ops = {
>         .set_clock = sdhci_set_clock,
>         .set_power = sdhci_set_power_and_bus_voltage,
>         .get_max_clock = sdhci_iproc_get_max_clock,
> +       .get_min_clock = sdhci_iproc_bcm2711_get_min_clock,
>         .set_bus_width = sdhci_set_bus_width,
>         .reset = sdhci_reset,
>         .set_uhs_signaling = sdhci_set_uhs_signaling,
> --
> 2.7.4
>
