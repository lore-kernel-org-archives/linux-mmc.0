Return-Path: <SRS0=SgEP=CU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC22C433E2
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 06:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7549E221E5
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Sep 2020 06:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599804052;
	bh=WESK6UKUjRSkP/TKSKzcEG4kxiuhjNV3m+bUJP3+ZXk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oDwlUlTLeZQVgEts8N9zGd/x6dF6D114kJfVjOuoHm/N/KsHLiPpeOeanRQ7aREWH
	 i4ydFDf7g41ooWgqmFioIC+He+3k1G5ZTLzPZ+lMroNCP3ODxZ5wKu8edUghlRGs/6
	 HKxFWJlVqxHN94gWH6mz9TR4dHD11NXuqy0LJ428=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKGAr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKGAr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 11 Sep 2020 02:00:47 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3315221E5;
        Fri, 11 Sep 2020 06:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599804046;
        bh=WESK6UKUjRSkP/TKSKzcEG4kxiuhjNV3m+bUJP3+ZXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LC7DGZ8rQekxgJUgL7zxJ0LSh8Y/78j+NhruI5QfUcNvg1Qnnm5Qz3wO0/okaaFUA
         WVguyWmjY1UBQ9GxUMisqY9kXRKh70rJ39UFlNetdPSqcs6RJ0mLNogVJ4Op3PRi+h
         kmmKZWyIKgr1QkKcWDHBRWULkVuo4+FNDgWkBwkM=
Received: by mail-ed1-f50.google.com with SMTP id g4so8768450edk.0;
        Thu, 10 Sep 2020 23:00:45 -0700 (PDT)
X-Gm-Message-State: AOAM532K56wgC580HP5gHKHNUMIZAb1K5Fp9G7cHX0cde1ITsE5oZQqe
        8Hhegfvdk2kMKVYmfjuCFrkjgVHpY+PH1wVNihg=
X-Google-Smtp-Source: ABdhPJymE4+rHgjSFNYuvs+iwJGMjk8bYNxuRzgTr6WbXwAWTZAX5N+hRh1+ebmhCBeiPPYGzNLG50rUvrXYcNeA9YU=
X-Received: by 2002:a05:6402:515:: with SMTP id m21mr346459edv.348.1599804044455;
 Thu, 10 Sep 2020 23:00:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200902193658.20539-1-krzk@kernel.org> <CAPDyKFqBS-ws6fkirDQL8EEqh9At88K2vrG5fc8K5_JiXsmfyg@mail.gmail.com>
 <CAL_Jsq+ajm5aiAJfQdS2+2DO1ynBDHWha_7TsA4u-2qwd87y6g@mail.gmail.com>
In-Reply-To: <CAL_Jsq+ajm5aiAJfQdS2+2DO1ynBDHWha_7TsA4u-2qwd87y6g@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 11 Sep 2020 08:00:32 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf8cNDGaXGkYpgc-LEEPSoF2JxwzQp7fwVQB3kLJWNKXw@mail.gmail.com>
Message-ID: <CAJKOXPf8cNDGaXGkYpgc-LEEPSoF2JxwzQp7fwVQB3kLJWNKXw@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: Minor cleanups and compile test
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
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

On Fri, 11 Sep 2020 at 00:55, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Sep 3, 2020 at 2:40 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 2 Sep 2020 at 21:37, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Hi,
> > >
> > > Set of minor cleanups.  Patches requiring more attention:
> > >  - 6/11: Testing and review would be appreciated,
> > >  - 11/11: I build tested multiple architectures but not all and
> > >    definitely no all possible configs. This one could sit on the lists
> > >    for few days so 0-day would try it.
> > >
> > > Best regards,
> > > Krzysztof
> > >
> > > Krzysztof Kozlowski (11):
> > >   mmc: bcm2835: Simplify with dev_err_probe()
> > >   mmc: davinci: Simplify with dev_err_probe()
> > >   mmc: dw_mmc-zx: Simplify with dev_err_probe()
> > >   mmc: jz4740: Simplify with dev_err_probe()
> > >   mmc: meson: Simplify with dev_err_probe()
> > >   mmc: sdhci-brcmstb: Simplify with optional clock and dev_err_probe()
> > >   mmc: sdhci-of-arasan: Simplify with dev_err_probe()
> > >   mmc: sdhci-tegra: Simplify with dev_err_probe()
> > >   mmc: dw_mmc: Simplify with dev_err_probe()
> > >   mmc: sdhci-of-sparx5: Use proper printk format for dma_addr_t
> > >   mmc: host: Enable compile testing of multiple drivers
> > >
> > >  drivers/mmc/host/Kconfig           | 42 ++++++++++++++++--------------
> > >  drivers/mmc/host/bcm2835.c         |  4 +--
> > >  drivers/mmc/host/davinci_mmc.c     |  5 ++--
> > >  drivers/mmc/host/dw_mmc-zx.c       | 11 +++-----
> > >  drivers/mmc/host/dw_mmc.c          |  9 +++----
> > >  drivers/mmc/host/jz4740_mmc.c      |  5 ++--
> > >  drivers/mmc/host/meson-gx-mmc.c    | 16 ++++--------
> > >  drivers/mmc/host/sdhci-brcmstb.c   | 12 ++++-----
> > >  drivers/mmc/host/sdhci-of-arasan.c |  7 +++--
> > >  drivers/mmc/host/sdhci-of-sparx5.c |  4 +--
> > >  drivers/mmc/host/sdhci-tegra.c     |  7 ++---
> > >  11 files changed, 51 insertions(+), 71 deletions(-)
> > >
> > > --
> > > 2.17.1
> > >
> >
> > Series applied for next, except 11, thanks!
>
> I see there's a bunch of these already, but I think we can do better
> here than dev_err_probe. We have _optional variants for the case not
> getting a resource is not an error. So the called functions like
> devm_clk_get can print an error. We already have this for
> platform_get_irq along with a coccinelle script to fix cases. I have a
> WIP branch[1] doing this.

That's quite good idea.

Best regards,
Krzysztof
