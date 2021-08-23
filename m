Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618D8C432BE
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4846061262
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Aug 2021 01:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhHWBHp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 22 Aug 2021 21:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232908AbhHWBHo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 22 Aug 2021 21:07:44 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A8C061760
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:07:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g21so23636397edw.4
        for <linux-mmc@vger.kernel.org>; Sun, 22 Aug 2021 18:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pjckf6bfV/IeJNN9n6MQVl/LTL3lu1yq7lS4IYzu/QM=;
        b=YXvUInxkTo+QS04+RTXnvdY5Tut9xBKcT9moQ79TGp2GjLkU/lF29770JsA6UY+UOn
         yjlARSI3QSab1F39xGyUm9LqcHKPE++VUejnLyKwbHAVdhKJnDNssxuQqlmSJhbAj2OT
         YxqGNv5II7hqHyRemXMsdL1BA/qgC6MEvPlCNcoHEhp6bZw3rOvoOzKVrjATtwfU9zue
         R0esUcu67bVhSd0ErcQC/7zaqVKqAAK4SPfsJQ+wsgTJKwMXBkS1CDhRG2++ClbJLMg2
         f77F2jBXBEzMMA7p3ZzlFd9ahFPEAgnqx1ZNVe670GdAp6aOQ7bP8biCveNS+9nuRpn+
         Dhfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pjckf6bfV/IeJNN9n6MQVl/LTL3lu1yq7lS4IYzu/QM=;
        b=Nq2n2fEVPsSmoz4RibNRDIcSRly/5fYLV7f83GokPARVKKt24ecfAYtvhFo+p3DVBl
         OVINW/7CaVF0ODp6kcCBML/LO99BFdS55kUA5C2Qvwj51MZiVYoNli4XoXfbC7YSolel
         et28HgaUP//ikKhfm/LGI7kgB2YTJgNMCypKCKOG3NxBQUhRws/auC6SbTCCkdYctqPB
         CMXZ7mX619oKlxrYMbMV3c+GoRACqF9OTeJtHx8S6iu05vF8hcPXEmkaZdEE8uh+0NSX
         dICpgfzAVZ8eXCO7CetQMj3ZMinECdWnVLFfPLnrAej64jXB6mUcq4CQrKuHBZlHk1AE
         0lxw==
X-Gm-Message-State: AOAM531fHCI38zGvQ9QS5+j8tSGtDzbEslCNhbqJw5DfhZf0sOOaItRM
        vhV4kQIeZTIi5VCDQhRuq0R6DIVODZ7s2j+ouCFCVg==
X-Google-Smtp-Source: ABdhPJxLjyDYm7QVxm1dvdfIEw9t3Et/mk1X0dx98a7+Jgg205IWLNBlgQOSRuBoYLny9Mb7LfeCW8J2s/qhMUfMTOY=
X-Received: by 2002:a05:6402:5208:: with SMTP id s8mr35097217edd.222.1629680821623;
 Sun, 22 Aug 2021 18:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210304034141.7062-1-brad@pensando.io> <20210304034141.7062-2-brad@pensando.io>
 <TU4PR8401MB1055D51E8D1B48DC7D7294E3AB979@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <TU4PR8401MB1055D51E8D1B48DC7D7294E3AB979@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 22 Aug 2021 18:06:51 -0700
Message-ID: <CAK9rFnz+PksEFjUh5ZpRLyvk21ZpVTxtwDYn_OhOEBJWjEYe7w@mail.gmail.com>
Subject: Re: [PATCH 1/8] gpio: Add Elba SoC gpio driver for spi cs control
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Elliott,

On Thu, Mar 4, 2021 at 12:44 PM Elliott, Robert (Servers)
<elliott@hpe.com> wrote:
[...]
> > +config GPIO_ELBA_SPICS
> > +     bool "Pensando Elba SPI chip-select"
> > +     depends on ARCH_PENSANDO_ELBA_SOC
> > +     help
> > +       Say yes here to support the Pensndo Elba SoC SPI chip-select
> > driver
>
> Pensndo should be Pensando

Fixed the typo, thanks.

> > diff --git a/drivers/gpio/gpio-elba-spics.c b/drivers/gpio/gpio-elba-spics.c
> > + * Pensando Elba ASIC SPI chip select driver
> ...
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("Elba SPI chip-select driver");
>
> I think it's conventional to include the company name there, so
> start that with "Pensando Elba"

Ok, thanks.  BTW I deleted these lines as I should have used
builtin_platform_driver() and not a loadable module.

> Also, "SoC" and "ASIC" are sometimes included after Elba, but sometimes
> are not. Consistency might be helpful.
>
> > +static const struct of_device_id ebla_spics_of_match[] = {
> ...
> > +             .of_match_table = ebla_spics_of_match,
>
> ebla should be elba

Fixed the typo and using SoC which is more accurate.

Regards,
Brad
