Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4228CC433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1141161606
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbhCCBqX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:46:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349595AbhCBKm2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:42:28 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AB6C0611BC
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:39:55 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id t15so6604320ual.6
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H0hmZCFeDNqAbXx5GUKcKo1fxTItQnWIdXjqLdnPSeQ=;
        b=ImnDxZzQiN6+xQO0jDbYudZZ5bZAsbEITwar8lWZPd7fQ83yGWzCBnHvplZ0wWJ0ow
         P25AE9GJP4NQvMp4y3IIKvqAn/tQAkoIN31eb42woz6/xzDWE2L1co7qfEYN95VwpD+9
         n1EU4ETEtPCqhAH7MKBpDAXSsDYch2NkH6D959mXvnxfWVqsqe3mOcihO4BGcGIqAkc5
         lR7Fzh3YY10hQo0Z2VbA3GZqewqkRDAINWI7MU64FHTbamGCHdfwqRx/PXeNK9zNPlMh
         ygL953xVMYIz2asSrEiNZ75UNlZx3cjUi1iWP7o2oTGUGsTznPqLLjLUwMhqnffhYKd6
         pctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H0hmZCFeDNqAbXx5GUKcKo1fxTItQnWIdXjqLdnPSeQ=;
        b=hTnUtL39bVLxbFt4qQ1PbL572VEuW7vJFsORg4gy2yFUKeZh3ioZzyoVw2gxVvlu1Y
         dOXkVvrUk/XyyPeQsdAKLkzyCtAtiBgc++hmNJ+5p4zcUOyBjXNPHo4XFlrJTZFtnNso
         bAcMO5SbepVDTXzT9sPsQf0+b9Sac1Mx9MtlSRpZmmkL6JwLri12XoOaDuzeItu7bedO
         do51wN3lG0kLA7GsqG3YNjQrdJ7qB6hPZ9axXUJrvy6y2yX0xtp2Sqexy0o0G9VSpVwF
         CypqDk0xDGDIzx+CsiZRLWLl/gN8Tkwlp/5eXD44nklNaMA7ZRxaDGXosm1drSRsN8gq
         MwaA==
X-Gm-Message-State: AOAM532sh29sEWiRX2BNzcx3B0U0qttR3DtPCenN7snnkqH4Jex/XMVs
        o/ECw8XuSi6DIxEnbafyRM4B/UmiNUpIgNBCAeX9Zg==
X-Google-Smtp-Source: ABdhPJx5zWar9vzmGNaDwjkCHaFzZgByiXdLPVKbwNxLcirxr8ZsQUC7izpDBiTOw7BnhXrSEGYIkB5n9j8rL06nuYw=
X-Received: by 2002:ab0:1581:: with SMTP id i1mr10807661uae.15.1614681594298;
 Tue, 02 Mar 2021 02:39:54 -0800 (PST)
MIME-Version: 1.0
References: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
In-Reply-To: <1614222604-27066-1-git-send-email-peng.fan@oss.nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:39:15 +0100
Message-ID: <CAPDyKFq3J=Shzgxp8XsdZqdZcOZ-n5WJ+mWejXM1-Qp8PgjBNA@mail.gmail.com>
Subject: Re: [PATCH V3 0/5] imx esdhc dt/driver update
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Feb 2021 at 04:22, <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> V3:
>  Patch 1, drop unneeded pinctrl-0/1/2
>  Patch 2 is new to avoid break dt bindings check
> V2:
>  patch 1, 2, 3 is new
>  patch 4 is not changed
>  https://patchwork.kernel.org/project/linux-arm-kernel/cover/1611198593-16287-1-git-send-email-peng.fan@nxp.com/
>
> Peng Fan (5):
>   dt-bindings: mmc: fsl-imx-esdhc: add pinctrl bindings
>   dt-bindings: clock: imx8qxp-lpcg: correct the example clock-names
>   arm64: dts: imx8qxp: correct usdhc clock-names sequence
>   dt-bindings: mmc: fsl-imx-esdhc: add clock bindings
>   mmc: sdhci-esdhc-imx: validate pinctrl before use it
>
>  .../bindings/clock/imx8qxp-lpcg.yaml          |  6 +++---
>  .../bindings/mmc/fsl-imx-esdhc.yaml           | 20 +++++++++++++++++++
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi    | 18 ++++++++---------
>  drivers/mmc/host/sdhci-esdhc-imx.c            |  2 +-
>  4 files changed, 33 insertions(+), 13 deletions(-)
>
> --
> 2.30.0
>

Applied patch 1, 4 and 5, thanks!

Kind regards
Uffe
