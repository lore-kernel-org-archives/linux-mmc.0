Return-Path: <SRS0=ayAG=3E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01028C33CB1
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA8624656
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Jan 2020 15:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579103405;
	bh=jLqDV64pAlXOUia4wz8vrkob1sYuRxZFLQiK/Lx0pyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RKuWYSMgeTA2P0VveYtDA2YiRL+rTa1vXqZs9pXIe6vGOVQY1Ziugp7RqR5PFyIUV
	 ddOCO8+JRrOxTF2f1dpZdhyM7XLmors6a4cxcXUFvLX/vBeTpeLLB2ol4UNgLiHfy5
	 5wUfkRpyrZzm8s7/1+/I8kiTHUbG8Lg3rdFWRiRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgAOPuF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:50:05 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35057 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgAOPuF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2020 10:50:05 -0500
Received: by mail-oi1-f195.google.com with SMTP id k4so15826660oik.2
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2020 07:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B7DX59sNSuvGuHSzjzaWJDesXQ6glcdz/pP97LB2HkM=;
        b=medWnEalNsKV/u9tDQs/gNLvC54xAqltAIP+Gr9MFvtSGvyfIB9D6nOzI/NoQo2CCv
         qRP7tyuAwqGN93KldEODHk0dUDEtBXKXCcG+CRxSGvScVGTBtGBkW+L4Bby2lx6VWpIg
         8a9C02NaSOW6oJdzvR5yK5cp0lHEj9S50QQVBwzKXvidfBU3Lh/1HAQFWsYRxZhQeMND
         aE+Sb6YkbCaneczXGxAkqNNIPCxrCgH0P/uoFGZ5b6FwkpyGXpy0zqVnBGlKBEN0JjG4
         8Bxjanj0dCBPeDWZr3e6jrnn+5EKUFy0aoU7s6oo1ZzdBS/jSerlJ8IKvMiKOhsyNk16
         7dXA==
X-Gm-Message-State: APjAAAUl9LwF1/nLA/9mO6gKwqoXK+TelsLyySRPVwyt8lknbPXfFucW
        QUH5XmtUBdQI0yXZDWFVKpLihxA=
X-Google-Smtp-Source: APXvYqy9aM2wmfVgx8NgUhRLLHzz/rZS4G8spMXzATBkuwWhu4dUpRhr+C/ycwrvnLK7MI5kdbaGIA==
X-Received: by 2002:aca:f555:: with SMTP id t82mr313252oih.103.1579103403721;
        Wed, 15 Jan 2020 07:50:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e69sm902400ote.0.2020.01.15.07.50.02
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:50:02 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22040c
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:43:35 -0600
Date:   Wed, 15 Jan 2020 09:43:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mark.rutland@arm.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        broonie@kernel.org, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, rjones@gateworks.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        aisheng.dong@nxp.com, richard.hu@technexion.com, angus@akkea.ca,
        cosmin.stoica@nxp.com, l.stach@pengutronix.de,
        rabeeh@solid-run.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, jun.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 4/7] dt-bindings: spi: imx: Add
 i.MX8MM/i.MX8MN/i.MX8MP compatible
Message-ID: <20200115154335.GA15650@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Jan 13, 2020 at 01:33:19PM +0800, Anson Huang wrote:
> Add compatbile for imx8mm/imx8mn/imx8mp.

checkpatch reports a typo.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 2d32641..33bc58f 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -10,7 +10,10 @@ Required properties:
>    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
>    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
>    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
> -  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
> +  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
> +  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
> +  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
> +  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain CSPI/eCSPI interrupt
>  - clocks : Clock specifiers for both ipg and per clocks.
> -- 
> 2.7.4
> 
