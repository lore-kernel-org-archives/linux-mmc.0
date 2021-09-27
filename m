Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0CFC433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEDF160FED
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 18:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbhI0Sme (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 14:42:34 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45603 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbhI0Sme (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 14:42:34 -0400
Received: by mail-ot1-f52.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso25622787otv.12;
        Mon, 27 Sep 2021 11:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aT74sA8N2lUocgMluPhJs3Gm7SxBOR0E9ip/6duvBVU=;
        b=i+MIo9YmnFVKvwH3u1OS/hEw6x9vNy/kIuPsKgeky/H+l8oi2HaD8MpIJ0J36KgCcQ
         ZN3mAMbsRxbpzwd+PI5wvBna/0jLMeECzDFDc6z4uHG64VBtXEs3fTyOlnrS9tns0SCQ
         nQUHpPi7MlMBJHP4y4EkQ1AFV22Uw/Rn2qciT3nT0m8q0rqOCO+lNCDaNywWjROReQKF
         r/vTg7Y5p2vjVcw2aeSZxSZLpKK+LEdohZL7NKrMFwYN/hKXUTNtR1jF3mscwgU78wdL
         L2YCbmrB3GUhmtW650/H6WZceWBXZnTIn6IZNim8XPBBdKjgFe862VAghsb8cL35dENz
         Xbig==
X-Gm-Message-State: AOAM530F3SO7+UNak+BScS9JRkmzoES5bmBacfL75cfQwcK7qJAHz46t
        gLF3PjfXl2xhJsLWTnw42Q==
X-Google-Smtp-Source: ABdhPJxYyVnhkkXpCnNCYmWcKTble598kdOQWM1WnmFBNHS1MKlFJTW46Jl/GPLx0rfmdruXu7as7Q==
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr1308181otb.283.1632768054214;
        Mon, 27 Sep 2021 11:40:54 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r18sm4245072ooc.27.2021.09.27.11.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:40:53 -0700 (PDT)
Received: (nullmailer pid 3622187 invoked by uid 1000);
        Mon, 27 Sep 2021 18:40:52 -0000
Date:   Mon, 27 Sep 2021 13:40:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     joel@jms.id.au, mturquette@baylibre.com, sboyd@kernel.org,
        adrian.hunter@intel.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        andrew@aj.id.au, BMC-SW@aspeedtech.com, steven_lee@aspeedtech.com
Subject: Re: [PATCH 09/10] dt-bindings: mmc: aspeed: Add max-tap-delay
 property
Message-ID: <YVIQNPbbnhIqTSuu@robh.at.kernel.org>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-10-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922103116.30652-10-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 22, 2021 at 06:31:15PM +0800, Chin-Ting Kuo wrote:
> Add max-tap-delay proptery in order to record the maximum
> tap delay on different platforms.
> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 987b287f3bff..5bb66849df65 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -37,6 +37,9 @@ properties:
>    clocks:
>      maxItems: 1
>      description: The SD/SDIO controller clock gate
> +  max-tap-delay:
> +    maxItems: 1

An array?

> +    description: The maximum delay in picosecond for SD/SDIO controller

Properties with a unit should have a standard unit suffix.

Should be common property? If not, needs a vendor prefix.

>  
>  patternProperties:
>    "^sdhci@[0-9a-f]+$":
> -- 
> 2.17.1
> 
> 
