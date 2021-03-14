Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86480C433DB
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 23:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED1864E76
	for <linux-mmc@archiver.kernel.org>; Sun, 14 Mar 2021 23:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhCNXno (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 14 Mar 2021 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhCNXnQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 14 Mar 2021 19:43:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA07C061574
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 16:43:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id t18so6328393lfl.3
        for <linux-mmc@vger.kernel.org>; Sun, 14 Mar 2021 16:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+5ScLWA/ADeBe/oMOOUSI5PFgHlHPjBcYld0NBl47Q=;
        b=mbbr0Gj+pc1thMUzjA1Ykk4g0qVlesZ5yqBWQGQZQ2BMYA0ANKnd1T6YXtXZdx1N/G
         BfK/HjcmtQCs4xNPI8gBj6iZYPwlfVMNci2z1lqWXYYTgbragAxRXxn3rJ7d2LRczwU1
         zN43uYH2VSA1XOZQuq/89CLQKVP083Z8667YuHlylKu1JCM0fGeP9h7erm8CvuIMYiN0
         DZ9OQkJ8MOHgwiV/uRf8kJQiCOZUSjE3OAakapMqvSAVZaTlkbZbvdi2b15l1msSLjog
         NVJiYuuba2Zi8W7Nmt6Q755DrPAUx8eJGtLiLB4CMaNhU2PbDWuMKiozcoLsWxpd9cCe
         NMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+5ScLWA/ADeBe/oMOOUSI5PFgHlHPjBcYld0NBl47Q=;
        b=KNJmmnZyNzmYdMFI2A+yIOBZrQmLKE18Kg9dj1R8olwe5wDxjNUs9b9jP3/GTr7f6K
         jHykXFr5A7B3Du71qC1RkaGq3VaLtoykwoybmnhGE56q/QZ/fTmy2mu5yXpWjfe6FIUe
         kNy5kqrRG19UFtx4skOLgZUs+j73AHLcFC6VfLkSDyj5Jp90slNI/4RCpnmhgmHEsUzJ
         YA/bYMdkJWv42t3dgFxjWWwBOP1lRMSk4eeZ5fJOPHGx6WRXORLxNk1T3tykGgDNazDM
         QwOLd8H7VNAnsA6L0bvuopAmyMrmbnN3xcvWtpiXoNy6kkksUb+IaE/hG+eitVfAkuGa
         sEGA==
X-Gm-Message-State: AOAM530yvY3X3p7VQJYpzdr+xn39gIgNEqQxo7nq3T6MLBGiIJk10IAV
        gyS6ZO+w7kKOuIhdfkHAyof7nVTf95m+CqpxCruI+w==
X-Google-Smtp-Source: ABdhPJzerti5+ixXGgGBHTSWzHl1Vc2msbMBqZNpmT3OP2WcE0GvfaNHIVnZGogSqwojo3DvpEfcwtLV+K6K/yYstfw=
X-Received: by 2002:a05:6512:243:: with SMTP id b3mr6380364lfo.529.1615765392236;
 Sun, 14 Mar 2021 16:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210313215302.4076765-1-linus.walleij@linaro.org> <CAGRGNgU_C6keHC_Ty3iruJc5cwsBGJRRBm8DWH91fHjygPv0fg@mail.gmail.com>
In-Reply-To: <CAGRGNgU_C6keHC_Ty3iruJc5cwsBGJRRBm8DWH91fHjygPv0fg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Mar 2021 00:43:01 +0100
Message-ID: <CACRpkdbHfH=+m3EJ9CBGkQ3rh6MGtKy4ixk3fgu15rxEzMg5dw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Convert the BCM4329 bindings to YAML and extend
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Mar 14, 2021 at 1:05 AM Julian Calaby <julian.calaby@gmail.com> wrote:

> I don't know if this is necessary for SDIO, but should the non-4329
> compatibles have the 4329 compatible as an alternative?

I can, and I guess I should add it, as I grep:ed and saw this:

arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
compatible = "brcm,bcm4339-fmac", "brcm,bcm4329-fmac";

So from more to less specific.

Yours,
Linus Walleij
