Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6E7C4167B
	for <linux-mmc@archiver.kernel.org>; Thu,  8 Dec 2022 21:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLHVfa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 8 Dec 2022 16:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLHVf3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Dec 2022 16:35:29 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B5878BAA
        for <linux-mmc@vger.kernel.org>; Thu,  8 Dec 2022 13:35:28 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-3cbdd6c00adso29362057b3.11
        for <linux-mmc@vger.kernel.org>; Thu, 08 Dec 2022 13:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tlFUfNslInmoKrVXkH1lhTSHZIbojnQ8pkFmtckc3GY=;
        b=K30+WCfX8giduPvnrjcW4mf0ZRHkFyzYUFp5Xw7Zjv/oHUrV8dMXoacaTfnJxSLDwV
         pVeAN6CSxR/O/Vx40v4erwGSsTiSXe3BI/bCWsHnatqvqmAYi2FqyUlAzRP5W0y2p5aE
         zAMj6D1W7oNBlX+83qRGtrT5KuxtIXTavxGMWCCNE4DdR8cS0J3wu80gRV6T992+pMA4
         hmoUbprlR34I2rGMsgz46+y2PEb9RfKy+swqPIFvY9MPPF985zvYmfUFrwWlSjxOyf9M
         WI2I3nsrrptkAptuLcZe9jRb6RKZya66wgPG4LDdLz5f79U48zqo0n1oOC6z22UMXm/O
         /38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tlFUfNslInmoKrVXkH1lhTSHZIbojnQ8pkFmtckc3GY=;
        b=xu+uElFsZ5Iv3MgtwUkUV5KJc/DIXH9A97YqWvjgrbRtPtXcvrecUxTfZ1x2ImnkZQ
         3XTAfKkvMYnn2DT15FjFVNgN+kE40+EZB1ywr4EI/uDtMOfrQVfydL0YVBG0K1EErc9Q
         32YlQKaPJa4CD3LzgKglIVug2VlekFLAPFOaDwN1N8i5xeEnHplNETwndL1h6QHmbh0Y
         yooQCAFKK6mF5K52GR8SXkmQ42K05f+gNRyirjOJO1RPhvmVXVeL73d1qVRuEcD7kFUJ
         lT+ZFl5H1iX5TQQ6lP0AcZSpiN1lLJUSjce2/SWKvBtJYXzw1M0Z07JvL/dYLIjpAF6i
         d/MQ==
X-Gm-Message-State: ANoB5pkkWasw2BCQU4uPeq9mfjRPB28NyY0NYYfkSkCF9vhKi0bbhHJ5
        I+Oh310ig4z+Q+V3wcA8QvvDn/47IgAEvyP4/hPR/R5hDi4m4v78
X-Google-Smtp-Source: AA0mqf5lejhclephxCw5o0uTd2TpzNhPuNBMRa9NqKnFF/sR8PB4mPhQmV9Y5dXLDaQc09tXea5EUQ+vf5gXqUZdr5c=
X-Received: by 2002:a81:b45:0:b0:3c8:b520:2fa6 with SMTP id
 66-20020a810b45000000b003c8b5202fa6mr48364581ywl.411.1670535327801; Thu, 08
 Dec 2022 13:35:27 -0800 (PST)
MIME-Version: 1.0
References: <20221205105931.410686-1-vadym.kochan@plvision.eu>
 <20221205105931.410686-4-vadym.kochan@plvision.eu> <CACRpkdaXQqrCEqu9HTMZMMWbnkQxXEmoJNtiH-HENZWeDqjqTw@mail.gmail.com>
 <BN9PR18MB4251300124E30A16B3F5C521DB1D9@BN9PR18MB4251.namprd18.prod.outlook.com>
In-Reply-To: <BN9PR18MB4251300124E30A16B3F5C521DB1D9@BN9PR18MB4251.namprd18.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Dec 2022 22:35:16 +0100
Message-ID: <CACRpkdayw4JPY_3HFvgDpfPaDwOZHKKmyaahpEbKR6DaO_VJuA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v3 3/3] mmc: xenon: Fix 2G limitation on AC5 SoC
To:     Elad Nachman <enachman@marvell.com>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Hu Ziji <huziji@marvell.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Elad,

I get it, I think. I was a bit confused by the 3G/4G terminology.

On Thu, Dec 8, 2022 at 11:20 AM Elad Nachman <enachman@marvell.com> wrote:

> The lower 31-bits of the address placed in the ADMA is passed through the interconnect, and remapped to the base of the DDR.
>
> Hence only addressing of the lower 2GB of the DDR memory is supported for eMMC in this device family (AC5/X).
>
> So the quirk needs to kick in above 2GB of physical memory accessed from the base of the DDR.

How "clever" to skip bit 32. This should be in the patch description.

> This is why a quirk which only kicks in above 4GB is not sufficient.

So the author of the patch should create a new quirk that kicks in above 2GB,
devised to be similar in style of the 4GB quirk we already have.

> Furthermore, SDHCI_QUIRK_32BIT_DMA_ADDR is checked in sdhci_prepare_data() as a way to
> disable DMA when the offset of the scatter-list DMA address is not 32-bit aligned. If the address is
> aligned, this quirk does not disable the DMA, and will not solve our problem.

That's right.

Let's just create a new quirk:

SDHCI_QUIRK_31BIT_DMA_ROOF

Define the semantics such that this will allow DMA for buffers that are below
the 31st bit, but does not have the semantics to limit scatter-gather buffers to
be 32-bit aligned.

Yours,
Linus Walleij
