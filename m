From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Thu, 17 Feb 2011 19:10:18 -0600
Message-ID: <AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTimjQfuNU-_rZTjAPrjxJhb=3kReVysBKoPE6Q4o@mail.gmail.com>
	<201102091013.56670.arnd@arndb.de>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:50326 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758158Ab1BRBKW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Feb 2011 20:10:22 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1I1AWkc018612
	for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 20:10:32 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1I19e3u018259
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 20:10:32 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 11so1988947vws.15
        for <linux-mmc@vger.kernel.org>; Thu, 17 Feb 2011 17:10:19 -0800 (PST)
In-Reply-To: <AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Fri, Feb 11, 2011 at 4:33 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> Arnd,
>
> Yes, this is a Toshiba card. I've sent the patch as a reply to Linus' email.
>
> cid - 02010053454d3332479070cc51451d00
> csd - d00f00320f5903ffffffffff92404000
> erase_size - 524288
> fwrev - 0x0
> hwrev - 0x0
> manfid - 0x000002
> name - SEM32G
> oemid - 0x0100
> preferred_erase_size - 2097152
>

Ok. Big mistake. Sorry about that. This card is Sandisk card. I got
confused over all the manfids changing.

Here is the Toshiba card:

cid - 1101004d4d4333324703101a17746d00
csd - 900e00320f5903ffffffffe796400000
erase_size - 524288
fwrev - 0x0
hwrev - 0x0
manfid - 0x000011
name - MMC32G
oemid - 0x0100
preferred_erase_size - 4194304

I'll get you the flashbench timings for both.
