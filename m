Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A0AC432BE
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFDD610D2
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Aug 2021 14:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240533AbhHSOLv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Aug 2021 10:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240547AbhHSOLu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Aug 2021 10:11:50 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464C8C061575
        for <linux-mmc@vger.kernel.org>; Thu, 19 Aug 2021 07:11:14 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1mGil6-0002Bo-5p; Thu, 19 Aug 2021 16:11:04 +0200
Message-ID: <bb658c8013e2e8e38c21b83d59eec7046d939097.camel@pengutronix.de>
Subject: Re: [PATCH v2 3/6] dt-bindings: mmc: fsl-imx-esdhc: add fsl,
 broken-auto-tuning binding
From:   Lucas Stach <l.stach@pengutronix.de>
To:     haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de
Cc:     devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 19 Aug 2021 16:11:01 +0200
In-Reply-To: <1629285415-7495-3-git-send-email-haibo.chen@nxp.com>
References: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
         <1629285415-7495-3-git-send-email-haibo.chen@nxp.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-mmc@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Haibo,

Am Mittwoch, dem 18.08.2021 um 19:16 +0800 schrieb haibo.chen@nxp.com:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add a new fsl,broken-auto-tuning binding for sdio devices. When sdio
> device support sdio interrupt, need to use this property to disable
> auto-tuning. Auto-tuning circuit is conflict with sdio interrupt.
> 
Wouldn't it be possible to do this automatically by the driver without
a DT property when a SDIO card is detected?

Regards,
Lucas

> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index b5baf439fbac..d7c8e5880473 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -93,6 +93,15 @@ properties:
>        tuning step can't find the proper delay window within limited tuning retries.
>      default: 0
>  
> +  fsl,broken-auto-tuning:
> +    description: |
> +      Recommend for SDIO cards that enables SDIO interrupt for SDR104 and SDR50 mode.
> +      SDIO interrupt uses DAT[1] to signal the card's interrupt. Auto-tuning circuit
> +      will detect this interrupt on DAT[1] when in 4Bit bus mode, and take it just
> +      as normal data, wrongly adjust the delay cell. This property is used to disable
> +      the auto-tuning function.
> +    type: boolean
> +
>    fsl,strobe-dll-delay-target:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description: |


