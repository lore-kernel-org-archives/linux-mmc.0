Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A2AC433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 21 Dec 2021 13:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238043AbhLUND2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 21 Dec 2021 08:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238040AbhLUND1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Dec 2021 08:03:27 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7349C061401
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:26 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id p8so21297351ljo.5
        for <linux-mmc@vger.kernel.org>; Tue, 21 Dec 2021 05:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BklsEzYOKN5NzN+jKf42upOseZFcIPymlb6DwRKDDYM=;
        b=tAm0b7OdnZ+KqS8rwrJsomM8RedG+2bL7ofKXwJCPK9fXLaQSsdZHl015C4qDo5Xzt
         l5FHhW20LHhpchFvnBdgkQCtJRf/zuJeHxgwJp9RMRurlVCz3j3u+4xOR8wBzU+5uL7w
         Brsn13Cr/PjCWgB+MkNcFCMhdVzC+/EdJKxcAyt0klMrxQ191irjl1V8A0SLr2Rj2wXF
         mRCJa5L2UjS1fEgutUhDCeRf6bqiiTenjwgPxxVulAJ10wIpuohYI00K9YDZT/uINgUc
         8fY5FKRuce+jjEfI63pM0fU/TkD4qGfHpUb1iASYtILZFJ0ghTmSOzm7rv9MRIngGYMo
         SzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BklsEzYOKN5NzN+jKf42upOseZFcIPymlb6DwRKDDYM=;
        b=WC5Dk7f0pec6tV9ibhjK4MrAmVfEDiGlU1bZBPvVRYrXqKzGCXf9iCoh2LFrtRnIQC
         4N8WTFMsCnVPouEg+SMjvS1YlnC8YjO5Mx6Zs1EHt810yRmGLkG0oq1FsJobBr/A/blH
         a9rszBdK1wcb2IQ9eVjEBNj7ZMhMv2YRoJg04RrDd4VZxiuoy1SInRe9/rNxl4vtQ0iR
         NYfyQ/xdp2s9x0RuCyffvcV/twkRdgqfSCy3l9923cS74DUk9fUK9OqUSmvHfHEBBokF
         6lTumMx3Lcf/XQGQ726Q8npH/EpoQhlvCL7bap7sCkGzBLZMo4SaIG2TOWzlSNaVjjDX
         x6AA==
X-Gm-Message-State: AOAM533ORoyamkGzOI2EF0cSfjDFNmAM11eICjJuSihwozcLBSquOL9Y
        fyz3TcmhBpHYWEZrZDdFcGy89uPfkVn/Pd6mPGQTiw==
X-Google-Smtp-Source: ABdhPJyjzfFymKYCSVirNcz8GGdi6nI9/nsK/j+LZj4hEfP98GWY52IBMfalhcQ3xiRVY4rOQW8XpeOTfjSURLAw9SQ=
X-Received: by 2002:a05:651c:10b1:: with SMTP id k17mr2419272ljn.463.1640091804957;
 Tue, 21 Dec 2021 05:03:24 -0800 (PST)
MIME-Version: 1.0
References: <20211210091834.28958-1-yann.gautier@foss.st.com>
In-Reply-To: <20211210091834.28958-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:46 +0100
Message-ID: <CAPDyKFqr1fx8hvqvdettPyUYtdVEN+9d1m7908Y-j9GjXzPXJg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmci: add st,stm32-sdmmc2 compatible
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.pallardy@foss.st.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 10 Dec 2021 at 10:19, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> Although this compatible is not used in kernel, as we use the common
> MMCI driver, it is used by bootloaders. The U-Boot driver was merged
> before the kernel driver and uses this compatible.
> To avoid issues when aligning device tree files between kernel and
> boot loader, the ST dedicated compatible is added to bindings file.
>
> Signed-off-by: Yann Gautier <yann.gautier@foss.st.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 47595cb483be..eed54bee7665 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -53,6 +53,12 @@ properties:
>          items:
>            - const: arm,pl18x
>            - const: arm,primecell
> +      - description: Entry for STMicroelectronics variant of PL18x.
> +          This dedicated compatible is used by bootloaders.
> +        items:
> +          - const: st,stm32-sdmmc2
> +          - const: arm,pl18x
> +          - const: arm,primecell
>
>    clocks:
>      description: One or two clocks, the "apb_pclk" and the "MCLK"
> --
> 2.17.1
>
