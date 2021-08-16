Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48354C432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D91D632CC
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Aug 2021 13:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236434AbhHPNob (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Aug 2021 09:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239502AbhHPNoX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2021 09:44:23 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB2C0613CF
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:43:38 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id s19so3447432vsl.11
        for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2021 06:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4j1EPaCAhY0yofr86q8NsmPKn2PcIlUxbO8XGy4dHTs=;
        b=k1ctUmXw8Tba7zc92DCZbniyfFWUG06JGlm0mUtVJld1ZbGk+Ji87EGxcmNsPwvLig
         GcUM9sBlS9hsNBeNR/bYOahhOg9BtXmweAKZYPodcUDHgrdCbqW+6QrvZyyceU7+NZHj
         2KBcMmEqvDyr+DBfTLoPxseWqeuV9FJ88xwTur//Th+Aq3oaeX67b0BB2tgtil6t6ln4
         nPEqAfBxFUmCcvcYpaC72CdZIfMXyfK7ZVTvXHo1xHMqQvn2k+PpGYFAUmkg+Fvwy5Ei
         AcYQ+zDiTWFJF0D/ygr64qJb/uyTyT+GAeRTMExf8NMM6Bs/yYSTXDsu7v5ZL5eMqV+q
         ZIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4j1EPaCAhY0yofr86q8NsmPKn2PcIlUxbO8XGy4dHTs=;
        b=OyMTcIeLyShk0pnE/QJJ2j9EkPybFyBWI4YYXw+i5ermkEcjLNpXQKODvrplTZ5Pno
         v3HuQuxEiy2lBpWkr1LQu5QlG3RsOQnV65nS9i5M+kXS7UqL5iRxdeg9HS6VndvP095S
         vVADfY0N/GMOEx8N8604tV7VzcBqM9faGPfDjDpDCK//zGw0pBKMJ15kvT0hBRqTWiUV
         kfCY16Uz0L7wC1/KBnauoL/F9WXiN3U3IHqcEop4WwAsdm6kjIw3vQ40F1+hs1NSSRWO
         DnR1ABMgw8VmqJ97Vc6fWd7igdGafbjtOZHonBEx4LRa1OotgJrVfUmpZZJ0cuJ7hMAH
         JiEA==
X-Gm-Message-State: AOAM530HFK8LtgIjCzBl/5x6A8cL/aruKETtnvVhEEvH7l+9U6Wmwj+s
        Fn17ZRDMABCFk1475chcd0O6LN80mocw6rPg+4G65Q==
X-Google-Smtp-Source: ABdhPJzgjbK9bA+0Eua3gH02d8KWPZ08u9Nv5FoHKOi3SIlbnB5yL/IFLFJ1CzI7NyLExz40UroppQl25VpktZ3ZKDU=
X-Received: by 2002:a05:6102:5f4:: with SMTP id w20mr3836130vsf.34.1629121417313;
 Mon, 16 Aug 2021 06:43:37 -0700 (PDT)
MIME-Version: 1.0
References: <1629117508-4886-1-git-send-email-haibo.chen@nxp.com> <1629117508-4886-3-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1629117508-4886-3-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Aug 2021 15:43:01 +0200
Message-ID: <CAPDyKFqagBkbnxxh+KWbV2=sjkj3mGrKXUweOL5TrMJ1-Hmnww@mail.gmail.com>
Subject: Re: [PATCH 3/6] dt-bindings: mmc: fsl-imx-esdhc: add
 fsl,sdio-async-interrupt-enabled binding
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 16 Aug 2021 at 15:00, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Add a new fsl,sdio-async-interrupt-enabled binding for sdio devices
> which enable the async interrupt function. When get this property,
> driver will avoid to use DAT[1] for hardware auto tuning check.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index b5baf439fbac..8a9f1775b0e2 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -122,6 +122,16 @@ properties:
>        - const: state_200mhz
>        - const: sleep
>
> +  fsl,sdio-async-interrupt-enabled:
> +    description: |
> +      Recommend for SDIO cards that enables SDIO async interrupt for SDR104 and SDR50
> +      operating modes. SDIO async interrupt uses DAT[1] to signal the card's interrupt.
> +      uSDHC tuning mechanism must use DAT[0] and CMD signals to avoid a possible
> +      conflict and incorrect delay line calculated by the uSDHC auto tuning mechanism.
> +      Enabling this device tree property is only recommended for layouts that are
> +      matching the SD interface length.
> +    type: boolean

We already have a common mmc property, "cap-sdio-irq", that tells
whether the controller supports SDIO irqs (which is delivered on
DAT1).

Can't you use this instead?

> +
>  required:
>    - compatible
>    - reg
> --
> 2.17.1
>

Kind regards
Uffe
