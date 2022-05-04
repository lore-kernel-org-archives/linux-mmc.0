Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F4C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348271AbiEDKl6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348252AbiEDKlz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:41:55 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026492983C
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id t25so1120596ljd.6
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lD3vvXHAHJs3IRnQAHfphn1E2NtyGe633IfNU2pH9ck=;
        b=QaNg+hrH0pWi1gegQLwIunoR96zQeWK405W/Y0DimAXEprgC6u6tNQyTc1XTqFVU4h
         poyJ1hvGMfkGW4M4zzVcfyyiBE5x7enLur2bhx1BCk1vMfmmunpoJJvu62TgUJYs7EUN
         rNETTUTSN7ekB6AXtT3O4rljzo4wb9v3QUMtEUUaODNLuI7ECb3F49YEvM+74VF7zM3W
         m2cSjEjDZLt6B8o16XYHmC/R5xDBzmcf6Zi47MWoXmAq1hHZUYbz8bh+bRzkTgtz+jjX
         CRGalEFuDBlXelp8sBL1sgXTzlbdfuBK0920R5Qh6l0w7CVfq4DSsVE7n1+PvvcN6ziO
         PGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lD3vvXHAHJs3IRnQAHfphn1E2NtyGe633IfNU2pH9ck=;
        b=o26IaSSp0WgGaeUJmWapUGilamqxx+1OW1U1tAn8Om54YP22anIZ0n9geF5igrt7UW
         QQ4DX1GfJIQ+eZtK/FjQhj/0amk0INK474LwagcAE2MzTpIqmbhxw0/i+VPiaSVbfZ+u
         H4HL43yMg5w05vUFgDKprRwiWbwrgPsIDqSU47rJf7THUC2Gq0+zLH5qrmucVIanjWF8
         fRIkKGZbJ+Biq8llwkIebpBSIOW6m7Q7ANcsTIvV0z5yJrSYn/3QPlLFlsxq4vnCyosP
         GSpoAJGo505AQtTK6cdDKnHy8+g9h+o1bgKVomvpdD1tJEZETJhuYtT+1Miqrn+/y575
         kU5Q==
X-Gm-Message-State: AOAM531UzV1Ra9Nz2sOhC3jO48xpHQ+q/BgEM/Q6G3uuaHiTk64I9aW1
        gcaql5jpJejvbR2V7bxwLsFYYdiDTO/Q9xfHQNHe1UOM8Ik=
X-Google-Smtp-Source: ABdhPJy+kS6AXMWUkmQ6E/kbOxo9lyfYr8OK70af4kdLrlbjvuToWT0sZZJrsSDzfyNmt7IFspcd+yMVuBQcDDWWKHI=
X-Received: by 2002:a05:651c:483:b0:24f:2ae0:61f3 with SMTP id
 s3-20020a05651c048300b0024f2ae061f3mr12397148ljc.229.1651660693223; Wed, 04
 May 2022 03:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:36 +0200
Message-ID: <CAPDyKFrkkif0ABhe0_pZFBpWjMVoXETKZ7GpJUORR94LmbbaGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: correct number
 of reg entries
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 28 Apr 2022 at 10:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The binding should not allow infinite number of 'reg' entries, so add
> strict limit.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index dccd5ad96981..54a0edab5f8c 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -31,7 +31,7 @@ properties:
>            - const: brcm,sdhci-brcmstb
>
>    reg:
> -    minItems: 2
> +    maxItems: 2
>
>    reg-names:
>      items:
> --
> 2.32.0
>
