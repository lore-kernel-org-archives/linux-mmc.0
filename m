From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: mmc: sdhci stop SDCLK during asynchronous interrupt peroid
Date: Sun, 9 Jan 2011 17:34:10 +0100
Message-ID: <AANLkTi=y6v9FFSXTquhP3czL2aTWSft7gZZMvKnb4G9+@mail.gmail.com>
References: <AANLkTimXQMkWhJZ=nD8r-odmU+J6nf+7U+6KOHr5E1N1@mail.gmail.com>
	<CFD46C56-3B58-40E8-8B05-7FF768725B86@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:33858 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751848Ab1AIQeL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 11:34:11 -0500
Received: by qyk12 with SMTP id 12so21211815qyk.19
        for <linux-mmc@vger.kernel.org>; Sun, 09 Jan 2011 08:34:10 -0800 (PST)
In-Reply-To: <CFD46C56-3B58-40E8-8B05-7FF768725B86@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Linus Walleij <linus.walleij@stericsson.com>

> This will enable clock gating for SD/eMMC and SDIO cards. =A0This is =
not a good idea for SDIO where
> there are known issues. =A0This is one reason the software clock gati=
ng code does not enable
> clock gating on SDIO. =A0Not all SDIO cards can work.

See the patch I just posted on the list. I added support for software
clockgating.
"mmc: add MMC_QUIRK_BROKEN_CLK_GATING"
This one might base on this quirk to detect if the connected sdio card
can be clockgated.


Regards,
Pierre
