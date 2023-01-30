Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DA0C636CD
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Jan 2023 22:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjA3WoP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Jan 2023 17:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjA3WoO (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Jan 2023 17:44:14 -0500
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F155B5;
        Mon, 30 Jan 2023 14:44:14 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-16332831ed0so17141982fac.10;
        Mon, 30 Jan 2023 14:44:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Dd1xrRz53UjrIdfgUBK41KzbuN/bNPD0VVk5rgihzo=;
        b=pqO3Y8qz5LR1Mnk0zdrf9DldS1x3g0JKo9gOKd5sB4NIYc3oF82qvvBK5uHEUk3nv1
         iMB6+kRmpSnDroj60MhyQI7SDKSQ07A/amHTW0qgeKGXwfmELlWWR/IjJhamm9uwiknM
         890STRYh4ub2qy+XWh8SZnA0H6UqVrTXgDmjepiNJyNPgCNydSE5syLD0fM+DMAR5Fgp
         NonbJWD2fY4K+KyxLJb2NObRnk66AipqVBrW13OMX4CXbi6+pEofwZhfxJGAsdjTvtTt
         1oIB+jhpiwDAsSG6EiLBzXCE109D7NE2OmvwuiMHrRv175s+j9rPy7uZMQnK9voM/5Di
         +YNQ==
X-Gm-Message-State: AO0yUKV/uAba5mTkxgfAO2KnuIlY5lbGJaqvxax22O/3rAOjGZaWCGfd
        c/h2LrLXA+otOuyOWvl0MQ==
X-Google-Smtp-Source: AK7set/m1taRtJm0LOpvPwG/TMWCeRzTyTrkxodgd902uvtxZKBBvL4xrf7BzI3+8LC3j3xNJDygbw==
X-Received: by 2002:a05:6871:606:b0:163:2779:d81f with SMTP id w6-20020a056871060600b001632779d81fmr13555765oan.34.1675118653485;
        Mon, 30 Jan 2023 14:44:13 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n19-20020a9d64d3000000b006884924ca4bsm5890268otl.5.2023.01.30.14.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:44:13 -0800 (PST)
Received: (nullmailer pid 3661761 invoked by uid 1000);
        Mon, 30 Jan 2023 22:44:12 -0000
Date:   Mon, 30 Jan 2023 16:44:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hermes Zhang <chenhuiz@axis.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@axis.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: mmc: Add cap-aggressive-pm property
Message-ID: <20230130224412.GA3658652-robh@kernel.org>
References: <20230130064433.962712-1-chenhuiz@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130064433.962712-1-chenhuiz@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jan 30, 2023 at 02:44:33PM +0800, Hermes Zhang wrote:
> Add a new property: cap-aggressive-pm to enable the
> MMC_CAP_AGGRESSIVE_PM feature for (e)MMC/SD power saving.

Is that a kernel feature or something from the MMC or SD specifications? 
The former doesn't belong in DT. Set this based on the compatible string 
of the controller.

> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
> 
> Notes:
>     Update commit message
> 
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 86c73fd825fd..7ca674263dba 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -177,6 +177,11 @@ properties:
>      description:
>        enable SDIO IRQ signalling on this interface
>  
> +  cap-aggressive-pm:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      enable MMC_CAP_AGGRESSIVE_PM feature
> +
>    full-pwr-cycle:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:
> -- 
> 2.30.2
> 
