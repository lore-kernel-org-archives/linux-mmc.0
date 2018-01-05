From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri, 5 Jan 2018 10:06:20 +0100
Message-ID: <CACRpkdYcESu=ZO1GfE+YoAsJxjVrtQQVk88wewkRPu_q2Lz6dQ@mail.gmail.com>
References: <20180104201045.31139-1-linus.walleij@linaro.org> <OF2F4F13DD.1FAE7453-ONC125820C.00262A12-C125820C.002B3610@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:44320 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751261AbeAEJGV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 04:06:21 -0500
Received: by mail-io0-f177.google.com with SMTP id k18so5088831ioc.11
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2018 01:06:21 -0800 (PST)
In-Reply-To: <OF2F4F13DD.1FAE7453-ONC125820C.00262A12-C125820C.002B3610@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Jan 5, 2018 at 8:51 AM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

> I can comfort you, it doesn't work :). I tried both, with your print
> outs and without.

Hey it doesn't segfault! :D

> After I patched the kernel it doesn't find the root
> filesystem anymore. Here is the kernel log:

OK I clearly need to find a system with sdhci on it, so I dug up a laptop
with SDHCI to experiment on. Now trying to figure out a bit about
x86_64 development...

> Suprisingly there is a mmcblk0rpmb partition now. I don't know what that is
> and if this was there before, but normally it has nothing to do
> with our system. On our other systems it is not present.

It is a feature of the eMMC card, and the feature list is retrieved with
special commands from the card. Usually eMMCs that have boot partitions
also have an RPMB partition.

Yours,
Linus Walleij
