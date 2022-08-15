Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62CBC28B2B
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Aug 2022 18:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233013AbiHOSwB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Aug 2022 14:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238719AbiHOSs5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2022 14:48:57 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B81942AE4
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:28:41 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s199so9428336oie.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Aug 2022 11:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xr6JHD6AFlrXJM6hu6thcV+Az5D3BSvwhjamyNOLK2U=;
        b=ZL6j2aZKnPT9BzOcJXtmGblq+Cr4dfi/Nv9LSagWsbWX1e4NdbYHodjiedJL70lrR9
         IQQap1hMa3NR0CwTrdB1Wf42NhJ/kfhJcATdkjdgjcruyhjVBaHrXyaNcQppJ1Li2kQb
         JE0ye0LdvPw69kByyeqX4ASHgTEnred0IXglQPommePBsHtGhcL4e2s8ro5YPmvxmN3/
         D2V9b+2BA4s5wGQyfKgceRV9sjm3k9MBN1lWTI/q4jk3HNlYxsmutp55rRKkPa51qQ/0
         Uu5yMgpCmDioN8eDLnwDa4mRm5ld+CdNaYNUkjSdAKj2mBs4dEaBNx6p8Akae0KHGEY7
         kgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xr6JHD6AFlrXJM6hu6thcV+Az5D3BSvwhjamyNOLK2U=;
        b=UPEmvDWc5/xnv73ks2AJSWIaak+D6bgHkvJf7XxU929ocYUukzGWGAYEV0oaQMt3eh
         5Bp0KhunY0KQTbssW6/qHENHsS5AxsYEzfI0MfLjXbK6rnAdJVTU1vkWWzEl5Ug+1Qvx
         tmItuDVux4Wz+B/gh8DqJIQh5+seiyc89xD5qWwU0oJGlllz0gkOtFDRM3gby5N5z2YS
         K28Cy2/kuQSn0Gl/h33RjR1MIf1mA1itSchBWfbDmGw6a76MqnwjYzhIAiAVuD2KQpB+
         dYymYhUAasjKkUkZIUw3i4n8L1Bha7LsM14QYNhkbkFmoLLyZhsyw1oHyZAQLqXMn0zR
         9CZg==
X-Gm-Message-State: ACgBeo39notd7tYq9mv/Im94GlX8UUAK3KPSM3HBPoyAZMwNiCHKmDKY
        LE/7Hb6gjbCNUOr//z6tdztoFcHFv2jCyGinjLtj0A==
X-Google-Smtp-Source: AA6agR4v3x1WhnxjKeasF3bXPDPg2zd7s5kes2dQkr2E98b6hUIgSzGyPCj88i2ddzks+sDf7pzB6zRpG9Hi7SrPdxs=
X-Received: by 2002:a05:6808:1c06:b0:33a:9b3b:b3ce with SMTP id
 ch6-20020a0568081c0600b0033a9b3bb3cemr7429087oib.53.1660588120827; Mon, 15
 Aug 2022 11:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727164202.385531-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Aug 2022 20:27:58 +0200
Message-ID: <CAPDyKFoDNkLk_FLuYRSdGVmCK809v8m_R_tLbgTTRP5tfaz08A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: mmc-spi-slot: drop unneeded spi-max-frequency
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 27 Jul 2022 at 18:42, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> spi-max-frequency comes from spi-peripheral-props.yaml.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> index c45b91099325..c0662ce9946d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-spi-slot.yaml
> @@ -23,8 +23,6 @@ properties:
>    reg:
>      maxItems: 1
>
> -  spi-max-frequency: true
> -
>    interrupts:
>      maxItems: 1
>
> --
> 2.34.1
>
