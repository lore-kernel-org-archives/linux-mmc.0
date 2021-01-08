Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84751C433E6
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 03:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF53235DD
	for <linux-mmc@archiver.kernel.org>; Fri,  8 Jan 2021 03:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbhAHDhB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 Jan 2021 22:37:01 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:44583 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbhAHDhB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Jan 2021 22:37:01 -0500
Received: by mail-io1-f41.google.com with SMTP id z5so8421113iob.11;
        Thu, 07 Jan 2021 19:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3VDZFiJx7Spodzkqss9mSg6HRwcEHXQuHkP19xzMH0I=;
        b=oUQhidZi1EvohFRAa9dKVVBjY6/A5SiBJJQTZr0zAcIU6IhXYTmBvgnrjErwhZ/zl1
         tbloGxfjs4GZV44g8P4PnPtZd0jjkrMIquu4FgcwihpMYuZOOCGVHReR5m9oxoU/nIn+
         ml2JehFZTufS7Lbx2CZc+KKCPX1wZjMfPibVFT1RaQk3hFlvZohfHdzELmo2sjPhKGi+
         q/dFTaW3DALsgd/pE2PYkf7gs9jpJVAxqycG5+bhmPkfVpIzIxkcBfYr7FjIGYkYloLD
         e/XnvP/EFZkn0AYnJGyYZzKnFXW/ZXVuYDvBlg3qlbQBADIqXl95/FRWEKxtNpjXh/qH
         en4Q==
X-Gm-Message-State: AOAM533L+MTUh0jGASOiZOESbIfmp4o3CQVPvnhuUFwN4Eh9JAOr87fu
        mD56wGF9qQJlbo48MLUjNQ==
X-Google-Smtp-Source: ABdhPJyMZifp++9/Cg5R5t+3SbZt4WxN4m+BB9f2orCO4x+lxRP7aotyG+dM992Fj5Arxb/WWDPp+w==
X-Received: by 2002:a5e:841a:: with SMTP id h26mr3818763ioj.54.1610076980597;
        Thu, 07 Jan 2021 19:36:20 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id k4sm4805005ioh.45.2021.01.07.19.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 19:36:19 -0800 (PST)
Received: (nullmailer pid 1839226 invoked by uid 1000);
        Fri, 08 Jan 2021 03:36:17 -0000
Date:   Thu, 7 Jan 2021 20:36:17 -0700
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 1/6] dt-bindings: mmc: renesas,sdhi: Add r8a779a0 support
Message-ID: <20210108033617.GA1839197@robh.at.kernel.org>
References: <20201227174202.40834-1-wsa+renesas@sang-engineering.com>
 <20201227174202.40834-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201227174202.40834-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 27 Dec 2020 18:41:55 +0100, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/mmc/renesas,sdhi.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
