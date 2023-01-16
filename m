Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F11C54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 12:17:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjAPMRy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:17:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbjAPMRa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 07:17:30 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCE61F4A2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:19 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y5so20808795pfe.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=niLw8CrFfbtqWSwYWAs/NSWK6EA7i4usYpPbKEoqMyA=;
        b=q6uTMPVzD/khb/6i8b46Suojs9oTXx6lzQhLZngzPhAi9JP06r0emP+CCfZSsJPd+F
         9wce9fEgGtZgafYsFKXVayUYG6vEIrMLvIszh38bTYKLZY44FM3OGptNIhW3735z3j9j
         tIj16RXbMEuPyLh9455tmWQ2iTtIehhf8LIe/o2iaYIHYwbHpm5aWeIZRK2Shrl5+2Y9
         2UQAjd6qtAz0UEHPi3EXsNKKl8idON8t48sCHrP5+6gR474dVEenUzQn8Ef/s7BjNX1g
         LskSdkmuKcZGXvz5JrNmjPbb59amnAQzz0UqLilKPDtn0sNacqXKSLmz5OzW4XW5picB
         M0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niLw8CrFfbtqWSwYWAs/NSWK6EA7i4usYpPbKEoqMyA=;
        b=w2vRjdzxVeu2D8eRHF26kJobR+Qh0Gbu/BwUW8xfpqzfvWP9cUOVNdxhWxpnROkSdN
         934hvCQs+DUYs3fH+6UdHYWAbwo9x+BJQNhXJ0ztROIGM76/x36EzxA0CFdkEjbqREsQ
         zF1C0z39b5lkFnTdlQ4Zx6jg6lY+MOMgnRnrpZB6rxAghR+Kn35PZhDCXZ2Q5T60Ke4F
         S0GUCZXgUESwzeLdMcczA28RgsH6wNwkP22PCakBD9ezTMsu26G01nAnskEUmW/Ut38V
         FZuuj5u0get9QUNWTybIwKJdJpfLKY17gOzxwdDC/XAcRnqglUaIbmAKu62DMHfF+slX
         2NCQ==
X-Gm-Message-State: AFqh2kquwAcFK6iKm66pf/xgee6hqYOPPEpsJ5xfgOgF8mPv8H1x9xev
        ipNwqgo0YTkNNwEyCXb3RKsq5U3Wm1gWRB59YK2joA==
X-Google-Smtp-Source: AMrXdXulMG3/bVkeZEmcmYD/O8CnTyqzGEwQOU+28y4QK3hbV9OyLKDL2DAGiE9JNvgSHQLwfbpFDSlDnpYmJ/yceUU=
X-Received: by 2002:a63:454a:0:b0:4ac:d8f8:91e6 with SMTP id
 u10-20020a63454a000000b004acd8f891e6mr2233211pgk.541.1673871438709; Mon, 16
 Jan 2023 04:17:18 -0800 (PST)
MIME-Version: 1.0
References: <054c9f4dbb0bb1525f780d1e85c724436465c20c.1673270716.git.geert+renesas@glider.be>
In-Reply-To: <054c9f4dbb0bb1525f780d1e85c724436465c20c.1673270716.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:42 +0100
Message-ID: <CAPDyKFqVi=h8aBTp4KjNLS7PAbRSLfHpnyf9_=a6Szd1PfEtdA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: renesas,sdhi: Fix RZ/V2M clock description
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 9 Jan 2023 at 14:26, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> The SD Card/MMC interface on the Renesas RZ/V2M SoC uses 4 clocks, like
> on RZ/G2L SoCs.
>
> The current description specifies 3 clocks, like on R-Car Gen3, which
> will lead to "make dtbs_check" failures:
>
>     arch/arm64/boot/dts/renesas/r9a09g011-v2mevk2.dtb: mmc@85000000: clocks: [[3, 1, 18], [3, 1, 20], [3, 1, 19], [3, 1, 17]] is too long
>             From schema: Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
>
> Fixes: c8dbdf2a1044951b ("dt-bindings: mmc: renesas,sdhi: Document RZ/V2M support")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 4357736074898ff3..fa089cbb155bd0fb 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -122,6 +122,7 @@ allOf:
>                - renesas,sdhi-r9a07g043
>                - renesas,sdhi-r9a07g044
>                - renesas,sdhi-r9a07g054
> +              - renesas,sdhi-r9a09g011
>      then:
>        properties:
>          clocks:
> --
> 2.34.1
>
