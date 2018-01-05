From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri,  5 Jan 2018 11:03:26 +0100 (CET)
Message-ID: <OF76C564BA.6811E770-ONC125820C.00365A44-C125820C.00373E96@rittal.de>
References: <CACRpkdYcESu=ZO1GfE+YoAsJxjVrtQQVk88wewkRPu_q2Lz6dQ@mail.gmail.com>,
        <20180104201045.31139-1-linus.walleij@linaro.org> <OF2F4F13DD.1FAE7453-ONC125820C.00262A12-C125820C.002B3610@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:34531 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750997AbeAEKD1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 05:03:27 -0500
In-Reply-To: <CACRpkdYcESu=ZO1GfE+YoAsJxjVrtQQVk88wewkRPu_q2Lz6dQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

> Hey it doesn't segfault! :D

Okay, so I guess it was a successfully test :D.

> OK I clearly need to find a system with sdhci on it, so I dug up a laptop
> with SDHCI to experiment on. Now trying to figure out a bit about
> x86_64 development...

Oh, sounds like fun. I'm looking forward to read from you.

> > Suprisingly there is a mmcblk0rpmb partition now. I don't know what that is
> > and if this was there before, but normally it has nothing to do
> > with our system. On our other systems it is not present.

> It is a feature of the eMMC card, and the feature list is retrieved with
> special commands from the card. Usually eMMCs that have boot partitions
> also have an RPMB partition.

Thanks for that information, I assume it comes with a newer kernel because with
our old 3.7.2 kernel there was nothing like that.

Kind regards,
Benjamin Beckmeyer
