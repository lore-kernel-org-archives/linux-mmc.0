Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8CDC433DB
	for <linux-mmc@archiver.kernel.org>; Sat, 27 Mar 2021 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98339619BB
	for <linux-mmc@archiver.kernel.org>; Sat, 27 Mar 2021 17:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhC0ROL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 27 Mar 2021 13:14:11 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42863 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbhC0ROK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 27 Mar 2021 13:14:10 -0400
Received: by mail-oi1-f181.google.com with SMTP id n140so9004850oig.9;
        Sat, 27 Mar 2021 10:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hTVQjGeLjaxzwSPabxK/lSxnQipUu7ywlyHTCGDIzb0=;
        b=YBQeb+mmgtKHsredeS9HMjTDjTuIhzqk1ti3LsCrO0LHMb3+BvB/npM0NzATKa++Wj
         ldCezCrokc3MxO/s3W6iCzy2O7S+kedAOQV94F9EGdVB1uuUvnYS7sMABaNYFB/2auLN
         IstHaukYMc0vn0ZU9JLk2wx3dHm75r6gm9wpnUOGrOv57YxV+QGPNOVVzG4bwgCER71b
         VuGzvdnuPrAdnkfHa2qXh2+O6IYkbh51/P6r7ZlUiDwIBcrbqcrPpSsvR7AitH3jZDTK
         SvByQlUZq4ZwhlwYR40rZil2IgAvZZ9WA6n6YAY+etkazxwCGhyfU/ZT4xmkpo4bKk0w
         FI6A==
X-Gm-Message-State: AOAM532habjVpaUrVMK0OQzCqsDX4cKn5COS6m3F4SUVMI1r1PEkwMg+
        sqohTxNybN2NZE9PeN7/vg==
X-Google-Smtp-Source: ABdhPJysnxJuGbIjzhHQGpKpMMLNMlCrnFroN50uzagvg0gQqa0wa4rMWoFHTa1tiUVAuY5SpENrBw==
X-Received: by 2002:a54:408a:: with SMTP id i10mr14082034oii.141.1616865250282;
        Sat, 27 Mar 2021 10:14:10 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id m19sm2656074oop.6.2021.03.27.10.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:14:09 -0700 (PDT)
Received: (nullmailer pid 262112 invoked by uid 1000);
        Sat, 27 Mar 2021 17:14:04 -0000
Date:   Sat, 27 Mar 2021 11:14:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        adrian.hunter@intel.com, bcm-kernel-feedback-list@broadcom.com,
        alcooperx@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>,
        Scott Branden <sbranden@broadcom.com>, phil@raspberrypi.com,
        linux-mmc@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        nsaenzjulienne@suse.de, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, tim.gover@raspberrypi.com,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: mmc: iproc-sdhci: Add clock-frequency
 support
Message-ID: <20210327171404.GA262081@robh.at.kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
 <20210322185816.27582-3-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322185816.27582-3-nsaenz@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2021 19:58:15 +0100, Nicolas Saenz Julienne wrote:
> Users might want to choose a different clock frequency than whatever the
> bootloader provided at probe time. Add 'clock-frequency' bindings.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---
>  Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
