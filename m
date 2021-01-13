Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177FAC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A887223432
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 13:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbhAMNIs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 08:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbhAMNIs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 08:08:48 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30125C061786
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 05:08:08 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id d6so479770vkb.13
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 05:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9oNPkEmUO8hkna64sWXChu9HZjo0m5iZB1erj41a8uI=;
        b=qwHeMAfERZE2zl0I3lja3nX4Mwy/ITwsKJwRa1su1yK90uMfOzGztxj9fWZNqvNv8S
         7/oc1PDmQUX3bnjseo4QLXR/7Gv2NRuBmyCjHAwDAW+5Jo6tMsxSe9OpV/tkq3GVl0Lf
         OsSRcY4nHnN+1qNrbqZaD97FSchwHLK7q9ZPiUA6FWW7ajkKfAyCnxIAl6aT1+vXtt7h
         0+vJa0/3j9DlBiL9TFXutAPHb5GN3JPMLYh1MWgr0RysQyW1as0DKK+ZXKBYZg0wqStO
         4r4pmEeIpBFtiOe1XBwlY27+0zS52pNudiNejRz8H33dZIREBYFwpP40yKuUdH8rtBPa
         tVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9oNPkEmUO8hkna64sWXChu9HZjo0m5iZB1erj41a8uI=;
        b=FTSQG4PASMbHsVBzz36+5zAkHquxLWHWREhbHEhPds1ik7d9iqcG3Kftbt56KrxP8D
         8LTGBG7EwPoqRL+uJk/Ki1WbAxT6sAQJnwiIh1NPYuiFf754nEuZ5fNQBJdG+NBweOfX
         21QY/Geho2b8dDwD+5zdmOHWOdPOocU8dQFvkta/OPA2qPIqsKv0m+qyns1XmEXNICiO
         RHPk8G147CQ4yd8A9L+I9eXgSf443ZXGUtXlzkbZx2sowovjDDZV87wAxO7BPkUNElve
         QmxQCO9XmBy1R5/xsMA3MbnV20z+1sv8SsimUhrh+5AAjH3tdbLM6o4a35AIHt3CgdYJ
         /tUg==
X-Gm-Message-State: AOAM531cmmAm3lkadJCLZOXuEbrK3y6VQLizixE98PR53j03YmyK26q2
        JwZsBf23NGDnHvYWpMCv0ZxhUDSu8s0DuuR2lKxLrA==
X-Google-Smtp-Source: ABdhPJwQAdLZCij898e92iUq41dX/oLOa7oxz5JbuvCcn/nO6ViS5Yj/u70grbsYjpCHZ4QTgqWEAq4wyvXXNKee4vo=
X-Received: by 2002:a1f:dec2:: with SMTP id v185mr1702891vkg.8.1610543287405;
 Wed, 13 Jan 2021 05:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20210113105723.7916-1-ricky_wu@realtek.com>
In-Reply-To: <20210113105723.7916-1-ricky_wu@realtek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 14:07:30 +0100
Message-ID: <CAPDyKFrxpihy6wtRUPrAwRkWnwmRVxJcKMUesbjPKJURfrHJBQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: rtsx: add delay before power on
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        feng@realsil.com.cn, Doug Anderson <dianders@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Jan 2021 at 11:57, <ricky_wu@realtek.com> wrote:
>
> From: Ricky Wu <ricky_wu@realtek.com>
>
> Make sure voltage below 0.5V before power on
> when do power cycle
> At mmc-core recognition card phase will do
> power cycle quickly so our device need at least 100ms
> to make voltage down to below 0.5V
>
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>

Applied for next, by amending the changelog a bit, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
> index e6f5bbce5685..0e5043a03965 100644
> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> @@ -906,6 +906,8 @@ static int sd_power_on(struct realtek_pci_sdmmc *host)
>         if (host->power_state == SDMMC_POWER_ON)
>                 return 0;
>
> +       msleep(100);
> +
>         rtsx_pci_init_cmd(pcr);
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SELECT, 0x07, SD_MOD_SEL);
>         rtsx_pci_add_cmd(pcr, WRITE_REG_CMD, CARD_SHARE_MODE,
> --
> 2.17.1
>
