Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82914C4332F
	for <linux-mmc@archiver.kernel.org>; Thu, 28 Apr 2022 22:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353073AbiD1W6S (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353070AbiD1W6S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Apr 2022 18:58:18 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED311C1CAA
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 15:55:00 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id s30so11609299ybi.8
        for <linux-mmc@vger.kernel.org>; Thu, 28 Apr 2022 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cgTFMUsq9gVZz59+3kDOySK+OVbeH8W2pPDccjzuXKE=;
        b=ov2q5f2yE12o/uS00CPcFLtntiChTcYemtbGaDmhDAusLUIMEjB4VaNqGcC3WNcCPd
         L7yYE9xuB/7zZyKq9VQCxp2jIFB8CR7OFU5ZyhIOoVX3kFdYNID85+1a7J1f7sxAjjtG
         W7h8rWHl0hDVgXzxH0vvYzqteazALEC74JXOYii/DLzplO/NYZ0Lc0/ot+q4NvVAqt/I
         YIiJgCRu8Bb3hGo76YEBHfVL64mDFlBZKDBoB33icT3OC/SkBRmpCz6Nglkboa6ia0jE
         dDwfvH+RJVmQAqLIK8xM+VJl3XthUy4h6wSYEuLNngxFj+VdGOtvJcl1oBXwOwCsjeKl
         KreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cgTFMUsq9gVZz59+3kDOySK+OVbeH8W2pPDccjzuXKE=;
        b=WhWjl880EgMsLKNG2FuTbrZTc0e3cHoyWsTtlA1HyfTh7GLibx/KmHAvEuTiyh2QXF
         /h82fXkhDMyPBVmfwK2UG3SCvjRk4yYzxDCywjasmpLC6LhIGxj6foS46LZiP/z2Gkbp
         1tgfQvAS8SP7tTLwRI0hq2Y09MpZkfaIQ6XMxOGQMFYw9wJhi2hkiRn8w0ellAhlyC/R
         EnjpaOePNEA8AE/ZdvhKJjHLUf2H8PFsqOdLxAbfo3AW07M9RWZXzFBDqS8PIkDR5BpZ
         bfpZRG3Lg1jwSkajPpAvOu+55sp89E4wfz0ZAXAmXiObf2VYq/CLpr7zu4aG/1/5Iy4d
         YKaw==
X-Gm-Message-State: AOAM530J3FOXtnAf9bynyW7EM53/Tr19X4YRK++Wzod3+ALKV8TJFSHY
        UAQ4JYCe+KRLgUfEXwFM34MnqganquRzVug1Mi0UBw==
X-Google-Smtp-Source: ABdhPJzzpmlI/Pkjo7HQbAq5Q2zszomNzPfs/JPPXY6KHrXgc/mt8oB2lus+Oi/UtX2SN9COoG/Tm2fMjSmMEsomV1M=
X-Received: by 2002:a25:bcc3:0:b0:648:7360:8e75 with SMTP id
 l3-20020a25bcc3000000b0064873608e75mr20334083ybm.533.1651186500208; Thu, 28
 Apr 2022 15:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-13-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-13-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:54:49 +0200
Message-ID: <CACRpkdZZGXMV5cnZpdat1Z_22CZE-gGfCqRHpOqnd_asw_KMwQ@mail.gmail.com>
Subject: Re: [PATCHv1 12/19] pinctrl/rockchip: add error handling for
 pull/drive register getters
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
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Apr 22, 2022 at 7:09 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> Add error handling for the pull and driver register getters in preparation
> for RK3588 support.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Patch applied.

Yours,
Linus Walleij
