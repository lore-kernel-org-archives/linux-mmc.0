Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78050C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 Apr 2022 12:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbiDUMN7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376597AbiDUMN6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2022 08:13:58 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC62ED73
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 05:11:05 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y32so8337404lfa.6
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2022 05:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2qh1sP8uzQryeVgDtsc75uouxg8rbCQSDajPwRRmCQo=;
        b=Z0INWc9lxyV6HU2uh2mPeBqK0yli23uZv/u24ByX5vg6Pu4bhQ7AzrEPCeUdwAodwC
         pC+3TIzpU57+5m5qC3ebKzY93Rycc2+gHYqhtruCTqoWutODQzVzIEOhd2YfqeK6yqIF
         Xu6b4XHkcJ32Hm1srnlpzDf1g2t+aZDF2WSNHDuPjSJZbdfU1LuzRzn0LYl8gaxoraZ/
         gVFgo5J3mpWveMo2GKV02uNZfN3GI7ia3OBZjgXqrR8oRDkqaHkPNZ/XW+zCLqPWsFg9
         Wz/2JXeM+6hz5hvpyqD6hZJqcc7QVRa76tne8gXABci2GCSjRBFoRffN6oTU6BDV/wBP
         dmIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2qh1sP8uzQryeVgDtsc75uouxg8rbCQSDajPwRRmCQo=;
        b=duzW8xWEgFFVfIJhwG+/7mnYOTm62Ya+mx9Et+YkeyCqCSHzVqxKkBMXZqPHXs+9+a
         WLKWIRauRb9qk7Cw4MG0t7m15Bqy4Uv5bilKHCrSMmfU3RO4BAscxdBSNOhmTCrfJVWO
         2FbGhsGJTOsXR05bYL/eITAXOMK6KnFaA+h1fyky4dalt0Lb9XUuKRJo743ywEDD2cTI
         hIYvS49a5ZeU0GMsjYcZbfhsJ3r9pRVkiQ3wzHJ+N30PFzqg9nm+0JnHmfaze5PTwHGh
         etKkBoC+J6VdSPcgKfzj6Dn1iAyWbLslw8VbYpzpMEvUbeFUhNzz98wWimRMdivk7lEo
         luWA==
X-Gm-Message-State: AOAM530qBNDtcaBHbu/sKbwZlbDai9WHoz9MUu2QfYre6X93dFB9vM33
        N8rceuvIU53P9UCmsgvcqQaA6w/8oAeykBkaa9EoPw==
X-Google-Smtp-Source: ABdhPJxiF6HE3qtyySBVgBeLZFZb4229Fdfv3WYeASID+W6jtiE1O7ThlV69sO3NVsaNvqCnkYIoYFyNgU7zcMkUyh0=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr19385452lfr.233.1650543063540; Thu, 21
 Apr 2022 05:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220418102040.4993-1-a-govindraju@ti.com> <20220418102040.4993-2-a-govindraju@ti.com>
In-Reply-To: <20220418102040.4993-2-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 21 Apr 2022 14:10:27 +0200
Message-ID: <CAPDyKFrHi3-7FMfwRP5rtjSbTOnw73FvU5ZAz=eC8-XqQZYpsg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-am654: Add flag to force
 setting to TESTCD bit
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 18 Apr 2022 at 12:21, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> The ARASAN MMC controller on Keystone 3 class of devices needs the SDCD
> line to be connected for proper functioning. Similar to the issue pointed
> out in sdhci-of-arasan.c driver, commit 3794c542641f ("mmc:
> sdhci-of-arasan: Set controller to test mode when no CD bit").
>
> In cases where SDCD line is not connected, driver support has been added to
> force the controller into test mode and set the TESTCD bit. In order to
> implement this quirk the driver uses "ti,fails-without-test-cd" flag from
> the device tree node. Therefore, update the bindings to document the above.

Would you mind rephrasing this a bit. DT bindings is about describing
the HW, not about what the software should do.

Otherwise, this looks good to me.

Kind regards
Uffe

>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 0566493c4def..0ab07759b472 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -186,6 +186,13 @@ properties:
>      description: Clock Delay Buffer Select
>      $ref: "/schemas/types.yaml#/definitions/uint32"
>
> +  ti,fails-without-test-cd:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      When present, indicates that the CD line is not connected
> +      and the controller is required to be forced into Test mode
> +      to set the TESTCD bit.
> +
>  required:
>    - compatible
>    - reg
> --
> 2.17.1
>
