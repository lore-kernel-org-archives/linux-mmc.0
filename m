Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1169EC433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE34233E2
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 11:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbhAML0w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 13 Jan 2021 06:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbhAML0v (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jan 2021 06:26:51 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB14C0617B1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:51 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id 17so577971uaq.4
        for <linux-mmc@vger.kernel.org>; Wed, 13 Jan 2021 03:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cttz/D2YdQLsR3C43ckdGIJQQ5YrOYDnbNf5IhNcLYI=;
        b=LEcwabxJhci29cnamIgXuHBO/Z3LtbMfhlsaTAGsoL9g8zKCBLZxqcS0ebx87zsJH4
         uy0zhjszBskdOKPTHR0OK4tdYaz1XJlzAREFfrO+9OW58rvWU+48/NSnwPq02leH4WCp
         cE4wcDuFxuj4hhLXqbRlGDPpRggYUEB5DzVgCR6M0jnAHD7pNY3MGX0vjOg6ZgD8FnYE
         qPo0cGJup4guB8Hwshd45R+sII1vauMATFhH1bBybUz64fCPzTizQvw7t5bCs0x8DGr2
         83s7PBi+V6jdPZYmGjo8OJ+N7Y98lWtA8ijopW+CXpTrCY28bQwhz0IVk8bVfGZE9D0w
         sJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cttz/D2YdQLsR3C43ckdGIJQQ5YrOYDnbNf5IhNcLYI=;
        b=nODBWgr2IpykuZupSriHaxvneiIfGVxGcZNyJ8Whyn7oflTL+Xdvntvzg1ZmFKMmyJ
         bmBOjI3amrD8Kmio3oyJ/DPlj0lCoUdpFZbqYGVD4lNecVMguYz+3t2oDBLKRQ8+AoQL
         TjLy3XNnN7XH0Io5tB66pqQrWmHHH0OdEJ80Sx6bJ5nuzcPkU21biX24YeAcfCoSUPIy
         WbHwW/wIo9C7SZVbryNZ2s8Rjtv5Wt0kbrE4qwK65cDcKIv4Oh9Zolxl9fKAltt0ki3h
         VzuLehnl5tto8oHhGkQoI8zzzMZ90Xzps9wVIJU7/e8u4A2OJN46z7a0R69+GaqvCeD+
         BhmQ==
X-Gm-Message-State: AOAM531W5rLwMi9F5rypof9uW4Ro1LZcjkKhewmT4qk/ZCFi3knPORmb
        7u1+N3l6IakoRUYtvRJicjyc2f3ntwDcbSWOEXsndw==
X-Google-Smtp-Source: ABdhPJwk9cikIsLvk8wBtOv80r3nN6Wd86Yx/Dl91r0NxtDJZtYZrmyEAcUkJnDivNztwQjpv9hIZjRVGl2XX+Dffxk=
X-Received: by 2002:ab0:2e99:: with SMTP id f25mr1317060uaa.104.1610537150635;
 Wed, 13 Jan 2021 03:25:50 -0800 (PST)
MIME-Version: 1.0
References: <20201227174202.40834-1-wsa+renesas@sang-engineering.com> <20201227174202.40834-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201227174202.40834-2-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 13 Jan 2021 12:25:14 +0100
Message-ID: <CAPDyKFqBJNiV3M7MFTydLRtR7S+wok6OkLnKFrfzbi0TfPxiUQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mmc: renesas,sdhi: Add r8a779a0 support
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 27 Dec 2020 at 18:42, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 6bbf29b5c239..5908a717d2e8 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -59,6 +59,7 @@ properties:
>                - renesas,sdhi-r8a77980 # R-Car V3H
>                - renesas,sdhi-r8a77990 # R-Car E3
>                - renesas,sdhi-r8a77995 # R-Car D3
> +              - renesas,sdhi-r8a779a0 # R-Car V3U
>            - const: renesas,rcar-gen3-sdhi # R-Car Gen3 or RZ/G2
>
>    reg:
> --
> 2.28.0
>
