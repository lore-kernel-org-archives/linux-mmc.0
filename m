Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4385C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Apr 2022 14:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354512AbiDOOfO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Apr 2022 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354467AbiDOOfN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Apr 2022 10:35:13 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEA52E6BC;
        Fri, 15 Apr 2022 07:32:44 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so8212679fac.11;
        Fri, 15 Apr 2022 07:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=lbNCJKTZYftED6nJP7xJB0YB8KniXXh2gE8PdNUGElw=;
        b=AYTA5XquIe4BE89aDG6iofq8xdojzmh56SZpijhy9a1hwdzPz1qgzRF7Ot/TZXXpne
         K1UggUNzdRGD7gF3baLIJ0lsZ23kBF8IivEIgEjQlB5DFFJdTrM5hylniyr/oG0fieVD
         M36p8xa08yvL4xcFn9plmOU3MmH64li0dKS+NvxT5Pr1yoctKihuW0LBXdTd7jxLR8N2
         GwCRUIZRr8BGtsL4CcNvuW6Uc55Od2NTTt12QBQ0mQC4Hh5grpmEA27avhQsPrPgv8rN
         TLJ8J1qStL9j/v4a/uijQ39MC99OTzB0KWBSoApMq6zUlWIraLqeYVIkAyf3go9WC1Yp
         NvUg==
X-Gm-Message-State: AOAM531QNDavm5yGFVNEOuwRYTEiks7uWeE8yS/QhYOyWe/4mrAXh3ch
        iSzuiAZj7YgAOvuckuE5Ow==
X-Google-Smtp-Source: ABdhPJwRpfaOMjkZ+7Xx+M8ZEg1DeCSRF0lXPpuofoYKaeq05NhtGS9O2aRewKCJCA6W90xxlw3rzA==
X-Received: by 2002:a05:6870:600a:b0:d7:4895:75be with SMTP id t10-20020a056870600a00b000d7489575bemr1482571oaa.35.1650033163767;
        Fri, 15 Apr 2022 07:32:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m22-20020a9d73d6000000b006028f49a6fcsm1138070otk.4.2022.04.15.07.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 07:32:43 -0700 (PDT)
Received: (nullmailer pid 251791 invoked by uid 1000);
        Fri, 15 Apr 2022 14:32:41 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, sebastian.hesselbarth@gmail.com,
        andrew@lunn.ch, devicetree@vger.kernel.org, krzk+dt@kernel.org,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gregory.clement@bootlin.com,
        linux-mmc@vger.kernel.org
In-Reply-To: <20220414230603.567049-5-chris.packham@alliedtelesis.co.nz>
References: <20220414230603.567049-1-chris.packham@alliedtelesis.co.nz> <20220414230603.567049-5-chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 4/4] dt-bindings: mmc: convert sdhci-dove to JSON schema
Date:   Fri, 15 Apr 2022 09:32:41 -0500
Message-Id: <1650033161.801334.251790.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 Apr 2022 11:06:03 +1200, Chris Packham wrote:
> Convert the sdhci-dove binding to JSON schema.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  .../bindings/mmc/marvell,dove-sdhci.yaml      | 38 +++++++++++++++++++
>  .../devicetree/bindings/mmc/sdhci-dove.txt    | 14 -------
>  2 files changed, 38 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/marvell,dove-sdhci.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-dove.txt
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/


sdio-host@90000: $nodename:0: 'sdio-host@90000' does not match '^mmc(@.*)?$'
	arch/arm/boot/dts/dove-cubox.dtb
	arch/arm/boot/dts/dove-cubox-es.dtb
	arch/arm/boot/dts/dove-d2plug.dtb
	arch/arm/boot/dts/dove-d3plug.dtb
	arch/arm/boot/dts/dove-dove-db.dtb
	arch/arm/boot/dts/dove-sbc-a510.dtb

sdio-host@90000: interrupts: [[36], [38]] is too long
	arch/arm/boot/dts/dove-cubox.dtb
	arch/arm/boot/dts/dove-cubox-es.dtb
	arch/arm/boot/dts/dove-d2plug.dtb
	arch/arm/boot/dts/dove-d3plug.dtb
	arch/arm/boot/dts/dove-dove-db.dtb
	arch/arm/boot/dts/dove-sbc-a510.dtb

sdio-host@90000: Unevaluated properties are not allowed ('interrupts', 'clocks', 'non-removable', 'bus-width' were unexpected)
	arch/arm/boot/dts/dove-d2plug.dtb

sdio-host@90000: Unevaluated properties are not allowed ('interrupts', 'clocks', 'non-removable', 'vmmc-supply', 'reset-gpio' were unexpected)
	arch/arm/boot/dts/dove-sbc-a510.dtb

sdio-host@90000: Unevaluated properties are not allowed ('interrupts', 'clocks', 'non-removable' were unexpected)
	arch/arm/boot/dts/dove-d3plug.dtb

sdio-host@90000: Unevaluated properties are not allowed ('interrupts', 'clocks' were unexpected)
	arch/arm/boot/dts/dove-cubox.dtb
	arch/arm/boot/dts/dove-cubox-es.dtb
	arch/arm/boot/dts/dove-dove-db.dtb

sdio-host@92000: $nodename:0: 'sdio-host@92000' does not match '^mmc(@.*)?$'
	arch/arm/boot/dts/dove-cubox.dtb
	arch/arm/boot/dts/dove-cubox-es.dtb
	arch/arm/boot/dts/dove-d2plug.dtb
	arch/arm/boot/dts/dove-d3plug.dtb
	arch/arm/boot/dts/dove-dove-db.dtb
	arch/arm/boot/dts/dove-sbc-a510.dtb

sdio-host@92000: interrupts: [[35], [37]] is too long
	arch/arm/boot/dts/dove-cubox.dtb
	arch/arm/boot/dts/dove-cubox-es.dtb
	arch/arm/boot/dts/dove-d2plug.dtb
	arch/arm/boot/dts/dove-d3plug.dtb
	arch/arm/boot/dts/dove-dove-db.dtb
	arch/arm/boot/dts/dove-sbc-a510.dtb

sdio-host@92000: Unevaluated properties are not allowed ('interrupts', 'clocks', 'cd-gpios' were unexpected)
	arch/arm/boot/dts/dove-cubox-es.dtb

sdio-host@92000: Unevaluated properties are not allowed ('interrupts', 'clocks', 'non-removable', 'bus-width' were unexpected)
	arch/arm/boot/dts/dove-d2plug.dtb
	arch/arm/boot/dts/dove-d3plug.dtb

sdio-host@92000: Unevaluated properties are not allowed ('interrupts', 'clocks', 'vmmc-supply', 'wp-gpios' were unexpected)
	arch/arm/boot/dts/dove-sbc-a510.dtb

sdio-host@92000: Unevaluated properties are not allowed ('interrupts', 'clocks' were unexpected)
	arch/arm/boot/dts/dove-cubox.dtb
	arch/arm/boot/dts/dove-dove-db.dtb

