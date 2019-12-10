Return-Path: <SRS0=vd7C=2A=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446BDC43603
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125D220637
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Dec 2019 23:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beGFSe5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfLJXcW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Dec 2019 18:32:22 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43603 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbfLJXcW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Dec 2019 18:32:22 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so15149158lfq.10
        for <linux-mmc@vger.kernel.org>; Tue, 10 Dec 2019 15:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mcIDbF4B4nn2zcGXR/MC2XQ02CkfW3IDb5WQBzH4Sl8=;
        b=beGFSe5YQ4VhpLrjypn7rGYDNL9lShUDavUdQvkMW3ez9S1Ku6IExlQQ2FtDsewrpi
         o0yHygpV3KzNM2ZLWvm5WyNBKU3x83BjtBfPEwrYhSQBWilyJunbCh7o3ntZgO7QG/1K
         WwuGD52SO7WPpm94CxwEU00PfML2X0M7v3hbrSRN6QDu331ryaOLQpM/oDRaSA8d989g
         x7VcCrG1cTLSB4/tVi2Cixj+Rogys5HL+nLx3dSNe5YUljhjWn0Ma630n1gNZvAurdqr
         L6Rwe1dmnnOPhvFUb4Kma9pWz8R4ydYUqzMaelylPnTrpW9B0vXz3ipqaFbiVDErVf/8
         jcdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcIDbF4B4nn2zcGXR/MC2XQ02CkfW3IDb5WQBzH4Sl8=;
        b=P4x3kmIlCsiV0LVpJniqi6dSKO3ofWqKnGdYlZA73/6MaVI6moAtC45OtxUAoUfc0g
         N2d7xVBdEF6/uAVIh0Tdxs4qF4ueQExtqrzOY/Rn9o0KY9yx+4uauUmOBqkkFmhzSMwt
         DgFz26G8fA4peBYoP1j0+zk1FXPL4/SxRs1TsGbtdDYpNaiZev23RfPLwOXjBPTl57nB
         tSzO1dNZr2mAZx2YvSzkUtGtP/Y+IFvMXzv8TNNZTuoFb5o9/ZhmN/jS4DBorpz+2I5L
         fW/VKCQtPJAOe59TjRYD1oNndNvTGxO76Ye6TjRs2jZgAqYoSnmmlJgjnetQHlAAP4OO
         65FA==
X-Gm-Message-State: APjAAAVQnBZddOsc1zlmlRJSyV5HyJTPOXa4+iOR2bNnmtUC0fH7gwyU
        obpsw8ZJ6P27JxWxblomPYr/xQM94bNt5nMrMGUGGQ==
X-Google-Smtp-Source: APXvYqyrTfU0YS/VPMxXKnxZTeJHcl8kMipiGVLFlYYF8987Aof78WElYMzOP4pURPe8W2TwqNMXy8hKHctsV/QFzKA=
X-Received: by 2002:ac2:55a8:: with SMTP id y8mr254446lfg.117.1576020739801;
 Tue, 10 Dec 2019 15:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20191203130120.11511-1-haibo.chen@nxp.com> <20191203130120.11511-10-haibo.chen@nxp.com>
In-Reply-To: <20191203130120.11511-10-haibo.chen@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Dec 2019 00:32:08 +0100
Message-ID: <CACRpkdYN9rL9go68dyGgED0=atZMV7uAU3jfsT025e1NvB6brg@mail.gmail.com>
Subject: Re: [PATCH v2 09/14] doc: dt: fsl-imx-esdhc: add auto-cmd23-broken binding
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Dec 3, 2019 at 1:54 PM BOUGH CHEN <haibo.chen@nxp.com> wrote:

> +- sdhci,auto-cmd23-broken: disable the ACMD23 function of USDHC.
> +  This is required for eMMC on imx6qpdl/imx6sx/imx7d when it use ADMA mode. Because
> +  for these SoC, it do not support the ACMD23 completely, only take the 16 bit block
> +  count from the 0x4 register (BLK_ATT) as argument for the ACMD23, the upper 16 bit
> +  of the CMD23's argument is ignored. This will impact the reliable write operation
> +  and the RPMB block write operation, because these operations need to set the bit 31
> +  of the CMD23's argument. SDMA mode will default disable the ACMD23 mode. SD card do
> +  not has this limitation on these SoCs.

This looks weird.

Is the bug in the *host controller* or in *the card*?

It looks like the card.

And then it should just be a quirk for this eMMC card in
drivers/mmc/core/quirks.h plus corresponding code in
the core.

Otherwise everyone using this eMMC card has to add this
property in their device tree and that is wrong if we can already
detect it from the card ID and apply it for that card, anywhere.

This is not the first time I see card quirks as DT properties,
it seems like a bit over-reliance on DT.

Yours,
Linus Walleij
