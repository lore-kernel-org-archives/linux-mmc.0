Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5167BC432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 15:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4019460E77
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Aug 2021 15:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbhH3PKk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237323AbhH3PKg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 30 Aug 2021 11:10:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CAFD960F6C;
        Mon, 30 Aug 2021 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630336182;
        bh=wsc9RNKxQkmls5vCsAO7AtLZpw0ffp68hvKWafxByBE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=e4zlaCA0cxDDd7LNEjQhW9oaIXMt1Rq1/MRUI6P3+IL4hHs48K2mV2/KpVaxIKDyl
         L+d+x3N/ivB9QXcgKliqQzo0yM0RDi76df4LOaKUHU+QI8msERS5s8ydMVn3NaRwty
         TxF3v1OQ8p5SrzbgAH9UsBiDwMcFhJtqBzPzJ/tgC040AYu7nujLA3ExeWtdshzpQF
         wiV2AS5CkUjIydDK0uFsUsnE6mv91t+L7w7uW9rv3RmuM/UXnexT8QOb+hzjlVxVb8
         TY6+U0dObG2m9NNYBT6IO1qhNicEjh8Yz8gTyw2e8fOwH3kMDFjmvv4m/I7og/LGXw
         aYRFzvlGdKBLA==
Received: by mail-ej1-f42.google.com with SMTP id mf2so31841641ejb.9;
        Mon, 30 Aug 2021 08:09:42 -0700 (PDT)
X-Gm-Message-State: AOAM532PV175H3cqSYwxtcbfsAosEJb3p3tXYgoOvT5cAdGBJ8vH5Yvz
        i48/5CaGke4JjrhIQp7f/BxNm2/UWkCJNi52/g==
X-Google-Smtp-Source: ABdhPJzl1EsqiJCWv1IXdEPt9qKg22NWFB0gUwARdXlndzryzwnHbKAOddbGyjkT62uyPXgbclcQa3gbHOE5Lt6TpME=
X-Received: by 2002:a17:906:b4d:: with SMTP id v13mr26171264ejg.468.1630336181386;
 Mon, 30 Aug 2021 08:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210819154436.117798-1-krzysztof.kozlowski@canonical.com>
 <20210819154436.117798-2-krzysztof.kozlowski@canonical.com>
 <YSUDTSuNlsOmu/G+@robh.at.kernel.org> <9423ddab-4635-ea15-7a9d-dbcf1bc215dc@canonical.com>
In-Reply-To: <9423ddab-4635-ea15-7a9d-dbcf1bc215dc@canonical.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Aug 2021 10:09:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKU4opYerjxXTnAuouLc5-GQQKnPX+qZEMBuzYV-inmJw@mail.gmail.com>
Message-ID: <CAL_JsqKU4opYerjxXTnAuouLc5-GQQKnPX+qZEMBuzYV-inmJw@mail.gmail.com>
Subject: Re: [PATCH 2/6] dt-bindings: mmc: cdns: match MPFS MMC/SDHCI controller
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yash Shah <yash.shah@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 24, 2021 at 2:02 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 24/08/2021 16:33, Rob Herring wrote:
> > On Thu, Aug 19, 2021 at 05:44:32PM +0200, Krzysztof Kozlowski wrote:
> >> The Microchip MPFS Icicle Kit uses Cadence SD/SDIO/eMMC Host Controller
> >> without any additional vendor compatible:
> >
> > I think the lack of vendor compatible is the error here. Experience has
> > shown that vendor specific compatibles are needed for licensed IP.
> >
>
> In such case this could be:
> 1. a specific "microchip,mpfs250t-sd4hc", which
> seems to be on MPFS Icicle Kit:
> https://www.digikey.co.uk/en/product-highlight/m/microchip-technology/mpfs-icicle-kit-es--polarfire-soc-fpga-icicle-kit
>
> 2. or a generic "microchip,mpfs-sd4hc"
>
> Any hints here?

Best for a Microchip person to answer, but sure there's some existing
compatible strings for other blocks on this chip to follow the same
pattern.

Rob
