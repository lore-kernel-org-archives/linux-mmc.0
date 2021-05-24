Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F575C04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE2E610CE
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbhEXONn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbhEXONe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:13:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D19C06138B
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:12:05 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b26so24814020lfq.4
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EqzKZy8iG5YtODeoQ+7arxZWeDSaRjeQIJ9lF+wQUvM=;
        b=mceq3hTDdifAJiqp7ulPjiCJ3NEgeMnoBdVCNB9C7MFH36BifBM8EsuhWPsqrv2pus
         de/9fBoSLzgB1hBeDCZK/eQGGsY6G6mx5a09cAnG5je608TnYffFYCGw/733trTGJYGT
         wVRzdDUViH96KyDBLHT8Z/S35/uZ7T4IlauGZeYjXw81oPiv4UkuOCAbkQXAHL8MAnBh
         /4X3ziVwd14FomNlrrXUXkx5PNPcsGxI/STW2Nx3yWxG4ZQ9KFOASEyPOr2hN4N0GxXk
         EK5H8QwSQxixy1DNJtQWThxVRBcuv901Xj8abXpnsbJtxPSYxKftHPKJXVuS5OAnOA4B
         cABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EqzKZy8iG5YtODeoQ+7arxZWeDSaRjeQIJ9lF+wQUvM=;
        b=l7gCuJxbyYrnfoVB3ZPMTNtLQLPtl8XZa3QXWLo1RoH7hXVEcLBONF5zB6dsTqWQXf
         g4Ru4Jp2yOZRTkzYumAn8UU+5x3kPHmcmXZt1zM5OeTZvzmjFe8/ne96XoQxFueQk2mG
         2Y8kFMlAOBYLviZG9gFHYFB5MT8jNrleF6cQjdbd06j3etTWijQC2afWiDh/CntZV6ej
         rfCK3H+Nt3+mUh4luXlS6fjjrvuS6XRSF1WPVyA8hUQJcH92URo8qhsbvIUt/dJsjVrp
         JxF7UeC+LjjsQDfmefwTp3aZ1sDP9TA7Wk9zi7MD5iuz8myx2opE49d1OZZXxPHAK3gF
         pifg==
X-Gm-Message-State: AOAM532fOMXw6QZzEcTDn9JeWtqgUCmIZKaTdJ5sRxLYV1kPcGvAVGh1
        xNAZj7EK54544UGMzF9jLHj8pLNwJVNT4W1AvsBdag==
X-Google-Smtp-Source: ABdhPJxPgWa+XQ/7Yg9tLBVcQQ7nzCQ0v/2otc+UDqjvNgiP2uxY0CceWIfPJOWFC9pJWYvoJbCIy35NX/VyVkYlof8=
X-Received: by 2002:a19:c511:: with SMTP id w17mr11003208lfe.113.1621865523890;
 Mon, 24 May 2021 07:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210516230551.12469-1-afaerber@suse.de> <20210516230551.12469-7-afaerber@suse.de>
In-Reply-To: <20210516230551.12469-7-afaerber@suse.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:30 +0200
Message-ID: <CAPDyKFpfL8uSK5Vk-=FjN+D0Sz3TWn28kWjF0g8cmftu_moZfg@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: mmc: rockchip-dw-mshc: Add Rockchip RK1808
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 May 2021 at 01:06, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>
> Add a compatible string for Rockchip RK1808 SoC.
>
> Signed-off-by: Andreas F=C3=A4rber <afaerber@suse.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml =
b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index eaa3b0ef24f6..54fb59820d2b 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -30,6 +30,7 @@ properties:
>        - items:
>            - enum:
>                - rockchip,px30-dw-mshc
> +              - rockchip,rk1808-dw-mshc
>                - rockchip,rk3036-dw-mshc
>                - rockchip,rk3228-dw-mshc
>                - rockchip,rk3308-dw-mshc
> --
> 2.31.1
>
