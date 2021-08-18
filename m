Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F741C4338F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 18:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AAD610FF
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Aug 2021 18:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhHRSth (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Aug 2021 14:49:37 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33784 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhHRStd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 14:49:33 -0400
Received: by mail-ot1-f54.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so5369752oti.0;
        Wed, 18 Aug 2021 11:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mFM10FkKUqKwfO9MnVHXIsn1wrjSk6OwROs1K7AMqrE=;
        b=Y41fRhxhCxqSEISNnnrIBTZ0vTmxbVCQrvQqTw+9XXBxWrCm8TVXyo0Ay3C8C09TMq
         CRMIryDbtu51v1xwBVS1Xsag4NqDThGmRB4NsYO+FpK6XaaoFDadxOp7GwgrAmGrWNsZ
         OMSrdp2fhbyQC+mKhAp42AHdlj0Dd+MXpKaKiVlrdoCD+NA4Jbh3qYnpO1f3aS9XGytb
         jLgmSzBHwGburc+452deL9yB+Wl9sV5A+AHwOZptcVV8PolVMxElfIOc9o9Wbs0ML5G5
         s0UXjUNzg0eX/OC47VzRlnkKQ9NFjF8CpyLNfNhLozV7aVjGf3PSI8kPT+egtAcKbdEq
         0mwA==
X-Gm-Message-State: AOAM532aalgn+eqzRATPlf8z6CCW51VOI50oKzLZs3TWb5kVCnXTSdUA
        J+cIS47lBc1TxwTVN8ffHA==
X-Google-Smtp-Source: ABdhPJwNqWe9L4q1pV8YiVvQEWr2wvPBzy6QVVut+3EmfxypdzCijfLr3sz1yBEajCTLBSX3AX+ySQ==
X-Received: by 2002:a05:6830:1bc1:: with SMTP id v1mr7980785ota.246.1629312534574;
        Wed, 18 Aug 2021 11:48:54 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n73sm217973oig.9.2021.08.18.11.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:48:53 -0700 (PDT)
Received: (nullmailer pid 2901547 invoked by uid 1000);
        Wed, 18 Aug 2021 18:48:52 -0000
Date:   Wed, 18 Aug 2021 13:48:52 -0500
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-mmc@vger.kernel.org, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/6] dt-bindings: mmc: fsl-imx-esdhc: add
 fsl,broken-auto-tuning binding
Message-ID: <YR1WFGUGS3pERnOD@robh.at.kernel.org>
References: <1629285415-7495-1-git-send-email-haibo.chen@nxp.com>
 <1629285415-7495-3-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629285415-7495-3-git-send-email-haibo.chen@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 18, 2021 at 07:16:52PM +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Add a new fsl,broken-auto-tuning binding for sdio devices. When sdio
> device support sdio interrupt, need to use this property to disable
> auto-tuning. Auto-tuning circuit is conflict with sdio interrupt.
> 
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

Seems like something that could be broken on a variety of hosts and 
should be common?

If auto tuning is broken, shouldn't that speed be disabled?

Rob
