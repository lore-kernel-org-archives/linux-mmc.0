Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC953C71155
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 01:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 824FA20C56
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 01:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbgLABjq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Nov 2020 20:39:46 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:33790 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731246AbgLABjq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Nov 2020 20:39:46 -0500
Received: by mail-il1-f196.google.com with SMTP id y9so133360ilb.0;
        Mon, 30 Nov 2020 17:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aFtL1H7loFGYO+c900rrh3RzbynWEEM3DE8u4tmHGbM=;
        b=nrDmcr7YI8dey3T4O9114EAK9SJG9MtMiU5IK6+Rc7V2rWQWuEqSx0Cxy8Z2zVvCeG
         87vefrNLALNa+cyCQ/37+py816XZ+duZov8KNfl40HBcgpKW+9YHZ3ZSSYeC4CaUV3uy
         Q1621+yjRCmX6rj0gW0hT2cQyLn1/6vC0W05I3fdRRjmFFMCdqtoNNhIP9y+zxX7lhC9
         6my3ePerLFyNOmzbSvh2FCeg7trwbd7XPA7+5DPZGnuyZUeLhXkJSHj31mAUElH0L6on
         y1ebzjCPiOdaN6ulYpP5wwcAaNsg1S5QkXFmDbnB7TJyisiN2ddNVVxRjNLvsWjJtIVQ
         MyGw==
X-Gm-Message-State: AOAM531DMBgjbuoUoxIKLlh/4wLtdCBbI9uYVabkGJAC2y/HS9Qadg5a
        MOIztBex28Fys7kFQrmmQg==
X-Google-Smtp-Source: ABdhPJxdjICj/+PdHev1sJ928jx+YdcRmxgrh97vCxIJcSSvxnlhvW632SpflFpFKHB24PLed3NLMw==
X-Received: by 2002:a92:6e05:: with SMTP id j5mr545097ilc.136.1606786745651;
        Mon, 30 Nov 2020 17:39:05 -0800 (PST)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id s17sm188876ilj.25.2020.11.30.17.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 17:39:04 -0800 (PST)
Received: (nullmailer pid 3446943 invoked by uid 1000);
        Tue, 01 Dec 2020 01:39:03 -0000
Date:   Mon, 30 Nov 2020 18:39:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH RESEND v4 01/18] dt-bindings: mmc: imx: fix the wrongly
 dropped imx8qm compatible string
Message-ID: <20201201013903.GA3446913@robh.at.kernel.org>
References: <20201126105900.26658-1-aisheng.dong@nxp.com>
 <20201126105900.26658-2-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126105900.26658-2-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 26 Nov 2020 18:58:43 +0800, Dong Aisheng wrote:
> The compatible string "fsl,imx8qm-usdhc" was wrongly dropped in patch:
> commit 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")
> Add it back.
> 
> Cc: Haibo Chen <haibo.chen@nxp.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Fixes: 80fd350b9590 ("dt-bindings: mmc: fsl-imx-esdhc: Fix i.MX 8 compatible matching")
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
