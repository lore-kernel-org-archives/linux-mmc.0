Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BDCC433F5
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Apr 2022 22:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiDVWDE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Apr 2022 18:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbiDVWDC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2022 18:03:02 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04454160E1
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2022 13:45:49 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f7bb893309so17619567b3.12
        for <linux-mmc@vger.kernel.org>; Fri, 22 Apr 2022 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTYVVxfz08ji7LisN1HyvD8Q42QQWkxJnHZuQ3wrXDI=;
        b=CyZGYcQdOD77c4tnXXyDM7egLNC+xD5Lfbo++f/oEd6Mc7YuF4nZcSJzO8litplCwO
         9Hl8ANPegA2yhs1atnyTv3F2IXhNasW6GYJwzObOkSp1IUpm00J+fxtkzcorapDPlSjB
         wP2YAOJ0YRS/HVWxrNoRy+JCkpS9b9oEy7h2uDzLPAXyBisQ4AOVV6l0b5CYEBGu8Lm+
         hCH9vb+4DKR1/NV539hOeSudxUu6kTO+2/+GzaVxDlMjEv3oolcffR8KWHlMwU0FjbN1
         Xjh3xCynw6y1akW6P75hxoxD98mqku4I6Zw+cZjnySE4cxkqbK+/qalL6jdwhx8TQlTl
         zheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTYVVxfz08ji7LisN1HyvD8Q42QQWkxJnHZuQ3wrXDI=;
        b=2cisqzYzwB3ou453RQCGatqq8RMeo9Qd4On7kYMv4BDtB4NJw4Q2tjzlN45ZpNQZJG
         /LkgP9LznEe+Q6bM91RzkACgdYifnjkK317KAIvE+VXEMFkQaLDvs//HIY7P+Zh2K9J5
         40PfV9hcgrSMAUHeDwZ50R2dyorxQO+9u5k99CXRMBY5eFzoLOdshEuA2rmj2JO8VJZO
         c/ycXhGKGB+PcfDDvBcx4Ctw7frPNJEGY0/hzNRxY2cPOgg17f8T3XzWv+MLk8zx8Y8W
         5z/pesAX18/jwDSAQpfBRIOTy1+LpYnXQxcPO5rrUlnxSVSItEz7yeAzhvh/D05vGUtm
         j0IQ==
X-Gm-Message-State: AOAM533gmuZBCsZsKhdCIt4W/8HzdzPz/C+6FBAIrw07AsyQ1c9qHucB
        vZr5rtk+bs7q3rad2TwT7VVbpoLYCK2lr3HRdXJSbw==
X-Google-Smtp-Source: ABdhPJzq86ruhOqEYU+8gN4yyBiknGW6LZI+KGiMSXNBWuHztdTVyCg6yrBXJo6ofvLK9zohuzrwA6ko4NYCiLa0wzQ=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr6900986ywd.448.1650660348505; Fri, 22
 Apr 2022 13:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-18-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-18-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 22:45:37 +0200
Message-ID: <CACRpkdaBixtCX=rdMCVJb6QgFhBRZxEnPpDYDzsznx93TL4Jgg@mail.gmail.com>
Subject: Re: [PATCHv1 17/19] arm64: dts: rockchip: Add rk3588s pinctrl data
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Jianqun Xu <jay.xu@rock-chips.com>, kernel@collabora.com,
        Shengfei Xu <xsf@rock-chips.com>,
        Damon Ding <damon.ding@rock-chips.com>,
        Steven Liu <steven.liu@rock-chips.com>,
        Jon Lin <jon.lin@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Apr 22, 2022 at 7:14 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> From: Jianqun Xu <jay.xu@rock-chips.com>
>
> This adds the pin controller data for rk3588.
>
> Signed-off-by: Shengfei Xu <xsf@rock-chips.com>
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Signed-off-by: Steven Liu <steven.liu@rock-chips.com>
> Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> [port from vendor tree merging all fixes]
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Please funnel this through the SoC tree.

Yours,
Linus Walleij
