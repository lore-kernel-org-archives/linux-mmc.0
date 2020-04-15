Return-Path: <SRS0=Q6+y=57=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C96DC2BA19
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D28020787
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Apr 2020 09:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HlDX9VqN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895785AbgDOJpd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895777AbgDOJp1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Apr 2020 05:45:27 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D119C061A0C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 02:45:27 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id g184so654361vsc.0
        for <linux-mmc@vger.kernel.org>; Wed, 15 Apr 2020 02:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IKneV1QmlQeFe14d2ij+c/DrY29o4dYLg5OuU7iOZ00=;
        b=HlDX9VqN/q1XOlTmbmOLIVOx/7tesuanSLl06t1gTwR9us6rzItr66I7aA8sWlwvEt
         Na7MZjbi8HHUdZewMqSKPkCrWStLSVSxEKeGqQFcRPReLypSDYAQ1Oz2CSeHB3X4Yvz9
         hz+1ueYW09VBx0IRIfCY/X9b9NOrrutAiU8r0A9kis4tmjqJbNto0YKC6wZewTGtdfH8
         s6JYidkh7NYDf9LWC0g6QnKPdBTLZLLzFVa0Fd56XqptXrevZtj29JHEBTCV8VBlY32/
         oG5L3M+X5qnucPyjFLgxx7fIIcv16/qBT28UnQqcDYjyMZBZdwIoLlhavP15Ytbix5rZ
         w7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IKneV1QmlQeFe14d2ij+c/DrY29o4dYLg5OuU7iOZ00=;
        b=fTehVvCS5Okq56Of4wjzk5GxifR0Mml03FvgYkgFgEdCGcLiNztG0dBhtGQy6Askwh
         xePPRyXQLSCM3ss2uFZ8Kh9ITtHSw/E4HlYHkYHREmd7ssdeU9nLh4lTFCkkEWtpQi7h
         B3zrj+nWLbCQ89VpoEO+dIP1iL9IyfakVBTHB8c39AhdwT2B15+ZcJKDpop2txya5Q9r
         eRRlZCrNNggz1tI83xTR7InD9s0MZsUW+0kUf+Wpvs08X18lueF926brJ22XNDm2UpFS
         RQPCt7VC1jZ2J76wxDYIIguTeLwpkRen0/7cXptBcWMMGsfNXZWkeUaJeRDAgJfjQNKk
         oQzQ==
X-Gm-Message-State: AGi0PuaAb9W5q7/L0L0B3Tlqcc4ApLKewS6VZbSwGjWIHFUcQWpFCXMe
        b41+h4T9heG1IkYQ0Qc+hEpLIP62jO2pj6Y/01fZYw==
X-Google-Smtp-Source: APiQypK/eCTR6aPxe1VJ6fthD5zd+fP4epl+3QgyBuboiAKFXdVoJb/FjRC5Dv0EcwpOxHHLvsE+rKAnzhRmYHvHqxo=
X-Received: by 2002:a67:11c4:: with SMTP id 187mr3694939vsr.34.1586943926106;
 Wed, 15 Apr 2020 02:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <1586165281-11888-1-git-send-email-chun-hung.wu@mediatek.com>
In-Reply-To: <1586165281-11888-1-git-send-email-chun-hung.wu@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Apr 2020 11:44:50 +0200
Message-ID: <CAPDyKFrTSzTmHwChytRe8YVzYZk8LUuXALK_zk8M4ZCH=Owtag@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] mmc: mediatek: add mmc cqhci support
To:     Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Yong Mao <yong.mao@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

- trimmed cc-list (please do so at your next submission, as to get a
bigger chance of getting feedback)
+ Yong Mao (I would like Yong or Chaotian to at least ack this, before
I can apply).

On Mon, 6 Apr 2020 at 11:28, Chun-Hung Wu <chun-hung.wu@mediatek.com> wrote:
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
> 1.9.1

At the next submission, would you mind please stick to the following
type of header format for each patch "[PATCH v4 2/4]....", as I think
it's currently a bit confusing.

Kind regards
Uffe
