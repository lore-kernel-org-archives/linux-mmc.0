Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B9BCCA47C
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jun 2022 10:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241412AbiFGKoY (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiFGKoT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jun 2022 06:44:19 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB422873F
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jun 2022 03:44:09 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b12so7734954ljq.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jun 2022 03:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bYFD6ZOpXjJqsuy7HbhVsOG9Ou/7QiC6/kt1uj8uGVM=;
        b=bSltXF1fWfX+fOUvFPx7NGF2U404GinR6heDQ9RFgA5S1AIfWYyMsOWYrQUVK3Hwlj
         +YYobxOOaBFTinTehS/K2KTLPxsVEwCsAIXtaXWe2cluA74jEWCrVArRUB0ZEnWkE6Hy
         yspw3em1YfkaWVzJUVLbtb2bJKyIv/CIj+3y6g0jI9nDdXtHnY2f1gFefkaa6W89NYSu
         k0+DYj2xNWWKfwkgpYwFGp4TYCAy1q4065HhDSBHrK0yR0IH/UNdkRO2rzhETKJCkWGH
         Taa8S0D10XNb8EKmoNRqKxfiIbqYXnQ9Ax66Ba63oAQ2VCsbhaVeLkM68G/eyzX8zkQX
         6QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bYFD6ZOpXjJqsuy7HbhVsOG9Ou/7QiC6/kt1uj8uGVM=;
        b=LrBUREroIwfwOCNJf3V02ZI+hQC2r3SGa7rvwg0mxVVze7R6w76DpVyvh2Uow0atXp
         01y0Hy9qYpRvZ7dHW0ZlJtXNkeqEiInKWyZWhQh46uGvDAo7C1HvD99PzUGlJ406It9u
         jizfmKXf/gFCZggL2t5sr4l9KWo7vsHW2ZNR/J7MBXBW2OjkWKdvYdKmPQ7V8Djpwj5V
         pv81LUZCGPwlDn+uTihhhDITICpAk23TiaL56+hNGhJyX42cMKr6rf7nF0iiYG2aAyec
         x7p/I8ABQL8U7owvd6EFqCbtGATuPf5oPtIFuqqgYMURCPCxqOMIccthyXLKdMmI0gRZ
         yuGA==
X-Gm-Message-State: AOAM531kXAfQIGeZNl2Eu9K/MXDTHVPqnGiO/m+WT09rW1C3+pQjwBuJ
        0IFUhD7t9OmT8MzJDO8gV6RcH+CwwmnWRRc1vFNF0BF750M=
X-Google-Smtp-Source: ABdhPJwxfeGq9JYJe9QgtkLt2opFT5Zf0MS8KwZYUe5kYBtOX3KQwJvaFyYra3C0vsdx+B421X5GQZ1Ql3rvGgxEx0A=
X-Received: by 2002:a2e:9e54:0:b0:250:d6c8:c2a6 with SMTP id
 g20-20020a2e9e54000000b00250d6c8c2a6mr55514399ljk.16.1654598648783; Tue, 07
 Jun 2022 03:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220603233300.21789-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20220603233300.21789-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:43:32 +0200
Message-ID: <CAPDyKFqU=J2EbNqsRhg-3T0tF46ivjzOcQ2kCNks=Yv5H9N=Hg@mail.gmail.com>
Subject: Re: [PATCH] mmc: renesas_sdhi: add R-Car Gen4 fallback compatibility string
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 4 Jun 2022 at 01:33, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> For now, Gen4 is treated the same as Gen3. But we still want a seperate
> fallback just in case.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> index 3084b15ae2cb..8f2e6619fa68 100644
> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -268,6 +268,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a77990", .data = &of_r8a77990_compatible, },
>         { .compatible = "renesas,sdhi-r8a77995", .data = &of_rcar_gen3_nohs400_compatible, },
>         { .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
> +       { .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
> --
> 2.35.1
>
