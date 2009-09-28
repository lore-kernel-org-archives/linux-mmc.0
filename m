From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] Move MMCI header to amba include dir
Date: Mon, 28 Sep 2009 20:45:38 +0200
Message-ID: <63386a3d0909281145t509f9105x396f5d32b79e9c47@mail.gmail.com>
References: <1253625972-19407-1-git-send-email-linus.walleij@stericsson.com>
	 <9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:57762 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbZI1Spg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Sep 2009 14:45:36 -0400
Received: by bwz6 with SMTP id 6so1484385bwz.37
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2009 11:45:38 -0700 (PDT)
In-Reply-To: <9383297B60843144AC17878B479520F110AEE53835@SJEXCHCCR01.corp.ad.broadcom.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Branden <sbranden@broadcom.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

2009/9/28 Scott Branden <sbranden@broadcom.com>:

> You changes cause the bcmring platform to fail to compile.

The noes! Patch mailed.

> Can you go through all the ARM platforms and make the
> necessary adjustments with the change in header files
> for mmc?

I think bcmring was the only one, I missed it because this
patch was boiling when bcmring got merged... Look:

linux-next-work/arch/arm$ grep -r 'asm/mmc.h' . | wc -l
0

Whereas:
linux-next-work/arch/arm$ grep -r 'linux/amba/mmci.h' . | wc -l
10

So I think I've fixed them now.

Linus Walleij
