From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: PATCH: mmc.c DDR print of card type not correct
Date: Mon, 1 Nov 2010 19:11:15 +0100
Message-ID: <AANLkTikDV86SXjkj_B4Mv=hfDeMU=QAywRgQROfcen7A@mail.gmail.com>
References: <Act3QTFHJtPJMcP5Qf2uwZskt324LQ==>
	<24C0629C-F7E8-4D4A-A42A-2B6578B5AE2D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:56301 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752157Ab0KASLR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Nov 2010 14:11:17 -0400
Received: by wwe15 with SMTP id 15so6371765wwe.1
        for <linux-mmc@vger.kernel.org>; Mon, 01 Nov 2010 11:11:16 -0700 (PDT)
In-Reply-To: <24C0629C-F7E8-4D4A-A42A-2B6578B5AE2D@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>

2010/10/29 Philip Rakity <prakity@marvell.com>:

> we should not call mmc_card_set_ddr_mode if we are in single data mod=
e. =A0This sets DDR and causes
> the print out in the log to say the card is DDR when it is not.
>
> Explicitly set ddr to 0 rather then rely on MMC_SDR_MODE being 0 when=
 doing the checks.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>

Acked-by: Linus Walleij <linus.walleij@stericsson.com>

This looks correct to me and my immediate colleagues.

Yours,
Linus Walleij
