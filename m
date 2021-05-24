Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC01CC2B9F8
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D886108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhEXOMW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhEXOMW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:22 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CE3C061756
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:10:54 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id m9so4640981vsq.5
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l5h+WQ0oEWo38CL1jqONencxRgJu9VTR6nMezb6lhhU=;
        b=GUwyy8oLVtvgR/eVwjg9YG73fIlQJGj74auOljdnWJShozK2XxEvHWunJzAd9tyAB8
         JXwELDLtm525q0YbcH1QKAWHDpwkvrNYimXaPuxKgYG+L/3DBPg6PgiaHmB5IS6zRMHr
         8c7x+GALzPTPJHEQiyYu4W8Nsm5+fGArsEPhmCMTMkG0ylHyRhpXRFtdcXZ49P6IkRtR
         XcqquB1KrkUNuJ3dmRvJMX9qQyoXxH8iCq9Nly2mhS3Xm3/jQn0A8ZXMW76crG+Lg79T
         a0iHkN4ZAPHXMN4vBESk0Blnt5eO8iZft9p+8JY+IrlMH5muNLQuMdaH8VzUsi+tG/UN
         bEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l5h+WQ0oEWo38CL1jqONencxRgJu9VTR6nMezb6lhhU=;
        b=oqlC/i3X4bP4XJ3JB+UTFJlgGVIxwvRPltaX3otpTJ6NgUheTBRqeBNg0WDqZQwHJo
         7/qvJNhZSy74BJljFksesVFymW34yI5v+Fsv7FWMyI+K1AtmrchxBFylXViB95kUSxgK
         KLd1HJ80RLh4SCX+L3gMTw/W8Ey/MJ9TpwQBSueL0PnI7qi37X7CweJ8gXz5f1mxaLAU
         kCY+KMOfarnSREE2htfHLoqT/g9Wf6yy7ybvFaBCQj4g0KXmZT9tbPqMJjcmM5jxCjVC
         dXt10u3Hg/LD6VZqsAHP6PU65Exkiwj8Ze4e378ylRQFSkNgz2Rbli1y5EAyqsi4bv4H
         TuMA==
X-Gm-Message-State: AOAM533md8+UmwaD0lCGw7jyApynaulxBfAlODm2w44xXAhRcNzl9viL
        nUuTwJVNFLZ8o/gpuKT9n3Wb6uBbylg6wizel8W4Rw==
X-Google-Smtp-Source: ABdhPJwtziN/FCGvgGw4/XlFkWpcDdnay97ug47LPV8fFhhcyAayvbokIVDoG13Dji6ETVLY30FzGOnySJip8KB3INs=
X-Received: by 2002:a67:1087:: with SMTP id 129mr20524337vsq.42.1621865453208;
 Mon, 24 May 2021 07:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210510190400.105162-1-l.stach@pengutronix.de>
In-Reply-To: <20210510190400.105162-1-l.stach@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:15 +0200
Message-ID: <CAPDyKFqL+7dgBaYL5ozrsB2U-+FEERx6MgAoAib6YdmAN6hHDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: add no-mmc-hs400 flag
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 10 May 2021 at 21:04, Lucas Stach <l.stach@pengutronix.de> wrote:
>
> From: Lucas Stach <dev@lynxeye.de>
>
> HS400 requires a data strobe line in addition to the usual MMC signal
> lines. If a board design neglects to wire up this signal, HS400 mode is
> not available, even if both the controller and the eMMC are claiming to
> support this mode. Add a DT flag to allow boards to disable the HS400
> support in this case.
>
> Signed-off-by: Lucas Stach <dev@lynxeye.de>
> Acked-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index e141330c1114..ac80d09df3a9 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -220,6 +220,11 @@ properties:
>      description:
>        eMMC HS400 enhanced strobe mode is supported
>
> +  no-mmc-hs400:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      All eMMC HS400 modes are not supported.
> +
>    dsr:
>      description:
>        Value the card Driver Stage Register (DSR) should be programmed
> --
> 2.31.1
>
