Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB76C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 19 May 2022 13:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238378AbiESNFN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 May 2022 09:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiESNFM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 May 2022 09:05:12 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DF9A7E1C
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2022 06:05:10 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ff39b44b06so55620067b3.13
        for <linux-mmc@vger.kernel.org>; Thu, 19 May 2022 06:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvS6oIYuJD+X/Sl5GyHKX9reZ4E6zgz4WuUSfpo4I1I=;
        b=cuUOVJMltrI7hB/SFs6chT4HOwwy3oA61jegFQS3eMZwuTE+w1145KZDnb8oyR6Tel
         QgauXxUvZ36jV/zTD3D7xyjpzpc8h/ztzct0mhcAnNACKMODQfg7Ymse3S7OsjhJQ3So
         Lsu1g4HGPEk955ldtzo/ZZgcprFUvW/9gsDpeAH7TtYK+0agHPo6Mhmo6IS/p59W6Mqo
         SItSjTv6JmhbnmqXgSbmSi/R9mCOCKAKvo+9lt8V/HzbaSCmmuMX5iXJqR67MluglWjx
         dhgi1CpRcdxgS803lPXtYUALykAzcFfh7ha/NcKJmOXatxLKmrsZmei8JKCv/eK+k0r3
         4O5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvS6oIYuJD+X/Sl5GyHKX9reZ4E6zgz4WuUSfpo4I1I=;
        b=WEHNo7BTsco71lKstczfimXlrEjJ9U5eAuLn3r6uGibYBxL/Hq4pD7hmpPhsqkJW2H
         mVodZjN/dRtcvUWwbPIpmlhrhefVEYCz9l4nZ/Gu+Lvq5XYypgdS2qU8q3J0VCx9JVbX
         sYuHQ02gPWOmRoD9kdDjdbxYXM8xdYX1q/uuUo8dB3H39DHdw6CbtABcltZgowU7FDB6
         y60tY7COeiW2DwZ//2MBZtlqo3k99FsnCnRkc4udRzNHBtbWQ/VXsn9QK+d505zfnIQ5
         fMubtfjvQsv3cXBgdU+3nLjTWFReL6A92RFg0a0GqJv6TQQUZHnuDIqJxSD9b0NiF1WX
         3z3A==
X-Gm-Message-State: AOAM530uedK/stq3agsmWWHTl3ktiibqIafCkzSUs0fztEl/e1cD2w7l
        JlpHqlNd7NA/MiYMKUEoRvRk5wc4IIGTOB8csDAUWw==
X-Google-Smtp-Source: ABdhPJzCqwZlIRlav0EjPiuT+GEqGML2V538fx0hb3/tK+CgfQDqc/5gWM2/UHdZ3ADOOwISs7cS0bmmxHbqgXmtybc=
X-Received: by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr4769667ywd.448.1652965508286; Thu, 19
 May 2022 06:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220504213251.264819-1-sebastian.reichel@collabora.com> <20220504213251.264819-19-sebastian.reichel@collabora.com>
In-Reply-To: <20220504213251.264819-19-sebastian.reichel@collabora.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 May 2022 15:04:57 +0200
Message-ID: <CACRpkdY4Db1jV55HUeLzOjqWs3cfjSCpcKX2Q7Zs-+rB9UkEsg@mail.gmail.com>
Subject: Re: [PATCHv2 18/21] dt-bindings: pinctrl: rockchip: increase max
 amount of device functions
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

On Wed, May 4, 2022 at 11:38 PM Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:

> RK3588 can have 10 different device functions, so increase the maximum
> amount appropriately. Considering rockchip uses auto-generated pinmux
> files, adding a quite complex if construct to increase the limit just
> for rk3588 does not seem to be worth the effort.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

This patch applied to the pinctrl tree.

Yours,
Linus Walleij
