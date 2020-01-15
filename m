Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18BDC33CB3
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 01:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93BC02467A
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 01:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579053044;
	bh=UxnaQGzIT0+PGL8esA8JIS3vl1vobjBqLQe1d6qSd/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2fU8BcwcoVy4iWjLOmNqmWqEyU4GF0Zg/GvWaRfnZ+LGJ/KM7v7PplN3TsGnOr5V+
	 fJORvDY+ngC54Tx+3JAe2/9f04YfNIbOpLoqtppVOeCYIx/EQnhlxJuH7OnS5Wz6O/
	 27fNLoktGMuDDvoNcq/IbOCkpLL/TXM+9IDo2VuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgAOBun (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Jan 2020 20:50:43 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37154 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgAOBuk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jan 2020 20:50:40 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so14713024otn.4
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2020 17:50:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x+DC5uDF1yRidwXaAC7rLMyWxsUNF7MxyQx/Ttg6A48=;
        b=XFwLIQpQd48ALuGdpkqT2VJoZmVQEOpJG5vRFXMQVeaAs+MCZbqMM05p2XDj9HIksn
         QCewwIlDg7XO5SgI0hVJj3wWutfQjysFTxwoKj9nnoz9uqRn6EFj1JGadNgZmt/1REGE
         Cidfp8QTw4zfNHN2NAex0n3XFZ1hZIqBOcm7SUHnA9oM/J2ArrkNhj8UudrPjB4Prrhp
         FLn81ySVQkxsxCM3Ja0BdV/OQx+Pf27i3BC3YKZm8+IGsUXq91ozW8YkyDFe4aKGfNAo
         E6f7KFxxy2GdkTnIx3wCEVGuXb5WvhKp2E1UEkpAkMz/wAcyOLnH2lVUcnJYbp6+wRK8
         6AnA==
X-Gm-Message-State: APjAAAX/K5GQ6zNbxBf4Ve4uTVfumy3j02bVZ2gyc4v9+gaRW/N+GkoD
        gk4c9kU/wdSCBmtf+oB5J4TjHgE=
X-Google-Smtp-Source: APXvYqxjzdh52XeBvFNa1TvWPjj+A8UfeEo2GdEBWWwNtB0gWJF5Q4IaI85pB6oe8McHSAt2o3qT3Q==
X-Received: by 2002:a9d:5545:: with SMTP id h5mr1095484oti.296.1579053039294;
        Tue, 14 Jan 2020 17:50:39 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm5252826oie.0.2020.01.14.17.50.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 17:50:38 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220a2e
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Tue, 14 Jan 2020 19:50:37 -0600
Date:   Tue, 14 Jan 2020 19:50:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com
Subject: Re: [PATCH 1/3] dt-bindings: mmc: sdhci-am654: Update Output tap
 delay binding
Message-ID: <20200115015037.GA26114@bogus>
References: <20200108150920.14547-1-faiz_abbas@ti.com>
 <20200108150920.14547-2-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108150920.14547-2-faiz_abbas@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Jan 08, 2020 at 08:39:18PM +0530, Faiz Abbas wrote:
> According to latest AM65x Data Manual[1], a different output tap delay
> value is recommended for all speed modes. Therefore, replace the
> ti,otap-del-sel binding with one ti,otap-del-sel- for each MMC/SD speed
> mode.
> 
> [1] http://www.ti.com/lit/gpn/am6526
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-am654.txt   | 21 +++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> index 50e87df47971..c6ccecb9ae5a 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.txt
> @@ -18,7 +18,20 @@ Required Properties:
>  	- clocks: Handles to the clock inputs.
>  	- clock-names: Tuple including "clk_xin" and "clk_ahb"
>  	- interrupts: Interrupt specifiers
> -	- ti,otap-del-sel: Output Tap Delay select
> +	Output tap delay for each speed mode:
> +	- ti,otap-del-sel-legacy
> +	- ti,otap-del-sel-mmc-hs
> +	- ti,otap-del-sel-sd-hs
> +	- ti,otap-del-sel-sdr12
> +	- ti,otap-del-sel-sdr25
> +	- ti,otap-del-sel-sdr50
> +	- ti,otap-del-sel-sdr104
> +	- ti,otap-del-sel-ddr50
> +	- ti,otap-del-sel-ddr52
> +	- ti,otap-del-sel-hs200
> +	- ti,otap-del-sel-hs400
> +	  These bindings must be provided otherwise the driver will disable the
> +	  corresponding speed mode (i.e. all nodes must provide at least -legacy)

Why not just extend the existing property to be an array. We already 
have properties to enable/disable speed modes.

>  
>  Optional Properties (Required for ti,am654-sdhci-5.1 and ti,j721e-sdhci-8bit):
>  	- ti,trm-icp: DLL trim select
> @@ -38,6 +51,10 @@ Example:
>  		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
>  		sdhci-caps-mask = <0x80000007 0x0>;
>  		mmc-ddr-1_8v;
> -		ti,otap-del-sel = <0x2>;
> +		ti,otap-del-sel-legacy = <0x0>;
> +		ti,otap-del-sel-mmc-hs = <0x0>;
> +		ti,otap-del-sel-ddr52 = <0x5>;
> +		ti,otap-del-sel-hs200 = <0x5>;
> +		ti,otap-del-sel-hs400 = <0x0>;
>  		ti,trm-icp = <0x8>;
>  	};
> -- 
> 2.19.2
> 
