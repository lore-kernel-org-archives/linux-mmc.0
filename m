Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284ECC04FF3
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 100826108E
	for <linux-mmc@archiver.kernel.org>; Mon, 24 May 2021 14:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhEXOMx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 May 2021 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbhEXOMs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 May 2021 10:12:48 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA75C061574
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:18 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id f15so12988457vsq.12
        for <linux-mmc@vger.kernel.org>; Mon, 24 May 2021 07:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY6jyrsjJi+HRe/mQv1siQhxLxlSd/Eu9JyaCf+aU6s=;
        b=IXs1jXps0iRBX4YK9sEw4oHXipJS2Vdcqg8JktkfHSIi5jU2oVnIJyIAzOS7eZcYNw
         o5mQqMSbTrVSYXiNmkgb0meO+JonZ1dPBDOVINXK2+9ItmqFWGyVdMbhgZwgJLiArKJQ
         vme5ZxZkosQY3pAdTR1TV4i1TkPBo7lCLx8I1moZEsxTAtfhMYwytO4EnwYpgJ88/bO5
         Inh2i9pYEld/fb+HBFPhty7+WIUSjWjNfL1o9SWOmWowtK+9L75wswYYxZdw2SC0KmgP
         BCf8MKMOK6BGch3AhVUMN0zBUIOqiKqKbaiOu9JBcy6MXM3W/dcOrvoTlR9yF5TcNblt
         jVig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY6jyrsjJi+HRe/mQv1siQhxLxlSd/Eu9JyaCf+aU6s=;
        b=X+WgrC4r95T7saJ9D8nF89qDXE0pyI/wjSvrCIFypF3gf0ZRSHqaaHKO6sfkKIe4W2
         uckyItnHaHVfzmj7NHRrBdu7BBXPveo2dESX2sQCNp/2JVuOy5NuXHmu3NBwfBHxym7i
         +6Ri32ZJ1TZJWCt993OCQu/9VJ7wsCc3gFl9bEUxvYPfv7ZW7lg2kR80DYeIOrCQN6XM
         qPWPL2nS7Z7U3DlBhBP6O48LFdgism8AbIq2pILGUbyIWnLGA4FXNfome4A+ccfomaoD
         3nBl05LrLCc2UZF78BIluDoecbsD5o9+vXlxsAK6pxZw7QlmlSr1GJYl8W3eoPfLGjJ+
         7QSQ==
X-Gm-Message-State: AOAM532dHkfHwYi6eb9+BFrwXW5XInd3l06k1q1zfgoMviCTXkG2hYcQ
        qvhxpSy0pw4RzRoOzVJSBqkaBZoiyhcX4JtCgJadFw==
X-Google-Smtp-Source: ABdhPJzy5pWzjYOdI2C/JAdvDJO42gMZKBOGSCRG9HkPRjrjrvdlF4IEcTEM2E/bQlE0mUc+P4Djeej/ypqMDjf5eb0=
X-Received: by 2002:a05:6102:7c1:: with SMTP id y1mr22086341vsg.34.1621865478143;
 Mon, 24 May 2021 07:11:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210519153712.3146025-1-robh@kernel.org>
In-Reply-To: <20210519153712.3146025-1-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 24 May 2021 16:10:40 +0200
Message-ID: <CAPDyKFq-dFj2sS3gsh=oBywmoTKkxojYCq8B8Gn5kXyEiFChKA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: Clean-up examples to match
 documented bindings
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 May 2021 at 17:37, Rob Herring <robh@kernel.org> wrote:
>
> The "sdhci" compatible is not documented though used as a fallback in a
> few cases. It is also not supported by a Linux driver. Just remove the
> example as part of ridding examples of undocumented bindings.
>
> The "brcm,bcm43xx-fmac" compatible is also not documented. Update the
> example to use one of the correct ones, "brcm,bcm4329-fmac", instead and
> use a device class based nodename.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
>  - Also fix "brcm,bcm43xx-fmac" example
>
>  .../bindings/mmc/mmc-controller.yaml          | 20 ++-----------------
>  1 file changed, 2 insertions(+), 18 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index e141330c1114..646ae768d625 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -357,22 +357,6 @@ dependencies:
>  additionalProperties: true
>
>  examples:
> -  - |
> -    mmc@ab000000 {
> -        compatible = "sdhci";
> -        reg = <0xab000000 0x200>;
> -        interrupts = <23>;
> -        bus-width = <4>;
> -        cd-gpios = <&gpio 69 0>;
> -        cd-inverted;
> -        wp-gpios = <&gpio 70 0>;
> -        max-frequency = <50000000>;
> -        keep-power-in-suspend;
> -        wakeup-source;
> -        mmc-pwrseq = <&sdhci0_pwrseq>;
> -        clk-phase-sd-hs = <63>, <72>;
> -    };
> -
>    - |
>      mmc3: mmc@1c12000 {
>          #address-cells = <1>;
> @@ -385,9 +369,9 @@ examples:
>          non-removable;
>          mmc-pwrseq = <&sdhci0_pwrseq>;
>
> -        brcmf: bcrmf@1 {
> +        brcmf: wifi@1 {
>              reg = <1>;
> -            compatible = "brcm,bcm43xx-fmac";
> +            compatible = "brcm,bcm4329-fmac";
>              interrupt-parent = <&pio>;
>              interrupts = <10 8>;
>              interrupt-names = "host-wake";
> --
> 2.27.0
>
