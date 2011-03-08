From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [[RFC] 2/5] MMC: Add block quirks support.
Date: Tue, 8 Mar 2011 21:28:35 +0100
Message-ID: <AANLkTikc1TW4J9+TmLL9sU2NbH2U66xD0hFXQyeHSkRg@mail.gmail.com>
References: <1299017344-25361-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-1-git-send-email-andreiw@motorola.com>
	<1299295274-32130-2-git-send-email-andreiw@motorola.com>
	<1299295274-32130-3-git-send-email-andreiw@motorola.com>
	<AANLkTinzYpjJxDR64RPsVYS1oFe6QB_7GMmGPXMaMnW-@mail.gmail.com>
	<AANLkTinUGu2aVpCOdGNrYgi3NAw4RiQRd=+gdd_PaDSh@mail.gmail.com>
	<AANLkTimZW-aHC1e0hJAsGTibM6uV2cF3+3NwYr3ppOCa@mail.gmail.com>
	<AANLkTi=DhG+yBESfGdFrc7gox2Z_VW-rOfhezsVyeitO@mail.gmail.com>
	<AANLkTi=AEMhOfbBtBfyqeuo9P85Qme=YirrYbF9gAGgf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60216 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754877Ab1CHU2g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Mar 2011 15:28:36 -0500
Received: by pvg12 with SMTP id 12so934364pvg.19
        for <linux-mmc@vger.kernel.org>; Tue, 08 Mar 2011 12:28:35 -0800 (PST)
In-Reply-To: <AANLkTi=AEMhOfbBtBfyqeuo9P85Qme=YirrYbF9gAGgf@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: Arnd Bergmann <arnd@arndb.de>, tardyp@gmail.com, linux-mmc@vger.kernel.org

2011/3/7 Andrei Warkentin <andreiw@motorola.com>:

> The other real issue I see is that it's kind of nasty to put
> block-related workarounds into core/quirks.c. The later seems more of
> generic card interface workarounds, rather than workarounds for
> specific functionality. It would be like putting workarounds for, say,
> sdio_uart into core/quirk.c, IMHO block workarounds are still
> function-level workarounds, and so should be dealt with at the
> function-level under mmc/card. Thoughts?

The SDIO cards are function-level too, so what you're saying is
that the file quirks.c should be moved from core/ to card/
and extended there?
If so, yes.

Linus Walleij
