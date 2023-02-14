Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5013C64EC7
	for <linux-mmc@archiver.kernel.org>; Tue, 14 Feb 2023 12:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjBNMTm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 14 Feb 2023 07:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjBNMTl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Feb 2023 07:19:41 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C6D279B1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:15 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id e1so5295301pgg.9
        for <linux-mmc@vger.kernel.org>; Tue, 14 Feb 2023 04:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VitTC1VuJJTYQdu/YxVhewyoRuLfVR95SI/0DF3Rtkk=;
        b=zSMZ0SAQRHkrq2J59pKTUyRm/EgW7A96+q56OMg53CqV3DKUCQ2nM3YFYiMUKNDg/G
         a7cpwNCer1XRfIyJaxmIoRTahJxemkW8/e01lZSNkFQV2GaVuVb7N4fLQB+9EqJ+w6sx
         BiCqjflfoFNsTEM6tWqPKH08sHvXNSXsG/okCOA3UqLEPiuOz02PV8vV9wWn031UD1wA
         xlDynBpHDfnlDtJa+fYX2nYUjJ/mZJ4gKkLMyhLvJVOeg4lDrw9c+bEpVPMXEUhkCnpG
         5i9TmK8v1b/Iukd+OYCzdwLr0J+C2S+NDflvEALPWV2k/06+4Gf5g8rHJNA9tsUQOdwk
         rvqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VitTC1VuJJTYQdu/YxVhewyoRuLfVR95SI/0DF3Rtkk=;
        b=0GwSQCXTZFYu/3OeY8HL8IT7S3IZvV2f6vnBLbHJnWZJmm2saUHUt+VMmbPP8vVyB4
         sV/Q9QEjR2ElxLEs6VTdAd2PtsRZJFaUJEwFttfJBWoUpV4JWcmiVFieZQr5ZG+fMMP1
         Jk0RrLzyAfAOWFbEFngj6fJgoM2vkMwBUaM3mhf/chbVasZtYcrVszNrfEaRN2Tlxix2
         YKuelKc/O69f1YGPL5U10WzB/ZRW7rfX2H12n0muuJD/1qjXpBHA0B2+3YxLLu9PB7b2
         ERMT9BWSGdfgj66vWHWcc49WyFLTa2GvFJ1yA2DdN6Kdx+TJYx4mhjXaJzYFWvwR41Js
         bFQQ==
X-Gm-Message-State: AO0yUKVAxaDAy8fNAB6fNXY73vuEavZ82HT38u9l0SkbC5AaDFdmfAGi
        KgfFJHUYs0PTAfrjwFWEPZFfk/vGk7gVYWt9byH1AA==
X-Google-Smtp-Source: AK7set8JIgqTFRd+MPjZCDMEsWGRo7JvDEgDNe76d7sr74vRhR4GnDIpaRE1zD+ANtND83e7m5npa+uI9v2YUR+e89o=
X-Received: by 2002:a63:7b5a:0:b0:4fb:949d:72 with SMTP id k26-20020a637b5a000000b004fb949d0072mr312698pgn.8.1676377155136;
 Tue, 14 Feb 2023 04:19:15 -0800 (PST)
MIME-Version: 1.0
References: <20230213152740.359055-1-lucas.tanure@collabora.com>
In-Reply-To: <20230213152740.359055-1-lucas.tanure@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:38 +0100
Message-ID: <CAPDyKFoQ5Eucevs7H4c8CfH_2yFF5Xp0sCPq7QOY066GB6_nig@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: rockchip-dw-mshc: Add RK3588
 compatible string
To:     Lucas Tanure <lucas.tanure@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 13 Feb 2023 at 16:27, Lucas Tanure <lucas.tanure@collabora.com> wrote:
>
> Add RK3588 compatible string for SD interface.
>
> Co-developed-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index 67d7223f74da..211cd0b0bc5f 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -39,6 +39,7 @@ properties:
>                - rockchip,rk3368-dw-mshc
>                - rockchip,rk3399-dw-mshc
>                - rockchip,rk3568-dw-mshc
> +              - rockchip,rk3588-dw-mshc
>                - rockchip,rv1108-dw-mshc
>                - rockchip,rv1126-dw-mshc
>            - const: rockchip,rk3288-dw-mshc
> --
> 2.39.1
>
