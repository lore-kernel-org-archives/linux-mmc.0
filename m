Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF4EC4321A
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B685B22AAA
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Jan 2021 18:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbhASOtz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 09:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392680AbhASNqB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 08:46:01 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FBAC061798
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:43 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id p20so3791245vsq.7
        for <linux-mmc@vger.kernel.org>; Tue, 19 Jan 2021 05:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZwifCSX45KhsvY2iJTL0WhKEp/VAHjvt7PynTrJUsDk=;
        b=gXiQ9xYsNg2rnEMj13umiSHP/tkUj27IExlmJW/qZx9JksExVXRsHUCGfoxnZWGyJJ
         SKWAYjFK9DPjcoXXlgUEs9WTuRdGa/03tT/483PmfSPDxQJ6dbN225oN1DNdAsKB4uVH
         /k4QpdhAfSSJQD8AYQSXb4pAQ5AY/AttZgTO5QjFveSHjxZ/B5NE8/kqGaMUNJuhjUso
         UVVEF6SGqB27rWUHyjL+go4wPes6yO13Jlix6AX3TxAcQZ1ygsyq8wN3TPS6FHceaYle
         pc4Kou13auHkqOan07St4EEvFaNXTJ0vIIPjfYz00ZFryUzmj1jtISPyqDlyxslZdlVU
         SQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZwifCSX45KhsvY2iJTL0WhKEp/VAHjvt7PynTrJUsDk=;
        b=Z/8bN+lmBYRbZqNuwxz9C9Cx5l09J4r42gPgdWVMSYmIbyB05T2ppm1rz5RkxwAfyx
         IG1R0EGbWxfRVLNsRbcX2xNnsaBb5L+Mud2jy1X202YMj/e4s7t+8KGaAwTWFxSZMQm1
         bq5fgKsS6y3YKFVNbapnLBdy3EyAjrn51IKmjfg9GrrgLWkwde8QNB5yhAKqkoMMdm9C
         S2ckfuHTfv27WWKAeg+qxX/oYXhiu78NQpZGyp3yZxylQ+zC6KZfeKWxGUwS/0Mtix0a
         3SCQ19C1vg73rCuQhWcv/MX5jbTSmfSZqyFHrPZtk+zBkCznpCbYNOdTsUl4BNUusxCI
         ReMw==
X-Gm-Message-State: AOAM530cujlFyaIvjmMFnX0CXVtD0p23P9Cyt0HplKP55boo0AgoPaUX
        NNVC1Rkzmm1AFHJiv0tcO6xAvaRxJmUdX3qkybV6+Q==
X-Google-Smtp-Source: ABdhPJyNZwiCneblhx3D9rnVa5WXxr7vgezCM4SQABvJl8PA3qInPMT4IDEoPvGCeZB1In3tRQZbqkcIIA+453oN+aY=
X-Received: by 2002:a67:f997:: with SMTP id b23mr2484759vsq.34.1611063823059;
 Tue, 19 Jan 2021 05:43:43 -0800 (PST)
MIME-Version: 1.0
References: <20210115193218.5809-1-grygorii.strashko@ti.com>
In-Reply-To: <20210115193218.5809-1-grygorii.strashko@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Jan 2021 14:43:06 +0100
Message-ID: <CAPDyKFp3K7G_36vB5BrMjhLgCD99xi4tL9sHGaunTGm+AqYeNw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: fix compatible for j7200
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Faiz Abbas <faiz_abbas@ti.com>, Nishanth Menon <nm@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Jan 2021 at 20:32, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> On TI J7200 SoC the SDHCI controller compatible defined as
>  "ti,j7200-sdhci-8bit", "ti,j721e-sdhci-8bit"
>  or
>  "ti,j7200-sdhci-4bit", "ti,j721e-sdhci-4bit"
> which causes dtbs_check warnings:
> mmc@4f80000: compatible: ['ti,j7200-sdhci-8bit', 'ti,j721e-sdhci-8bit'] is too long
> mmc@4f80000: compatible: Additional items are not allowed ('ti,j721e-sdhci-8bit' was unexpected)
> mmc@4fb0000: compatible:0: 'ti,j7200-sdhci-4bit' is not one of ['ti,am654-sdhci-5.1', 'ti,j721e-sdhci-8bit',
>  'ti,j721e-sdhci-4bit', 'ti,j7200-sdhci-8bit', 'ti,j721e-sdhci-4bit', 'ti,am64-sdhci-8bit', 'ti,am64-sdhci-4bit']
> mmc@4fb0000: compatible: ['ti,j7200-sdhci-4bit', 'ti,j721e-sdhci-4bit'] is too long
> mmc@4fb0000: compatible: Additional items are not allowed ('ti,j721e-sdhci-4bit' was unexpected)
>
> Fix it by adding missing compatible strings and their combinations.
>
> Fixes: 407d0c2cdd12 ("dt-bindings: mmc: sdhci-am654: Convert sdhci-am654 controller documentation to json schema")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/sdhci-am654.yaml  | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 34e53db29428..3a79e39253d2 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -15,14 +15,19 @@ allOf:
>
>  properties:
>    compatible:
> -    enum:
> -      - ti,am654-sdhci-5.1
> -      - ti,j721e-sdhci-8bit
> -      - ti,j721e-sdhci-4bit
> -      - ti,j7200-sdhci-8bit
> -      - ti,j721e-sdhci-4bit
> -      - ti,am64-sdhci-8bit
> -      - ti,am64-sdhci-4bit
> +    oneOf:
> +      - const: ti,am654-sdhci-5.1
> +      - const: ti,j721e-sdhci-8bit
> +      - const: ti,j721e-sdhci-4bit
> +      - const: ti,j721e-sdhci-4bit
> +      - const: ti,am64-sdhci-8bit
> +      - const: ti,am64-sdhci-4bit
> +      - items:
> +          - const: ti,j7200-sdhci-8bit
> +          - const: ti,j721e-sdhci-8bit
> +      - items:
> +          - const: ti,j7200-sdhci-4bit
> +          - const: ti,j721e-sdhci-4bit
>
>    reg:
>      maxItems: 2
> --
> 2.17.1
>
