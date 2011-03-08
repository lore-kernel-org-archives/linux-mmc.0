From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Tue, 8 Mar 2011 14:57:53 -0600
Message-ID: <AANLkTimQhTLLpOUk-GNibaLOYJ7yNGyD1Epm2T51oZyE@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
	<AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
	<AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
	<AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
	<AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
	<AANLkTi=AEMhOfbBtBfyqeuo9P85Qme=YirrYbF9gAGgf@mail.gmail.com>
	<AANLkTikc1TW4J9+TmLL9sU2NbH2U66xD0hFXQyeHSkRg@mail.gmail.com>
	<AANLkTiktQ6zR+SVGa396LBDqgWm+C8BGoQ_94_D9bDRR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og115.obsmtp.com ([64.18.0.246]:40760 "EHLO
	exprod5og115.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756076Ab1CHU5z (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 15:57:55 -0500
Received: from il93mgrg01.am.mot-mobility.com ([10.22.94.167])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p28Kuasf021138
	for <linux-mmc@vger.kernel.org>; Tue, 8 Mar 2011 15:56:36 -0500 (EST)
Received: from mail-qy0-f170.google.com (mail-qy0-f170.google.com [209.85.216.170])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p28Kuat7021132
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 8 Mar 2011 15:56:36 -0500 (EST)
Received: by qyk32 with SMTP id 32so3334194qyk.15
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 12:57:53 -0800 (PST)
In-Reply-To: <AANLkTiktQ6zR+SVGa396LBDqgWm+C8BGoQ_94_D9bDRR@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, tardyp@gmail.com, linux-mmc@vger.kernel.org

On Tue, Mar 8, 2011 at 2:34 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Tue, Mar 8, 2011 at 2:28 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> 2011/3/7 Andrei Warkentin <andreiw@motorola.com>:
>>
>>> The other real issue I see is that it's kind of nasty to put
>>> block-related workarounds into core/quirks.c. The later seems more of
>>> generic card interface workarounds, rather than workarounds for
>>> specific functionality. It would be like putting workarounds for, say,
>>> sdio_uart into core/quirk.c, IMHO block workarounds are still
>>> function-level workarounds, and so should be dealt with at the
>>> function-level under mmc/card. Thoughts?
>>
>> The SDIO cards are function-level too, so what you're saying is
>> that the file quirks.c should be moved from core/ to card/
>> and extended there?
>> If so, yes.
>>
>> Linus Walleij
>>
>
> Alright :-).
>
> I'll extend the current mechanism in quirks.c to match on manfid/oemid
> and revision. In fact, the current code
> assumes all cards use cis.vendor and cis.device, but that only applies
> to SDIO cards.
>
> Thanks,
> A
>

On a second thought it should still belong within core, since it's
getting built as part of the MMC core support... The tables could be
per-function-driver, I suppose...
So mmc_fixup_device takes as an additional parameter a pointer to the
lookup table...

A
