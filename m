Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EB8C433F5
	for <linux-mmc@archiver.kernel.org>; Wed,  4 May 2022 10:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbiEDKmH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 May 2022 06:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348294AbiEDKmE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2022 06:42:04 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580912A718
        for <linux-mmc@vger.kernel.org>; Wed,  4 May 2022 03:38:19 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 17so1132504lji.1
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2022 03:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xzd4OnTUAsEYtJcnIhTTpNw2Yky9MP4XqoNUTULsUQI=;
        b=kSVtfyHf7tg8/sLpM/0/dLnjG9ImmFlBRkxbtoZ2tfUcHYrVqaNmrVKuKh4wbeICwy
         5MBNMZCqXh+L8XxSJN7CSx031QRCUAZXQvS2DaoQPn5/OSIVVxIuuBjAMnNEABmM7YwQ
         2zm+bHQaqAd6yMuqsavlMsklJfGW/woWqFUP6w0ol517lN0v/T8kGyPMWndRf7gP1s5J
         NVIk3hNAbqVCoNBTrR0NUQ6OoEt6GksUT19Zlfu2KehIRJRD3ihPeClAuPAINjKMgXHP
         +7SCwycjSCIQMGv4jCsXQw+NohKhsKb2ghGv+ram05aUOx/ISepA/y6u2y/NnXo4eULc
         Rrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xzd4OnTUAsEYtJcnIhTTpNw2Yky9MP4XqoNUTULsUQI=;
        b=37VMSE6bvW4oT86cKr7KAC4sFh98F9k1Emlv/S1ONRZo99IP4Bu4jfFZqMRGZgM7nW
         RpE5kUtslnu8He9RRqE8Z4ymk+odkBBWREJH+cP+e5fZ7J4jjBt2h+GZLBUccQo29MGe
         GpaxSllTXWrjRiBbbbbKByV4g9/z/u/SDEzB4Yeef+fl33WYaZWz21eVgiuHcWUDz1/p
         nm8P6drP1pDnGo8kSmyjcwURV9Q8ONmc/kpbVXth947bmvs4dZ13gOXZ2x/nb7PSZWAX
         ndu/riGkgPmm/8aHlRDtyvMZ2AVYYFWDjQ9ObNSd7ogWC02GXpY2hlWne0mX2WFEtTUZ
         h44g==
X-Gm-Message-State: AOAM532efjeCkLpWuiaGPT4tj9U6MxxAJf5Ec6aPB4QbKcUvyP0H78OG
        h6rvJ/EqFyDm6IK3efXeNeav6bWCboAmAUO6sAu/49Nf3us=
X-Google-Smtp-Source: ABdhPJyBywRSIyt7pALugnYtqinczQCbJyAuSG22YjxDVCMSbWyXlAOWVeYTDVaw4tknpDuWK26kA6zmnb4HoVTFLNI=
X-Received: by 2002:a05:651c:a12:b0:250:5abe:4ec4 with SMTP id
 k18-20020a05651c0a1200b002505abe4ec4mr7487747ljq.4.1651660698910; Wed, 04 May
 2022 03:38:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
In-Reply-To: <20220429220833.873672-1-bhupesh.sharma@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:42 +0200
Message-ID: <CAPDyKFp+wJ8aQk4ZNLzg+O4yp_Jw-JyMSW+5F_dhiHrri=j8RA@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: sdhci-msm: Convert dt-binding to yaml & add
 support for sm8150
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, bjorn.andersson@linaro.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 30 Apr 2022 at 00:08, Bhupesh Sharma <bhupesh.sharma@linaro.org> wrote:
>
> This patchset converts the Qualcomm 'sdhci-msm' device-tree binding
> to yaml format and also adds support for sm8150 Qualcomm Soc.
>
> This patchset is dependent on the qcom dts fixes sent via a separate
> patchset (see [1]), to make sure that the 'make dtbs_check' and
> 'make dt_binding_check' work well and Rob's bot is happy as well.
>
> [1]. https://lore.kernel.org/linux-arm-msm/20220429214420.854335-1-bhupesh.sharma@linaro.org/
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


>
> Bhupesh Sharma (4):
>   dt-bindings: mmc/sdhci-msm: Convert bindings to yaml
>   mmc: host/sdhci-msm: Add SoC specific compatibles
>   dt-bindings: mmc: sdhci-msm: Add compatible string for sm8150
>   mmc: host/sdhci-msm: Add compatible string check for sm8150
>
>  .../devicetree/bindings/mmc/sdhci-msm.txt     | 123 -----------
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    | 193 ++++++++++++++++++
>  drivers/mmc/host/sdhci-msm.c                  |  24 +++
>  3 files changed, 217 insertions(+), 123 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
>
> --
> 2.35.1
>
