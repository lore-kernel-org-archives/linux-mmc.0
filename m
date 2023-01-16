Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18738C54EBE
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Jan 2023 12:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjAPMR6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Jan 2023 07:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjAPMRc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jan 2023 07:17:32 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B131F4BE
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:23 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so7267753pjg.4
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jan 2023 04:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DPqO0oBcmgLKXeUWn1XrKDG5BAxYKOWw0dzZV7vwqgY=;
        b=RBemEAblyGxLU2fm+hF8zw3C54DMdenP3WBAbUkch/IgLgrsspgI0YHK0xnoM41K6c
         D6DLw3KbsYIr8wOBErprC+IDge8r0EZCkO4gYqUuuMJ71XI4SiRpl+6jYMh/ka+XnC3O
         qBM4uqF9B69lckXQpNFIc8rJs6GbxIdEywcyzAy66ly7cI2Pq2t9pRqB28mV//niLz+c
         vS1ZEY0tjlPlzKLDbAAlwUd77tSF6GpNoWJxRWlmSRUYkOSbhIPCHOKZTV7t2jN5BxkD
         288U3zbCm7TE50rGRtDtdoLZxtyivIU6QKp1o+mcPfuvt2bNSmElRv5Qm+jMylI7LA6q
         C8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DPqO0oBcmgLKXeUWn1XrKDG5BAxYKOWw0dzZV7vwqgY=;
        b=rwPY7/w3iS9pqE3F1kCEiOvWEo/8ciVgQI4SavXGjrwSIHvqjTL9zvaVrKfvFaX8/p
         csJTMWgGz3CYw59Y2lNzoOPkSs35xizavmBN8pHURkablbEu1cv0sx/V6AVK40OtIkkl
         DC1Jr/8g4e4q8q7COyMaW/QNrYyoLw4kSQd6d2jx8gTe49l2NBs5gxoaDDnjeOKDfoS5
         PjlHiX8Gx5Ga8yVs9pWM/k60s16UtpelOWCcHXiJ+iFmc/5qpHt+evt8JQbGbBltEuhr
         mbBknUGX6eIwtAGdbnQKTNmFFkSbQD2f4ntNVf/3d09SBnrxh2Cq1lCCyeiOZ7WYAcqk
         DxDA==
X-Gm-Message-State: AFqh2ko7DPc1DQiuQMiMuqw/CE0fKICFl+6CUvYhmXlN0JPNTZUA0rHk
        fGEc/88rs++PNorpsprGXf4rqVdlNW+aCh20UH/wdw==
X-Google-Smtp-Source: AMrXdXtjP8Sa+jjQ/yKSmwOET06UAgBRMczv2XdwvgBPcFbZjhPB2Nmss/cYPNG3ijFP/Uj+v3ozjZeYtP9vh3SqL4A=
X-Received: by 2002:a17:902:9692:b0:186:a98c:4ab8 with SMTP id
 n18-20020a170902969200b00186a98c4ab8mr644271plp.118.1673871443175; Mon, 16
 Jan 2023 04:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20230115195212.2530087-1-andreas@kemnade.info>
In-Reply-To: <20230115195212.2530087-1-andreas@kemnade.info>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:47 +0100
Message-ID: <CAPDyKFoTAiBFPu5cjLzX+VhWfRU3LMp+pLqGJthqqCwo3=KC_w@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: mmc: fsl-imx-esdhc: Add some compatible fallbacks
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 15 Jan 2023 at 20:52, Andreas Kemnade <andreas@kemnade.info> wrote:
>
> Currently make dtbs_check shows lots of errors because imx*.dtsi does
> not use single compatibles but combinations of them.
>
> Add fallbacks for imx6sll/ull which are useful for U-Boot.
>
> This will significantly reduce noise on make dtbs_check.
>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes in v3:
> - simplify things by using enums
>
> Changes in v2:
> - allow only combinations with fallback compatible
> - reduce them to the cases where they are actually useful
>
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index dc6256f04b42..3423e1cd8b5d 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -29,14 +29,17 @@ properties:
>            - fsl,imx53-esdhc
>            - fsl,imx6q-usdhc
>            - fsl,imx6sl-usdhc
> -          - fsl,imx6sll-usdhc
>            - fsl,imx6sx-usdhc
> -          - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
>            - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx6sll-usdhc
> +              - fsl,imx6ull-usdhc
> +          - const: fsl,imx6sx-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mq-usdhc
> --
> 2.30.2
>
