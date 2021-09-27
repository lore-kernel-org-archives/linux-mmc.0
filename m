Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F1C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 166B560FED
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 18:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235765AbhI0TAw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 15:00:52 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:42515 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235745AbhI0TAw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 15:00:52 -0400
Received: by mail-oi1-f175.google.com with SMTP id x124so26857337oix.9;
        Mon, 27 Sep 2021 11:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eV+PRo6a2MRz/DpkFNL4n5kAGNJtpr9EpyO3zFy3ARk=;
        b=JvGBmHO1v82cyGWfwYDSeTFralz1O2RFM3ucncP3Qs252oT8lQ9qpgE7Zv5se5lF6k
         5D7OfG44y+kLhbZkngH8dQg8V4yhXlXmQPLLTEpCYov9mV+r+dGxLIMTFg+xaYJnIUWV
         7ssNC9EtZ01uOwL0Zzvi7ybOxd0sY75imno1i0LX91/qqvqM+hz0edomUFlVVRwkotet
         Xkhk69w6CtOesQkfxoOiNCW8nwJTHnKEcvSieimRkYRPEGJ2TIAzhHSlhVRO8PZLKBJi
         IfHxr+xIdYdoNSaG0i/pWQeTxw6CJU72XZ5JK4BBrrr59qD9AwNoSurn2qtB6EViWmVN
         wcCA==
X-Gm-Message-State: AOAM532VvaJt9VLE0+cBFHC9pGZTtCjlNncvQ9CAaR2fuRKFw5RlJGLc
        KBOkbGB5uT8+Sa+Q0nP86w==
X-Google-Smtp-Source: ABdhPJwMJelZ7z1gOyM6KU2hxuI5UxVhhaZKlukjtCf2pvupYDr2rXhjepC7YZIdsEs7BDBH3vdEvw==
X-Received: by 2002:aca:604:: with SMTP id 4mr520177oig.8.1632769152914;
        Mon, 27 Sep 2021 11:59:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p64sm4054025oih.29.2021.09.27.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 11:59:12 -0700 (PDT)
Received: (nullmailer pid 3666744 invoked by uid 1000);
        Mon, 27 Sep 2021 18:59:11 -0000
Date:   Mon, 27 Sep 2021 13:59:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
Cc:     joel@jms.id.au, mturquette@baylibre.com, sboyd@kernel.org,
        adrian.hunter@intel.com, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        andrew@aj.id.au, BMC-SW@aspeedtech.com, steven_lee@aspeedtech.com
Subject: Re: [PATCH 10/10] dt-bindings: mmc: aspeed: Add a new compatible
 string
Message-ID: <YVIUf7/4ukMcrOb9@robh.at.kernel.org>
References: <20210922103116.30652-1-chin-ting_kuo@aspeedtech.com>
 <20210922103116.30652-11-chin-ting_kuo@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922103116.30652-11-chin-ting_kuo@aspeedtech.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Sep 22, 2021 at 06:31:16PM +0800, Chin-Ting Kuo wrote:
> Add "aspeed,ast2600-emmc" compatible string for the sake of
> distinguishing between SD and eMMC device.

Why?

Is the h/w block different? We already have properties to handle some of 
the eMMC specifics. Also, you can have a child node for the eMMC device 
if you need that.

> 
> Signed-off-by: Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>
> ---
>  Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> index 5bb66849df65..41105cd104c6 100644
> --- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
> @@ -52,6 +52,7 @@ patternProperties:
>            - aspeed,ast2400-sdhci
>            - aspeed,ast2500-sdhci
>            - aspeed,ast2600-sdhci
> +          - aspeed,ast2600-emmc
>        reg:
>          maxItems: 1
>          description: The SDHCI registers
> -- 
> 2.17.1
> 
> 
