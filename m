Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99602C4332F
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Dec 2022 21:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiLHVNR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiLHVNQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2022 16:13:16 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F336FF02
        for <linux-mmc@vger.kernel.org>; Thu,  8 Dec 2022 13:13:16 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3cbdd6c00adso28750857b3.11
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2022 13:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=soc6B9tEjBwoJB9lGsc2dEEhtgB2qWgmXeK3gpYqXsY=;
        b=q+PuMpZRFA+cdjBHh866YIQm0c38cAAl/UjxGeBl4OmlT+HR/AO+EDP8w4H3iDQOFI
         1bxoP7XR9Ix+xAhNsUpJ2ej06FGmLP5BcP0ggE/yH/flcVuMqLBU+925vO/g1sYzTdV9
         q1NSsNNa8is0K8ysC4+q66x2XisApu+g8UScZXUvdRSyVoCOmWHtUqwnrSHoHN8F68ul
         AzQdVMgjzmVb1eCPNpyfaSCZ+9ADJsQfncLoRQBjW9e+K7J87GeDFN18ez3MptEGiE8o
         YKKP2k2opNXGpT5UuXFwSolkjTLZWpO8KyDWptpK+Zua9RmvfVWWSisqnhvXwewo+7Cu
         JCRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soc6B9tEjBwoJB9lGsc2dEEhtgB2qWgmXeK3gpYqXsY=;
        b=y4qdA6vAu6uRUAIzSql7D+kgzG8Zbyudd5M5mFehEfl9S3mW8pK8UP3pwSf5XK/hxH
         ZsaieWW3ugRnsfUzDuJoUA3VU4iFlibE64MC9ijtgJB/yCfldwCMh0ATcUssQfdXWqfX
         9PVxsxIcN67xpIZaD1yXzbyq/7ct9FJAVawTsHx+M8Hu2/XQ8yb/T6g0VAPhA5hCIVS/
         2o3nSWVY+tZnwnYbv+1PTsQT2+7pFrsAvsN7N2Zhn57dAFJHlV2Rg8zmVIxi9WyvBQF8
         xw/cT55MM7dKwO3t3cRq1Vw7p2hXhm61ASaNb1xpkhhmMrD+pnHZL7tCC4GaYOFwdYwL
         XDAQ==
X-Gm-Message-State: ANoB5pn8WB5kfloQrm67hTt8T8iH8F0NpAp+RbhRSmeYXWT1rouCDcf+
        KFQ/F9H7kaXLULE0uSa6fFzHO3aZYpzAkyg+/MAHs0KxDP72cg==
X-Google-Smtp-Source: AA0mqf5WRT4mHXfrsSBEeehzvRcsxHd7WGu3PF+0jUl9JAFmRJN5HORADxjGm1ZP1O59O1iaDIHHBzdX0L7xnrO4NGE=
X-Received: by 2002:a81:7853:0:b0:392:b19b:47e9 with SMTP id
 t80-20020a817853000000b00392b19b47e9mr9758426ywc.252.1670533995276; Thu, 08
 Dec 2022 13:13:15 -0800 (PST)
MIME-Version: 1.0
References: <20221207131731.1291517-1-william.qiu@starfivetech.com> <20221207131731.1291517-2-william.qiu@starfivetech.com>
In-Reply-To: <20221207131731.1291517-2-william.qiu@starfivetech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Dec 2022 22:13:04 +0100
Message-ID: <CACRpkdY6364RtQMgGAFA024Pb-9v6+xcTUJdH+-MvzooBGYnhw@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: mmc: Add bindings for StarFive
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi William,

thanks for your patch!

On Wed, Dec 7, 2022 at 2:17 PM William Qiu <william.qiu@starfivetech.com> wrote:

> Add documentation to describe StarFive
> designware mobile storage host controller driver.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>

(...)

> +  starfive,sys-syscon:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      The desired number of times that the host execute tuning when needed.

This is not consistent with the use in the code of the attached driver.
There it is a phandle, and it has three cells, which I am critical of.
Also this description is hard to understand.

> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts

I don't think the syscon phandle is optional.

> +    #include <dt-bindings/clock/starfive-jh7110.h>
> +    #include <dt-bindings/reset/starfive-jh7110.h>
> +    mmc@16010000 {
> +            compatible = "starfive,jh7110-sdio";
> +            reg = <0x16010000 0x10000>;

No syscon phandle in the example: this needs to be added.

Yours,
Linus Walleij
