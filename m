From: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Subject: Re: [PATCH] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri,  5 Jan 2018 12:08:46 +0100 (CET)
Message-ID: <OF94AFB2FA.5B7D9F59-ONC125820C.003C0FB9-C125820C.003D39CB@rittal.de>
References: <CACRpkdaLoOaT_j7XdKBd39DMJ-qoKWpLFfmWcf9R84_QY4bBdA@mail.gmail.com>,
        <20180104201045.31139-1-linus.walleij@linaro.org> <OF2F4F13DD.1FAE7453-ONC125820C.00262A12-C125820C.002B3610@rittal.de> <CACRpkdYcESu=ZO1GfE+YoAsJxjVrtQQVk88wewkRPu_q2Lz6dQ@mail.gmail.com> <OF76C564BA.6811E770-ONC125820C.00365A44-C125820C.00373E96@rittal.de> <CACRpkdY6whY4Xrt5ijhyNCDVR8LgXyi7krkeUoSMhtsBjUJZYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailgw03.loh-group.com ([195.226.74.51]:39227 "EHLO
        mailgw03.loh-group.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751008AbeAELIr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 06:08:47 -0500
In-Reply-To: <CACRpkdaLoOaT_j7XdKBd39DMJ-qoKWpLFfmWcf9R84_QY4bBdA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

> When you say you flashed "another kernel and it works" did you mean
> some random kernel, or exactly the same you applied my patch on,
> but without my patch?

> Please confirm that you have a booting merge base so I'm not chasing
> ghosts here :)

Sorry for not be exactly enough. 
I'm using Yocto to build a kernel with some other patches(which have nothing 
to do with emmc). This is my base and on this base I test your patches. 
With your patches it is not booting and without it is booting. 

So, no ghosts at all.

Kind regards,
Benjamin Beckmeyer
