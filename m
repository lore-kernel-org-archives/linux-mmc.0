Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73C8C43334
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Jul 2022 11:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbiGLLK1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jul 2022 07:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbiGLLKN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jul 2022 07:10:13 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F13B186D
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:10:11 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id u13so13352939lfn.5
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jul 2022 04:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uwaWTlB9XyYSCbsGwzEE8BVlrGpHkrwxw1TbvJ4Org4=;
        b=DZx1pmciZROwc48L94adQPdjnNrHIsmIDfTxOKjK16+njO+4fyxaxlfXdN3waf3a0b
         iM5mPh1KW6XDNtqJ5QAy5OO0FvJxeAr8GKZ6B10T7DxKG8mzOirP0a/YeYev9YrUP8Go
         EM+SizTVel+y1raK1kbUZEwmfSD12pnlfo5JjYYQO6uzVckxQqgfpa0i5Am1uxsmX4xN
         iBX32lKu6C3qjvzBGmJG7BNnfMG3ZTa9XelXo5bv/y+hJv2m28qCCC0SUYvJ5OENLuHE
         O/7banmuGTWx6F4R2jJhe3T5FbLDe9eZdTERHLTzM798W8RBUvKoY7oUZwazBiMlgvS+
         9llg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uwaWTlB9XyYSCbsGwzEE8BVlrGpHkrwxw1TbvJ4Org4=;
        b=PUERXeGvXgVosTsM58A86yoEnYSugWurGChbz8NDbpVmalGixHPrTLTtIa726SnANo
         OqxruKLVSkchXr6ZObpxg3bgUSVdzJ0SS+96HSuT6IZywTNlmc6iyK/oefzytplynQkj
         II/VjAtYOceXyVDVbG3DD2uRss3J9vJ5z1RgJCnwto9sOExon4xGp3Jvzo8ph8IbsReT
         WOOAx66517MD4+saIWjZa4gztX3KJC9Mfc8cC2nU90fN/EJSt3JDVG4ub+fhJS3mtAja
         ZkZKI+eOOL8mMBhGVN4hfDIPy5G7RCn8bTJmMGxgaM9d93u4H1LDJ6uo6yHpx1SQu1UH
         BQcg==
X-Gm-Message-State: AJIora/2k2VXUWodBjjSUvzIG4UJO72yYF9gj3mdzrDrCuRH/UkGZw0f
        aQaSLi70TZFDJan9iWKoVA+OTtUIX8km63sUVQgWhQ==
X-Google-Smtp-Source: AGRyM1ve5l8iOOqjKIRpIrGFxxBTNnh3DERnaKcFR3f0PFlcws/EjMxWxw8lvTV7HgWGqRd6EEPzTV4VMLjMOFwbt28=
X-Received: by 2002:a05:6512:15a8:b0:489:ed48:24 with SMTP id
 bp40-20020a05651215a800b00489ed480024mr2187021lfb.184.1657624210224; Tue, 12
 Jul 2022 04:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220704143554.1180927-1-robimarko@gmail.com>
In-Reply-To: <20220704143554.1180927-1-robimarko@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Jul 2022 13:09:33 +0200
Message-ID: <CAPDyKFro0BkQdRJ1q44ED95CqQHbujBshAtFJm_PVPUD+rKE=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: sdhci-msm: document resets
To:     Robert Marko <robimarko@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, bhupesh.sharma@linaro.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 4 Jul 2022 at 16:35, Robert Marko <robimarko@gmail.com> wrote:
>
> Commit "mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC" added
> support for utilizing a hardware reset and parsing it from DT, however
> the bindings were not updated along with it.
>
> So, document the usage of "resets" property with the limit of only one
> item.
>
> Signed-off-by: Robert Marko <robimarko@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 31a3ce208e1a..ca8814a80443 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -116,6 +116,9 @@ properties:
>      description:
>        Should specify pin control groups used for this controller.
>
> +  resets:
> +    maxItems: 1
> +
>    qcom,ddr-config:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: platform specific settings for DDR_CONFIG reg.
> --
> 2.36.1
>
