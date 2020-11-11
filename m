Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E22C388F9
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 01:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3612068E
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Nov 2020 01:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKLBcJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Nov 2020 20:32:09 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42972 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbgKKWvJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2020 17:51:09 -0500
Received: by mail-oi1-f194.google.com with SMTP id w145so4086588oie.9;
        Wed, 11 Nov 2020 14:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4gO6y2+FXbWp6kk6yQSxbYzLSmr490RK8fybVbeec4=;
        b=FUEwiwe/HUGJLEJ7jidNj4e7p8PKULcg/pIKwiWi4pBE6z25wJW/Ba9xC4LOwYcGeQ
         Glga+rEXzBR3b8c24O2osl4UoMkSMko0Igno8q0v0ZyNcGcJ0GtdAp6uk+BTLyu+kz3Z
         JbNKnCjv8bEzQ/59kMNVyvCYVnARKU9B7jCYYQt/DOc7qVfBTHGHtz6L4v6BBBHYZXd4
         p22RnNCtCVNeL5P6GFoVRviaIIyI5l+hrVj3PyZuWPiRumc5rhogjZ7AJApK5jHI3+lj
         7JjpyBq/6xGjD0RFgnMgA7HitWBZz4sCS1Y5ljpf7X1V2CBOydxIvNtdvLOaodtSzT3U
         vnTA==
X-Gm-Message-State: AOAM531xpdAQgVpEaYIhW+9geudsyrqn0XiKGgEHo2rb0sGesk8pqXUY
        6flmJDm5PobZYd4pj4MJQZI3vKyjxA==
X-Google-Smtp-Source: ABdhPJxLE6Xc450qW/K5XRNneTiy41ELWNn8+7Dq1V98fWKkYaZKkDGwc6LQwGMIK0127+2/O+r9Pw==
X-Received: by 2002:aca:4ccc:: with SMTP id z195mr3489679oia.124.1605135067210;
        Wed, 11 Nov 2020 14:51:07 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m15sm837189oou.11.2020.11.11.14.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 14:51:06 -0800 (PST)
Received: (nullmailer pid 2191616 invoked by uid 1000);
        Wed, 11 Nov 2020 22:51:05 -0000
Date:   Wed, 11 Nov 2020 16:51:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        linux-mmc@vger.kernel.org, tiny.windzz@gmail.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH 16/19] dt-bindings: mmc: sunxi: Add A100
 compatibles
Message-ID: <20201111225105.GA2191562@bogus>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <1e6af41ce01eafd0d366257e5be9a0aa90bb97c8.1604988979.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e6af41ce01eafd0d366257e5be9a0aa90bb97c8.1604988979.git.frank@allwinnertech.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 10 Nov 2020 14:45:16 +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
> 
> Add binding for A100's mmc and emmc controller.
> 
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml        | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
