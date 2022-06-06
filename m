Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73606C433EF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jun 2022 19:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiFFTEv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jun 2022 15:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiFFTEu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jun 2022 15:04:50 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23B8B855;
        Mon,  6 Jun 2022 12:04:48 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id d7so6670201iof.10;
        Mon, 06 Jun 2022 12:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sGKPVnUEEvdVlKAmlJ0qrIg6gdUWkifWdLO8M4OIYps=;
        b=zReO9qFZuPO3HzrKKUnKGKtozecN98yA4tXvObo5dqQvKXGMx4Vg9y8B9g+3b6FwoM
         9ne+VsqVydprwUrweArthj51DmJqct6Q7tlkhhWbXfr4aUIFgdyfm9RxGvIl5mhzIILr
         CB0QyrbG4RaVf8ynEEA9kEvg+A+Nes21zYNz/EkQIALBQf+lH6esjDHUuySn+PmLfapR
         lgW5WmZ+ZNwbeE17MCquw4kAHLVb4KXBpl4jkO1EBm2z4RpQoHTd4mN6+P51jBL2xYee
         z+sjtc8lWftpv8C/xXKrr9Nno5v8hDLxWj8SHgRysdhQOGAycfEEolyFeuIguWe70P+g
         ztuA==
X-Gm-Message-State: AOAM53155QiTJNIEJqOlqxR4xEX3TmU52+Wuz/2AiwL/ZYcxnihp4EGW
        xN8/vv3umjpgFwC0gi24clzoTXCgkg==
X-Google-Smtp-Source: ABdhPJyz9oF5K+CIB42cEXZms9KPP7tDG658jOjayJN9oFgw4DQb5pHCHmvgMlAtp6wT+trbKraJ2g==
X-Received: by 2002:a05:6602:234a:b0:669:4107:c6e with SMTP id r10-20020a056602234a00b0066941070c6emr5672684iot.11.1654542288255;
        Mon, 06 Jun 2022 12:04:48 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id a5-20020a02a005000000b0032e9bf3b973sm5929533jah.5.2022.06.06.12.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 12:04:47 -0700 (PDT)
Received: (nullmailer pid 1088323 invoked by uid 1000);
        Mon, 06 Jun 2022 19:04:45 -0000
Date:   Mon, 6 Jun 2022 14:04:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: mmc: samsung,exynos-dw-mshc: convert
 to dtschema
Message-ID: <20220606190445.GA1088268-robh@kernel.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org>
 <20220605163710.144210-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605163710.144210-4-krzysztof.kozlowski@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 05 Jun 2022 18:37:09 +0200, Krzysztof Kozlowski wrote:
> Convert the Samsung Exynos SoC specific extensions to the Synopsys
> Designware Mobile Storage Host Controller to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mmc/exynos-dw-mshc.txt           |  94 -----------
>  .../bindings/mmc/samsung,exynos-dw-mshc.yaml  | 159 ++++++++++++++++++
>  2 files changed, 159 insertions(+), 94 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
>  create mode 100644 Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
