Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD12C433FE
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41696103B
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Sep 2021 22:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbhI0WfC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237990AbhI0WfB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Sep 2021 18:35:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D71EC061769
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:33:22 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b20so84354349lfv.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Sep 2021 15:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zM4fBOa/Cc+NJs4yahzMxnuSKuzGDGiVwQrXYFaw3GU=;
        b=ICqqWiLqBDT0t9jn6SdzLmBUmYs8DPRMcEdkG/ON8LnfK+o2owAjxRZT39rfh4QrLn
         p22YxgnEJr3UTYZjIE2c4ZOCvY09SBymnqCl6tPrRSPnZbYlV6juugSp0gNhHH6URqyL
         mbHSiB74bJwO4un0kQa2UBlAo6OMSw5/ngEY5oIMd5yn504Kut5DolDmWvlYd3Kx9rZk
         Uq7xSNHzr/9qLjG/aYPN6a57oIh/mWVxMqOo0x4qamWtNyEP6MSPvLZ3D7roH2Ns6x8M
         u4FB/+gGQ9WtalJv/uQK8Po9mlTNNOT+9BBzObVeGwvqef+kMMCxbGe/I+NvUU1JWk/3
         31Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zM4fBOa/Cc+NJs4yahzMxnuSKuzGDGiVwQrXYFaw3GU=;
        b=n3sbj6a06qxCPaE9hwxBBnQf3LsJPbNVaTJvDbVhXP6SsmhK5OvXuMB+sHCLeCyNvt
         26fJK5kND/G8XDNhAbs5bAbWdT5E3sE4U7oAu41LY+GvnmK1+svyV3yt7R3Ngr9LWOnk
         ANpahU5bb2SP1xvJgXVBi8gnsxkh+nNqcFP/Vbds3tCKEDcUhxNYqIajksFW0GbwzP52
         6Sq3AilCIr2fjuPRm8NhfBVyblMV46psiZ3VNkCKLF9PM6tiVLWcPM0wmu3lAHzQlcUB
         7R3PXMsn/zHAzqkEsY/UvpBbA926AuuFVXOXcp2f6E2RzE/k/Gxpckps3Aoo22w2jUyn
         mchA==
X-Gm-Message-State: AOAM53131L5M5l2rF2GCHRFksgUcyQUmZzPx+XCY4074KcvsG7a0tiVJ
        OZIrgqx0R4TMjRI5lMSBAMuYyKITRzOW2/vTbJXSSA==
X-Google-Smtp-Source: ABdhPJyCkbS2MXhhj2GEIsJRQHChM3/s/YxU0WZXM/5MxIvupi0dl1BoN6G6RUeYG8MNAmtmUhre/M6FEpZgurOihS4=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr2166459lfv.358.1632782000629;
 Mon, 27 Sep 2021 15:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20210927125044.20046-1-krzysztof.kozlowski@canonical.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 28 Sep 2021 00:32:44 +0200
Message-ID: <CAPDyKFpnd0TWxvdbivkNUN9YrPyWWdiQkLLp94MNWh8pXXqxdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] dt-bindings: mmc: cdns: document Microchip MPFS
 MMC/SDHCI controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Sept 2021 at 14:50, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The Microchip PolarFire SoC FPGA DTSI uses Cadence SD/SDIO/eMMC Host
> Controller without any additional vendor compatible:
>
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible:0: 'cdns,sd4hc' is not one of ['socionext,uniphier-sd4hc']
>   arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dt.yaml: mmc@20008000: compatible: ['cdns,sd4hc'] is too short
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Rob Herring <robh@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
>
> Changes since v3:
> 1. Adjust commit msg.
> 2. Add tags.
>
> Changes since v2:
> 1. Document vendor compatible instead of dropping it.
> ---
>  Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> index af7442f73881..4207fed62dfe 100644
> --- a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - microchip,mpfs-sd4hc
>            - socionext,uniphier-sd4hc
>        - const: cdns,sd4hc
>
> --
> 2.30.2
>
