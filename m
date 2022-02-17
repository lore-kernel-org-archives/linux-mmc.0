Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B69C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 17 Feb 2022 15:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242621AbiBQPkY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 17 Feb 2022 10:40:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242628AbiBQPkT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2022 10:40:19 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA8A2B2E32
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:40:03 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id c10so8935584ljr.9
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2022 07:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKaf8T6bwo43/+sxm31m52Fuq6JfePQe5wLfdK/sZ50=;
        b=KPzAxecZid6LlUo+0wXILBlFXqEIIMlQhrTqEj6z4UqIp9jIQF/gbYiCxGu81gLFpJ
         /pIGlLeDUvdHwupl4nghICsruLArh0hORXmoOtKaH6HpqNuBvjs+4ihA3oAWbqhEwkDd
         T5ThBdpMxq1FEOb1fMDz2mAoWunpfky3vnZyTBNmJjqtuwuMvexR2rTKaztVVD9Y7mFT
         pSkdWAYemi7Dg2p/PAZ6kUQyJizRwmSoZPO3SN8oNgMcOWtjdFb59gSvTJlmKxV3ebyO
         swvV57on6z9k7ex4uQZNZiEhi7wpsexsYfo+YGjAX6eu4VmlQXo9PvDl66YhEpV8QHuQ
         vYWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKaf8T6bwo43/+sxm31m52Fuq6JfePQe5wLfdK/sZ50=;
        b=AeTk6A3JvpYCiISM5VzWCC0GVCBpNI7IUXsLYbgk+GB1obtzUn2WHioxpKuUdthsL1
         0cutlALZolr9GO9tZuUeGiD9H1RdaubGZLnTdt+JsdY46ERVGpsC8NtlNYUzola6lptV
         9RoU5IR1C4uynbAMjEjcaXdlASnOPP5u1g1VFRiFo9yxxOKFWN9p0YCbRERj/gluxIXf
         G2/YbYc9JTpqaL65ObTREDi08AvavWWsT7yUplVGqkuZgOC8z1TpsTg7PsmvNKTgLyEH
         bG29yv47j1NNwxsxWxihs/4Vu5FqRaaAxbpmTkaANucdgYTTfJXNL7jHuUrkdad9aDyy
         /1aw==
X-Gm-Message-State: AOAM530YHJ98RBq6ciQB6SHyid7NjW2hl5dUmK6jlUBmNfAlYNTQoRt3
        YYrJs231UgQQc2a9D3EFh3F77rYcXqqO5oU2y47WsQ==
X-Google-Smtp-Source: ABdhPJy3TfM6nshThKhOgFc73bYv1Dg2ra93FL9Fw7hGDmnU8ExqI9gSmyeqSR0lzf7QncPN+wOHbziKZqL/5WQjZ/s=
X-Received: by 2002:a05:651c:50f:b0:239:3332:2a1e with SMTP id
 o15-20020a05651c050f00b0023933322a1emr2636574ljp.16.1645112401967; Thu, 17
 Feb 2022 07:40:01 -0800 (PST)
MIME-Version: 1.0
References: <20220216134346.11029-1-a-govindraju@ti.com>
In-Reply-To: <20220216134346.11029-1-a-govindraju@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:39:25 +0100
Message-ID: <CAPDyKFqORZ-8aGQvfm8bSVLUzDGK-wWDRr+ABFLpH0q+D92EYg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for
 AM62 SoC
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 16 Feb 2022 at 14:43, Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> Add compatible string for AM62 SoC in device tree binding of AM654
> SDHCI module as the same IP is used.
>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 9fbf16b3bc8d..0566493c4def 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -21,6 +21,7 @@ properties:
>        - const: ti,j721e-sdhci-4bit
>        - const: ti,am64-sdhci-8bit
>        - const: ti,am64-sdhci-4bit
> +      - const: ti,am62-sdhci
>        - items:
>            - const: ti,j7200-sdhci-8bit
>            - const: ti,j721e-sdhci-8bit
> --
> 2.17.1
>
