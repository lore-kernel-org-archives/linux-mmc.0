Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33CEC64EC7
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 12:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232106AbjBNMTP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 07:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbjBNMTO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 07:19:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDECD279BC
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:07 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id gd1so4146398pjb.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uSyTPuLuU1wBaDbWkcoFTMyZUSCsuecKMj0PYuIA5S0=;
        b=UtyFQDh00wwW4KU//WECOJIVyRndF4FW071LndcUwBkhKWW6ETfQGjngKJyH/WLIkO
         HHY3PJL0xDode7S+nxPASS+y+MuAATdqfpNv3VkNNgV/Sxh1gby588iCkO3BJtXnQVsK
         i5Uhg2bvAHkaa5LLYw0up2TgGRQuKydeyZh/ZG9219bxWZOP4Q1FZqJVwlQyktQIV8tB
         hAhV5gu5YkCULjmdugBAyYSyFgjkikIdt85pin/NgfVYeMxxx9ofi9SUCZW9WPXNJup1
         +JeV5ksPQWUKAVej86tjPkY+ahVFKtvScCSpLdzmhMF+FJ9t+XfO/Reg2vsSxkQWq8lb
         hrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSyTPuLuU1wBaDbWkcoFTMyZUSCsuecKMj0PYuIA5S0=;
        b=VM1arMME4nHM+4ua4kgp/DpoCD8cn80uD5zZ76KsoLMwHfgHxUV1Wl4cRxEYnG5yS1
         kKpHFJg410tKgFuLe93WY+RupTGCn+sbIXJ7j+p7vULnunIXWsJiY0GG2RxtlBJOhIDx
         nwLitJL9AKg+LENZKbkS9zM2n4gKknGUXBBjFH8Ggo17Om5m5ZoEAQNAVqnwj/v0BUEj
         T68ottckI44QjItIMWUKnL3KEnDGK56EgPUY/utnQMS+VQb9oMSCHdzYRLM5Tt2LmVa1
         7cdZ6QC2S/8F7ccWUK0Dp3iVY80mlnDFAtK+NaCKtOD68ceE0PNMraEDpju0dIis+t3j
         zZDw==
X-Gm-Message-State: AO0yUKWtA4DjoZz6W1TP4jGzO3uIpSN3/ZtWhrydGBG+z7wk5tN85/X2
        yeDPlwqpc+yz2Wxi2SXB+s5lk7oMw3V88yYzfmazkA==
X-Google-Smtp-Source: AK7set/rppMKL8PmLlE6ZEPS+7aWqreZKZYPF7wXZqHbPA1PNgDb/YZ4rvKhpOEHETPhdtpvcTko9h+d92SGx9X/SuA=
X-Received: by 2002:a17:90a:c710:b0:233:ce0b:5f78 with SMTP id
 o16-20020a17090ac71000b00233ce0b5f78mr2138910pjt.32.1676377147435; Tue, 14
 Feb 2023 04:19:07 -0800 (PST)
MIME-Version: 1.0
References: <20230213045233.32470-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20230213045233.32470-1-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:31 +0100
Message-ID: <CAPDyKFo7LizvRzjbohy9XcL=Nyscj9Dp-VNvUnx94fF409uzZg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Add resets property to cadence SDHCI binding
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Feb 2023 at 05:52, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> Cadence SDHCI controller allows reset control support on UniPhier SoC.
> Add resets property to cadence SDHCI binding.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> Changes since v1:
> - Add Acked-by: line
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index d3dce4d6c168..adacd0535c14 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -29,6 +29,9 @@ properties:
>    clocks:
>      maxItems: 1
>
> +  resets:
> +    maxItems: 1
> +
>    # PHY DLL input delays:
>    # They are used to delay the data valid window, and align the window to
>    # sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
> --
> 2.25.1
>
