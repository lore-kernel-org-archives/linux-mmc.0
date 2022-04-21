Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1763C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 13:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388151AbiDUN6M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 09:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387047AbiDUN6M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 09:58:12 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BE32E094
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:20 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id n17so5842737ljc.11
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0K5sa4UCW+AAk8i4/ssQSDWQtlDxhnoOfuuhPz50cEY=;
        b=jGxPAuP4XxEcbpP5UQiKSIXfu1FSfEmNm582+CatDKdMYg6j5lpR1+a78whkdNttjP
         sAbHbXu9KSFSGXYjPudc54+LySEdPjw/trgs9d6JIF4TNUmtaFa4eTURMugA4K9+lUgV
         m8T9AAZ+2HuqO2HehsMjmVTlmBc0QJG4wx/vZ9qpv6t4hz8AM0Zcrj43tMH+oI8ntl3o
         DfVNQx07ST+rV77ru3sLky5iwzKbl+ur+VOnG8M2H9Rx0CRKYiAOguwq3NxjhJQEK11u
         PM5V/L6ixUoabkzioVbGJiu2nMdVCFXvo/0Yi/Ccwbq2TwHF+88QfhDEUFDOrbmd4+vM
         PEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0K5sa4UCW+AAk8i4/ssQSDWQtlDxhnoOfuuhPz50cEY=;
        b=VIVFkvq8kysJ0EFYI2hZFIGa5RvTyq4MeoEdPp+63N3fQZHn0x8q7MEkagfFoN/m0u
         RZDDBYJYE3ctW0LT0U0QyK25eNJTNox85rFQlKt+wASuaz8r2QooxxVeAhC2qTIJeZnj
         KptkwdplU6tHXM0AvjjDeduZggoNmJQ2FK1DqxVHJe2A7up7x5BW+Q9txSZs57sAh9vm
         mKIHWR2X2c099P05PPCoMfJgQWkkwaBj8FXJ3liu2S/3ZHGKgVm8HQf6dDoHuKNq32QF
         2H2SwvVPYU4KC8udwUKFKf5BCuvAXG9netZ6IUSy7AEsTEnarQtswSFdIVw6DcIeNEZ0
         VTrg==
X-Gm-Message-State: AOAM530Cz5xtGjTpeAGWyiq0Au10+AtGyhgCsSS1MMNnRDtkkKEreqND
        QUze6Ey6T5gGwzVhBsRMXvtuldjHL2P7fGrrv4yR9w==
X-Google-Smtp-Source: ABdhPJw9+pH0JKX02raXdY3bFsTuK+Pi7yhGUW9FyrJtFC00/H/UBtSWuEUhk9cSRloTjSSG+8BIiRLJSajSNoBWl4E=
X-Received: by 2002:a2e:8199:0:b0:24d:c3cc:ff45 with SMTP id
 e25-20020a2e8199000000b0024dc3ccff45mr9937023ljg.229.1650549319281; Thu, 21
 Apr 2022 06:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220417144223.649201-1-linus.walleij@linaro.org>
In-Reply-To: <20220417144223.649201-1-linus.walleij@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 15:54:43 +0200
Message-ID: <CAPDyKFotPog=aez576hFeFWjy52GB14PvsS+772DWpim1jB1uQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Add small binding node on level shifters
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 17 Apr 2022 at 16:44, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> The VQMMC is often provided by a level shifter, so drop a small note
> in the bindings that this can be the case and how that is done.
> It is helpful information since this is pretty common.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 513f3c8758aa..ff5ce89e5111 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -298,7 +298,10 @@ properties:
>
>    vqmmc-supply:
>      description:
> -      Supply for the bus IO line power
> +      Supply for the bus IO line power, such as a level shifter.
> +      If the level shifter is controlled by a GPIO line, this shall
> +      be modeled as a "regulator-fixed" with a GPIO line for
> +      switching the level shifter on/off.
>
>    mmc-pwrseq:
>      $ref: /schemas/types.yaml#/definitions/phandle
> --
> 2.35.1
>
