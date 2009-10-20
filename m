From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
Date: Tue, 20 Oct 2009 12:27:03 -0500
Message-ID: <4ADDF2E7.4010200@billgatliff.com>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>	<1255418388-27866-1-git-send-email-u.kleine-koenig@pengutronix.de> <4AD42E10.7010801@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:56779 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbZJTR1H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2009 13:27:07 -0400
Received: by yxe17 with SMTP id 17so5185217yxe.33
        for <linux-mmc@vger.kernel.org>; Tue, 20 Oct 2009 10:27:11 -0700 (PDT)
In-Reply-To: <4AD42E10.7010801@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Pierre Ossman <drzeus@drzeus.cx>, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

Nicolas Ferre wrote:
> Uwe Kleine-K=C3=B6nig :
>  =20
>> This fixes a compile error introduced in
>>
>> 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
>>
>> That commit moved arch/arm/include/asm/mach/mmc.h to
>> include/linux/amba/mmci.h.  Just removing the include was enough.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de=
>
>> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Bill Gatliff <bgat@billgatliff.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Pierre Ossman <drzeus@drzeus.cx>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> Hello,
>>
>> what is the right path to Linus for this patch?
>>    =20
>
> Uwe,
>
> I gess that Andrew Morton will have to handle it.
>
> Let's help him not forget it ;-)
>  =20

Indeed!  This one _really_ annoys me.


b.g.

--=20
Bill Gatliff
bgat@billgatliff.com

