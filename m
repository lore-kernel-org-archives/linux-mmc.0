From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 04/12] mmci: allow the card detect status not to be
	inverted
Date: Thu, 29 Jul 2010 15:53:19 +0200
Message-ID: <AANLkTikQi+SPpx8Wpvb0siSSsw0ZhusWaaKmqRnfHrnz@mail.gmail.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-4-git-send-email-rabin.vincent@stericsson.com>
	<20100729123443.GA18923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51753 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754344Ab0G2NxU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jul 2010 09:53:20 -0400
Received: by bwz1 with SMTP id 1so209081bwz.19
        for <linux-mmc@vger.kernel.org>; Thu, 29 Jul 2010 06:53:19 -0700 (PDT)
In-Reply-To: <20100729123443.GA18923@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Rabin Vincent <rabin.vincent@stericsson.com>, Colin Tuckley <colin.tuckley@arm.com>, linux-arm-kernel@lists.infradead.org, STEricsson_nomadik_linux@list.st.com, linux-mmc@vger.kernel.org

2010/7/29 Russell King - ARM Linux <linux@arm.linux.org.uk>:

> What now needs to happen is the sense of the GPIOLIB support on platforms
> needs to be checked - eg, I suspect the card detect via the GPIO primecell
> is inverted on Realview - in which case we need a 'cd_invert' rather
> than the negative 'cd_noinvert'.

Doesn't seem so. I applied this patch and it works like a charm just
like before on PB1176. (PL061 is compiled in, so it's not that other
weird stuff being used.)

I hope I'm doing the right thing, boot with card inserted, this appears
in the bootlog:

mmc0: new SD card at address 80ca
mmcblk0: mmc0:80ca SU512 483 MiB
 mmcblk0: p1

Remove card:
mmc0: card 80ca removed

Insert card:
mmc0: new SD card at address 80ca
mmcblk0: mmc0:80ca SU512 483 MiB
 mmcblk0: p1

And so on.

Yours,
Linus Walleij
