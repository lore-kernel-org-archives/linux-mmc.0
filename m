From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: MMC flash is very slow since 4.14 - "mmc: Delete bounce buffer
 handling" was the problem
Date: Wed, 3 Jan 2018 18:28:33 +0100
Message-ID: <CACRpkdZ+0Mbq5cQmj4V2Wv6rQ+Nq4_K7VZT=oGE6HFKrHRtWGg@mail.gmail.com>
References: <OF6E8F2076.873BA83E-ONC125820A.002C8518-C125820A.003A70E6@rittal.de>
 <CACRpkdYbdx=ncW2HaB=GZvR59Htyon=9=1ewzPo9hKdsRq_FhQ@mail.gmail.com> <OF030842CB.F1296E1F-ONC125820A.0053A410-C125820A.005569FE@rittal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f47.google.com ([209.85.214.47]:40680 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbeACR2f (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 12:28:35 -0500
Received: by mail-it0-f47.google.com with SMTP id f190so2604385ita.5
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jan 2018 09:28:35 -0800 (PST)
In-Reply-To: <OF030842CB.F1296E1F-ONC125820A.0053A410-C125820A.005569FE@rittal.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Benjamin Beckmeyer <beckmeyer.b@rittal.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Pierre Ossman <pierre@ossman.eu>

On Wed, Jan 3, 2018 at 4:32 PM, Benjamin Beckmeyer
<beckmeyer.b@rittal.de> wrote:

> But it hangs while booting. The lines above are the last output on the serial console.
>
> So, for now, I guess the device needs the DMA.

Yeah seems like so... :/

So we need to get a bounce buffer back for bugged SDHI devices.

I see two options:

1. Put the bounce buffer into the SDHCI host (this is the only driver
    that seems to have any need for it).

2. Manage it centrally. (Like we did before, or in the block layer.)

Notice that the block core has bounce buffer support. However there,
it is used to bounce highmem buffers to lowmem buffers because of
hardware limitations.

The bounce buffers we use with SDMA are only
for copying the SG list fragments into a continous buffer so that we
do not need to shoot off a lot of individual small DMA jobs.

I hope everyone is on the same page here, that this is where
the speedup comes from?

I guess I can try to open code some stuff into the SDHCI driver
for the SDMA case (I guess it should be for that case only.)
Lemme see what I can hack up!

Yours,
Linus Walleij
