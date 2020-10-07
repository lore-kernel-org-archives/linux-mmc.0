Return-Path: <SRS0=fQuC=DO=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D95BC4363C
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 08:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B575D21D90
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Oct 2020 08:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLxI4Kqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgJGIzv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Oct 2020 04:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgJGIzv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2020 04:55:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1DDC061755;
        Wed,  7 Oct 2020 01:55:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id w21so957408pfc.7;
        Wed, 07 Oct 2020 01:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBSwN6CySi9VXctdQH39fe1z7EMm/ePFjoVWaHKSbZM=;
        b=NLxI4KqmbygpJjxMAQrlyuRtpTCOTOOLLmCjz3P4vwS7w85TVTfZYauKXfPMslhfI2
         pKaMmCv8tdVEwRFe37uzDubQive+VmXbV9K7v7Ty+RPdt1AhARwzYNxTNmbBY3F5n3qF
         Ko8qmPDsqjMNq6UcuA/HQZvad5uy2IzOr1VobIJjpFXt5xlZGv2TGwFr+htmk8d1MPv6
         hJR8YyqlVpcuz5sVNQvU+gIBmMptlyLXYRIN/Wpz8exOtndjZxeFuOhAG45iYBL3vgZR
         Zs538Ow/OSZQNOsX2xasq765zLVyH+evkcRoQyFX6fCen2uS9wXYG4xufFwZK6ge4eD6
         5vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBSwN6CySi9VXctdQH39fe1z7EMm/ePFjoVWaHKSbZM=;
        b=DWrbIEj/xTyJ1qX/27AnmBw1gC12UZakp5BPwZTNCMf435SVpseG0seilExmi3rjs1
         Bl9MgaOuaf3RmTxw9xETI4WAZurz7FZCo9ZCFm+tXYg+JavXht+REvQujyDbHfxyq55u
         bUuQ6Q3TaYddDlEzL5Z232v7RC5dVjmNJZK7wV9+NIqa5rk4xSq0L3EuZzQ0jWVoERAT
         rtlLgYUPrTZTY0Ob93kIrWbSzcuJJ+n+ASkddfN07K1jSNtNS53dbYy1GP7vgblIocJe
         ZngX65sayLNn6jZZNPf4A4ZP+VOuqkkAvyPlaUdiuQB12+tsHfe6E2icrp+ENaFOx7m0
         7GeQ==
X-Gm-Message-State: AOAM531Ps1k/hFResUNd8Ohpp7/NENbbVR6dam50BDTiLY2JWlEIbWsB
        MykRLJNhr70V/71MPN1ZdXs7sfDOTmeCz/wybAo=
X-Google-Smtp-Source: ABdhPJyEvCXOeL/H/lWIGF5FDFaKJS+D0Ie0L8/uGypdH+G6PKeAb37lNqqlZ0iLRQs3nHIy5AkPX3X1XAIgkSh7vuI=
X-Received: by 2002:a63:4c1d:: with SMTP id z29mr2157070pga.203.1602060950488;
 Wed, 07 Oct 2020 01:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20201006155549.3595-1-muhammad.husaini.zulkifli@intel.com>
 <20201006155549.3595-2-muhammad.husaini.zulkifli@intel.com> <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com>
In-Reply-To: <49c9fe27-ee82-f490-482b-365101d3b6cf@xilinx.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 7 Oct 2020 11:55:34 +0300
Message-ID: <CAHp75VfXe=dwbNEdUfwmMnZCkSTRH_6HjGD0MUs=GY0en4f0sw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mmc: sdhci-of-arasan: Enable UHS-1 support for
 Keem Bay SOC
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     muhammad.husaini.zulkifli@intel.com,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lakshmi.bai.raja.subramanian@intel.com,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Oct 7, 2020 at 11:38 AM Michal Simek <michal.simek@xilinx.com> wrote:
> On 06. 10. 20 17:55, muhammad.husaini.zulkifli@intel.com wrote:

...

> > +             /*
> > +              * This is like final gatekeeper. Need to ensure changed voltage

like a final

> > +              * is settled before and after turn on this bit.
> > +              */

...

> > +             /*
> > +              * This is like final gatekeeper. Need to ensure changed voltage

Likewise.

> > +              * is settled before and after turn on this bit.
> > +              */

...

> > +     struct device *dev = &pdev->dev;
>
> nit: I got this but as I see 3 lines below maybe would be better to use
> it everywhere but it can be done in separate patch.

In that case I think it would be better to have that patch first. It
make follow up code cleaner.

...

> > +     if (of_device_is_compatible(np, "intel,keembay-sdhci-5.1-sd")) {
> > +             struct gpio_desc *uhs;
> > +
> > +             uhs = devm_gpiod_get_optional(dev, "uhs", GPIOD_OUT_HIGH);
>
> I can't see change in dt binding to record uhs gpio.
>
>
> Better
> sdhci_arasan->uhs_gpio = devm_gpiod_get_optional(dev, "uhs",
> GPIOD_OUT_HIGH);
>
> then you can avoid uhs variable.

Actually it's readability vs. additional variable. It was my
suggestion to have a variable to make readability better.
Are you insisting on this change?

-- 
With Best Regards,
Andy Shevchenko
