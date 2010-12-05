From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: working around a Marvell wifi SDIO bug
Date: Sun, 5 Dec 2010 16:15:19 +0200
Message-ID: <AANLkTinPbGcxOU8w_Wy3YVe-QOYpmQm+K7sgRHd-K2vp@mail.gmail.com>
References: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33020 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285Ab0LEOPl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Dec 2010 09:15:41 -0500
Received: by iwn6 with SMTP id 6so2163082iwn.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Dec 2010 06:15:40 -0800 (PST)
In-Reply-To: <AANLkTik2F_-g2beZT5mLe4+XSBL-HUKnceeKqtKQZC=g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sat, Dec 4, 2010 at 6:22 PM, Daniel Drake <dsd@laptop.org> wrote:
> In this case we are not changing current or voltage, we are just
> asserting a specific signal to the card. So its messy from the start
> (I'd have to invent a list of supported voltages or something).

This is exactly what we do today with the 12xx - we just need to
assert a digital signal, which by no means power the device (the
voltage value we provide isn't really fed from the gpio signal).

Your case might be slightly different, but still I think it's worth
looking into this approach first.

> Another option would be just to hack this into the kernel. Inside
> mmc_power_up we'd add something like the following:
>
> #ifdef CONFIG_OLPC
> if (machine_is_olpc())
> =A0 olpc_reset_gpio_fixup(host);
> #endif

Please don't.

Core code should not contain such machine-specific details (imagine
how it would look when other boards will start adding this 8686
tweak...).

> Another cleaner option (but perhaps OTT for just 1 user?) would be to
> add a notifier chain that is called at this point.

That would obviously work but as you and Nicolas mentioned it's an
overkill: we don't really need random users to plug into this hook,
and using notifiers will just make the code less readable and harder
to debug, so it's better to try to find a solution that fits.
