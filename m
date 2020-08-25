Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC8C433E5
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 02:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A1F2072D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 02:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598322997;
	bh=7KbuUTHlIItfikUQbFtRLSBC7XGCJcztEERAvEv0Zg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X0pikheNJ3EGFO4BtByRCsKFQrchI73K+pTU/paTYJ5reneLTp5xq9hYr7qaruud4
	 yoMl7e9R8tIbgmAk1yOdigF1m4dLcz6jS7YY3GM0Pr/RY98KMHA3uHpBL2dSCuuvrY
	 XJGZy7TlRtQHLF3PuUD2Qz0euJ7tR4dgvUoaN17E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgHYCgc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:36:32 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36641 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbgHYCgb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Aug 2020 22:36:31 -0400
Received: by mail-il1-f196.google.com with SMTP id f75so8854939ilh.3;
        Mon, 24 Aug 2020 19:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K8h9Jb3PzDvqOlcr8sfXes3SPhzFbbE8GYhtrBX5VUM=;
        b=ThfW/U891E/P4uJbFZLBP3Sj5v28KYEim23a1T4d5+CyuajRdY+kKMiIYnAK6ZWLCR
         rlN7iMXcO+xJwDM4Xc3fbPzbHrCszQhikpAsmA9Vt3S0VgfemLzhTf5JRU4idTTRlqKH
         jQXcyUzN08g/E6QtfsuybwEUnIroDC6rjKMZ7yjwYR2JfCtDJfEEV+Kfyzz7ECnQ8raI
         cTA81hxndCsCx6uQCDsi+2JTacMwb7mKn3bXY5wC5Xs853mAZ+0R5TIvU3kkx4k0KHCl
         n32cWSrrCocXAJEz/4lscjv6027Q0Omg0EDUiSoUyhFNQXEyTjIqr7xxhr4YEIjLOSkR
         lDVA==
X-Gm-Message-State: AOAM5320Li5gGo7Sgg/H4oaSM7izwJJsYhHf3jMC2NcljZ7BrWS5pPNs
        H8QDC+tGOT6Uib/INU2jYQ==
X-Google-Smtp-Source: ABdhPJwcjroqKXf1mi5GXNQHjQ9HKA/7zcSadHqkGKotN9/NZ4WfMuEmphCyPvhsBmU9PpaSyJzjrQ==
X-Received: by 2002:a92:c50e:: with SMTP id r14mr7619717ilg.161.1598322990324;
        Mon, 24 Aug 2020 19:36:30 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d1sm8157228ila.67.2020.08.24.19.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:36:29 -0700 (PDT)
Received: (nullmailer pid 3834261 invoked by uid 1000);
        Tue, 25 Aug 2020 02:36:26 -0000
Date:   Mon, 24 Aug 2020 20:36:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Li <frank.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, Fugang Duan <fugang.duan@nxp.com>,
        linux-pwm@vger.kernel.org, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, Han Xu <han.xu@nxp.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 10/19] dt-bindings: reset: fsl, imx7-src: Add i.MX 8M
 compatibles
Message-ID: <20200825023626.GA3834231@bogus>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-10-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-10-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 24 Aug 2020 18:26:43 +0200, Krzysztof Kozlowski wrote:
> DTSes with new i.MX 8M SoCs introduce their own compatibles so add them
> to fix dtbs_check warnings like:
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: reset-controller@30390000:
>     compatible:0: 'fsl,imx8mm-src' is not one of ['fsl,imx7d-src', 'fsl,imx8mq-src', 'fsl,imx8mp-src']
>     From schema: Documentation/devicetree/bindings/reset/fsl,imx7-src.yaml
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: reset-controller@30390000:
>     compatible:1: 'syscon' was expected
> 
>   arch/arm64/boot/dts/freescale/imx8mm-evk.dt.yaml: reset-controller@30390000:
>     compatible: ['fsl,imx8mm-src', 'fsl,imx8mq-src', 'syscon'] is too long
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  .../bindings/reset/fsl,imx7-src.yaml          | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
