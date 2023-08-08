Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E2FC04A6A
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Aug 2023 17:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjHHRzs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjHHRz1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Aug 2023 13:55:27 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E94B298A4
        for <linux-mmc@vger.kernel.org>; Tue,  8 Aug 2023 09:25:01 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-76754b9eac0so451844085a.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Aug 2023 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511888; x=1692116688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YwNCnLA4BDgyiFzQID8GItNEy8vbOZgDk2M81TSduC8=;
        b=NGFYmKzHV4pG1RPpaKcEa8KG118YQji+Acrhl1oA8lOzmP6S3g4tWoErjiakk3PRNJ
         bf75v/j3El1Lt/WX/KZmK1IX+1DoQud4Om6j7Jbc8rqJjRGejWIUWuVAdJXG4Lqd++gV
         KmRN20dFjjOhjrGVU45+vDQKMxOw8nPF6l0JMrinfaXJRKM473Skn0hgFxW939i7cpXz
         a0pMLPxNnOonWRyl9+iQS34YDvAFWm5K8lVOT2FkAZGxAhFwlv6BG249QifKvLM6ZG5k
         9OWoPe+Zrn1WkFA5AGkn7ZSowdZ4wKqmwd3aPl1KQ6SlIUKG5hdXg2kDLp4Xcgp/twij
         egKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511888; x=1692116688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwNCnLA4BDgyiFzQID8GItNEy8vbOZgDk2M81TSduC8=;
        b=NZYFUGd0GBpecHG9W170b6zt7qSbmzyItdQZ/WsJYnWB60Bg3CAP54o3nv3m1/PHcR
         5uvi0jByHUqDwap0fzoLsI9e6OlZu+c+2bOwvZbmIkLQDAYKQtmw2N9dilNXHGmD97dx
         n6DpLI9OUnKatb3ohzs7ujI31vIcnGWLDyJnnRmpAOH20V6jmr8pNuw8ywYJRW19nWqR
         LYwPs2IKEH4SlpLjViJI1YvRESjv3c5mFf6KE7Uj77TI22g5lVp8xLxWri3w+k23iuP8
         aBoXNZMJnw3BzMDlVg27Qpua1qJNhPM3q1/t8JJ5IPL3jFuBKq9630Q2xhrOz5zeOxqE
         hmmQ==
X-Gm-Message-State: AOJu0YzSsmzJWsa9J/U8NvxT5BtNKuGMRYVaH5zWRJ/14dw9OVPIO6OT
        9YSQoasYYOwSm/JS85aEBo8iPKsuF8Ogn4TDcAvJ6KkAFfckeqXJ
X-Google-Smtp-Source: AGHT+IG9EEqlXpXWekaLAYR4RRWGuO58HRpkGWaCiIehSEMsiNiSZuyy3X4+ishH9SYGOyW6zxa/y5LIsjM1cUS7rOQ=
X-Received: by 2002:a25:24b:0:b0:d4d:b6de:69bd with SMTP id
 72-20020a25024b000000b00d4db6de69bdmr7351002ybc.23.1691484651033; Tue, 08 Aug
 2023 01:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230728102616.266235-1-varshini.rajendran@microchip.com>
In-Reply-To: <20230728102616.266235-1-varshini.rajendran@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Aug 2023 10:50:14 +0200
Message-ID: <CAPDyKFoeLar9SRiq_dusmo0ZQGoeqKygi0Y3HOPQ8FO+BaaCTw@mail.gmail.com>
Subject: Re: [PATCH v3 19/50] dt-bindings: sdhci-of-at91: add microchip,sam9x7-sdhci
To:     Varshini Rajendran <varshini.rajendran@microchip.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Jul 2023 at 12:26, Varshini Rajendran
<varshini.rajendran@microchip.com> wrote:
>
> Add microchip,sam9x7-sdhci to DT bindings documentation.
>
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>

Applied for next, thanks!

Next time, please convert to yaml before changing the bindings.

Kind regards
Ulf Hansson

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-atmel.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> index 69edfd4d3922..a9fb0a91245f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
> @@ -5,11 +5,13 @@ Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
>  sdhci-of-at91 driver.
>
>  Required properties:
> -- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci".
> +- compatible:          Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci"
> +                       or "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci".
>  - clocks:              Phandlers to the clocks.
>  - clock-names:         Must be "hclock", "multclk", "baseclk" for
>                         "atmel,sama5d2-sdhci".
>                         Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
> +                       Must be "hclock", "multclk" for "microchip,sam9x7-sdhci".
>
>  Optional properties:
>  - assigned-clocks:     The same with "multclk".
> --
> 2.25.1
>
