Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D27C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Feb 2022 16:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237824AbiB1QON (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Feb 2022 11:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237819AbiB1QOM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2022 11:14:12 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5BA3981F
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 08:13:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id b9so22250105lfv.7
        for <linux-mmc@vger.kernel.org>; Mon, 28 Feb 2022 08:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aj7ohy06sMocjpRr7VZziDX9Znc+y574ZQOuLLO9Ujc=;
        b=w8xFoxchmHuUDWSWIr1m6mGNR6QoP/Fkox6tNxODLRHvHOdqf9pAqIoK8/XrJ7sHc9
         XM5W5YdyH4w05cP766eT945ueHGFLySs0dT2QHLWngzOsr/hbmx9tevQJyU+XTL57HdT
         ajGIIzFSBnly4VtG8mQC7Z3poAmBiopPqJ6ULBOqT4Ik6srf4xCR5L1K+EtQM5QTjWVQ
         L47zDYUutuH2hzqZ7NahI0n1+nRJpkDhW1NRYqV4TegLZtdeU+mfG96bvfWZ01lMEOk3
         sQFHLwC/tMagzFhuDQiAfKao32H7O9/xPui6f+K4/ahLSDIiX8sv8BUDtZekvYNthp11
         e3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aj7ohy06sMocjpRr7VZziDX9Znc+y574ZQOuLLO9Ujc=;
        b=qW3gsdPMPU+1dZMS5GxHCje3VROWbFZqhssrymx60oYwktQwZ7mc3vO1QZ5pZ9hzUH
         IuhrG07eCWTXOR3uUTMF2k4CUzuGJxaC18zQTbbLa9aTn/b42pM8fpP6JQV6HAA8+D/8
         JqWEhVGcuDhK/t+h/3ak7D1CS+Y29aOu982fRf23N+gWBkXgiZ5rXRoEo2HQXzTbrCZE
         mbY4nZocRzm8UyqnIaReWTVOyu97QbJ35RgsFsuXVkEH57RNNI0pGxF0n3ok133LP9ZP
         SEhXtFOhsCau0u40PIeaAXQVqDQMS0jI5TfbJxcfGw7pMg/Pn7Wd0w8BgP34juDzDIZt
         Kmyg==
X-Gm-Message-State: AOAM5328iOm6qKnxcrtFD8l2Y5wRtNTPCeUvGo8LORKpqpm1dKMKHO4+
        YI1nW/JjxVINHU5ADo2cHnx1ODVVP2OrgEEWksXYi9++xirqMQ==
X-Google-Smtp-Source: ABdhPJwb8L4XXbmlNDwOvZjuKWEIzxBEm2q8c2oLQ6pda77hgpnw7LP1z8YK99bj5SrelYP+NZwELijfzodQzpA0P3Q=
X-Received: by 2002:a05:6512:3604:b0:443:5d4b:3760 with SMTP id
 f4-20020a056512360400b004435d4b3760mr13142342lfs.358.1646064811622; Mon, 28
 Feb 2022 08:13:31 -0800 (PST)
MIME-Version: 1.0
References: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
In-Reply-To: <fb7cda69c5c244dfa579229ee2f0da83@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Feb 2022 17:12:55 +0100
Message-ID: <CAPDyKFrYWgCbwk6-hNZjtx4mdn7Sx1NJLie+f8wEjS==_HXR5Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: rtsx: add 74 Clocks in power on flow
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 22 Feb 2022 at 08:28, Ricky WU <ricky_wu@realtek.com> wrote:
>
> After 1ms stabilizing the voltage time
> add "Host provides at least 74 Clocks
> before issuing first command" that is
> spec definition
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index 2a3f14afe9f8..e016d720e453 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -940,10 +940,17 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (err < 0)
>                 return err;
>
> +       mdelay(1);
> +
>         err = rtsx_pci_write_register(pcr, CARD_OE, SD_OUTPUT_EN, SD_OUTPUT_EN);
>         if (err < 0)
>                 return err;
>
> +       /* send init 74 clocks */
> +       rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, SD_CLK_TOGGLE_EN);
> +       mdelay(5);
> +       rtsx_pci_write_register(pcr, SD_BUS_STAT, SD_CLK_TOGGLE_EN, 0);
> +
>         if (PCI_PID(pcr) == PID_5261) {
>                 /*
>                  * If test mode is set switch to SD Express mandatorily,

As you probably are aware of, the mmc core uses three power states
(MMC_POWER_ON, MMC_POWER_UP and MMC_POWER_OFF) to manage the
initialization, while it invokes the ->set_ios() callback for the mmc
host driver. During these steps the core also tries to manage the
different delays that are needed according to the eMMC/SD specs. You
may have a look at mmc_power_up() in drivers/mmc/core/core.c. In the
rtsx case, MMC_POWER_ON and MMC_POWER_UP are treated as one single
step.

Moreover, it has turned out that some mmc HWs are actually controlling
these delays during the initialization themselves, which makes the
delays in the core superfluous. Therefore we have made the delays
configurable for host drivers. For DT based platforms, we have the DT
property "post-power-on-delay-ms" and for others, it's perfectly fine
to update host->power_delay_ms before calling mmc_add_host().

Would it be possible to take advantage of the above "features" from
the core, to avoid hard coded and superfluous delays?

Kind regards
Uffe
