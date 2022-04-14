Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F6DC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Apr 2022 17:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343859AbiDNRw7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbiDNRw6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Apr 2022 13:52:58 -0400
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A8EA378;
        Thu, 14 Apr 2022 10:50:33 -0700 (PDT)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-e2a00f2cc8so6007059fac.4;
        Thu, 14 Apr 2022 10:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZlR/D0/otHvTlY+2pMZcbIUNYFJQyXUlIqHiCaoR55I=;
        b=ErrRq5GIstsA7cHWWt8eBDPL3/Lh8wsdhSCHtS4HPlbLvZw7/4rfGVuzgetUVTYG/F
         TG/v+hBG67PCHvjRw3P2LSPdwMN48ZSlqCOO0n1ZpOH7u1M0WlVt1ueJdkLRYF7nxWnc
         ztulODcCg0y5g8dCKUGNQV+Xd2WkRYoqcBJHjRDuhsMfe8NjdnGykw0jFRqUZuDQkMwx
         eDaQwYQg/JiSQ9eTG0zNaoy6jnbp0Rsabm1dQ1xkSsJY0wu1sPUcSaYwQVPjjd7FeQNY
         amdRFnYBtS2lXSw9Odm13DcKENjE200EOMtv9PWYfbRh63XBpbiBwabxSmED7V+R0q7U
         Y4cQ==
X-Gm-Message-State: AOAM5311yey1KF3k+RkXRIfG4m20PLYY2wn1z+QO+2Uizr0/pwMArC0P
        Md512rsMHyLW8dHkuDkalg==
X-Google-Smtp-Source: ABdhPJypy7mWmJNc9/QEldUq576HOU25RTupCocThXERn6C1nt+ragKXT7nAwRK3TsE76ih0pgog5w==
X-Received: by 2002:a05:6870:e30e:b0:de:ab76:eed7 with SMTP id z14-20020a056870e30e00b000deab76eed7mr2022092oad.101.1649958632925;
        Thu, 14 Apr 2022 10:50:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056830290300b005b2316db9c9sm256305otu.30.2022.04.14.10.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:50:32 -0700 (PDT)
Received: (nullmailer pid 2302839 invoked by uid 1000);
        Thu, 14 Apr 2022 17:50:31 -0000
Date:   Thu, 14 Apr 2022 12:50:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, netdev@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v6 11/13] dt-bindings: phy: mxs-usb-phy: Add i.MX8DXL
 compatible string
Message-ID: <Ylhe5/7DWU1DPly7@robh.at.kernel.org>
References: <20220413103356.3433637-1-abel.vesa@nxp.com>
 <20220413103356.3433637-12-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413103356.3433637-12-abel.vesa@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 13 Apr 2022 13:33:54 +0300, Abel Vesa wrote:
> Add compatible for i.MX8DXL USB PHY.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/mxs-usb-phy.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
