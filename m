From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4] RFT: mmc: sdhci: Implement an SDHCI-specific bounce buffer
Date: Fri, 12 Jan 2018 14:56:50 +0100
Message-ID: <CACRpkdYckpvRKLqJSi1Ri0X7R+Z3OOKB5FF535G2LmKnQqAmTA@mail.gmail.com>
References: <20180112100022.3191-1-linus.walleij@linaro.org> <OF8FC8E998.7A21E1C5-ONC1258213.003D371A-C1258213.003D82BC@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:34338 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933760AbeALN4w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jan 2018 08:56:52 -0500
Received: by mail-it0-f51.google.com with SMTP id m11so1802885iti.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jan 2018 05:56:52 -0800 (PST)
In-Reply-To: <OF8FC8E998.7A21E1C5-ONC1258213.003D371A-C1258213.003D82BC@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Pierre Ossman <pierre@ossman.eu>, =?UTF-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?= <benoit@wsystem.com>, Fabio Estevam <fabio.estevam@nxp.com>, stable <stable@vger.kernel.org>

On Fri, Jan 12, 2018 at 12:11 PM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

> sorry to say that but in my case the kernel doesn't boot anymore.
> Again, after I "patched out" the bounce buffer it's running fine.
> Here is the kernel output..

Something is corrupting the data apparently :/

Well since dma_alloc_coherent() is know to work, I will make a
v5 that uses that and still caps the buffer to 64K, and bail out to
single segments if we can't allocate a bounce buffer.

Yours,
Linus Walleij
