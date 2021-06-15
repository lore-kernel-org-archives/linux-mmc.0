Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F6CC48BE5
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 23:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21ADC613B1
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Jun 2021 23:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhFOXs1 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Jun 2021 19:48:27 -0400
Received: from mail-il1-f178.google.com ([209.85.166.178]:35491 "EHLO
        mail-il1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFOXs0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Jun 2021 19:48:26 -0400
Received: by mail-il1-f178.google.com with SMTP id b9so722023ilr.2;
        Tue, 15 Jun 2021 16:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JaQBVYoU9RCAXe0rj8luP77fQTfOXEYajqM9IA3NLmg=;
        b=dqf7raKEJCJmGHTLGt/bjnq7LLeWfnkTywjAXJZF0bb4NeeFqlTOHMYKMGbPn9Q3EC
         1fcsH1+frd/66eWCfMYH9VNdiyby51pBq3e5BXmJDIeBsLsThfu3SV+M3LOrOJMF2QDV
         cjobnxfleClus6XmYGOaaXqkvJSJ2b42EfpNaI1II5wlWFrpJpF97YEEjOU9v4qGRvhL
         w7BQwBzCKfaVy4CGgXF/Db3TF6VNKzGXSJ23GAOScL9xavszzVnZNX669spW8pKFIY8J
         WiDy9dHP7oFBrpYHzAgmjuwe036IVNVjIDdGJMFrf3aPsi/SJkPQgMV1nCtX1LSts25s
         p/Qw==
X-Gm-Message-State: AOAM53072umXPaLcycMijHLT1UYDRHwwl75zD//a7l+SaEu90U/s8+ku
        MIXH1gow9nWaX+yJJ5D/tQ==
X-Google-Smtp-Source: ABdhPJx6ia1W8JEbYC3rsl4BlNoDsoPaezbxUCrNtj80Grq+z9MtX5qqzfb2FnX0lGdYdHpb/neB/w==
X-Received: by 2002:a05:6e02:e53:: with SMTP id l19mr1514558ilk.15.1623800780861;
        Tue, 15 Jun 2021 16:46:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g9sm280008ile.12.2021.06.15.16.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 16:46:20 -0700 (PDT)
Received: (nullmailer pid 1688415 invoked by uid 1000);
        Tue, 15 Jun 2021 23:46:16 -0000
Date:   Tue, 15 Jun 2021 17:46:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Al Cooper <alcooperx@gmail.com>
Cc:     Scott Branden <sbranden@broadcom.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sdhci-iproc: Add
 brcm,bcm7211a0-sdhci
Message-ID: <20210615234616.GA1688363@robh.at.kernel.org>
References: <20210602192758.38735-1-alcooperx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602192758.38735-1-alcooperx@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 02 Jun 2021 15:27:57 -0400, Al Cooper wrote:
> Add new compatible string for the legacy sdhci controller on the
> BCM7211 family of SoC's.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
