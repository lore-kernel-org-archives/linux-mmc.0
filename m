From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: More TMIO MMC variant. What is a preferred name?
Date: Thu, 23 Nov 2017 08:04:51 +0100
Message-ID: <CAPDyKFpuiurgT5Zwo--EcaWOjZOdmSYotHrwH=c-byq3nkaxYw@mail.gmail.com>
References: <CAK7LNARB+-SzgNF+7KsG80o4Q=TZsEeyMLjR2Ve0bXCrQ5tc0w@mail.gmail.com>
 <20171108175320.wnq3d2x7lmpaya7s@ninjato> <CAK7LNASN8kjmiNHvX7zrgVv=5d81ovfGNRdHm8TXiJNgr+H9MA@mail.gmail.com>
 <20171120201142.n4l4jelxsmmtwjj6@tetsubishi> <CAPDyKFq_uVvBKBhATNYhq2mSMmNXA7tPSSPMESCnTDtQt9XrZA@mail.gmail.com>
 <20171121200111.vrpmsubme55356qv@ninjato> <CAPDyKFo6X+Z6bORzPow=79Q7jXZOu4SMA9dh1fDsD-_JrBRtgA@mail.gmail.com>
 <CAK7LNARpchnGL8ZGWcFs=bxmH2FK71Voyd5K1E6=3bHTjd-gyw@mail.gmail.com> <20171122170815.o3o5umayra7kbdg3@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:44376 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbdKWHEw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Nov 2017 02:04:52 -0500
Received: by mail-io0-f172.google.com with SMTP id w127so25653344iow.11
        for <linux-mmc@vger.kernel.org>; Wed, 22 Nov 2017 23:04:52 -0800 (PST)
In-Reply-To: <20171122170815.o3o5umayra7kbdg3@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On 22 November 2017 at 18:08, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> Another try:
>
>> # core
>> obj-$(CONFIG_MMC_TMIO_CORE)           += tmio_mmc_core.o
>> # TMIO-builtin MMC
>> obj-$(CONFIG_MMC_TMIO)                += tmio_mmc_original.o
>> # Reneses
>> obj-$(CONFIG_MMC_SDHI)                += tmio_mmc_sdhi_core.o
>> # UniPhier
>> obj-$(CONFIG_MMC_UNIPHIER)            += tmio_mmc_uniphier.o
>
> I left the Kconfig symbols for easier updating and concentrated on the
> filenames for now.
>

Looks good to me!

Kind regards
Uffe
