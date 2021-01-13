Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2E0C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 03:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FED23139
	for <linux-mmc@archiver.kernel.org>; Wed, 13 Jan 2021 03:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbhAMDVi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Jan 2021 22:21:38 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:38458 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbhAMDVi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jan 2021 22:21:38 -0500
Received: by mail-ot1-f41.google.com with SMTP id j20so627533otq.5;
        Tue, 12 Jan 2021 19:21:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+iPuStd3AQR7yWdhZaXQgBoj2q4Ys7I8UpydTO/Ec8=;
        b=D/EaciwzSJU1cOu3hPPLuJ2St75S/bwtB7DDq2wZMzv/MLQ4rqKVqnjJLHQNh/yhoc
         9p2QaJicy6l0xEitbdf43x7JlH/Hhq/P+u01LMBymwf2N96DDkApO2CcNxW6OTqdndro
         aJL5mbom26v9JdZWulpjCUwpFCbOsO/4uaUSM8xsugKZgF/TGeMF7ZnvizcAqyST+j7N
         Jp9Dmoi6pm/HfREYKFfP6T5gne9gLsEUCDx+9Zag+bRUpoGE2Qqu6ITgjOl7ibpBPu8C
         EU9Apxn1JCeim9i2yAjnotZtHLuUbQMSRrRo24WqYFfLeHIM3ZW/DTX70dVeKwokvBQV
         uVLQ==
X-Gm-Message-State: AOAM532IBBcddpvuzJ5DGKeOZJuemOeZna9vT+GHJlhpt3ntxdGz34Bk
        4ZTVzU9TY8SCdd6o5CVNecXUMT2aqQ==
X-Google-Smtp-Source: ABdhPJy/dQk3U0Lj10amKSCNtvSGirtROa1+5P42nhmc5oZ3sEVGoSG1Q77Id+BU8zD8pxbtMSU2Jg==
X-Received: by 2002:a9d:69c1:: with SMTP id v1mr8863oto.128.1610508051998;
        Tue, 12 Jan 2021 19:20:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r15sm168833oie.33.2021.01.12.19.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 19:20:51 -0800 (PST)
Received: (nullmailer pid 1465147 invoked by uid 1000);
        Wed, 13 Jan 2021 03:20:50 -0000
Date:   Tue, 12 Jan 2021 21:20:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, linux-mmc@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-am654: Add compatible string for
 AM64 SoC
Message-ID: <20210113032050.GA1465117@robh.at.kernel.org>
References: <20210107055457.14948-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107055457.14948-1-a-govindraju@ti.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 07 Jan 2021 11:24:57 +0530, Aswath Govindraju wrote:
> Add compatible string for AM64 SoC in device tree binding of AM654 SDHCI
> module as the same IP is used.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
