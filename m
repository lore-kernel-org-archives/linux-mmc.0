From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] mmci: fixup sg buffer handling in mmci_pio_irq.
Date: Sun, 8 May 2011 22:13:29 +0200
Message-ID: <BANLkTi=KswoqCqb_favD7EdX0NE47rM7Ew@mail.gmail.com>
References: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
	<20110508102219.GG27807@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36814 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab1EHUNa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 16:13:30 -0400
Received: by qwk3 with SMTP id 3so2708266qwk.19
        for <linux-mmc@vger.kernel.org>; Sun, 08 May 2011 13:13:30 -0700 (PDT)
In-Reply-To: <20110508102219.GG27807@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@stericsson.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>

On Sun, May 8, 2011 at 12:22 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, May 05, 2011 at 01:14:23PM +0200, Linus Walleij wrote:
>> The patch fix the problem by checking result of mmci_pio_write().
>>
>> The fault was introduced in the change:
>> =A0 =A0 =A0 I2e506ec1f5a7fadf9780c18d8d31573eaf048273
>> =A0 =A0 =A0 MMCI: Fixup sg buffer handling in pio_write
>
> I assume this isn't for mainline as that commit isn't present.

No I screwed up, I will post a combined patch with both and an
explanation instead, only relates to SDIO FWIW.

Thanks for your patience.

Yours,
Linus Walleij
