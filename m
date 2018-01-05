From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri, 5 Jan 2018 14:25:45 +0100
Message-ID: <CACRpkdZie+uHWX6FgqXEKitUR37S+UWvn__s1KuxyYvcdY7zGA@mail.gmail.com>
References: <20180104201045.31139-1-linus.walleij@linaro.org>
 <OF2F4F13DD.1FAE7453-ONC125820C.00262A12-C125820C.002B3610@rittal.de>
 <CACRpkdYcESu=ZO1GfE+YoAsJxjVrtQQVk88wewkRPu_q2Lz6dQ@mail.gmail.com>
 <OF76C564BA.6811E770-ONC125820C.00365A44-C125820C.00373E96@rittal.de>
 <CACRpkdY6whY4Xrt5ijhyNCDVR8LgXyi7krkeUoSMhtsBjUJZYg@mail.gmail.com>
 <CACRpkdaLoOaT_j7XdKBd39DMJ-qoKWpLFfmWcf9R84_QY4bBdA@mail.gmail.com> <OF94AFB2FA.5B7D9F59-ONC125820C.003C0FB9-C125820C.003D39CB@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:33989 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeAENZq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Jan 2018 08:25:46 -0500
Received: by mail-it0-f68.google.com with SMTP id m11so4559825iti.1
        for <linux-mmc@vger.kernel.org>; Fri, 05 Jan 2018 05:25:46 -0800 (PST)
In-Reply-To: <OF94AFB2FA.5B7D9F59-ONC125820C.003C0FB9-C125820C.003D39CB@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>

On Fri, Jan 5, 2018 at 12:08 PM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:
>> When you say you flashed "another kernel and it works" did you mean
>> some random kernel, or exactly the same you applied my patch on,
>> but without my patch?
>
>> Please confirm that you have a booting merge base so I'm not chasing
>> ghosts here :)
>
> Sorry for not be exactly enough.
> I'm using Yocto to build a kernel with some other patches(which have nothing
> to do with emmc). This is my base and on this base I test your patches.
> With your patches it is not booting and without it is booting.

OK we're back to guesswork, I guess maybe I need to use
dma_alloc_coherent() since the buffer gets bigger than 64K.

I'll test that and respin.

Yours,
Linus Walleij
