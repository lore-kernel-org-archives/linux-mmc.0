Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166FCC4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 18:33:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA15360E90
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 18:33:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhHRSeE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:34:04 -0400
Received: from mail-oo1-f52.google.com ([209.85.161.52]:43746 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHRSeD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 14:34:03 -0400
Received: by mail-oo1-f52.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so979308oos.10;
        Wed, 18 Aug 2021 11:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vMo+8CpaZowa487/3sqLBnwPwXf0K3aLC0kkTt3bcrU=;
        b=abaHx482Zh8HU/0sWiza7JKdQhnTwX86KhHmjdG1Oq8zNCu2uabAqyBX+a0hUN1ZPR
         9smABWc8nHIap3I3v+AbbGEK6LTd9l9QlXuN/SUE0pPG5+FDYr83OvtHsyndL0PnDjpJ
         oqaCldE6GHHQsum8+Kf0dMVJ1LK6oNtHkb25L1LMVA9LNb7Cs7r8VR+nGX2e85yRCNI6
         L34wMWIODHMoN6fijU/elZLl6rCbByqayGoX9BYr6p9Pgo7PUmpjUynp0lHaOD4ehLbF
         3mBcFkn6pHYqXCjxsCsRx1ctA9eilbE5RcMaMVNVYV5yRqQug7at36knszGPqlvM6pg8
         zZHg==
X-Gm-Message-State: AOAM531cCpD31EuB/nPls3oUI7/pT4vodcl2jSmfuGJAMAx8RjGBKhz7
        2hHGTSZgCWKi5ah5Nm1Atg==
X-Google-Smtp-Source: ABdhPJyyuODPJXGoyWMb6MBkpVANV0aA7zh7to3bVrP2cYuiZr85uz6iHDgDlTBDfFjisMLIS4v5ew==
X-Received: by 2002:a4a:8d97:: with SMTP id i23mr7780375ook.4.1629311608153;
        Wed, 18 Aug 2021 11:33:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m6sm157969otf.52.2021.08.18.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:33:27 -0700 (PDT)
Received: (nullmailer pid 2879568 invoked by uid 1000);
        Wed, 18 Aug 2021 18:33:26 -0000
Date:   Wed, 18 Aug 2021 13:33:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        ulf.hansson@linaro.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, aisheng.dong@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: change the
 pinctrl-names rule
Message-ID: <YR1SdhfM344Ii7BQ@robh.at.kernel.org>
References: <1629279984-7397-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629279984-7397-1-git-send-email-haibo.chen@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 18, 2021 at 05:46:24PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Change the pinctrl-names rule to cover all cases.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 21 +++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 17086f60f8a3..d324606a4f0a 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -116,12 +116,21 @@ properties:
>        - const: per
>  
>    pinctrl-names:
> -    minItems: 1
> -    items:
> -      - const: default
> -      - const: state_100mhz
> -      - const: state_200mhz
> -      - const: sleep
> +    oneOf:
> +      - items:
> +          - const: default
> +          - const: state_100mhz
> +          - const: state_200mhz
> +          - const: sleep
> +      - items:
> +          - const: default
> +          - const: state_100mhz
> +          - const: state_200mhz

You can drop this one and add 'minItems: 3' to the first case.

> +      - items:
> +          - const: default
> +          - const: sleep
> +      - items:
> +          - const: default

Similar here too with the prior case. Or use 'minItems: 1' in the first 
case. That additional allows the 2 entry case, but why isn't that valid? 
Couldn't a board only support default+state_100mhz?

Rob
