Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACDBC43217
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 16:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbiKPQSi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234362AbiKPQS0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 11:18:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF559B27
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:23 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2859295pjl.3
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 08:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dvp6aPXdskWw22vG4cUG9Anh9RZtqEUkN6NF3CqRa8Q=;
        b=zpHnP80Iv3WZA6SVm3xPJnPQZCfK12IBMTkLXrlkuH80NZN/zL31xOP4zW7lMISEBP
         hlvBx6riNPPdVLgNqK05axXDOKJnPqIaUaXO1GmB1lp/oAfvvAROfxO9CXLY48qc3Rfc
         n7i3VBAZo85JR/ChhWXjItUuDb1HAI0g8lR23WI2qgefq0mYD9lg4Q3A84yAOpRVMcRf
         svfKUD0dh/FcyQS8+wMTedCkBrOx0mzYsEVIZ5+H3aBbqveAGiCbbEJQomP2bNAYBbaN
         3iORzlI7ZVPv6AtS5evEMNcmNlCJyjJ5NIoV3BEhVkDRXF4V36N0OrfuVL5bcGuhniYb
         vc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvp6aPXdskWw22vG4cUG9Anh9RZtqEUkN6NF3CqRa8Q=;
        b=CsekxO0/wNwJxSS9p3VcnxHTxTwclJupf1EZ4StIa7Q0W5NeJYG0Ra+QsDwgwotuZs
         Bgyh5ObfOkpX1an7kCeVH5zO7dSDFpGZN+uJxLgHgXXtGJ/+gn2n6KIGDqpnAYDIsfXJ
         TqYu4VhXZcTcEu1W7ZzR02mWpipJ09oeZQH2/737wf2zdaeVEwLZENkDDaGod6lmXA65
         Ij6IDlbf8WnTNjzu4l4wNbzrmtjGiOoK9VLedAY/Kd0v2N8N7GwJXm/DJ+nAJW+3zb20
         svTQy1JSK81W3vYsJVvc+KW2bjlEsop3VoSVjzyaOpzCzGoLQ/KZuzxlUCqZP9qVkr/V
         ivEg==
X-Gm-Message-State: ANoB5pkLF27jy+qcrOKMBg7oahB9f9GE882eHEYftYEeObDgN2HxJsWs
        iJEse2AHV2hsnXGBpic8tb9HMjIOyKKTmJARNfk9Sw==
X-Google-Smtp-Source: AA0mqf6xMkxT9E7DWq3Ng6vFjK9UXooF5beAHY5gscd/9HrAj272x6MYVDzSbamQoScAHq+qHs5RibHKN1fmpEb5Z+o=
X-Received: by 2002:a17:902:a584:b0:186:be05:798e with SMTP id
 az4-20020a170902a58400b00186be05798emr9544083plb.37.1668615503443; Wed, 16
 Nov 2022 08:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
In-Reply-To: <20221111081033.3813-1-hayashi.kunihiko@socionext.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 17:17:45 +0100
Message-ID: <CAPDyKFpLVH1fEwKzjd8RP2NP0ZpEjo66XxvL5VVnCWMyS0dw4Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] mmc: sdhci-fujitsu: Add some features and support
 for F_SDH30_E51
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Nov 2022 at 09:10, Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
>
> This series adds some additional features such as reset control,
> non-removable media, and quirks for broken timeout clock.
>
> And this adds support for F_SDH30_E51 IP that is a higher version
> of F_SDH30 and supports eMMC 5.1.
>
> The above features are not specific to this IP directly, but are
> affected by IP configuration and external wiring.
>
> Changes since v1:
> - Add conversion and additional compatible patch for DT bindings
> - Add description for F_SDH30_E51 to the commit message
> - Append vendor name to MODULE_AUTHOR
>
> Kunihiko Hayashi (6):
>   dt-bindings: mmc: Convert sdhci-fujitsu to JSON schema
>   mmc: f-sdh30: Add reset control support
>   dt-bindings: sdhci-fujitsu: Add compatible string for F_SDH30_E51
>   mmc: f-sdh30: Add compatible string for Socionext F_SDH30_E51
>   mmc: f-sdh30: Add support for non-removable media
>   mmc: f-sdh30: Add quirks for broken timeout clock capability
>
>  .../bindings/mmc/fujitsu,sdhci-fujitsu.yaml   | 57 +++++++++++++++++++
>  .../devicetree/bindings/mmc/sdhci-fujitsu.txt | 32 -----------
>  drivers/mmc/host/sdhci_f_sdh30.c              | 31 +++++++++-
>  drivers/mmc/host/sdhci_f_sdh30.h              |  3 +
>  4 files changed, 89 insertions(+), 34 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/fujitsu,sdhci-fujitsu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-fujitsu.txt
>

Applied for next, thanks!

Kind regards
Uffe
