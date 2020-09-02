Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB9C43461
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8ED208DB
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBNyr78r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIBJEN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIBJEA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 05:04:00 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CA1C061246
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 02:03:59 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id b123so2161680vsd.10
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 02:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itlRbbBGemMZj6RC0w5yK0m6b8wHA0Bm1ChisOFrb20=;
        b=yBNyr78rhsjgGIM6THzbWs8HNIWZJ3x9mSBKPQCKbhJk3Z50mWkfvV36AeniWzm6Qe
         aV0O3gIzUSf2TBtCm8WiZfgTVOWDl5LrvDeSwdxS3af72jZ/nJ+ADWDAiInBepByAp1e
         PL7ZPKwuNQeUZHw8De3+ZvVR+Ey0sVdeRLxMKBdV4K67r0wUlexb75TREUjIyXlGg7is
         PihY0GAo6MCkNFPdUGtP5slwKjLpJZs9K1Q6/AlqFWGkvARIzhXvAXjseCwYU9TutPp2
         noJqeDASqYPwPcHT+7ZIoQciA7tsbb9NCIxdulFry0shP9Iscn23Cvo1dpeWNkQmxHu6
         0eIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itlRbbBGemMZj6RC0w5yK0m6b8wHA0Bm1ChisOFrb20=;
        b=WKBC0afbGRhXbywthyyn0IHWBewCJsZzooQ/vg2Dd2CTFLAECqZL7ZN9KsTaJugDvF
         ia3zmCCCVCSCymSnqJDihBEh5mRVUwP7cfwQhFpyRBad3oBo9Yoqlf8uo26eXiwXb0gH
         Ix18VgUqGHA5LuVxQEZ1tkFK7nhEYWQ9VbtYxSm/ZWOcd3Mc6qzf728OvCfs+cP64JMC
         E/bl9TeMVrLcUjkikedh7om3OdnzqHGcnQqyN9XuwflVubDzMLozkH8HmO6GjWFF3xcK
         DmY+9cl//U1GTI/kDlF+N4Fx6L174Np6khz7eb9OMLVko36On/Hy6HfKKCr+hQV6an0v
         ARtg==
X-Gm-Message-State: AOAM531vewwZjs0qhD7kJUMOcejxiqiCnfddZSw6f9ED9hTBKyMG7bUF
        daGuVRmhRfsLVu6oq/pd2I/RjDswhNKoq4oh1oGo8w==
X-Google-Smtp-Source: ABdhPJxjEM29jRCiVuNOJSS+uxtsMkMIs0ZX0+YfZ9Sew8Mzc1PTjMp9+B4YulTDlW5/psJ9L3xHp7zU+/tu3AYfYyg=
X-Received: by 2002:a67:7c4e:: with SMTP id x75mr4509007vsc.60.1599037439148;
 Wed, 02 Sep 2020 02:03:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com>
In-Reply-To: <20200901085004.2512-1-matthias.schiffer@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:23 +0200
Message-ID: <CAPDyKFrC62rLOQraHvh=8APWDk84YYo5YEg=uoUsgAeMx19G=Q@mail.gmail.com>
Subject: Re: [PATCH mmc-next v4 1/2] dt-bindings: mmc: document alias support
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 1 Sep 2020 at 10:50, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> As for I2C and SPI, it now is possible to reserve a fixed index for
> mmc/mmcblk devices.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
> v4: moved alias documentation from example to description
>
> v3: new patch
>
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index b96da0c7f819..f928f66fc59a 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -14,6 +14,10 @@ description: |
>    that requires the respective functionality should implement them using
>    these definitions.
>
> +  It is possible to assign a fixed index mmcN to an MMC host controller
> +  (and the corresponding mmcblkN devices) by defining an alias in the
> +  /aliases device tree node.
> +
>  properties:
>    $nodename:
>      pattern: "^mmc(@.*)?$"
> --
> 2.17.1
>
