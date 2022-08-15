Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EE8C00140
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243319AbiHOSwH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbiHOSvh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 14:51:37 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A382346DA8
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:29:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id p132so9416607oif.9
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kKQFgWHEbY+p2ZFCCe57naXRy0LRcwbgkfnnHiuAaKI=;
        b=dXTeuhXE2fMa8lJrfwZYFIdaVIzgrPygmU0f1QQ0c5f8eDvL0TaRVpZkemuok3gkSV
         cByWuo3hoGYzk92+fWoo8RZAX4Kkx7J5UOerAAZd2iROc3GuDEiDLWwNL/0QcDfJmEd6
         MCkjP9g7ZjL6DmyA3R7NGbIZt7bH/+Z6G67LsDWhqqhRhDYjUj7hDY5gFZBw29oB+Dwr
         IC+bUkyLsAai3ke2ZbDWnyljOK7N7c59WY/CJQWwuHoDNVXdG8Zv8ehjVpG6nqyUY5+g
         M8S/WJTHFFb5qxzxVa5GkHPgKR3IDAELKrBwlF03airGtJYG/xyZxuj5tMZ6NycqnZLk
         8dAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kKQFgWHEbY+p2ZFCCe57naXRy0LRcwbgkfnnHiuAaKI=;
        b=rVvJJS96Iixe/zyR4c5O5xHSKAv3mQEdQfUCT5kALe/wz+5CzK/KT6pcylvIzoBDUS
         R0YZIF5/qubBS19Wg73U3+3j7Tvt38GH6bxGhEv1zMu+9ZMC7FNTGULBsSmVWQXludr7
         WjxRRXLjx0uAJOOak/Tz6EiN0T5Iv0L9zPCt3Fo3qHsmR8rhqxYIqjDJCSJbWN//VMhx
         o6qaeqxxKKWJtIEtnouDxeIIUM5DoM1Z6yfhP9vGBgyVUGA/vc9BODR324sWUWsAnVrV
         jxLhPMZASOteJc41/DFYWq/HsGduTPcR6f8yye7EzWE47TweIMjlo1CP3ARFWjOBivMT
         LScA==
X-Gm-Message-State: ACgBeo1PEnhMSLZgUXZlGxYU1ap3VT/4dM7XmUr4p1oIygE7YTtlhdXS
        Q2xbBSiZBdjKL/xPEfX+7HrGcv3HgHkAee9zQ6z8vw==
X-Google-Smtp-Source: AA6agR6mHgLUwhhSGDDVkPAeBPIKfkAX3M0vhyj+SC2VMmz19Px/LCYhJDzW/ocV6X5KfhKTBwhnrixkhl4hvuHusSw=
X-Received: by 2002:aca:5e89:0:b0:344:80ab:1351 with SMTP id
 s131-20020aca5e89000000b0034480ab1351mr4591083oib.105.1660588165502; Mon, 15
 Aug 2022 11:29:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220811204024.182453-1-mail@conchuod.ie>
In-Reply-To: <20220811204024.182453-1-mail@conchuod.ie>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:28:28 +0200
Message-ID: <CAPDyKFrefLiR=QtuRuCdXgo1Y=vuwF6ok=kVK0hYgzVtaGHrSQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: cdns: remove Piotr Sroka as a maintainer
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 11 Aug 2022 at 22:41, Conor Dooley <mail@conchuod.ie> wrote:
>
> From: Conor Dooley <conor.dooley@microchip.com>
>
> Mails to Piotr bounce with a :550 5.1.1 User Unknown and the last
> mention of him on lore is the orphaning of Cadence NFC drivers.
> Remove him from the binding too.
>
> Link: https://lore.kernel.org/all/20200510122430.19105-1-miquel.raynal@bootlin.com/

This link doesn't work, so I decided to simply drop it.

> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index 99f89eb19356..7124e77617c9 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -8,7 +8,6 @@ title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
>
>  maintainers:
>    - Masahiro Yamada <yamada.masahiro@socionext.com>
> -  - Piotr Sroka <piotrs@cadence.com>
>
>  allOf:
>    - $ref: mmc-controller.yaml
> --
> 2.37.1
>
