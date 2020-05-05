Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2066C47254
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8370320746
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oZ94coJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgEELdn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 07:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728866AbgEELdn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 07:33:43 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CFDC061A0F
        for <linux-mmc@vger.kernel.org>; Tue,  5 May 2020 04:33:42 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id u12so1026096vsq.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2020 04:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=osnN+k7TRx1CxNSurAK8vOShk1LyMQb2x8AnE6QzWks=;
        b=oZ94coJsUHPB+yZjtmsoTEBVsGcjaStmgTIKwayDc+QAfqUHeJ1sTaV/T3k6EeMTZ4
         HV7Mpkil3Si743wW129jyYptj8WEJ+CJj6iv5sMvm4iwAcnVkWKrXIeis11TASfWj6Lf
         DeZ93pzzR6dXI+LGbkFgK33doL4KxxaKuhiZi/1SBZ16/iCt32twy9oZPIbr77JK56ww
         i6mL6VNikqgPVJgJ1xOUQ00ZCjnkPOLiALYZI96YuKWxnLYAhmFOeRu3MPn4Cypxs/EW
         KlzDQ4T3zF/WsiFcTuJBPMyWbktb2FM19Zt1bL+6W7i4PlqIzTiiAlN05kFi9IpW682z
         A2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=osnN+k7TRx1CxNSurAK8vOShk1LyMQb2x8AnE6QzWks=;
        b=XF38LExMOUFGVork/5elCdnGHBU2XP5qg4HIhbRhCFqMLmqDaE3xSnGeoJ1LwDGZE6
         Hup68wHgKchtc9WsElgfh3X834tE89HVcJc0P+M7SS0IfSd7w01IejBrVHuTW7sRaF0H
         KZJ7tvzMfKl2ckR3X5QlNA6XDYK1hwCOivg5/uNqoN5n/OPwrovDCjDEmh/kLcYM2ttu
         Mb+9uU4gK8a/7+VEKh62hwnTqO3nVemrdbt92OL6GETqzY0r4fYLQuUsFvtSYEtiLqw1
         8mHm9c4wz5aB0ikG0+G8GaS8iSShYlpns7OPYuz7UvaiwVaiI/v4gSoagTIbNzCz44XA
         +N8w==
X-Gm-Message-State: AGi0PuZO/1R7oeqxL4tAOUW/k0fBvN117IjQH4m3g58td5Y7uoFi82ZQ
        YwP0TAdZ1pbsEPkCTV3cdC5ZFZ+gRS5EOAsdHuYOzg==
X-Google-Smtp-Source: APiQypLY8nKD4DfZcnCRiLiUDvntUoeR/uDMv3OvvZWGA22jovAi64KJ1DFoGEwu2WgpKh3ipBPvYkzCgsaD0NcKFKg=
X-Received: by 2002:a67:302:: with SMTP id 2mr2119733vsd.165.1588678422073;
 Tue, 05 May 2020 04:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <1588031768-23677-1-git-send-email-chun-hung.wu@mediatek.com>
In-Reply-To: <1588031768-23677-1-git-send-email-chun-hung.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 13:33:05 +0200
Message-ID: <CAPDyKFrE_0Cm3PzmZ9qAzKHmhWobYovNRjrs5zk2YL5CQac=XA@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] mmc: mediatek: add mmc cqhci support
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- trimmed cc-list (Please do so also for you next submission)

On Tue, 28 Apr 2020 at 01:57, Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
>
> This series provides MediaTek cqhci implementations as below:
>   - Extend mmc_of_parse() to parse CQE bindings
>   - Remove redundant host CQE bindings
>   - Refine msdc timeout api to reduce redundant code
>   - MediaTek command queue support
>   - dt-bindings for mt6779
>
> v1 -> v2:
>   - Add more patch details in commit message
>   - Separate msdc timeout api refine to individual patch
>
> v2 -> v3:
>   - Remove CR-Id, Change-Id and Feature in patches
>   - Add Signed-off-by in patches
>
> v3 -> v4:
>   - Refine CQE bindings in mmc_of_parse (Ulf Hansson)
>   - Remove redundant host CQE bindings (Linux Walleij)
>
> v4 -> v5:
>   - Add Acked-by and more maintainers
>
> Chun-Hung Wu (5):
>   [1/5] mmc: core: Extend mmc_of_parse() to parse CQE bindings
>   [2/5] mmc: host: Remove redundant CQE bindings
>   [3/5] mmc: mediatek: refine msdc timeout api
>   [4/5] mmc: mediatek: command queue support
>   [5/5] dt-bindings: mmc: mediatek: Add document for mt6779
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.txt |   1 +
>  drivers/mmc/core/host.c                          |   5 +
>  drivers/mmc/host/mtk-sd.c                        | 151 +++++++++++++++++++++--
>  drivers/mmc/host/sdhci-brcmstb.c                 |  11 +-
>  drivers/mmc/host/sdhci-msm.c                     |   3 +-
>  drivers/mmc/host/sdhci-of-arasan.c               |   3 -
>  drivers/mmc/host/sdhci-tegra.c                   |   2 +-
>  7 files changed, 155 insertions(+), 21 deletions(-)
>
> --
> 2.6.4

While awaiting a respin of patch4, due to comments from Yong, I
decided to apply the other patches on my next branch. Thanks!

Kind regards
Uffe
