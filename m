Return-Path: <SRS0=ANdn=CT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0B8C433E2
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Sep 2020 22:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C5320684
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Sep 2020 22:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599778542;
	bh=qcDtdo4KtSRqLIHBTyQuxQS343VMAgWt9vLx/LQN3EM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wcCB0y0rtkIorAkIhCkqbpOZKBuJUS9va6U2EUJm5+249QeyvNT44uGfZ15116QYx
	 FTIGjmBKl3B0L/kaiPvuDvXjxyZJgUtAezn3Iyv3IryJ8I6+VH1mo6S8WDjLMvUgO9
	 meJlJkinUgR/ObWirEEnJGtlAiSvW6fUU24B8YxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725290AbgIJWzi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgIJWzi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 10 Sep 2020 18:55:38 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E350521D81;
        Thu, 10 Sep 2020 22:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599778537;
        bh=qcDtdo4KtSRqLIHBTyQuxQS343VMAgWt9vLx/LQN3EM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EQdTeSVMOyglZrJ0y9T548kiI7MRiDSrEo47DwdhHEHN4RxB+VTRtSw56opOsDIOc
         WYdet4IJLbdKzGORoMPu51NLQpp7MxMQev1pboeHfMxnPAK8rvhimKnpmWTJi3AikZ
         pDmfs0Emi8Ad6yLOoRQK63OCOGC/IjNpTGDx2nnA=
Received: by mail-ot1-f41.google.com with SMTP id e23so6790666otk.7;
        Thu, 10 Sep 2020 15:55:36 -0700 (PDT)
X-Gm-Message-State: AOAM532m5fsYYVUSqkmUKtrWbw8nOtXt5d4msp7DRCQRw6lR1FTL0PM0
        OGD+u06R4hWOe9mPTwVXQiiyD5h2DDdupQaPCQ==
X-Google-Smtp-Source: ABdhPJwxLrtw8P1iDFnINFBcq5+LFkPAZuZ45Y+BpDa4K34pf79dsdO3g4++HkIgCm6/pIKr4h47efJjCIAix2IDiXQ=
X-Received: by 2002:a9d:411:: with SMTP id 17mr5602788otc.192.1599778536187;
 Thu, 10 Sep 2020 15:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200902193658.20539-1-krzk@kernel.org> <CAPDyKFqBS-ws6fkirDQL8EEqh9At88K2vrG5fc8K5_JiXsmfyg@mail.gmail.com>
In-Reply-To: <CAPDyKFqBS-ws6fkirDQL8EEqh9At88K2vrG5fc8K5_JiXsmfyg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 10 Sep 2020 16:55:24 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+ajm5aiAJfQdS2+2DO1ynBDHWha_7TsA4u-2qwd87y6g@mail.gmail.com>
Message-ID: <CAL_Jsq+ajm5aiAJfQdS2+2DO1ynBDHWha_7TsA4u-2qwd87y6g@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: Minor cleanups and compile test
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Scott Branden <sbranden@broadcom.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Sep 3, 2020 at 2:40 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Wed, 2 Sep 2020 at 21:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > Hi,
> >
> > Set of minor cleanups.  Patches requiring more attention:
> >  - 6/11: Testing and review would be appreciated,
> >  - 11/11: I build tested multiple architectures but not all and
> >    definitely no all possible configs. This one could sit on the lists
> >    for few days so 0-day would try it.
> >
> > Best regards,
> > Krzysztof
> >
> > Krzysztof Kozlowski (11):
> >   mmc: bcm2835: Simplify with dev_err_probe()
> >   mmc: davinci: Simplify with dev_err_probe()
> >   mmc: dw_mmc-zx: Simplify with dev_err_probe()
> >   mmc: jz4740: Simplify with dev_err_probe()
> >   mmc: meson: Simplify with dev_err_probe()
> >   mmc: sdhci-brcmstb: Simplify with optional clock and dev_err_probe()
> >   mmc: sdhci-of-arasan: Simplify with dev_err_probe()
> >   mmc: sdhci-tegra: Simplify with dev_err_probe()
> >   mmc: dw_mmc: Simplify with dev_err_probe()
> >   mmc: sdhci-of-sparx5: Use proper printk format for dma_addr_t
> >   mmc: host: Enable compile testing of multiple drivers
> >
> >  drivers/mmc/host/Kconfig           | 42 ++++++++++++++++--------------
> >  drivers/mmc/host/bcm2835.c         |  4 +--
> >  drivers/mmc/host/davinci_mmc.c     |  5 ++--
> >  drivers/mmc/host/dw_mmc-zx.c       | 11 +++-----
> >  drivers/mmc/host/dw_mmc.c          |  9 +++----
> >  drivers/mmc/host/jz4740_mmc.c      |  5 ++--
> >  drivers/mmc/host/meson-gx-mmc.c    | 16 ++++--------
> >  drivers/mmc/host/sdhci-brcmstb.c   | 12 ++++-----
> >  drivers/mmc/host/sdhci-of-arasan.c |  7 +++--
> >  drivers/mmc/host/sdhci-of-sparx5.c |  4 +--
> >  drivers/mmc/host/sdhci-tegra.c     |  7 ++---
> >  11 files changed, 51 insertions(+), 71 deletions(-)
> >
> > --
> > 2.17.1
> >
>
> Series applied for next, except 11, thanks!

I see there's a bunch of these already, but I think we can do better
here than dev_err_probe. We have _optional variants for the case not
getting a resource is not an error. So the called functions like
devm_clk_get can print an error. We already have this for
platform_get_irq along with a coccinelle script to fix cases. I have a
WIP branch[1] doing this.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dev_err-removal
