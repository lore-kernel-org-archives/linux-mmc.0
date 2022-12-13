Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFCCC4332F
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Dec 2022 09:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbiLMJT6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Dec 2022 04:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbiLMJTZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2022 04:19:25 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9A1CB36
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2022 01:17:09 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id g4so16876733ybg.7
        for <linux-mmc@vger.kernel.org>; Tue, 13 Dec 2022 01:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OrCcU/eLo13ZBVFGTuTaNxXPpehWwnnZY10XGNdHAy8=;
        b=jY8Iifm5eNOXeLtqgcNeEtLlg72Z/GFVeA7N47+JQ66xQyPDLLq20dYbg2wKPZdwNw
         iH7E1kFNGGcrazr8YZ3qPHSLlH0l7Kc//qxuQ1J8QBTu2TnB8fhHHa2vBb3W0AEgFo3k
         PFfzEeBC1lTImi6i4N02iDVgFC/qxA474cU3WCKLuPurhu3A+Jy61GfL2HziN0sA2pea
         +n9tpHRvnvPE5L0b/yXtRMr5tSeqCkRXv+toB3EI+zsdt67LXXrn1aCZH1IzdXO/CKYn
         KZo59t2aIpdTpmVDM78MDa88CjIlKJuSstU5wBAeuGRDUT/uA+3TgtxWcXP9GbydUKym
         s8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrCcU/eLo13ZBVFGTuTaNxXPpehWwnnZY10XGNdHAy8=;
        b=yoCqZe7DeCj34I4B+eJNnTk5bG1tI9zs9nqAeU+KR0qz56b2fMQ1tLS4gyNuuf4+OC
         srJ/DUnRtpoNRFcZ+65TkCT57CaJzvVXc3bKGnQ4M1hODx0sIgloXhVyzCg3DVszZc+W
         miAN0XGCu2muZ8Q1wg5i76NjFf6et8fQTUEKMDuIGJrEpbfLW0Ss8gEx89D6yJPL3vT+
         j+rXMSP+HHwcHFAKNvESPxeOKTJVBkb9LjbsTYmIaLuJ/OxBQ5X53gNtIavRgy5Kb0U1
         YzvvuUmAq8SHofa5n7pS82ygW/c+Raqhta9DTH61UVBI0yCwc5QL2EHaA4q6j15mSDaz
         dB2g==
X-Gm-Message-State: ANoB5pl4btcTkeNEemu8lnpuArhp3P6maPFJURYdF8IvrGb25nxrnMIs
        iMmn9KMGp8IKJBoJ1B+h0pM+lDFQfxXTf1G0D5f2zg==
X-Google-Smtp-Source: AA0mqf7NaYcP+HSZvjgXCfXIqcmGoJ7EEDAPulojvkUQ4Lxe9RcBpGs+kV9gyCL2iiuFo3IeiBvYrEt9jY3WxC3+i4I=
X-Received: by 2002:a25:cc0b:0:b0:6f3:f978:efaf with SMTP id
 l11-20020a25cc0b000000b006f3f978efafmr56605874ybf.596.1670923029086; Tue, 13
 Dec 2022 01:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
 <20221205105931.410686-4-vadym.kochan@plvision.eu> <18cf4197-adce-3e47-7802-80b0d078368b@intel.com>
 <VI1P190MB0317641905664AFF51F9F4EA951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <ce870974-3e4f-107f-2047-89dcaebff1a2@intel.com> <VI1P190MB0317A616976EC99EA0C44F47951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <69dd8714-4be1-6b1b-fa07-04c790a6c6fc@intel.com> <VI1P190MB0317DADE7450282444BFED32951C9@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
 <44f642bc-8810-80d9-368a-15994de7f50d@intel.com>
In-Reply-To: <44f642bc-8810-80d9-368a-15994de7f50d@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 13 Dec 2022 10:16:57 +0100
Message-ID: <CACRpkdZhjrze4q39SPjATESRCQ_RW4XJn1a1SMDy-hApXu9VEg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Dec 12, 2022 at 9:43 AM Adrian Hunter <adrian.hunter@intel.com> wrote:

> >> Right but I guess I meant what about 0x3_00000000..0x3_ffffffff ?
> >> Isn't that also in DMA_BIT_MASK(34)
> >
> > Yes, you are right.
>
> So it would fail in that case?  Is it possible to use devicetree
> reserved memory or some such, to set aside 64k for the bounce
> buffer DMA mapping?

Yups spot on, reserved-memory can be used along with the kernel
CONFIG_DMA_CMA to achieve exactly this:
Documentation/devicetree/bindings/reserved-memory/reserved-memory.yaml
kernel/dma/Kconfig

Yours,
Linus Walleij
