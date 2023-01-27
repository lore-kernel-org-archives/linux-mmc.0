Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562C8C38142
	for <linux-mmc@archiver.kernel.org>; Fri, 27 Jan 2023 10:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjA0K5v (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 27 Jan 2023 05:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjA0K5o (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Jan 2023 05:57:44 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF7F079C99
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2023 02:57:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id v3so2987617pgh.4
        for <linux-mmc@vger.kernel.org>; Fri, 27 Jan 2023 02:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VShsvqMt8UYSKuUHpyz0EidKT6tLGpfipXewaaNHm6s=;
        b=WLYx+iRvZSP7KD0HpFH3oreScPz9Y+dhPqtYRa9dWConxZnUq5yz5NF/c+NmClzxiY
         ww7KVkWRkQ0eqIEWcqEnuvS/JyhBfR7mJYxElneuKrKKti/RvW2/38HqSLPJGw5D+h5D
         rk7SgOARdldP5e9u6L2XKKfBqykIIFrujUkJw54F2vfQRwqfbxlGl+Fh/rFj+QEVfUKK
         P5n/8vqZs8SsuSPEnONh+dWBH+UyL9jGiE0/B4Rlj1IhYHqtaGhDgrdz19GVf62Y1LpQ
         MzepLQeuqtrz3i/eReqf5RT77z8pU2KcYjZZYzJarhPemWrQnD6ve8BhT09Tx5wIZpnD
         TqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VShsvqMt8UYSKuUHpyz0EidKT6tLGpfipXewaaNHm6s=;
        b=wMHaYx8Mq/LrFIJtg8Z4Iw73t8vNw1ghQLs4vBxKX5Gg4XGDSnFbV5en1HoABCr1Ch
         T0pWWifmMcgitYCQyzoQM9JGf/2Y6yYi4mfWMatygCghArAabOKShAnmVgskkoAO1qoo
         HueIFlVl/sj+ThYAjO4N9YJFsrkGjp+3+/RB1PNqkAhi/ME/Tel/MJxaqrFQGFlCuGcH
         G5xbooBZsme7CzSzhsQCrlwKlcJl4vr2KTg1yFKhL3tRnzTku7YgMDEMbJgx4O/DN3C1
         4l723dS6YT0tfhjTrYles9b1AqgHCt6Celsh1VjKAt88aqPueEWIrvGsSmtUjzpaqM5r
         yZBQ==
X-Gm-Message-State: AO0yUKVh2A4+VlA8qCVN2+DswYDMCPqgD0eMFMmBqp+5T4XpC+El4D3x
        kYk1Xoq3bHGofZjeZO1qo+ISkusJn8GeyNDyuf0EXw==
X-Google-Smtp-Source: AK7set+qSUg3Xk7mTTTu/XUOLKflgfnqPfHJM+HUV7TfXkvHSzyx4A69fzrZJxEUjJyqegwMjvIW/vD1B7NdyjpTL6c=
X-Received: by 2002:a05:6a00:279e:b0:592:591c:f6dd with SMTP id
 bd30-20020a056a00279e00b00592591cf6ddmr586139pfb.7.1674817060276; Fri, 27 Jan
 2023 02:57:40 -0800 (PST)
MIME-Version: 1.0
References: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20230125010201.28246-1-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 27 Jan 2023 11:57:04 +0100
Message-ID: <CAPDyKFreuJhwsw3ECvhW+rdM9pouja8wttsRntbwvUR-5haPHw@mail.gmail.com>
Subject: Re: [PATCH 0/5] mmc: uniphier-sd: Add UHS mode support
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 25 Jan 2023 at 02:02, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> The uniphier-sd controller needs to control some siginals from the SD
> interface logic to transition to UHS mode.
>
> This series adds UHS mode support to the controller driver
> to refer to and control the interface logic registers, which include
> mode selector and SDR speed selector.
>
> Kunihiko Hayashi (5):
>   dt-bindings: mmc: uniphier-sd: Add socionext,syscon-uhs-mode property
>   mmc: uniphier-sd: Add control of UHS mode using SD interface logic
>   mmc: uniphier-sd: Add control to switch UHS speed
>   ARM: dts: uniphier: Add syscon-uhs-mode to SD node
>   arm64: dts: uniphier: Add syscon-uhs-mode to SD node
>
>  .../bindings/mmc/socionext,uniphier-sd.yaml   | 10 +++
>  arch/arm/boot/dts/uniphier-ld4.dtsi           |  3 +-
>  arch/arm/boot/dts/uniphier-pro4.dtsi          |  3 +-
>  arch/arm/boot/dts/uniphier-pro5.dtsi          |  3 +-
>  arch/arm/boot/dts/uniphier-pxs2.dtsi          |  3 +-
>  arch/arm/boot/dts/uniphier-sld8.dtsi          |  3 +-
>  .../boot/dts/socionext/uniphier-ld20.dtsi     |  3 +-
>  .../boot/dts/socionext/uniphier-pxs3.dtsi     |  3 +-
>  drivers/mmc/host/uniphier-sd.c                | 83 +++++++++++++++++--
>  9 files changed, 102 insertions(+), 12 deletions(-)
>

Patch 1 to 3 applied for next (I fixed up the comments from Krzysztof
when I applied), thanks!

Kind regards
Uffe
