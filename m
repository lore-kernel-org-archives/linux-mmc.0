Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4406BC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Dec 2021 13:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhLMNBu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 13 Dec 2021 08:01:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbhLMNBu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Dec 2021 08:01:50 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92610C06173F
        for <linux-mmc@vger.kernel.org>; Mon, 13 Dec 2021 05:01:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l7so23600878lja.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Dec 2021 05:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmZqoM0VKk19CgkjkqT2/mS1Wzq4NBD9qkKtBMLqLss=;
        b=CXhNuATQd8iDGZZytbWfLcg2yXtENnNCTKsNdZ1fZIz+RkCQDT2d8Yg5go8/P1d/c4
         wCDwchO9A63guwAOxxpmkrCXlkj8l94hZURQbhdTiA8ubNeK8kFVH+E5wZscpY7ZOO+3
         Op8xfaKGNiwSis5xYtXFSX7NW22UB+nyUknCHmGgniM4zQ4EZmoNaZA07WU9or+gVpg+
         1CYTnGCgEeZatVJ4KiscXfHqfpl/3vlyru7JgkzhHOb3nMwrumn337EVox8W0BdZ1v/G
         P7B7jwwpGbXjuqd/XoGfWZeHIMevRS4txQr6jxI+f+44dlx8w/Y33+6v97q64LsSO6WO
         UfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmZqoM0VKk19CgkjkqT2/mS1Wzq4NBD9qkKtBMLqLss=;
        b=T6I2qepP32p4ITy9sD1PD/WfU460MJgq9QUR/+pi+aG1NHTtvV9DxrZnSwuif18NJG
         o4ZbO+VWfLPORGXi3URophjX6ZCp48GQFXA9imAtnNvSgGBvxDEgypK2bmTUZ+ejsXR9
         uhViH/Cq+ApOgG9dGGkwUU0AXlkv04avkl/jWO7aZtM60zZ4rhwFzNGZHROhO5FwAxWV
         YxzB/HHqAWE2yqAMO9thF6x5mDkOItio2ox96ncASSSjOG6/5KIxU2hapZnHsHzS2U14
         ApfaqJmiSgYs1poW7DzpwNGCTU4U6YxW38vcjZe7Al1PZa4SIhUvSdhFS2K7hPgTEDjZ
         yyyQ==
X-Gm-Message-State: AOAM5325aPUFbuBBeNb/G87M4sZSg+gornBktBCT+y/9432CXPZifbDi
        uD95f+mZuQDPqT72VFfVbQy6aV+pAHqZiR3nxEi97w==
X-Google-Smtp-Source: ABdhPJwDPCbxiPnhThYyhmTadFojAvuJfukt/vgX9gGHkV9OErrpCAyUIo/lXKbMSSPm5smSXRJojyNJL0Ju04uDV1I=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr29570182ljc.229.1639400506261;
 Mon, 13 Dec 2021 05:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Dec 2021 14:01:09 +0100
Message-ID: <CAPDyKFoqGFJQ=i301+xXvP1he-tzL8pzZO3q6P+tERYFUNZskA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: meson-mx-sdhc: two fixes
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 12 Dec 2021 at 16:00, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The first patch in this series fixes Broadcom SDIO wifi cards (using
> the brcmfmac driver) on Meson8 SoCs. Meson8b with Realtek (RTL8723BS)
> SDIO wifi is unaffected by this (it worked fine before). Testing was
> done (on the S82 board) in private by a user who wants to remain
> anonymous.
>
> The second patch in this series is a minor cleanup which I found when
> working on the first patch.
>
>
> Martin Blumenstingl (2):
>   mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands
>   mmc: meson-mx-sdhc: Drop unused MESON_SDHC_NUM_BUILTIN_CLKS macro
>
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 2 --
>  drivers/mmc/host/meson-mx-sdhc-mmc.c  | 9 +++++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>

Hi Martin,

I noticed that you didn't cc the Maintainers from Baylibre, perhaps
the amlogic list is good enough?

Kind regards
Uffe
