Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9DAC433ED
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 16:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 523B96103E
	for <linux-mmc@archiver.kernel.org>; Fri,  9 Apr 2021 16:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhDIQTM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 9 Apr 2021 12:19:12 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:39804 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDIQTL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Apr 2021 12:19:11 -0400
Received: by mail-ot1-f46.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso1471108otv.6;
        Fri, 09 Apr 2021 09:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6+t5pl9yiZgeYjahPqpAZZKi8bWzrvkcd68BkJAc7U=;
        b=QOSMadggEbwUvDatFQVMgcfCeqHuEUdzAoLbk4d+UGmNhV9sgbANb93n3S0l1rjU4P
         6vtEZn9kOmBbo+s/q8kf7amgxVi2FBRumaoXk9LWAPzMySrf6GQeGUFlwkJDMYm8Q7QN
         nFiNDZg1wXZSH1Td8Hr+KKhZqSmfhrJgcbtAWgbJloXxKpNucUwayGnst8ARTxxwBzvv
         AT6UCGkvHez8vxZUOgCjRlGBA0MAF/UF2gASn80daYMmV1Z5TLrG9c3s1Gd56ALs8cpB
         KZqzqjhxC9P4MyXnDNtnUp1bngbHS5B8QDvIhj9jdZBPhu0p4VIokHFXeDfOYPZwejAF
         fk5A==
X-Gm-Message-State: AOAM531AgYLA7b8N1q9iPCZs86WWj9ahDIR9dnrHy54Eo629n7hkvEYB
        Pwlg7uW8ZfQRmK/D54Pgmw==
X-Google-Smtp-Source: ABdhPJyrAOG2bnJLeYmCGUVGO7oqCy02r/oDqFq2pcAf7aThY3BxjjJpxNkuNlfg2ZoZct6bMj2b6w==
X-Received: by 2002:a9d:591:: with SMTP id 17mr12521855otd.115.1617985137160;
        Fri, 09 Apr 2021 09:18:57 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n13sm676778otk.61.2021.04.09.09.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:18:56 -0700 (PDT)
Received: (nullmailer pid 3750799 invoked by uid 1000);
        Fri, 09 Apr 2021 16:18:55 -0000
Date:   Fri, 9 Apr 2021 11:18:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     Scott Branden <scott.branden@broadcom.com>, stefan.wahren@i2se.com,
        Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, phil@raspberrypi.com,
        adrian.hunter@intel.com, linux-rpi-kernel@lists.infradead.org,
        Stefan Wahren <wahrenst@gmx.net>, nsaenzjulienne@suse.de,
        tim.gover@raspberrypi.com, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, alcooperx@gmail.com,
        Ray Jui <ray.jui@broadcom.com>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
Message-ID: <20210409161855.GA3750765@robh.at.kernel.org>
References: <20210406104802.20898-1-nsaenz@kernel.org>
 <20210406104802.20898-2-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406104802.20898-2-nsaenz@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 06 Apr 2021 12:48:01 +0200, Nicolas Saenz Julienne wrote:
> Convert the brcm,iproc-sdhci binding to DT schema format using json-schema
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> 
> ---
> 
>  .../bindings/mmc/brcm,iproc-sdhci.yaml        | 63 +++++++++++++++++++
>  .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 -----------
>  2 files changed, 63 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
