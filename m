From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH 12/12] mmci: support variants with only one irq
Date: Thu, 23 Sep 2010 22:04:38 +0200
Message-ID: <AANLkTikuf7Br7oTfynrRQ2DW0Tiw3QvJL58sKZGBsF=3@mail.gmail.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
	<1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:45564 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016Ab0IWUEj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 16:04:39 -0400
Received: by qwh6 with SMTP id 6so1336944qwh.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Sep 2010 13:04:38 -0700 (PDT)
In-Reply-To: <1277198267-10860-12-git-send-email-rabin.vincent@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin.vincent@stericsson.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

2010/6/22 Rabin Vincent <rabin.vincent@stericsson.com>:

> The Ux500 variants have only one IRQ line hooked up. =A0Allow these t=
o
> work by directing the PIO interrupts also to the first IRQ line.

I see this one is dangling in the patch tracker, FYI I have regression
tested this on the PB1176MPcore with its unmodified ARM PL180
MMCI block - read/write files copy mount/unmount - no problems.

Yours,
Linus Walleij
