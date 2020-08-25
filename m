Return-Path: <SRS0=3fsM=CD=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594BFC433E4
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 04:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4722072D
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Aug 2020 04:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgHYErk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:47:40 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37881 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgHYErj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2020 00:47:39 -0400
Received: from [2001:67c:670:100:1d::c0] (helo=ptx.hi.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kAQrH-0004DB-JG; Tue, 25 Aug 2020 06:46:55 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1kAQrF-0004IR-Cn; Tue, 25 Aug 2020 06:46:53 +0200
Date:   Tue, 25 Aug 2020 06:46:53 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-15?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Li Yang <leoyang.li@nxp.com>, Han Xu <han.xu@nxp.com>,
        Frank Li <frank.li@nxp.com>, Fugang Duan <fugang.duan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 13/19] dt-bindings: nvmem: imx-ocotp: Update i.MX 8M
 compatibles
Message-ID: <20200825044653.GK13023@pengutronix.de>
References: <20200824162652.21047-1-krzk@kernel.org>
 <20200824162652.21047-13-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824162652.21047-13-krzk@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:38:05 up 187 days, 12:08, 138 users,  load average: 0.13, 0.17,
 0.18
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 24, 2020 at 06:26:46PM +0200, Krzysztof Kozlowski wrote:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - fsl,imx6q-ocotp
> +              - fsl,imx6sl-ocotp
> +              - fsl,imx6sx-ocotp
> +              - fsl,imx6ul-ocotp
> +              - fsl,imx6ull-ocotp
> +              - fsl,imx7d-ocotp
> +              - fsl,imx6sll-ocotp
> +              - fsl,imx7ulp-ocotp
> +              - fsl,imx8mq-ocotp
> +              - fsl,imx8mm-ocotp
> +              - fsl,imx8mn-ocotp
> +              - fsl,imx8mp-ocotp
> +          - const: syscon
> +      - items:
> +          # The devices are not really compatible with fsl,imx8mm-ocotp, however
> +          # the code for getting SoC revision depends on fsl,imx8mm-ocotp compatible.

Shouldn't this be fixed? It seems strange to justify a binding with
existing code.

Sascha

> +          - enum:
> +              - fsl,imx8mn-ocotp
> +              - fsl,imx8mp-ocotp
> +          - const: fsl,imx8mm-ocotp
> +          - const: syscon
>  
>    reg:
>      maxItems: 1
> -- 
> 2.17.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
