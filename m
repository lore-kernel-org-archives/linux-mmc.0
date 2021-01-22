Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6607C433E6
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A28A923A79
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Jan 2021 17:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbhAVQwy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Jan 2021 11:52:54 -0500
Received: from mail-oo1-f53.google.com ([209.85.161.53]:37799 "EHLO
        mail-oo1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbhAVQix (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jan 2021 11:38:53 -0500
Received: by mail-oo1-f53.google.com with SMTP id q3so1541058oog.4;
        Fri, 22 Jan 2021 08:38:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IJqXZextJeUoTrX2V4E3ao4hSBB8OJuxy8CcBdR+FQY=;
        b=DPmhP9FsrhGmYWP40aiGXFJvArCOkYXz9CuwEdC6LrWg0626oue+f9D9J9Dohlry1x
         fQkPf8uqnPkDnMiS6jfDGr8LJ4mRcACX2SrKru4zAUwf0wlQ0yNbRmAN1/l8UCI1lxvN
         wqn3QkwjU+AAOSyAzF2Ui2l7BvP/Q0lb5varR8tBS09aGHmb9UP5v8d5vYwA6FGlV2M0
         mrCvMAfIXEa//+XznuwEpeswmz5hm0664prEYAS+9Y2tYGEKFYro71pR1DrPCJ6Lw8sP
         bw2OQGIjPRQAf+Ou4Z5PBrFKOcLTnom5CF9tOMv+juzCWNhBI5auM8EQSYiMqjAPzcTM
         6k1Q==
X-Gm-Message-State: AOAM533EIrCVDNcS063s6tAyqeUlQrhYi3/c/Jpckps23+CvoEbb2qlD
        Oa4+GRZpKxKz52Lr0t4bByNURYwo9g==
X-Google-Smtp-Source: ABdhPJxowEC7A+jxQgyMDuvGBD3AQBCNNvXJhAvODEqewhmKdy74t4Rl7eWduqx9NYmKPCGSjq3uJA==
X-Received: by 2002:a4a:96b3:: with SMTP id s48mr4378855ooi.11.1611333493835;
        Fri, 22 Jan 2021 08:38:13 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s66sm1659949ooa.37.2021.01.22.08.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 08:38:12 -0800 (PST)
Received: (nullmailer pid 929869 invoked by uid 1000);
        Fri, 22 Jan 2021 16:38:11 -0000
Date:   Fri, 22 Jan 2021 10:38:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     peng.fan@nxp.com
Cc:     ulf.hansson@linaro.org, shawnguo@kernel.org,
        adrian.hunter@intel.com, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] dt-bindings: mmc: fsl-imx-esdhc: add pinctrl
 bindings
Message-ID: <20210122163811.GA926374@robh.at.kernel.org>
References: <1611198593-16287-1-git-send-email-peng.fan@nxp.com>
 <1611198593-16287-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611198593-16287-2-git-send-email-peng.fan@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 21, 2021 at 11:09:50AM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add pinctrl bindings for fsl-imx-esdhc yaml
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 802c9df23752..f91e97cd7d4e 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -103,6 +103,31 @@ properties:
>        Only eMMC HS400 mode need to take care of this property.
>      default: 0
>  
> +  pinctrl-0:
> +    minItems: 1
> +    maxItems: 2
> +
> +  pinctrl-1:
> +    minItems: 1
> +    maxItems: 2
> +
> +  pinctrl-2:
> +    minItems: 1
> +    maxItems: 2
> +
> +  pinctrl-3:
> +    minItems: 1
> +    maxItems: 2

You can drop these. They are automatically added and there's not 
anything additional to describe here that's useful.

> +
> +  pinctrl-names:
> +    minItems: 1
> +    maxItems: 4
> +    items:
> +      - const: default
> +      - const: state_100mhz
> +      - const: state_200mhz
> +      - const: sleep

This should stay since you are defining the names.

Rob
