Return-Path: <SRS0=N9dB=5P=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A4DC2D0E5
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 16:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CDDE20780
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Mar 2020 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585585689;
	bh=6RPaIUBO7fLLSXtfF+V8XGbHNXoxt/ndTSxvAR1MYKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FkUf1Wj4Kv+scAZppyUgnd/n0gBDvjw6CuBnE+Q0Ux1F+6MQjFGUH3E1kyNcA7XC+
	 +vYQ3KQT0XSk6UvXJzL47VtJjEmqIYu3WUSH/UpRPH6+qKsAbnjheu9j9+jdyJlT+y
	 it5YcV2gr0gB62igEWvSPKc9vbXoTzNblEThaLpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgC3Q2J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:28:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34849 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgC3Q2I (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2020 12:28:08 -0400
Received: by mail-io1-f67.google.com with SMTP id o3so12844301ioh.2;
        Mon, 30 Mar 2020 09:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4xE6WgRPY/ofYo+AU3gHyBfgox1LqQ8FIlPCkJQGyk=;
        b=r0+96FptN8CJH6y52dEDWtF2x7ozTX8GYAfp2guU5/nTMdUudznJcGBi/7gtFHyDil
         dWpdib+DqQ7cJmMuRABgNaXNAO+IzRJ20xfl9dzBfqtGF/rbSG0qUDjXHDsWR7yPr7lu
         N3zbEpcTMf/3d1+9e3MTvHzLCEBkDIb+1SFociNGPrVBWMdb5C0ivuJB9QD9JsecJ575
         bbyxbwrimxAQhvlxxRwuPyMeI6Ts6NhWhQzQtj1irN2Gzb3mcfAU64R2Du0LgRcSkATD
         rMJVgKsleN0Y+cUxCLDpJHvM/0mH30bPM2FXq/genQ6yGMc+6X6n/ATY0gviaAszj1Z9
         pFxA==
X-Gm-Message-State: ANhLgQ22giKhDQosQxGwHYk1a9Wxnsq6/AV1fQjjfOi088CI5VHTZdNW
        ixkqkA2HxqJMHmSkNzdWRA==
X-Google-Smtp-Source: ADFU+vtqY4AfJ9Mj+w3Ew+uvBRq1gXk3qUFKAIQJlsvqmcTWMhltCzJINAWQvEG/UaLUJ+dp7lTSjQ==
X-Received: by 2002:a02:a85:: with SMTP id 127mr11347531jaw.51.1585585686698;
        Mon, 30 Mar 2020 09:28:06 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s66sm5031561ilc.9.2020.03.30.09.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 09:28:05 -0700 (PDT)
Received: (nullmailer pid 28168 invoked by uid 1000);
        Mon, 30 Mar 2020 16:28:04 -0000
Date:   Mon, 30 Mar 2020 10:28:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com
Subject: Re: [PATCH v5 1/3] dt-bindings: mmc: Document the Amlogic Meson SDHC
 MMC host controller
Message-ID: <20200330162804.GA27288@bogus>
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com>
 <20200328003249.1248978-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328003249.1248978-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Mar 28, 2020 at 01:32:47AM +0100, Martin Blumenstingl wrote:
> This documents the devicetree bindings for the SDHC MMC host controller
> found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
> bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
> HS200 mode (up to 100MHz clock). It embeds an internal clock controller
> which outputs four clocks (mod_clk, sd_clk, tx_clk and rx_clk) and is
> fed by four external input clocks (clkin[0-3]). "pclk" is the module
> register clock, it has to be enabled to access the registers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 83 +++++++++++++++++++
>  .../dt-bindings/clock/meson-mx-sdhc-clkc.h    |  8 ++
>  2 files changed, 91 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml
>  create mode 100644 include/dt-bindings/clock/meson-mx-sdhc-clkc.h

Reviewed-by: Rob Herring <robh@kernel.org>
