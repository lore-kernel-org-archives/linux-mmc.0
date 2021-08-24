Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF6DC4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B2B6135F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbhHXO02 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:26:28 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43560 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbhHXO02 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:26:28 -0400
Received: by mail-ot1-f41.google.com with SMTP id x10-20020a056830408a00b004f26cead745so46518525ott.10;
        Tue, 24 Aug 2021 07:25:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jyMACbnrPXd1erQcb+LvBC0ocm8yjDa4ithLKyYa+1s=;
        b=fRE4IaaTDQwqYdlb+yih52ecRL8C2Kq8oiWIFbvXUD0Knl+67J9s40KJr6hqCeoFGA
         aMhbNOJupTlbRNF4KxiRojkp7XD/reuV5/lEJcggLr09qVziI3Htg3KsCd0wQFVGLT0y
         5zKCYUOhiizaO/hcIfV/OG36H7JxdMcFbxZWzU/fkHlOhmdPt6g7r7ZIPhNWT2dxwjPn
         KJvezYoLAE3Z82vISzFByXsRdxChAjeyZPMD6PjSUMgN5qag7xLTNDOFgIu3K5n/SLYS
         +uqmLS23EUp61G+rVcHEvBPOA0oGfqA9Hcjd7E7aQDmyhqRUK/YGF9NCkst4ALF/Twvt
         4bqg==
X-Gm-Message-State: AOAM532s/8Pxa5Y/oPnxxwJfca799+cwwTT0UmjeGNsy4id+tfrRHlwl
        LJIr2wurs9Cx1E+XDqqCxw==
X-Google-Smtp-Source: ABdhPJyQ5pTJnPueANz0fmI3QoOLtF5rRMJxzoTk3RtU5Us4gq/Atrv6D2oj6Rtx4ytYQPvkkVmJcg==
X-Received: by 2002:a05:6808:144c:: with SMTP id x12mr2888451oiv.144.1629815143490;
        Tue, 24 Aug 2021 07:25:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s10sm3494573otq.61.2021.08.24.07.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 07:25:42 -0700 (PDT)
Received: (nullmailer pid 385941 invoked by uid 1000);
        Tue, 24 Aug 2021 14:25:41 -0000
Date:   Tue, 24 Aug 2021 09:25:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        festevam@gmail.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        linux-mmc@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v2] dt-bindings: mmc: fsl-imx-esdhc: change the
 pinctrl-names rule
Message-ID: <YSUBZbGOnl7C597b@robh.at.kernel.org>
References: <1629373938-9226-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629373938-9226-1-git-send-email-haibo.chen@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 19 Aug 2021 19:52:18 +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Change the pinctrl-names rule to cover all cases.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml  | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
