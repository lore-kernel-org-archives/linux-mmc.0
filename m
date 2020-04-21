Return-Path: <SRS0=Yb6F=6F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E324C2BA19
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 09:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF772087E
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Apr 2020 09:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i44fOYZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgDUJ0M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726628AbgDUJ0K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Apr 2020 05:26:10 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F03C061A0F
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2020 02:26:10 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id n128so3415217vke.5
        for <linux-mmc@vger.kernel.org>; Tue, 21 Apr 2020 02:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sutV1Oamoy4pwRt+VwqP9AtJQW6IanilRtSt3lz61TU=;
        b=i44fOYZUDMFqxzO+bLxz7mYEXUJOrpBd6UGd2O+okyMUpCDdFKYIA826sUc7iPf6we
         js7pHNoTwz0e4R+VDEEez61/nomAfRCsuE94AcZJ9S5rehCXy1mKu/shAWtzpt5XfI+r
         l2r9o/esXgf9BSBCXfnnvw6hbSFBgzLYaI5HilgMBU9YGUTsg5p6E8mn0f/ULpHUceV+
         grZbBZ4lBL1a3TWwDjxTT1wtbs2ryIpbqkXG4MOXWlfVjB0C5532Ob0xNjO+leG/B2jP
         C7PZF9bGVE3w+BOpv+3h7rP7Iv2Zp5h7xvJNVCEBTX3s7LvKyKbqlZBsoksAMNcbHIKb
         3+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sutV1Oamoy4pwRt+VwqP9AtJQW6IanilRtSt3lz61TU=;
        b=UkkVG03A1k5uUKpE+x5W3YMHojEy6QsUVj2OCLsOPgWaklj7Keg53zIQsYNoqHYQMU
         aPHN+JypHqHCjKUXUDpYQlLHJ0EBwtftbUO/YvHg0htIi0m2WrXJAWWDd4ikSULv994R
         cNQpChgSxhEM1zK+HA/+prZMuv92Spz7gFa8/qan8ue1/UnpR16M2cynAUIFRGTMxsko
         CztfOFdISAKqxbN7+ECCYrUq/3gDLqq4AhYMPWsvxsyQ9qaOGex2joxOM9Hp8aLhLkej
         IO4+eciD1QKolKBTdz25sVXOJhrIBYDhy/CcBu8sQ9NkI4A3hRw980u0qXouEB5B1h2R
         zM/g==
X-Gm-Message-State: AGi0PuYTntplUs+732wC9OxB7WK+irarkDTJfHZuHFO8E3TGJsSOu3P0
        09CoOElC/MnhoNXtY1OUe10cUOZdEw/4Ax6zzWRltQ==
X-Google-Smtp-Source: APiQypKgJ3XD4p50nn/CNLH8KAToU17AAWt5xtoXI0IXMljJSdFyItYyZUEcdUyWP2PTkh+mgDLx1kzXR3Z25Pm/P1U=
X-Received: by 2002:a1f:a60b:: with SMTP id p11mr8434277vke.43.1587461169800;
 Tue, 21 Apr 2020 02:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200420161831.5043-1-ludovic.barre@st.com>
In-Reply-To: <20200420161831.5043-1-ludovic.barre@st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Apr 2020 11:25:33 +0200
Message-ID: <CAPDyKFqC3fdnQ9CMYhS-=5MiCET=r5Az2S5oFoA2v1gdDeGO3w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci_sdmmc: fix power on issue due to pwr_reg initialization
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 20 Apr 2020 at 18:18, Ludovic Barre <ludovic.barre@st.com> wrote:
>
> This patch fix a power-on issue, and avoid to retry the power sequence.
>
> In power off sequence: sdmmc must set pwr_reg in "power-cycle" state
> (value 0x2), to prevent the card from being supplied through the signal
> lines (all the lines are driven low).
>
> In power on sequence: when the power is stable, sdmmc must set pwr_reg
> in "power-off" state (value 0x0) to drive all signal to high before to
> set "power-on".

Just a question to gain further understanding.

Let's assume that the controller is a power-on state, because it's
been initialized by the boot loader. When the mmc core then starts the
power-on sequence (not doing a power-off first), would $subject patch
then cause the
MMCIPOWER to remain as is, or is it going to be overwritten?

I am a little worried that we may start to rely on boot loader
conditions, which isn't really what we want either...

>
> To avoid writing the same value to the power register several times, this
> register is cached by the pwr_reg variable. At probe pwr_reg is initialized
> to 0 by kzalloc of mmc_alloc_host.
>
> Like pwr_reg value is 0 at probing, the power on sequence fail because
> the "power-off" state is not writes (value 0x0) and the lines
> remain drive to low.
>
> This patch initializes "pwr_reg" variable with power register value.
> This it done in sdmmc variant init to not disturb default mmci behavior.
>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>

Besides the comment, the code and the approach seems reasonable to me.

Kind regards
Uffe

> ---
>
> This patch is the proposal from:
> https://patchwork.kernel.org/patch/11457987/
>
> ---
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
> index d33e62bd6153..14f99d8aa3f0 100644
> --- a/drivers/mmc/host/mmci_stm32_sdmmc.c
> +++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
> @@ -519,6 +519,7 @@ void sdmmc_variant_init(struct mmci_host *host)
>         struct sdmmc_dlyb *dlyb;
>
>         host->ops = &sdmmc_variant_ops;
> +       host->pwr_reg = readl_relaxed(host->base + MMCIPOWER);
>
>         base_dlyb = devm_of_iomap(mmc_dev(host->mmc), np, 1, NULL);
>         if (IS_ERR(base_dlyb))
> --
> 2.17.1
>
