Return-Path: <SRS0=7jB0=A2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11637C433E5
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD17F2065F
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jul 2020 22:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594850800;
	bh=sT7Oo5qiCqBh81qeFvFiutT/b41f67Y6cxsHBsFk5VE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rTOC9cweYFb9OI0A/CB7lyJnSPp9yppV/MzksTgmhKx7BXNgz3Up27W4HgFyMk8Hm
	 VzrUhp0ekjs6vJGTUd3hQwckc4ohKXk1Y7qnco19YMJUWCb80C25nZXJ5xKne3GU8E
	 GPXHH5zV6imcd30zlb4OfIEXiMK/eHTvS1MfMsp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGOWGh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:06:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35396 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOWGh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jul 2020 18:06:37 -0400
Received: by mail-io1-f65.google.com with SMTP id v8so3962283iox.2;
        Wed, 15 Jul 2020 15:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRfjlVNBy4z5241SwQko9g8EbOlRqXEXvkQFTv6DkDQ=;
        b=aPU+nUGjxgoplbOWKBUaXbBJkG6xBH0cUmjrdxqgRN/yFK54ki4oj7GDSe+x52+J7u
         8vJrvCEgRooue8C+avE5rBXWTYJBgNSk4+om097fanrlK6YtC1pDToWl2+uU1U9AgbSY
         15WH3IIg8LrA8UbeVyK59Gh4AiMs/wal043vMxDQp4mBO9hdZRXNWEzZIP5jP77M73xW
         dT9TRRoSDv/oYZM0yGVrdqKs1mGBhZMo/rrIHynOz0Vz5Zqc0e0RewIwB3qxLWzQwXrS
         j8Rt6UVQDwdpzXTi5epgoADLmew8zuNMxUXpA6pJ0Wh53XcEDCmJbxNNHHdow/XrOXmI
         JTlQ==
X-Gm-Message-State: AOAM5321iHVBFBHrqWWzZ+48+N90ecWE0AF+Bnhn0gNQ6JriGi/3oIH6
        5AobgM1S5OhZf9PnaqUbXQ==
X-Google-Smtp-Source: ABdhPJySacJKCgv7hC4z5/mCzLrNdHpH7KUcxBpfRp0LlpERVpj8w9JWv8bBWjfagJiaww5INCe2ww==
X-Received: by 2002:a6b:b785:: with SMTP id h127mr1427356iof.161.1594850796234;
        Wed, 15 Jul 2020 15:06:36 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id p22sm1806151ili.88.2020.07.15.15.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 15:06:35 -0700 (PDT)
Received: (nullmailer pid 899956 invoked by uid 1000);
        Wed, 15 Jul 2020 22:06:34 -0000
Date:   Wed, 15 Jul 2020 16:06:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kangmin Park <l4stpr0gr4m@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: Convert sdhci-sirf to json-schema
Message-ID: <20200715220634.GA897068@bogus>
References: <20200706174336.27251-1-l4stpr0gr4m@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706174336.27251-1-l4stpr0gr4m@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jul 07, 2020 at 02:43:36AM +0900, Kangmin Park wrote:
> Convert the sdhci-sirf binding to DT schema format using json-schema.
> 
> At the same time, fix unit address to match the first address specified
> in the reg property of the node.
> 
> Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-sirf.txt    | 18 ---------
>  .../devicetree/bindings/mmc/sdhci-sirf.yaml   | 40 +++++++++++++++++++
>  2 files changed, 40 insertions(+), 18 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt b/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
> deleted file mode 100644
> index dd6ed464bcb8..000000000000
> --- a/Documentation/devicetree/bindings/mmc/sdhci-sirf.txt
> +++ /dev/null
> @@ -1,18 +0,0 @@
> -* SiRFprimII/marco/atlas6 SDHCI Controller
> -
> -This file documents differences between the core properties in mmc.txt
> -and the properties used by the sdhci-sirf driver.
> -
> -Required properties:
> -- compatible: sirf,prima2-sdhc
> -
> -Optional properties:
> -- cd-gpios: card detect gpio, with zero flags.
> -
> -Example:
> -
> -	sd0: sdhci@56000000 {
> -		compatible = "sirf,prima2-sdhc";
> -		reg = <0xcd000000 0x100000>;
> -		cd-gpios = <&gpio 6 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml b/Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml
> new file mode 100644
> index 000000000000..46269378d9b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-sirf.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sdhci-sirf.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sdhci Sirf Device Tree Bindings
> +
> +description: |
> +  This file documents differences between the core properties in
> +  mmc.txt and the properties used by the sdhci-sirf driver.
> +
> +maintainers:
> +  - Ulf Hansson <ulf.hansson@linaro.org>

Normally, this should be someone familar with the h/w, not the MMC 
maintainer.

Needs a reference to mmc-controller.yaml. 

> +
> +properties:
> +  compatible:
> +    enum:
> +      - sirf,prima2-sdhc
> +
> +  reg:
> +    maxItems: 1
> +
> +  cd-gpios:
> +    description:
> +      card detect gpio, with zero flags.
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sd0: sdhci@cd000000 {
> +          compatible = "sirf,prima2-sdhc";
> +          reg = <0xcd000000 0x100000>;
> +          cd-gpios = <&gpio 6 0>;
> +    };
> -- 
> 2.26.2
> 
