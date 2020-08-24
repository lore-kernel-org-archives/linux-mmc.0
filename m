Return-Path: <SRS0=kf8L=CC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC2AC433DF
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831302075B
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Aug 2020 09:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fW+0mduX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHXJv7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgHXJvy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 05:51:54 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7777CC061574
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:54 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id k1so1828526vkb.7
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2020 02:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2q1ajbiErRira53HKKXrYklVG3PnlJgLsr24GKSESBE=;
        b=fW+0mduXAJo6I00usVYLd80593zek0anWPHqMWg2M/w3DLXpOueIhU9HKiJQoHH6CB
         7RMHX9FGdi13UNc+JEJTIWt/J/udbr+B5Nt25R6/0Kf+mojenLe6j15NWCGTmxFJYJvq
         q9F/aTh7r33Rn15GzhOXIOgW3oLefqKm0t9N1yNSe7hhHsaKdJYx2ob+sb0oBS49Zdvb
         80WyA+2ttjZt0IDoqVYtfhGIFEC/+RUgkRpc4k+pz1vbXfto7qDZPAL2JziGVGw44F+Q
         Yl7GgcXkvIKeQWWCC9OxELndNMl5N63p0PLHj6Eko+s9i8AS3wOL5LddhkyxYEgPRSYq
         VEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2q1ajbiErRira53HKKXrYklVG3PnlJgLsr24GKSESBE=;
        b=CmdriruN8xytgd0ro1FtBw0JO22RXPmqlHl5+/H0F+upoRA1oC/6sBABkeRq3Xc9jw
         TbOrJogQKMABiDHy6r18L9TvJEaVJc8lsSOpiaXisGSyDpHQ/l4n4Oj7tcR63v97o1k3
         zs0MaaFd6rcIolVh7hn9OxawDZf32VKgMCuDT6ZRa2q0MVayUhbA53t/Cf3VCmR9lrdC
         XUnCMSK3fxyiNoqTjBrLQaHZ92Sazn2yvfUhr8VtwxwC+5bjhk/1R6+m/DfhPg5ADqCJ
         M/9jxsqItCrlnmN6I23udeveTAfxO6wxDE4YGqVVnT5K3eG9cSeIbKepyhd63W+J70Pm
         9gjg==
X-Gm-Message-State: AOAM531XUj0gTT3LNOAKIGqruJbKcQ4IEtj//2GuR9ATgajr6t7Ky5O2
        2G4M8zjBzG8oyH3JrraLwOO9GIJIL+olM1q0CXCkNQ==
X-Google-Smtp-Source: ABdhPJyroNBl9bu8cbvuTbtyDsOW3xnOs02H7+FfHBFmEDiB/7+UTI/z2QyyFgKHQXBMWQMkSGOzbbHpaTNuTkxV6Zw=
X-Received: by 2002:a1f:7c45:: with SMTP id x66mr1996597vkc.53.1598262713413;
 Mon, 24 Aug 2020 02:51:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200822061528.7035-1-madhuparnabhowmik10@gmail.com>
In-Reply-To: <20200822061528.7035-1-madhuparnabhowmik10@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 Aug 2020 11:51:16 +0200
Message-ID: <CAPDyKFqEtSuODBNSgt26gn9k=mHfnCcbN=LjR1BeCmgAM2SXwQ@mail.gmail.com>
Subject: Re: [PATCH v2] drivers: mmc: host: via-sdmmc: Fix data race bug
To:     madhuparnabhowmik10@gmail.com
Cc:     Bruce Chang <brucechang@via.com.tw>,
        Harald Welte <HaraldWelte@viatech.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrianov@ispras.ru, ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 22 Aug 2020 at 08:15, <madhuparnabhowmik10@gmail.com> wrote:
>
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> via_save_pcictrlreg() should be called with host->lock held
> as it writes to pm_pcictrl_reg, otherwise there can be a race
> condition between via_sd_suspend() and via_sdc_card_detect().
> The same pattern is used in the function via_reset_pcictrl()
> as well, where via_save_pcictrlreg() is called with host->lock
> held.
>
> Found by Linux Driver Verification project (linuxtesting.org).
>
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2: Rebase v5.9-rc1
>
>  drivers/mmc/host/via-sdmmc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
> index 49dab9f42b6d..9b755ea0fa03 100644
> --- a/drivers/mmc/host/via-sdmmc.c
> +++ b/drivers/mmc/host/via-sdmmc.c
> @@ -1257,11 +1257,14 @@ static void __maybe_unused via_init_sdc_pm(struct via_crdr_mmc_host *host)
>  static int __maybe_unused via_sd_suspend(struct device *dev)
>  {
>         struct via_crdr_mmc_host *host;
> +       unsigned long flags;
>
>         host = dev_get_drvdata(dev);
>
> +       spin_lock_irqsave(&host->lock, flags);
>         via_save_pcictrlreg(host);
>         via_save_sdcreg(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         device_wakeup_enable(dev);
>
> --
> 2.17.1
>
