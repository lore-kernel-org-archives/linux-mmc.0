Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64778C32792
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Aug 2022 05:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiHVFQJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Aug 2022 01:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiHVFQI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2022 01:16:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D17252B9
        for <linux-mmc@vger.kernel.org>; Sun, 21 Aug 2022 22:16:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so12341203edc.11
        for <linux-mmc@vger.kernel.org>; Sun, 21 Aug 2022 22:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9XRquiKtczGZrdHPEqA6WSyvm81oF4bOEAQ+13HYerQ=;
        b=SAiIxcHb4kUDUc3VEa2ho1tzuxThoNNZY/1Uy6ob5cxWpDMAgeWid7qhh1JGHzMGbM
         adHSfp3pJPdwumkTe334GAsPu2EKY2zVf0ZgMGTJDuJ3SrI6UEqh91/qCHuGRXQw1snv
         /1e79EhM6MjTf5SwV0uMLfQFrJ1HoFYfZpqvevvweqdEzjyYFlZtmV/EJfgjhfVj3EUi
         0XsC/T4XkSWokdnUY+/CPOVzfVcr8ThORv6pb4680aMO7Op76cXl+fqJrMS3ioeO09hy
         SzOT7E/D2WeM6kDvgcsmWkGn1PHym4wj8/UETx7DyE0Kmsc+CgU2T07R9NxHLpKuhXhA
         8OYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9XRquiKtczGZrdHPEqA6WSyvm81oF4bOEAQ+13HYerQ=;
        b=YFNGlmLfbNgNkBF0R+XfD/jy5ydocUsyzuRcOpgH0qf/2u/EcQoAi/LDT6NmNdBrVl
         FwsCmYOsRqxy9OWyTD5O9OS/gRobat0sMUY1wHaxWvJdVllHeUa4MWhFnp9qU8f5otQW
         TA94CNZXQFevrt1XnjnLE4xP9/8tIeW87c3xwR9s64AC7mLLgqEYwao/LJ6aQHzBxN84
         lskFJZeyk3GTfDFDWP4eV7hjD2fTPnBGpzx0jW1TEqpZgY5t/ss11OdNYIx6oK8w0+C9
         qfeGY1putj3H4afsG+chJH3cPUh0BnDVbpCdwIWaXBmBnRnpBtbGk1SGb6g+hp5ZshxK
         K8ug==
X-Gm-Message-State: ACgBeo2+010CPzr5cgfzavyXTShO4w+C3CoquF7pkQUKUxIwbsKMi5J3
        1MzE3gWFcLAa+ZVvIvC0vohmZCvutljIoatrgbImMg==
X-Google-Smtp-Source: AA6agR6LybaPwlMMl65wRvlyq8H6WWQJz/BQN9DIdJiuMLxwbfIvJqdASIjHGPhvc2W10vBYnlWtHxkr+SF+OLGyRk4=
X-Received: by 2002:a05:6402:42d3:b0:435:2c49:313d with SMTP id
 i19-20020a05640242d300b004352c49313dmr14569874edc.86.1661145364525; Sun, 21
 Aug 2022 22:16:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220819060801.10443-1-jinpu.wang@ionos.com> <20220819060801.10443-18-jinpu.wang@ionos.com>
 <CAFBinCCbjF_mkV+EaOtC0g_YbtX9TzBEN5fRJ_MiPaie5hxCwQ@mail.gmail.com>
In-Reply-To: <CAFBinCCbjF_mkV+EaOtC0g_YbtX9TzBEN5fRJ_MiPaie5hxCwQ@mail.gmail.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Mon, 22 Aug 2022 07:15:53 +0200
Message-ID: <CAMGffEnmGPDyuPPhWN0vyTMOtCHzfOo-Je=dVJ6ed7494ekKgw@mail.gmail.com>
Subject: Re: [PATCH v1 17/19] mmc: meson-mx-sdhc: Fix error check for dma_map_sg
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Martin,
On Sat, Aug 20, 2022 at 7:26 PM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello Jack,
>
> first of all: thank you for this patch!
welcome.
>
> On Fri, Aug 19, 2022 at 8:08 AM Jack Wang <jinpu.wang@ionos.com> wrote:
> [...]
> > @@ -388,7 +388,7 @@ static int meson_mx_sdhc_map_dma(struct mmc_host *mmc, struct mmc_request *mrq)
> >
> >         dma_len = dma_map_sg(mmc_dev(mmc), data->sg, data->sg_len,
> Does it also make sense to change the type of the dma_len variable
> from (signed) int to "unsigned int" (a few lines above)?
I double checked, it seems a good idea, I will do it in v2.
>
>
> Best regards,
> Martin
Thx!
