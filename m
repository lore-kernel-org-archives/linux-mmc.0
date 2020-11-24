Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5562FC56201
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB06020872
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Nov 2020 14:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDgjj2+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388782AbgKXOZu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Nov 2020 09:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388682AbgKXOZu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Nov 2020 09:25:50 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4671AC0613D6
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:25:50 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id m16so11169223vsl.8
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2020 06:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N0bYsVH3nX2+OrWeKV+IhWPNW7SxLL8wfGpVZs1WpC4=;
        b=EDgjj2+oAPA7Acji64+FmuVACR9K66q27TqlRkf8LTM2/hnbs4KTFVRq8v55KrYBdq
         vwI7SxLUYPVLhi2EjzKvEWfEO4V2ZpxHHYEpW4rVQeG2PXS3X/NDzXY0CZEVhSd1S0g5
         vpaeda9BQx3NJDhrFDGTuYRAu4BRmXHa1uSxzWBYyf3b0NErGFMiDgtSwy+SRNRrAJiK
         7El+PAryir76UjhHOYvMCell+95Nvgjz5c9sTd0qjSwsYIU17yTc7h/Pd3SxRRP3OZu/
         yhq5GTbzx8DkvOuotF9AIYMFo9rRH55YxSKW791CF7radC//clZc02ZJ41uvRV5n+5HL
         peTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N0bYsVH3nX2+OrWeKV+IhWPNW7SxLL8wfGpVZs1WpC4=;
        b=R4e5tiOFFkg7A0RCzgT2bfW62BNa15tIPgWmmWAvEO1SxiMYuAsEQM9p4cr604DD8o
         lHjIBNlu4HxdMdYY6UEDIXxjNYkB0MVxP1R5z7Ebrkcb09TlQ2ltoTf06ThWIr/4yORS
         NtMLH0wvJ2zdIxBv21b/y5xt2teJL+ordLt6wERlivxE74I8NKCNOxTDc1R6Sjp0ycM/
         6ewQ/2Rg+wqyZNFO+GeAHz+zNEDICF3zriUlaAyi8XvZ4pLygXMnbg7zX7b5xwBV7ztW
         JXva0bkPuIwHkO7CAciSkwTvDo+GYtLc5/FuYhpYEiq5vY4am5w8WKh+Xdx1ZkCGn7b2
         wOkg==
X-Gm-Message-State: AOAM531n+s63LRAB3ekLBi+1IHUlw3dH0v+6LY+WLYeHLvRSUaw49++Q
        iuXRKXSihTbXrYfiZ34Wq6WAGAKyE6fq5k0YsN7PhQ==
X-Google-Smtp-Source: ABdhPJzhZfHuOq5aKuFvvR01RfE3+t1reY1YiLArpVadOD1pJBErw+3edBrUDyCXjNqiRSg8zYmRuFcAc/c4n2DajhE=
X-Received: by 2002:a67:ce8e:: with SMTP id c14mr3917991vse.42.1606227949488;
 Tue, 24 Nov 2020 06:25:49 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com> <713f57f4a66fff9a50a8d93643a7987d6560becb.1605823502.git.cristian.ciocaltea@gmail.com>
In-Reply-To: <713f57f4a66fff9a50a8d93643a7987d6560becb.1605823502.git.cristian.ciocaltea@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Nov 2020 15:25:12 +0100
Message-ID: <CAPDyKFrFp52NhNPtbOmoCRVVTMACcmAFNomJJM1whm8dCAP2hQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] dt-bindings: mmc: owl: Add compatible string for
 Actions Semi S500 SoC
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 20 Nov 2020 at 00:56, Cristian Ciocaltea
<cristian.ciocaltea@gmail.com> wrote:
>
> Add a new compatible string corresponding to the MMC controller found
> in the S500 variant of the Actions Semi Owl SoCs family.
>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/owl-mmc.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> index b6ab527087d5..b0d81ebe0f6e 100644
> --- a/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> @@ -17,7 +17,9 @@ properties:
>      oneOf:
>        - const: actions,owl-mmc
>        - items:
> -          - const: actions,s700-mmc
> +          - enum:
> +              - actions,s500-mmc
> +              - actions,s700-mmc
>            - const: actions,owl-mmc
>
>    reg:
> --
> 2.29.2
>
