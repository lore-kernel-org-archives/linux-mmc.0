From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: MMC quirks relating to performance/lifetime.
Date: Fri, 18 Feb 2011 13:47:26 -0600
Message-ID: <AANLkTi=W16NxpzhrBhxJPmk-CSe+yyxAXMh6YYq6oaEt@mail.gmail.com>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<AANLkTinaY2RM86tX4ex+zsMwFKUdBNVpdZ8fFrt-e12_@mail.gmail.com>
	<AANLkTikjUEjr=Sd1Ewyj8-yAKPV3Wa2Ch1aE=0DtrXP6@mail.gmail.com>
	<201102181444.24476.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:58469 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754773Ab1BRTr3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Feb 2011 14:47:29 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.167])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1IJldkJ018419
	for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 14:47:39 -0500 (EST)
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com [209.85.220.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p1IJVrlX012510
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 14:47:39 -0500 (EST)
Received: by mail-vx0-f170.google.com with SMTP id 38so2755104vxc.15
        for <linux-mmc@vger.kernel.org>; Fri, 18 Feb 2011 11:47:27 -0800 (PST)
In-Reply-To: <201102181444.24476.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org

On Fri, Feb 18, 2011 at 7:44 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> I'm curious. Neither the manfid nor the oemid fields of either card
> match what I have seen on SD cards, I would expect them to be
>
> Sandisk: manfid 0x000003, oemid 0x5344
> Toshiba: manfid 0x000002, oemid 0x544d
>
> I have not actually seen any Toshiba SD cards, but I assume that they
> use the same controllers as Kingston.
>
> Does anyone know if the IDs have any correlation between MMC and SD
> controllers?
>
> =A0 =A0 =A0 =A0Arnd
>

I'm unsure about the older scheme (assigned by MMCA), but ever since
MMC is now JEDEC-controlled, the IDs have changed. Sandisk's new id
will be 0x45, and Toshiba I guess will be 0x11.
