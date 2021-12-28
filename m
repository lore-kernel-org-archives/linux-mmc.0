Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33102C433F5
	for <linux-mmc@archiver.kernel.org>; Tue, 28 Dec 2021 16:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236485AbhL1Q6j (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 28 Dec 2021 11:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236480AbhL1Q6i (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Dec 2021 11:58:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F08C06173E
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:38 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id u13so42510441lff.12
        for <linux-mmc@vger.kernel.org>; Tue, 28 Dec 2021 08:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0D9r3mLul2ar0LgSD8/IOjG0KAPGEOa0MFXsHroSmNg=;
        b=ZCuITCD/gPzPwsyI3gqJYzgJY61ybSgT4GMKhF9nwtrktez1pRqLMyRdS+i/wdIFZ6
         9CLvaDzynrc7uCuAS/jtlZTMfEYYKwo6lAsJFhJaqsNmPdC9H20LyEU+WjOyNSLJ0Rjj
         6FNl3MGSIIOnMjjyp3+Y4r54wCmTVVg/HrA5uRdkcdhpM1P4ZepwnYbpGGdk6G5SkYUk
         123sEaRm6t7ZJIkOW/KtDc3GSQKnqRXsxrDSkAND71dthGiybUnSv1wPXkeldJxtWpl+
         EL/Dp5Rv4LvjLhwGDBXsguoVfWFsPERcdBf8R2S74OFLQ1H2Sdx2xf42dd1EaNClEp30
         P8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0D9r3mLul2ar0LgSD8/IOjG0KAPGEOa0MFXsHroSmNg=;
        b=mUTUEGhq9fZ94s7wM8nNR77B/3ZyApDtf4b/46qNvDVB3Ni6W8/TsLfdXC3BEBMXMy
         9+kQrS6NQwuBZK/yCTBR5GXCtJid6CNTGomDbYNEAyeS+GueFNjMtOYo+8jmy+ppGag9
         Qmx3WHY0TB1hMkcS3kcJPxWx9jLFvzhCvDdCxb4YP9YZv+JRZVlb3cynFMLiElRWe8mH
         Mz+L56ofr0FYJXEHkCpbaWiIa4tO/zpnzlU1BAVvFrmxoQEAIqOGxNM5IsS+NnyKIbW9
         ohNFUIeTMQDBi1T6D5WZ10F6EWpoig9v0Zc8VPqPenITcIgYc33g3M5j35v3PcJ6lwSi
         K4sQ==
X-Gm-Message-State: AOAM533/0osKs17a3kvRWpbMbdKQ2OlVsFurA/VBGN3GP1n3o2x47wBM
        VRsMvu3qfftKOjSIlCZCuGp9u7Y6ftV2CrvasdqW9g==
X-Google-Smtp-Source: ABdhPJz1q7mhZOF0eI6zsQx2UPYqrGGdD1ruEZcsQYjkxHS54Vi4X7QfPeXJ6Ch5D9b2peWld4azn+1VGmysoAoKHGg=
X-Received: by 2002:a05:6512:3bb:: with SMTP id v27mr19505255lfp.71.1640710716727;
 Tue, 28 Dec 2021 08:58:36 -0800 (PST)
MIME-Version: 1.0
References: <20211224192545.74528-1-david@ixit.cz>
In-Reply-To: <20211224192545.74528-1-david@ixit.cz>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Dec 2021 17:58:00 +0100
Message-ID: <CAPDyKFqrZ349O+vNSExaU7QUTeCjf_Hfu_ia4T7AujCMiOZ1ow@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: PL18x stop relying on order of dma-names
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Dec 2021 at 20:25, David Heidelberg <david@ixit.cz> wrote:
>
> We don't care in which order are "rx" and "tx" DMA names supplied.
>
> Fixes: 4df297aaeb9c ("dt-bindings: mmc: Add missing properties used in examples")
>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index f0a44b2cfa79..a4f74bec68a3 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -70,9 +70,13 @@ properties:
>      maxItems: 2
>
>    dma-names:
> -    items:
> -      - const: rx
> -      - const: tx
> +    oneOf:
> +      - items:
> +          - const: tx
> +          - const: rx
> +      - items:
> +          - const: rx
> +          - const: tx
>
>    power-domains: true
>
> --
> 2.34.1
>
