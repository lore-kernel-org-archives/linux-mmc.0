Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC931C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 14:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D9B12084D
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579100209;
	bh=4hSgjlf+j7uAXIz4y06dxEdBrPMPHgzLbs71F0VcQCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pyynpiC/lA7WOJ8rSGMaerE7txi4VqFazSgE2mkBJB7Up8y04VYIyGR0wAaKAPFBd
	 iM2mzjWh8GH/9IHc9fHst+xZeggP3OOQ5u0DrZDopTuG5hCo7IzaTy95gkXQKxMXig
	 D5Zdwb0hZbzHIL1VKOqbC5KoJ6ubBjnyi6i196Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgAOO4s (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:56:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41573 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbgAOO4s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2020 09:56:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so16302320otc.8
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2020 06:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9gnxD+G4FNn+U8wzPNZLFG38GLzn+JUvySqC1BxpFAA=;
        b=AL4K9eP21hWUGmAelbhNEQ/GgtZsDHZgRn9iqd9mfuCge7yCeZn1L/ilIhLk/2JzZ7
         3/9k2yMN3qU+ZNeKLN0reftmk3aLN58icFX6eX/3toeJ31KubddMAxztuFHIwFNgdmC9
         6xWp9/+RuZkT+L0Wi4BpXf7n0VJQewiYSGIUrO1W0l11RnkpJ0oE+upVCwdZkgRQcujJ
         iZQxPoLI2XMYEBiXx+UbRNZ1Tf/JdDRnNBUKaleSq6+SRE+5sg4aoYXyeA0bXBLih769
         NqK86yjw1B1i56iXCXr5LMHmpWxtcB0L/tjIzf+IcKbHgHc0xT0JEA5pX9DajvGI5Hwv
         q64A==
X-Gm-Message-State: APjAAAWh00TkEl4K9pVRHshEls9EB4h84tH6OOVrXpa8eVvv08DWwq0R
        p/fQ4Y7/PJr0VuB9LqPK8d7k8bs=
X-Google-Smtp-Source: APXvYqzJH517D9ENRk9ayoI0+EdSoYXzdB617meto9J3liqZSQZhpLpKxZ1LcwzprSMU+BdSNi6Elg==
X-Received: by 2002:a9d:3d0a:: with SMTP id a10mr3012680otc.327.1579100207509;
        Wed, 15 Jan 2020 06:56:47 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e13sm5780599oie.0.2020.01.15.06.56.46
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 06:56:46 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22040c
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 08:56:45 -0600
Date:   Wed, 15 Jan 2020 08:56:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        srinivas.kandagatla@linaro.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 5/9] dt-bindings: mmc: mmci: add delay block base
 register for sdmmc
Message-ID: <20200115145645.GA599@bogus>
References: <20200110134823.14882-1-ludovic.barre@st.com>
 <20200110134823.14882-6-ludovic.barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110134823.14882-6-ludovic.barre@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jan 10, 2020 at 02:48:19PM +0100, Ludovic Barre wrote:
> To support the sdr104 mode, the sdmmc variant has a
> hardware delay block to manage the clock phase when sampling
> data received by the card.
> 
> This patch adds a second base register (optional) for
> sdmmc delay block.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index 6d3c626e017d..4ec921e4bf34 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -28,6 +28,8 @@ specific for ux500 variant:
>  - st,sig-pin-fbclk       : feedback clock signal pin used.
>  
>  specific for sdmmc variant:
> +- reg			 : a second base register may be defined if a delay
> +                           block is present and used for tuning.

Which compatibles have a 2nd reg entry?

>  - st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
>  - st,neg-edge            : data & command phase relation, generated on
>                             sd clock falling edge.
> -- 
> 2.17.1
> 
