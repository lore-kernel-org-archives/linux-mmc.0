Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2419C433EF
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Feb 2022 15:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355762AbiBNPX6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Feb 2022 10:23:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348353AbiBNPX4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2022 10:23:56 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9E5FF3A
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2022 07:23:48 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id t14so22709859ljh.8
        for <linux-mmc@vger.kernel.org>; Mon, 14 Feb 2022 07:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2Wzb73CCNJjymF4wVIRvovDIYwgk4oVDBjnM/KPNjs=;
        b=elp+5cTpAjU+1/ip79o/mzc94QPWcQLdADxYuHtbbb35WzwfcPePrjIkqA6nuvK8xr
         BlOV7/fKbg5q5P9bz1KGyaJV/tyQmgBVmkZV6IF4hLzxK/M/yGuI4KFp45wWoNuOU6i+
         glNkY+TH9jAi2XDKFPtdZNEXktN0yfyVN6LxczV5G2xn4w0voWRmzdUNDm3gYWGNh/po
         qp+PgBVIPqPEVbsxoB4OXVtFlH21t4pxQaCpVbsDuB++qcxTQ9nl8g8Fxy+AiSgYn63p
         agFwAWRXcAeQNjE2W5r47S8l4JFw7/FhVRMzFrFto1pRWpdlWen+Rq8WTSI64k4A6UfU
         MRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Wzb73CCNJjymF4wVIRvovDIYwgk4oVDBjnM/KPNjs=;
        b=flLy+VjtMFSACSEhA/wbyYHt+iFke4tJSlIkR+R9q90E5TCmXvIlb+rGbs/eZd8X8P
         PyEnqj6cwU1x0znKvwNaYnKddDXah4JBqoNWMjO54576yh87C94H79hsWZnKb1xCe0Jq
         lS2DiWiYccbwoIXOs3FjHfDr+Lf4BQCJWudpYlaASpjN0dDliR3r1ZZO2Rwo/Pu/60Ue
         L2NNG3LdYCz7PBXyis1AScXMtvCqhtrrsj54ANyoiBJ2MIqYyf9iDRlWcBJ3X7IkGeQs
         fh4TJkHwh08MuVyuaPk7bvyiySjesLv24pO4MGQ1iYCmgL51epFW2BEkfn0529wD15G7
         xizw==
X-Gm-Message-State: AOAM530Pu2VeDpK+arqWSj0XqojpoeRl5EdSih6lOolrvZD0C+f3clPk
        l13pP7wAQdaNEZxqfAmnNqQv/gZlEAHFhX3905/5eA==
X-Google-Smtp-Source: ABdhPJzfciI7TngcTILpWVQuCNuuqqSMq2cqqqebQNnx9wghhN7LjSSWuFvn2nKCKlLwBdlHEDzZrWnTrQa46CaiDAA=
X-Received: by 2002:a05:651c:179c:: with SMTP id bn28mr188158ljb.4.1644852226434;
 Mon, 14 Feb 2022 07:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20220119103212.13158-1-axe.yang@mediatek.com> <20220119103212.13158-2-axe.yang@mediatek.com>
In-Reply-To: <20220119103212.13158-2-axe.yang@mediatek.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Feb 2022 16:23:10 +0100
Message-ID: <CAPDyKFr8bV+1uTbuhMObvORLGJHsvZHUONJkdY54MXPPRWL5Qw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: mmc: add cap-sdio-async-irq flag
To:     Axe Yang <axe.yang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 19 Jan 2022 at 11:32, Axe Yang <axe.yang@mediatek.com> wrote:
>
> Asynchronous interrupt is a mechanism that allow SDIO devices alarm
> interrupt when host stop providing clock to card. Add a DT flag to
> enable this feature if it is supported by SDIO card.
>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 513f3c8758aa..16fb06f88471 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -165,6 +165,11 @@ properties:
>      description:
>        eMMC hardware reset is supported
>
> +  cap-sdio-async-irq:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      SDIO async interrupt is supported.

We already have a DT property for this, I believe.

"wakeup-source" is probably what you want, but we have additional
properties that are related to this too. See more below.

> +
>    cap-sdio-irq:
>      $ref: /schemas/types.yaml#/definitions/flag
>      description:

The above, "cap-sdio-irq", informs whether the SDIO IRQs can be
supported at all, by the host controller.

The property "keep-power-in-suspend" informs whether we can preserve
the power to the card during a suspend/resume cycle. This should be
needed in your case too, I think.

In other words, you may need to combine "cap-sdio-irq",
"wakeup-source" and "keep-power-in-suspend" to describe your HW.

However, what perhaps is missing, is a common MMC/SDIO binding that
let us describe an optional irq-line, which sometimes is being used
for the wakeup irq. In the sdhci-omap case, we look for an irq mapping
towards "wakeup" if specified in the "interrupt-names" property.

In some case, when the SDIO card supports an out-of-band IRQ line, the
similar should be specified in the child-node corresponding to the
SDIO card.

Kind regards
Uffe
