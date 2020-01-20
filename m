Return-Path: <SRS0=gs89=3J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF55EC2D0DB
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB0E218AC
	for <linux-mmc@archiver.kernel.org>; Mon, 20 Jan 2020 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9SLfMjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgATL0X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 20 Jan 2020 06:26:23 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:39606 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgATL0W (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Jan 2020 06:26:22 -0500
Received: by mail-ua1-f66.google.com with SMTP id 73so11354099uac.6
        for <linux-mmc@vger.kernel.org>; Mon, 20 Jan 2020 03:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iMltZyjqEXLKv+701Vx+gjP4V99Edn3VdTw2YKakZQU=;
        b=x9SLfMjB7Joymxy2DJJcHt4fk9IEyF7qN97bzNCYwmpcDBqmg1SdTYWO+kyjnMwaO5
         vlvUyp6xCkzLYG9znKaAlebIE6y7kK9X7Q68jdurP3WSoOblaPzDt5rgUmu/T7GzU//4
         8FYdO/Lp7bFdhVWgWiCt3KdYFvC1hS2HDZQua1Ou3cx8/TA3PD+Pnezep0ywRPTZU5hs
         8dzSXMy9v8ZNvyqKx0oB2Ll+5BGcLziuba5+Fb2Fhvp7gG6F7hP/g4O/lk4gQcQmiuPF
         QIMd9M8CdpLh+4bjIqsnfgmhiGxHi/pBs7PV+EX3YYEbKz8KS4kwmKpoIh7nQqvfEwYr
         IW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iMltZyjqEXLKv+701Vx+gjP4V99Edn3VdTw2YKakZQU=;
        b=pH3z3jlJl4yfXsF//kt6PvUYvd5BjLvlWWgDD2X9KnkUMbkDIobUfatbCZ5hslx+Dw
         yyxLu+BO810j8TNG7zwNC1xbnHwCTIO7yTTTwDWialO81gK7qZed2jRgCZGz9Qb0jntx
         pGXsJ7y+ex9/bkBrcbfLXPVDgjmvXLFxXzVvnBJi60dmBOJLBCkVzqmF4P/V4ynbboky
         yp1/8YUonN0dlsv9kpoKDDsjKyGHkRKTyBNArJyv442fEvHnurXGP+35MA5GB7WV7qx+
         ZyRRZmVnHrCANUdIg66SMja6hgtlOMpCM2cLqvngD12tPBWnX5N7MygnsV+rQzII6d2n
         vkvQ==
X-Gm-Message-State: APjAAAVz+lkTsG90aRqZx37QHV+8s/b8jkS/QuOtfCyKXvgbWNU0m461
        WAEOABXeS1z2URiIoJ3E3Mh14eyfiPwIvLtl7ng3hQ==
X-Google-Smtp-Source: APXvYqxKOg9xB8XfL4rfLGRcMxbyRFwMSCwEYJNga3Tv3rpmXA1r3UXHbtiJXS2hERZ8PkUrI2DpkswuNuzWn5p+4j4=
X-Received: by 2002:ab0:6894:: with SMTP id t20mr28696691uar.100.1579519581204;
 Mon, 20 Jan 2020 03:26:21 -0800 (PST)
MIME-Version: 1.0
References: <20200113210706.11972-1-alcooperx@gmail.com>
In-Reply-To: <20200113210706.11972-1-alcooperx@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 20 Jan 2020 12:25:45 +0100
Message-ID: <CAPDyKFr3mrkY5KNO8tnjD1Fuqbbbb_4s6vuJ4cyOrOHM1E5vQg@mail.gmail.com>
Subject: Re: [PATCH 0/6] mmc: sdhci-brcmstb: Driver updates
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Takao Orito <orito.takao@socionext.com>,
        YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Jan 2020 at 22:07, Al Cooper <alcooperx@gmail.com> wrote:
>
> The latest BRCMSTB SoC's now use a new Arasan controller along
> with a custom Broadcom PHY that supports HS200, HS400, SDR104,
> HS400E-ES and CQE. This series of commits adds support for these
> new features along with a few bug fixes. The 7216 is the first
> SoC to have this new hardware.
>
> Al Cooper (6):
>   dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 7216b0
>   mmc: sdhci-brcmstb: Add ability to use HS400ES transfer mode
>   mmc: sdhci-brcmstb: Fix driver to defer on clk_get defer
>   mmc: sdhci-brcmstb: Add shutdown callback
>   mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)
>   mmc: sdhci-brcmstb: Fix incorrect switch to HS mode
>
>  .../bindings/mmc/brcm,sdhci-brcmstb.txt       |  41 ++-
>  drivers/mmc/host/Kconfig                      |   1 +
>  drivers/mmc/host/sdhci-brcmstb.c              | 270 +++++++++++++++++-
>  3 files changed, 284 insertions(+), 28 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
