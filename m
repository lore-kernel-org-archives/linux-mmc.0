From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Tue, 28 Nov 2017 17:04:26 +0900
Message-ID: <CAK7LNAQtLdXBw_JzW2dYdVtC0b6eGCvO5KByXfKKJVxi02i61g@mail.gmail.com>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato> <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi> <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato> <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com>
 <20171122170815.o3o5umayra7kbdg3@ninjato> <CAPDyKFpuiurgT5Zwo--EcaWOjZOdmSYotHrwH=c-byq3nkaxYw@mail.gmail.com>
 <20171127171401.o7ch26oot2au5oux@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from conssluserg-03.nifty.com ([210.131.2.82]:38859 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750907AbdK1IFR (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Nov 2017 03:05:17 -0500
Received: from mail-yw0-f180.google.com (mail-yw0-f180.google.com [209.85.161.180]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id vAS857NR003088
        for <linux-mmc@vger.kernel.org>; Tue, 28 Nov 2017 17:05:07 +0900
Received: by mail-yw0-f180.google.com with SMTP id p74so12944906ywe.2
        for <linux-mmc@vger.kernel.org>; Tue, 28 Nov 2017 00:05:07 -0800 (PST)
In-Reply-To: <20171127171401.o7ch26oot2au5oux@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

2017-11-28 2:14 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
>
>> > Another try:
>> >
>> >> # core
>> >> obj-$(CONFIG_MMC_TMIO_CORE)           += tmio_mmc_core.o
>> >> # TMIO-builtin MMC
>> >> obj-$(CONFIG_MMC_TMIO)                += tmio_mmc_original.o
>> >> # Reneses
>> >> obj-$(CONFIG_MMC_SDHI)                += tmio_mmc_sdhi_core.o
>> >> # UniPhier
>> >> obj-$(CONFIG_MMC_UNIPHIER)            += tmio_mmc_uniphier.o
>> >
>> > I left the Kconfig symbols for easier updating and concentrated on the
>> > filenames for now.
>> >
>>
>> Looks good to me!
>
> Yamada-san?

Basically, looks good to me,
although I'd like to know our goal before we agree with it.

How about CONFIG names and functions?
Prefix CONFIG options with CONFIG_MMC_TMIO ?


# core
obj-$(CONFIG_MMC_TMIO_CORE)           += tmio_mmc_core.o
# TMIO-builtin MMC
obj-$(CONFIG_MMC_TMIO)                += tmio_mmc_original.o
# Reneses
obj-$(CONFIG_MMC_TMIO_SDHI)           += tmio_mmc_sdhi_core.o
# UniPhier
obj-$(CONFIG_MMC_TMIO_UNIPHIER)       += tmio_mmc_uniphier.o


Or, like follows?

# core
obj-$(CONFIG_MMC_TMIO)                += tmio_mmc.o
# TMIO-builtin MMC
obj-$(CONFIG_MMC_TMIO_ORIGINAL)       += tmio_mmc_original.o
# Reneses
obj-$(CONFIG_MMC_TMIO_SDHI)           += tmio_mmc_sdhi_core.o
# UniPhier
obj-$(CONFIG_MMC_TMIO_UNIPHIER)       += tmio_mmc_uniphier.o



What should I do for function names?
Shall I start with tmio_mmc_uniphier_ ?




-- 
Best Regards
Masahiro Yamada
