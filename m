Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4136C433F5
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD19660FBF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Sep 2021 17:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbhIFRLn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Sep 2021 13:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243861AbhIFRLn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Sep 2021 13:11:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F5DC061575
        for <linux-mmc@vger.kernel.org>; Mon,  6 Sep 2021 10:10:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q21so12303684ljj.6
        for <linux-mmc@vger.kernel.org>; Mon, 06 Sep 2021 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3NzOsAcij7qkGRYYRF+Gk9quH4ScOJdJCPVo4O4v2Iw=;
        b=GHRGp+FUEkuHWw+ma0xVKQKa3h0umQo2tZK29UHxYju0b6ue16Kq14o9Umrg1V2MzP
         OQQXLK8KNB+v/BxOIbCyTw0czVpMCwn+5JzpnXPuLMl7EWNQ7sHs3zh9WjxrvQpPpYiZ
         8LWWFMoMXZzjIgD/LiK4RPs8rIKwXYvFnw1MxOfktunYrvXWKxEQi+cNLd54jz/QxD82
         q5LZAvOaV1YZcbxrnCO9UXixRhXWa0Bb2CxeCigV01UXcy2uhxYVs602hEfUK+25gyzr
         O5FHrFpdUDfVO+z3EN+pb5IA++Pltvth3nAlf/Z4d1qU3iaIikLXoUvP/g8bceHOwcf6
         WvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3NzOsAcij7qkGRYYRF+Gk9quH4ScOJdJCPVo4O4v2Iw=;
        b=chzwYJeNX6dntit5KAEzQd6FUKFSZmth2LjeCKDQXlnz8XsDTspirnmviQ4bIrYy6T
         4DplU0MJ/EVeSlHYyvV+9dew4FiXrNCRAibM6zKWT3LegHGrj+7fo5kcwlJ40HOxecIM
         Cp7Wu+zptePHDRse7tyg0Q2GU7LhZjoOvs+EatiBwmZBn9mnoxeeiMtMUCyZXnNzmo4G
         dO8lkjy+kVFVrl/3iMMFN25Rb+I5fZor9r8PN3VBMpK3H5+KaL8cMhUJFTAyeV8ccXwJ
         wVZoG+EJgnzplYK4QG++QSSF/ovlzrh3tgTwrd+SMrXPq+61ODRQgY8vOjDJZZsIEQuN
         uAgg==
X-Gm-Message-State: AOAM532PtCoDigyfGbFTghP2l41IrsgMVVXJA5rPzvNwltRcieuG5Eom
        9FeKsxvoolCCDs/9npJ2NtURyIxaLpn/Xoq+/PzM4A==
X-Google-Smtp-Source: ABdhPJz02lZ2+/F+0r9vZ7g0b7LkWahcgAWP9qXLtKcaYaug81bz1fYecfyuvbPq62onmDQwmmLi7+yTxyKqBDnGYbQ=
X-Received: by 2002:a2e:7303:: with SMTP id o3mr11093870ljc.273.1630948236659;
 Mon, 06 Sep 2021 10:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20210827093855epcas1p4ac8e34d779fe30de3e03bcadedcb66c8@epcas1p4.samsung.com>
 <20210827093119.32481-1-cw9316.lee@samsung.com>
In-Reply-To: <20210827093119.32481-1-cw9316.lee@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Sep 2021 19:10:00 +0200
Message-ID: <CAPDyKFoXtep02GTFgKZmAoa7cN6CMBErf4UukWhrk5jU10Lj_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Remove unused parameters(mrq)
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grant.jung@samsung.com, jt77.jang@samsung.com,
        DooHyun Hwang <dh0421.hwang@samsung.com>,
        Seunghui Lee <sh043.lee@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 27 Aug 2021 at 11:39, Chanwoo Lee <cw9316.lee@samsung.com> wrote:
>
> From: ChanWoo Lee <cw9316.lee@samsung.com>
>
> The mmc_request structure(*mrq) is not used. //msdc_cmd_find_resp
> I remove the unnecessary code related to the mmc_request structure.
>
> Signed-off-by: ChanWoo Lee <cw9316.lee@samsung.com>

Queued for v5.16 on the temporary devel branch, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 4dfc246c5f95..813f57f6d9cc 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -961,7 +961,7 @@ static void msdc_set_mclk(struct msdc_host *host, unsigned char timing, u32 hz)
>  }
>
>  static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
> -               struct mmc_request *mrq, struct mmc_command *cmd)
> +               struct mmc_command *cmd)
>  {
>         u32 resp;
>
> @@ -997,7 +997,7 @@ static inline u32 msdc_cmd_prepare_raw_cmd(struct msdc_host *host,
>          * stop << 14 | rw << 13 | dtype << 11 | rsptyp << 7 | brk << 6 | opcode
>          */
>         u32 opcode = cmd->opcode;
> -       u32 resp = msdc_cmd_find_resp(host, mrq, cmd);
> +       u32 resp = msdc_cmd_find_resp(host, cmd);
>         u32 rawcmd = (opcode & 0x3f) | ((resp & 0x7) << 7);
>
>         host->cmd_rsp = resp;
> --
> 2.29.0
>
