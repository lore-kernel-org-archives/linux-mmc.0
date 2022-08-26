Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CC2ECAAA3
	for <linux-mmc@archiver.kernel.org>; Fri, 26 Aug 2022 09:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245682AbiHZJRU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245688AbiHZJRT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Aug 2022 05:17:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C40D741A
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2022 02:17:17 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq23so1212175lfb.7
        for <linux-mmc@vger.kernel.org>; Fri, 26 Aug 2022 02:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=kWwbtT/54FyUEO6wWPpRIwL8GLUA5z0zpRQ+oeLgI4Q=;
        b=uJjezohYlWYNbj23GA51zYTVzXsn8I7264i22VBOIJep8GJraT5Hxo5M2oUcFlo9t8
         miozsWwpM3suEEtBt/XymJNCw64FRkiKlXgLuk+td0iSoBnLuR3IjxKDuSMEg1oOIAx2
         YaYjoRrDhOf1VkNfbMKgnBkwWrze5ZOktyz2+9aItoZaAoCq3E50LjaR4Vd7q3llBgek
         uymRe4/ctK+sj5GKuRojGTMF93WUrWkgQ+kaPtPbme2aSJoAJvPusqJ8rkCY3JZDJVRD
         mD23zRydF7fb5y61iBYTCxjfz2nhqt9YuXXWADe6g2P+GZhJGHmj6S8qeAZ9UvB/QttY
         masg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=kWwbtT/54FyUEO6wWPpRIwL8GLUA5z0zpRQ+oeLgI4Q=;
        b=j6EjXHKkoAH8/osSiEfNH3QCl0y5tqGpdyIn6CPcwECtOF9iGRKkaHf1BFICvM7Ht7
         XC0D9IF/6UB3cHysEp57GEcz4WG+Camj+eKU/vggvQ10OZE+MLxjqGAqtunsX3aHvdOf
         SplD5w6f8Zbus0sOuK3ZPQP9wAXskmzVZOVdvyO9vUU+EkvRI2vpomXIhkjcXbDoZrB7
         SrSUXHsJoBTh9nTZF+PY3bdweb7j5BfYyzJ8PItFd64AjCy/6Hy9BHSrzKPHkjycEku7
         ECiu/rsoAxtn3IvidPCIzaQMZbrrRZV0tEcn8Ft/WByZVLwuo7DTSkf4s0Z88IIXKj1X
         vOIg==
X-Gm-Message-State: ACgBeo17FSycySzy3CIxlr/Qvhbxp0O9g2/f5CYzAUwMvNc7YaLYq1JM
        sGosDbygAM9GGoASwmfKD4X6yTX4Nukbm3ywP+J3HQ==
X-Google-Smtp-Source: AA6agR6c3bAZ3/2TopOviym18sXnze1yRcZBfeJcwIh55DYHGT4eqQP86GgpcX4QIr2GKajCvRrr7MX6kWdrKaBnJ2o=
X-Received: by 2002:a05:6512:6ca:b0:492:ef21:c085 with SMTP id
 u10-20020a05651206ca00b00492ef21c085mr2340299lff.71.1661505435752; Fri, 26
 Aug 2022 02:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190729.32358-1-a-nandan@ti.com> <20220819190729.32358-3-a-nandan@ti.com>
In-Reply-To: <20220819190729.32358-3-a-nandan@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 26 Aug 2022 11:16:38 +0200
Message-ID: <CAPDyKFpn+3MUA-Vp9cnY8a=rpg0kLQk0_c5+4=FgF0FbW7mxLg@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: mmc: Fix 'dma-coherent' was unexpected
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
        Hari Nagalla <hnagalla@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 19 Aug 2022 at 21:07, Apurva Nandan <a-nandan@ti.com> wrote:
>
> dma-coherent is mentioned in almost all TI K3 platform mmc
> nodes. Fix warning generated due to its missing match in
> yaml schema.
>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 0ab07759b472..ea9121fb188d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -51,6 +51,9 @@ properties:
>
>    sdhci-caps-mask: true
>
> +  dma-coherent:
> +    type: boolean
> +
>    # PHY output tap delays:
>    # Used to delay the data valid window and align it to the sampling clock.
>    # Binding needs to be provided for each supported speed mode otherwise the
> --
> 2.17.1
>
