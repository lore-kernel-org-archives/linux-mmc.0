Return-Path: <SRS0=r8P+=CL=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C620AC433E2
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C74720709
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Sep 2020 09:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOfT6RjW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgIBJEc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Sep 2020 05:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbgIBJDt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Sep 2020 05:03:49 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F93C06125C
        for <linux-mmc@vger.kernel.org>; Wed,  2 Sep 2020 02:03:49 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id s62so317761vsc.7
        for <linux-mmc@vger.kernel.org>; Wed, 02 Sep 2020 02:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ew8uPftzd7rZEwyKmHbAQ1uIc01gvs5Er2gSjYfu7W8=;
        b=wOfT6RjWKK9Cg08Nc5h2tPkm+jRI7/v3eKlCGASt8OfijrkTGiscXmoX8NyAqTFy2x
         t8mxemk7NUQGcOapBDBtIwgX+s7T+aMA7Isp1w44mxKk6ATRf3yvQn0EXwJpxb4wkiRY
         Zeh+pnFgy1Hlpxau2tEjagoxu23SnPstE5T+wd9RiN1dSuAWlyyLZPcBhVsJKNJFHIsh
         9DbTFjdf5ZE3a++HkXY9hQRc6g9tWl6fKc8giGuYZwKs9tOi+OBd7WvS9N7IZ21R0HfL
         M4euvKPWeZeSVeBlExbHJB09fiU6fWabTVlxt4CbIbW7hfxqfjDIA3cmCY9M9abnRu6y
         KcrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew8uPftzd7rZEwyKmHbAQ1uIc01gvs5Er2gSjYfu7W8=;
        b=ZQPu3//USnDgJl1Xo6CX9KyQlz7KoHKV/NAJQpuiGqdFyRFE3got9nDBguJKcED0CX
         gm8pTdHgH6zTfga7T/ZFpLveSbAtox0V4vLlWzb5f89H/USbel+HliAnxoyvdVPgQYr7
         qViJPUsNKqZvKZAyEYJErHWK1i6AFfva9tkw2PRW4R2J0MDEPtdeVdomDLAkYKQFpeyU
         AQyS4ArhG6GTYJsdgIl328E+qmSiS5wd0MBd2dMuBWaH5nWFVHmRYRCT30Sxv5zqcN6b
         cbF6BQSDDKUu6I2Ec6lsMuCyAkExF7HvxNNd6dD4MvJ93ZelhDheQQv+5OqM5SDeSRhM
         nbEw==
X-Gm-Message-State: AOAM532Uk9pWUg3OAJv4hUImOGDdIuh0/ij3hkutGLh1+Vj1aF/aqwkw
        tqisDfuGbqJmO0ln1WRWduRlAtaFJFjFPShKNaPYMQ==
X-Google-Smtp-Source: ABdhPJypfiJBpPKqO5parBohEkYTMjyGzwzAwZxO6TYjuaHX2IfAFD06OB4IGnxO8uyCU9sql8Or1PQuWxYknwgZ2nk=
X-Received: by 2002:a05:6102:5a:: with SMTP id k26mr4959457vsp.52.1599037428764;
 Wed, 02 Sep 2020 02:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200831161147.13515-1-krzk@kernel.org> <20200831161147.13515-2-krzk@kernel.org>
In-Reply-To: <20200831161147.13515-2-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Sep 2020 11:03:12 +0200
Message-ID: <CAPDyKFrwABSPKq9w9Mm=6COsFPuf18MYbuC_KffSgWyMJa+AWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: mmc-pwreq-simple: Accept more than
 one reset GPIO
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 31 Aug 2020 at 18:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> There might be multiple reset GPIOs but dtschema has trouble parsing it
> if there are no maxItems:
>
>   arch/arm/boot/dts/exynos5250-snow.dt.yaml: mmc3_pwrseq: reset-gpios: [[20, 2, 1], [20, 1, 1]] is too long
>     From schema: Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> index 449215444723..8d625f903856 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.yaml
> @@ -20,6 +20,8 @@ properties:
>
>    reset-gpios:
>      minItems: 1
> +    # Put some limit to avoid false warnings
> +    maxItems: 32

Not sure what number to pick. I guess two should be enough, but on the
other hand it doesn't really matter.

>      description:
>        contains a list of GPIO specifiers. The reset GPIOs are asserted
>        at initialization and prior we start the power up procedure of the card.
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
