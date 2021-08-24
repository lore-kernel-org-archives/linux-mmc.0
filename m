Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88686C4338F
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 775FD61248
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237990AbhHXO54 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237940AbhHXO54 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:57:56 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC9DC061757
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id p38so46253499lfa.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0jwM+NRdVEmoda+rXP1IvhOE4u26R3ufvVRf6e5LTU=;
        b=XPxxrAjMJ8s/8q5lP9xENYUlet4QRuQdTR76cLQ1Rh3T/ctYWPBJQeTO70Tr6aRm7b
         JxDFM4Wu3mGC16wuB8hCnS2tZWWiMWz4usGPbnmtH513neQTsvl+zBkEhwvFmEZdbkDv
         ncGC2b9Qif5fH2/CZQXvbH5undbnvA66nfEfE35zpsHg8WiTp1lvOe83iPshJ+K2xCau
         zKC4+Y8aPXHLgwgK8tMO79xos1D34Jg8QnIyWwXCC1NMRBoQs2i6q+T0D0g7z13Gw0V1
         G5EhiANjIl0o+xvRM5XyU5U5icYUMc9c72ZYCRd/ntjyY9if+ZaT9NPQODGSFoj6nGin
         IZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0jwM+NRdVEmoda+rXP1IvhOE4u26R3ufvVRf6e5LTU=;
        b=unv/V7A2+/RZSC3LXlRqEnnjnx5DM+0NZewtR3Ytsgdc47wRvTZzdTayTXkV0qopI7
         JQExNo7zsABDNSz+gD/Z/CTSd0tQNh/OeDwBr/5t7mkUhFx3Qa8EPMsK2sSsUAYMbeb4
         aaN0lpxlJ4bEuizRLrTeXHkmdbnOQiNQsVZc6phob7aLsUYLHPNUeDqi7cHHceeS8YQN
         EoB7Et6rzcnmDi1MBeofiR2LdXWkufVnC3C+XXfaZJsxzgL93zFdaVJwA+MgINea1txZ
         qS+sA9UI4rrmhZZxUC49IwtDq1NHhQIjg9wkohz2a7sGAd46ApjPu9okCSAjjQdEt+PF
         N42g==
X-Gm-Message-State: AOAM530pxeT6bzglTAb8NCYJeT3Q7PkBIStXdniNxq106oTQ3O1XSKME
        8c2LkGAIhj9tquxD0Jwk0Gv9APQ6OypB/3b1vczn7Q==
X-Google-Smtp-Source: ABdhPJzwAJNX13cGakqN8GmHHCm1Y9uxOcqa+dVBLkt73GD8MsYvUIndZ+1qRxOmG/g5qUJVP2UPWa7lg7As8HWfvHA=
X-Received: by 2002:a05:6512:e99:: with SMTP id bi25mr3313841lfb.486.1629817030730;
 Tue, 24 Aug 2021 07:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <1629278277-7313-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1629278277-7313-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:34 +0200
Message-ID: <CAPDyKFouXOzV4Lfk4v2Hrj_OPg5jL7h_WoNnM2sH3h44q+6NRA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add a new compatible string
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Aug 2021 at 11:39, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> Lack a compatible string "fsl,imx6sll-usdhc", so add it here.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 8a9f1775b0e2..1457eb21473e 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -29,6 +29,7 @@ properties:
>            - fsl,imx53-esdhc
>            - fsl,imx6q-usdhc
>            - fsl,imx6sl-usdhc
> +          - fsl,imx6sll-usdhc
>            - fsl,imx6sx-usdhc
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
> --
> 2.17.1
>
