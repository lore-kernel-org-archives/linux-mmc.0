Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A812C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 09:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC5B61107
	for <linux-mmc@archiver.kernel.org>; Thu, 11 Nov 2021 09:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhKKJvw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 11 Nov 2021 04:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhKKJvw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Nov 2021 04:51:52 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27BC061767
        for <linux-mmc@vger.kernel.org>; Thu, 11 Nov 2021 01:49:02 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y26so12782002lfa.11
        for <linux-mmc@vger.kernel.org>; Thu, 11 Nov 2021 01:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+qxxRiUlYzV6NJy/w1aZA2zpC3Ejr9rcijb9xcejxtU=;
        b=fwabXdPxk33LTkpstTyhO/jeEyZ5v6A0mqZq1+yy8KikYSiyjm/0DHwedOLmaAHjv1
         5XnLqQ9QuTFJhBK6VRgdEQWnizoBvM28QQx0nzfsqZ0ZbSEzTtkO3mm1Rlv2fZWH6bk8
         ySNCyF26/3vbRMfvtienYmjhtKkPzuWCzJLrqpaHJH1jb8AtAY8ahGxYzzvKdT1dvspM
         5qxHHDpRVfVRBwEY2WoIFZ2ZFZHLTWDvVUFKuTa330N/i3ea4AmSPa5kn/1a08fq24r8
         6sEnq+4mcqXF8g4Ivw0giJXLpsIuTbFp+/85cy+lb+TOO+YZyjg4b+UaZ7WL98sk6qvV
         SZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+qxxRiUlYzV6NJy/w1aZA2zpC3Ejr9rcijb9xcejxtU=;
        b=uVu2hbolL9dwXnUZq4CIAV8l5gtn8hKfEUu9E5lzd5bs7kex5XOzmj2m79gZ9kejN3
         aofjeCTYzcW/r7YSLUlVU1fVXho1SQxBaMOfhjsuNEHYVbn67je7R01go0Ad0o26mqqb
         ciHaCRTLN/i5+4oAd+MmMj7B/b62bWRXCczgVPNwmBBfx7+Wc9XxUE9HYh12JvbdtD8P
         jCTfkkvAEufNyj3u2GW2flZqEcWlW/0zcMjpcTiUWLLaasbC712nHdHXMZwlCULvUTZo
         GUzeMJ9tO97WtDxlKxlVYXMAQN9sv8p+rtl7SMU34GfgLF+4QcWD2gTtwuUOktXyLnHt
         2Gjw==
X-Gm-Message-State: AOAM531n2Aeyf+AcSPny1vG9deOYunYJBi0Onny9bPCfWMegvnUKHrA0
        RGkEYbDMaAwQrhPZBsivC4NgqR3NsoD3vBNua7dOdQ==
X-Google-Smtp-Source: ABdhPJxlRFNKTi8iBaQmWxFjFmrG8Zxa9Hr3CI86dasWfmOW1cNhzLyoiKvcw5egKVy9Q/996Czu9iuLL3HWjhZTwN0=
X-Received: by 2002:a19:ad4d:: with SMTP id s13mr5456304lfd.373.1636624141233;
 Thu, 11 Nov 2021 01:49:01 -0800 (PST)
MIME-Version: 1.0
References: <20211110191610.5664-1-wsa+renesas@sang-engineering.com> <20211110191610.5664-8-wsa+renesas@sang-engineering.com>
In-Reply-To: <20211110191610.5664-8-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Nov 2021 10:48:25 +0100
Message-ID: <CAPDyKFpwYK9kyF0Q_TP0zpgNRPgcsYTXB9CDFyO+F4shO_qBOQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 07/21] dt-bindings: mmc: renesas,sdhi: add optional
 SDnH clock
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 10 Nov 2021 at 20:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe



> ---
> Changes since RFC v1:
> * use 'oneOf' for the clock-names
>
>  .../devicetree/bindings/mmc/renesas,sdhi.yaml    | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> index 9f1e7092cf44..190a58ae77b5 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> +++ b/Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml
> @@ -132,12 +132,20 @@ allOf:
>        properties:
>          clocks:
>            minItems: 1
> -          maxItems: 2
> +          maxItems: 3
>          clock-names:
> -          minItems: 1
> -          items:
> +          oneOf:
>              - const: core
> -            - const: cd
> +            - items:
> +                - const: core
> +                - const: cd
> +            - items:
> +                - const: core
> +                - const: clkh
> +            - items:
> +                - const: core
> +                - const: clkh
> +                - const: cd
>
>    - if:
>        properties:
> --
> 2.30.2
>
