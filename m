Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC70C6FA82
	for <linux-mmc@archiver.kernel.org>; Tue, 27 Sep 2022 12:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbiI0MO3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 27 Sep 2022 08:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiI0MOX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 27 Sep 2022 08:14:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C0EAE9D1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m4so378372wrr.5
        for <linux-mmc@vger.kernel.org>; Tue, 27 Sep 2022 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9VY3Dc88zm1X3kFMt92f1ebyGXVZRmxVirreoMiyvQc=;
        b=NA6E2zVVA2woACEnZMqQ556hmczmfDzkGVcciItFpf+5hRvncoGO1SS/D81UrSazzA
         ZzC1f4gaght3AAk4ENdrXkaBZH1ex7mQNdrhzFAedr0FhVxI4mJ6qrT3SlcL5QOAL5w0
         EYxnjcuqZ/G7XGSMXovXeHGLhMoKg6CIy85+K8OdHCgFf1ybrzlY9ajrCnK3t2W+fP9Q
         0xp8jO3i5d4U8h0/F6PFOKSRkBRP5GREQWNthEiAvCfUzk54Q1yQMVxkIXI5H9lMdIi7
         AGuKlK1F9Z69S8NjhDkkO0RP+yraEl6WcFcyefFu37LED+Z7W0eVllz7cL7V4ByuSDfu
         E2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9VY3Dc88zm1X3kFMt92f1ebyGXVZRmxVirreoMiyvQc=;
        b=VGM1HPns5MpBiznSILK7ajgmx++IRyJebeM3PoM2bMUPXM4R09y1JxgJRAZbUn2wsI
         gPAatf2phAYXHF6h/M1jyK3/eQB3yjGgMA8Pvp3JFGEsBJKx46gcDYh7kF9J+mE9YaLE
         592NkdSUCavk6pgQlFsWCSr08gX32Knlr+fFlGVfa9PdUojXx7YSzvjcs+35ihV3jinZ
         L60wv5o4y6ytA5HItZnyki8AcSUMcQ2U+fEPOS5P7BwykQ+Nh8W8a1nr4fbBfRtNlRr4
         blQr4TLKw2E0S0clpisi9TIg8J2A6shwJKAwdthGGRcXKalQk8LMprhsHU54JrF/aeno
         yXdw==
X-Gm-Message-State: ACrzQf2YHw6k2JprbzBauefLol+/EL4hNSqqQDZc2LurBFFNzRz2UOTL
        zB5JjolLQYPM7A87pO1nk0OLB9Sf6JwemePzfLuhWA==
X-Google-Smtp-Source: AMsMyM7YNXPwbAoZ4jH2Sng8pypCwwIPhkKSy4c7346odtENVp/miYxI/prOTpVT0lDA1ChPnaYLHYhqClT2sp9fawM=
X-Received: by 2002:adf:f347:0:b0:22c:be39:4e38 with SMTP id
 e7-20020adff347000000b0022cbe394e38mr1614940wrp.151.1664280860789; Tue, 27
 Sep 2022 05:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220923014322.33620-1-mailingradian@gmail.com>
In-Reply-To: <20220923014322.33620-1-mailingradian@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:13:44 +0200
Message-ID: <CAPDyKFrKHza0+8F_8-8NEYh9gLcAPoeKu=qA6YZC2t3D9CJ06w@mail.gmail.com>
Subject: Re: [PATCH 0/2] SDM670 SDHCI support
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 23 Sept 2022 at 03:43, Richard Acayan <mailingradian@gmail.com> wrote:
>
> This adds the compatible string for SDHCI on the Qualcomm Snapdragon 670.
> As I noted before, I think it's fine to include something like this
> before the initial device tree because it is trivial.
>
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  drivers/mmc/host/sdhci-msm.c                         | 1 +
>  2 files changed, 2 insertions(+)
>
>

Applied for next, thanks!

Kind regards
Uffe
