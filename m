Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F7AC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 20:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33129619CE
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 20:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233110AbhCWURH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:17:07 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:46748 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbhCWUQv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 16:16:51 -0400
Received: by mail-io1-f50.google.com with SMTP id j26so19069713iog.13;
        Tue, 23 Mar 2021 13:16:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=2Xsddl20fBjvfqqLCcwceEr+314gBRXnBcSQaiPmnEQ=;
        b=rSpwkLjvIcMyzepR1bw9U61ggdwnTLqs98O9lfsw7Kz6PHWX4yVG/SZpJAJeWHCZ4v
         L6zbliO9Q5kzydKP/aSJh3lx9PtZsAzapXF7dUfbnxYbmyab+cM65ZNE74hoEkoxRb+k
         efJd9w5o2L+NjmXWA66VDqWNTZmMpOwtu8rUHafIlJIz2dRMXJsIavOgnofHcjCYFXun
         603fit4Jgc1Lq/I4Wmz/vnWWpRUYew87oGFS7GeUWX1G7Dkq9WaxYgmRCBOw0p5pe+QY
         QFQJPBJBE4rHkklBlhSClr0jmHWHZSRl8zTAkv+2HwvT7VTyb1bvkBGW/gc+9ser2ZZ0
         kJJg==
X-Gm-Message-State: AOAM531YqdiquXUZn6AsMGMKPNi7y9qyHb+4q9+km+bt+143d6Ds+++9
        gPg4dO65l621FNDwnp+Qjf4GH6kaJg==
X-Google-Smtp-Source: ABdhPJzawX8tfIo854j5immXLxsifbRwp8DwYYTmDA5IrkQdtI5aK3gjoHoK3ViTYHg2qW6qkWk4ww==
X-Received: by 2002:a02:605d:: with SMTP id d29mr6160144jaf.81.1616530610967;
        Tue, 23 Mar 2021 13:16:50 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b20sm9552288iod.22.2021.03.23.13.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 13:16:50 -0700 (PDT)
Received: (nullmailer pid 1244762 invoked by uid 1000);
        Tue, 23 Mar 2021 20:16:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc:     f.fainelli@gmail.com, alcooperx@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, adrian.hunter@intel.com,
        Ulf Hansson <ulf.hansson@linaro.org>, nsaenzjulienne@suse.de,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        tim.gover@raspberrypi.com, linux-kernel@vger.kernel.org,
        phil@raspberrypi.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20210322185816.27582-2-nsaenz@kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org> <20210322185816.27582-2-nsaenz@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
Date:   Tue, 23 Mar 2021 14:16:47 -0600
Message-Id: <1616530607.384911.1244761.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Mar 2021 19:58:14 +0100, Nicolas Saenz Julienne wrote:
> Convert the brcm,iproc-sdhci binding to DT schema format using json-schema
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
> ---
>  .../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 +++++++++++++++++++
>  .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 ------------
>  2 files changed, 58 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.example.dts:22.25-26 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.example.dt.yaml] Error 1
make: *** [Makefile:1380: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1456815

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

