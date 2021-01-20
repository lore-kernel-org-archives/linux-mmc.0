Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60B1C4332B
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 20:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88CE623443
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 20:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbhATUXk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Jan 2021 15:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388511AbhATN6M (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Jan 2021 08:58:12 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED89C0613D3
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 05:57:32 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id d3so5385351uap.4
        for <linux-mmc@vger.kernel.org>; Wed, 20 Jan 2021 05:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQRUNaC5+h0p4y2UVASnStt5pCZ++1OHwy904QFlDOU=;
        b=YmKwnOpeJW4eDGtKIslo97cWH9y3TeYb8DX/Vbu89eB8jz3hfa0yhw37AKWLEUhNWd
         mt3IwgaDym8aJRq9Uz7lV6K8iNHAMwk2fJ+r+8K0olNYvHJzDEyDG4vkPw9y7mkBaGnk
         lH8ym/UWGq5LphZM0VqjKC49dRyr42PaAz8+VR/Uxysqyr68nVD1SSnriakNF2W/xEmk
         8GOjJLQeOgHpw+jxwsd3OmuYxjZrCzbWBa1L/gKkrUlOj7tCITYhgfzlrYTc05H5W2Xp
         LkliuoROmVlBiW6V4n9iDOJEzqerJVNCnmfz/3uGpfFKAgHPHvVD6E2LlwAlmAIWpjN+
         HITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQRUNaC5+h0p4y2UVASnStt5pCZ++1OHwy904QFlDOU=;
        b=A+xvEtCc+jxTKB9WgZ8SXuIgkeAW6lJDOp70fsB9W/ICb3YomnFfMBPRY1RvR456jK
         kv4psFIj/cKB4ueBodF+NxmM8L/ghFcuiZKQNsY/ngaQbnS1JxgBLagZtqbgx/Lx17n5
         SHjOqnottN1B9XliY+cM6wM8LcMcf12xuJLe72OXJZHbQiBpP7SaEeuqT07bXbF6UvYl
         yUiZkiAWhEwd24jCi2Eap+aT8K3w1i6cRxXYQSqt2ujmOU1JKlazmyUnnXuCKvHTovzG
         OxAqKZhyYu17eLaXsPgJo/4Opsv3gcKnf9ecX2QK5J5vJ7+z0S2Us9LGSz1o7/QqbzfE
         /nMQ==
X-Gm-Message-State: AOAM531hP5KqDoFEehlum1m1JKkFTvpzOEK3Ca0dbMQppOE130TPJg8Y
        0KY+2uQGDZP630H5jVwGH/t4W1/yA3U6bt/eA1DX8XPRdXm/EA==
X-Google-Smtp-Source: ABdhPJwMO/0D8TqJK6Fkbz71C7eV0brQdczzonmnmAX0at6juF1yaKbw/I3Yc90cQE95Mkb1cMyQpmukFxP54jUO160=
X-Received: by 2002:a9f:204e:: with SMTP id 72mr5752752uam.19.1611151051471;
 Wed, 20 Jan 2021 05:57:31 -0800 (PST)
MIME-Version: 1.0
References: <20210114031433.2388532-1-andrew@aj.id.au>
In-Reply-To: <20210114031433.2388532-1-andrew@aj.id.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 Jan 2021 14:56:55 +0100
Message-ID: <CAPDyKFqBOWLBbAxZNhN5r=qjXTG9+3tX4nT8+Gz+Xbppsxh5_g@mail.gmail.com>
Subject: Re: [PATCH v7 0/6] mmc: sdhci-of-aspeed: Expose phase delay tuning
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        ryan_chen@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 14 Jan 2021 at 04:14, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> Hello,
>
> This series implements support for the MMC core clk-phase-* devicetree bindings
> in the Aspeed SD/eMMC driver. The relevant register was exposed on the AST2600
> and is present for both the SD/MMC controller and the dedicated eMMC
> controller.
>
> v7 is just a small change to the the kunit testing in response to Adrian's
> feedback.
>
> I've just done a quick build test of v7 given the small change and more
> extensive testing done with v5.
>
> v6 can be found here:
>
> https://lore.kernel.org/linux-mmc/20201218035338.1130849-1-andrew@aj.id.au/
>
> Please review!
>
> Cheers,
>
> Andrew
>
> Andrew Jeffery (6):
>   mmc: core: Add helper for parsing clock phase properties
>   mmc: sdhci-of-aspeed: Expose clock phase controls
>   mmc: sdhci-of-aspeed: Add AST2600 bus clock support
>   mmc: sdhci-of-aspeed: Add KUnit tests for phase calculations
>   MAINTAINERS: Add entry for the ASPEED SD/MMC driver
>   ARM: dts: rainier: Add eMMC clock phase compensation
>
>  MAINTAINERS                                  |   9 +
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts |   1 +
>  drivers/mmc/core/host.c                      |  44 ++++
>  drivers/mmc/host/Kconfig                     |  14 +
>  drivers/mmc/host/sdhci-of-aspeed-test.c      |  98 +++++++
>  drivers/mmc/host/sdhci-of-aspeed.c           | 255 ++++++++++++++++++-
>  include/linux/mmc/host.h                     |  13 +
>  7 files changed, 423 insertions(+), 11 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-of-aspeed-test.c
>

Applied patch 1 to patch 5 applied for next (patch 6 should go via arm
soc), thanks!

Thanks for stepping and helping with maintenance as well!

Kind regards
Uffe
